#include <Arduino.h>
#include <arduino-timer.h>
#include <Stepper.h>

#define CFG_STEPPER_RPM     5
#define CFG_STEPPER_STEPS   200
#define CFG_STEPPER_STEP    1

#define CFG_HOTEND_WAIT_MS  2L*1000L
#define CFG_STEPPER_WAIT_MS 60L*1000L/CFG_STEPPER_STEPS/CFG_STEPPER_RPM     

#define CFG_STEPPER_PIN_M0  4
#define CFG_STEPPER_PIN_M1  5
#define CFG_STEPPER_PIN_M2  6
#define CFG_STEPPER_PIN_M3  7
#define CFG_LED_PIN         8
#define CFG_HOTEND_PIN      A0
#define CFG_RUNOUT_PIN      2
#define CFG_THERMISTOR_PIN  A2

Stepper stepper_(CFG_STEPPER_STEPS, CFG_STEPPER_PIN_M0, 
    CFG_STEPPER_PIN_M1, CFG_STEPPER_PIN_M2, CFG_STEPPER_PIN_M3);

Timer<3, millis> timer_;

volatile bool hasFilament_ = false;

void runoutTriggered() {
    bool hasFilament = digitalRead(CFG_RUNOUT_PIN);
    if (hasFilament_ != hasFilament) {
        Serial.println(hasFilament ? F("ON") : F("OFF"));
        digitalWrite(CFG_HOTEND_PIN, hasFilament ? HIGH : LOW);
        hasFilament_ = hasFilament;
    }
}

bool debugPrint(void *arg) {
    digitalWrite(CFG_LED_PIN, !digitalRead(CFG_LED_PIN));
    return true;
}

bool stepperStep(void *arg) {
    if (hasFilament_) {
        stepper_.step(CFG_STEPPER_STEP);
    }
    return true;
}

bool hotendTempControl(void *arg) {
    uint8_t t = analogRead(CFG_THERMISTOR_PIN);
    Serial.print(t, HEX); Serial.println();
    return true;
}

void setup() {
    pinMode(CFG_LED_PIN, OUTPUT);
    pinMode(CFG_HOTEND_PIN, OUTPUT);
    pinMode(CFG_RUNOUT_PIN, INPUT);
    attachInterrupt(digitalPinToInterrupt(CFG_RUNOUT_PIN), runoutTriggered, CHANGE);
    stepper_.setSpeed(CFG_STEPPER_RPM);

    Serial.begin(115200);
    while (!Serial);

    timer_.every(1000, debugPrint);
    timer_.every(CFG_STEPPER_WAIT_MS, stepperStep);
    timer_.every(CFG_HOTEND_WAIT_MS, hotendTempControl);
    Serial.println(F("Started"));
}

void loop() {
    timer_.tick();
}
