#include <Arduino.h>
#include <arduino-timer.h>

Timer<1, millis> debugTimer_;

bool debugPrint(void *arg) {
    Serial.println(F("Running"));
    return true;
}

void setup() {
    Serial.begin(115200);
    while (!Serial);

    debugTimer_.every(1000, debugPrint);
    Serial.println(F("Started"));
}

void loop() {
    debugTimer_.tick();
}
