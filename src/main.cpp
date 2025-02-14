#include <Arduino.h>
#include <arduino-timer.h>
#include <Stepper.h>
#include <PID_v1.h>

#define CFG_TIMER_COUNT         3

#define CFG_STEPPER_RPM         40      // tune for desired feed speed
#define CFG_STEPPER_STEPS       200
#define CFG_STEPPER_STEP        1
#define CFG_STEPPER_RUN_MS      60L*1000L/CFG_STEPPER_STEPS/CFG_STEPPER_RPM     
#define CFG_STEPPER_PIN_M0      4
#define CFG_STEPPER_PIN_M1      5
#define CFG_STEPPER_PIN_M2      6
#define CFG_STEPPER_PIN_M3      7

#define CFG_LED_PIN             8
#define CFG_HOTEND_PIN          3
#define CFG_RUNOUT_PIN          2

#define CFG_THERMISTOR_PIN      A2
#define CFG_THERMISTOR_RUN_MS   2L*1000L
#define CFG_THERMISTOR_R        10000

#define CFG_PID_KP              23.0
#define CFG_PID_KI              0.043
#define CFG_PID_KD              160.0
#define CFG_PID_TEMP            200.0   // tune for desired temperature
#define CFG_PID_MAX_TEMP        240.0
#define CFG_PID_MAX_OUTPUT      200.0
#define CFG_PID_READY_TEMP      150.0

#define CFG_HOTEND_TIMEOUT_MS   5L*60L*1000L

volatile bool runoutHasFilament_=false, runoutTriggered_=false;
double pidInput_, pidOutput_, pidSetpoint_=CFG_PID_TEMP;
bool hotendIsPaused_ = true;

Timer<CFG_TIMER_COUNT, millis> timer_;
Timer<>::Task hotendPauseTask_;

Stepper stepper_(CFG_STEPPER_STEPS, CFG_STEPPER_PIN_M0, 
    CFG_STEPPER_PIN_M1, CFG_STEPPER_PIN_M2, CFG_STEPPER_PIN_M3);

PID pid_(&pidInput_, &pidOutput_, &pidSetpoint_, CFG_PID_KP, 
    CFG_PID_KI, CFG_PID_KD, DIRECT);

double thermistorRead() {
    static const double c1 = 0.8438162826e-03, c2 = 2.059601750e-04, c3 = 0.8615484887e-07;
    double level = (double)analogRead(CFG_THERMISTOR_PIN);
    double levelR = CFG_THERMISTOR_R * (1023.0 / level - 1.0);
    double levelLogR = log(levelR);
    double tempKelvin = (1.0 / (c1 + c2 * levelLogR + c3 * levelLogR * levelLogR * levelLogR)); 
    return tempKelvin - 273.15;
}

bool stepperStepTask(void *arg) {
    if (!runoutHasFilament_) return true;
    stepper_.step(CFG_STEPPER_STEP);
    return true;
}

void stepperInitialize() {
    stepper_.setSpeed(CFG_STEPPER_RPM);
    timer_.every(CFG_STEPPER_RUN_MS, stepperStepTask);
}

void stepperRelease() {
    digitalWrite(CFG_STEPPER_PIN_M0, LOW); 
    digitalWrite(CFG_STEPPER_PIN_M1, LOW); 
    digitalWrite(CFG_STEPPER_PIN_M2, LOW); 
    digitalWrite(CFG_STEPPER_PIN_M3, LOW); 
}

bool hotendPauseTask(void *arg) {
    hotendIsPaused_ = true;
    digitalWrite(CFG_LED_PIN, LOW);
    analogWrite(CFG_HOTEND_PIN, 0);
    return true;
}

void hotendCancelPauseTimer() {
    if (hotendPauseTask_ != nullptr) {
        timer_.cancel(hotendPauseTask_);
        hotendPauseTask_ = nullptr;
    }
    hotendIsPaused_ = false;
}

void hotendStartPauseTimer() {
    hotendCancelPauseTimer();
    hotendPauseTask_ = timer_.in(CFG_HOTEND_TIMEOUT_MS, hotendPauseTask);
}

void runoutProcess() {
    if (!runoutTriggered_) return;
    runoutTriggered_ = false;
    Serial.println(runoutHasFilament_ ? F("ON") : F("OFF"));
    if (runoutHasFilament_) {
        hotendCancelPauseTimer();
    } else {
        stepperRelease();
        hotendStartPauseTimer();
    }
}

void runoutTriggeredInterrupt() {
    bool hasFilament = digitalRead(CFG_RUNOUT_PIN);
    if (runoutHasFilament_ == hasFilament) return;
    runoutHasFilament_ = hasFilament;
    runoutTriggered_ = true;
}

void runoutInitialize() {
    runoutHasFilament_ = false;
    runoutTriggered_ = false;
    pinMode(CFG_RUNOUT_PIN, INPUT);
    attachInterrupt(digitalPinToInterrupt(CFG_RUNOUT_PIN), runoutTriggeredInterrupt, CHANGE);
}

bool hotendTask(void *arg) {
    if (hotendIsPaused_) return true;
    pidInput_ = thermistorRead();
    if (pidInput_ > CFG_PID_MAX_TEMP || isnan(pidInput_)) {
        pidOutput_ = 0;
    } else {
        pid_.Compute();
    }
    Serial.print(pidInput_); Serial.print(' '); Serial.println(pidOutput_);
    analogWrite(CFG_HOTEND_PIN, pidOutput_);
    if (pidInput_ > CFG_PID_READY_TEMP) {
        digitalWrite(CFG_LED_PIN, HIGH);
    } else {
        digitalWrite(CFG_LED_PIN, !digitalRead(CFG_LED_PIN));
    }
    return true;
}

void hotendInitialize() {
    hotendIsPaused_ = true;
    hotendPauseTask_ = nullptr;

    pinMode(CFG_LED_PIN, OUTPUT);
    digitalWrite(CFG_LED_PIN, LOW);

    pinMode(CFG_HOTEND_PIN, OUTPUT);
    analogWrite(CFG_HOTEND_PIN, 0);

    pid_.SetTunings(CFG_PID_KP, CFG_PID_KI, CFG_PID_KD);
    pid_.SetOutputLimits(0, CFG_PID_MAX_OUTPUT);
    pid_.SetMode(AUTOMATIC);

    timer_.every(CFG_THERMISTOR_RUN_MS, hotendTask);
}

void setup() {
    hotendInitialize();
    stepperInitialize();
    runoutInitialize();

    Serial.begin(115200);
    while (!Serial);

    Serial.println(F("Started"));
}

void loop() {
    runoutProcess();
    timer_.tick();
}
