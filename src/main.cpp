#include <Arduino.h>
#include <arduino-timer.h>
#include <Stepper.h>

#define CFG_STEPPER_STEPS   200
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

Timer<1, millis> debugTimer_;

void runoutTriggered() {
    Serial.println(F("Runout"));
}

bool debugPrint(void *arg) {
    uint8_t t = analogRead(CFG_THERMISTOR_PIN);
    Serial.print(t, HEX); Serial.println();
    digitalWrite(CFG_LED_PIN, !digitalRead(CFG_LED_PIN));
    return true;
}

void setup() {
    pinMode(CFG_LED_PIN, OUTPUT);
    pinMode(CFG_HOTEND_PIN, OUTPUT);
    pinMode(CFG_RUNOUT_PIN, INPUT);
    attachInterrupt(digitalPinToInterrupt(CFG_RUNOUT_PIN), runoutTriggered, CHANGE);

    Serial.begin(115200);
    while (!Serial);

    debugTimer_.every(1000, debugPrint);
    Serial.println(F("Started"));
}

void loop() {
    debugTimer_.tick();
}
