#include <Arduino.h>
#include <arduino-timer.h>
#include <Stepper.h>

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

Stepper stepper_(CFG_STEPPER_STEPS, CFG_STEPPER_PIN_M0, 
    CFG_STEPPER_PIN_M1, CFG_STEPPER_PIN_M2, CFG_STEPPER_PIN_M3);

Timer<3, millis> timer_;

volatile bool hasFilament_ = false;

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
    double t = thermistorRead();
    Serial.print(t); Serial.println();
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
