#include <Arduino.h>
#include <arduino-timer.h>
#include <Stepper.h>
#include <PID_v1.h>

#define CFG_STEPPER_RPM         5
#define CFG_STEPPER_STEPS       200
#define CFG_STEPPER_STEP        1
#define CFG_STEPPER_WAIT_MS     60L*1000L/CFG_STEPPER_STEPS/CFG_STEPPER_RPM     
#define CFG_STEPPER_PIN_M0      4
#define CFG_STEPPER_PIN_M1      5
#define CFG_STEPPER_PIN_M2      6
#define CFG_STEPPER_PIN_M3      7

#define CFG_LED_PIN             8
#define CFG_HOTEND_PIN          3
#define CFG_RUNOUT_PIN          2

#define CFG_THERMISTOR_PIN      A2
#define CFG_THERMISTOR_WAIT_MS  2L*1000L
#define CFG_THERMISTOR_R        10000

#define CFG_PID_KP              23.0
#define CFG_PID_KI              0.043
#define CFG_PID_KD              160.0
#define CFG_PID_TEMP            230.0
#define CFG_PID_MAX_TEMP        240.0
#define CFG_PID_MAX_OUTPUT      200.0

volatile bool hasFilament_ = false;
double pidInput_, pidOutput_, pidSetpoint_=CFG_PID_TEMP;

Timer<3, millis> timer_;

Stepper stepper_(CFG_STEPPER_STEPS, CFG_STEPPER_PIN_M0, 
    CFG_STEPPER_PIN_M1, CFG_STEPPER_PIN_M2, CFG_STEPPER_PIN_M3);

PID pid_(&pidInput_, &pidOutput_, &pidSetpoint_, CFG_PID_KP, 
    CFG_PID_KI, CFG_PID_KD, DIRECT);

void stepperRelease() {
    digitalWrite(CFG_STEPPER_PIN_M0, LOW); 
    digitalWrite(CFG_STEPPER_PIN_M1, LOW); 
    digitalWrite(CFG_STEPPER_PIN_M2, LOW); 
    digitalWrite(CFG_STEPPER_PIN_M3, LOW); 
}

bool stepperStep(void *arg) {
    if (hasFilament_) {
        stepper_.step(CFG_STEPPER_STEP);
    }
    return true;
}

void runoutTriggered() {
    bool hasFilament = digitalRead(CFG_RUNOUT_PIN);
    if (hasFilament_ != hasFilament) {
        Serial.println(hasFilament ? F("ON") : F("OFF"));
        digitalWrite(CFG_HOTEND_PIN, hasFilament ? HIGH : LOW);
        if (!hasFilament) {
            stepperRelease();
        }
        hasFilament_ = hasFilament;
    }
}

double thermistorRead() {
    double c1 = 0.8438162826e-03, c2 = 2.059601750e-04, c3 = 0.8615484887e-07;
    double level = (double)analogRead(CFG_THERMISTOR_PIN);
    double levelR = CFG_THERMISTOR_R * (1023.0 / level - 1.0);
    double levelLogR = log(levelR);
    double tempKelvin = (1.0 / (c1 + c2 * levelLogR + c3 * levelLogR * levelLogR * levelLogR)); 
    return tempKelvin - 273.15;
}

bool thermistorProcess(void *arg) {
    pidInput_ = thermistorRead();
    if (pidInput_ > CFG_PID_MAX_TEMP || isnan(pidInput_)) {
        pidOutput_ = 0;
    } else {
        pid_.Compute();
    }
    Serial.print(pidInput_); Serial.print(' '); Serial.println(pidOutput_);
    analogWrite(CFG_HOTEND_PIN, pidOutput_);
    return true;
}

bool debugPrint(void *arg) {
    digitalWrite(CFG_LED_PIN, !digitalRead(CFG_LED_PIN));
    return true;
}

void setup() {
    pinMode(CFG_LED_PIN, OUTPUT);
    pinMode(CFG_HOTEND_PIN, OUTPUT);
    pinMode(CFG_RUNOUT_PIN, INPUT);

    stepper_.setSpeed(CFG_STEPPER_RPM);

    analogWrite(CFG_HOTEND_PIN, 0);

    pid_.SetTunings(CFG_PID_KP, CFG_PID_KI, CFG_PID_KD);
    pid_.SetOutputLimits(0, CFG_PID_MAX_OUTPUT);
    pid_.SetMode(AUTOMATIC);

    timer_.every(1000, debugPrint);
    timer_.every(CFG_STEPPER_WAIT_MS, stepperStep);
    timer_.every(CFG_THERMISTOR_WAIT_MS, thermistorProcess);

    attachInterrupt(digitalPinToInterrupt(CFG_RUNOUT_PIN), runoutTriggered, CHANGE);

    Serial.begin(115200);
    while (!Serial);

    Serial.println(F("Started"));
}

void loop() {
    timer_.tick();
}
