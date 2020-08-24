#include <Arduino.h>
#include <SoftwareSerial.h>
#include <ArduinoJson.h>
#include <Wire.h> 
#include <LiquidCrystal_I2C.h>

#define RX_PIN      5
#define TX_PIN      6
#define CTL_PIN     4
#define RELAY1      A0
#define RELAY2      A1
#define RELAY3      A2
#define RELAY4      A3
#define SDA_PIN     A4
#define SCL_PIN     A5

byte relayPin[4]    = {RELAY1, RELAY2, RELAY3, RELAY4};

SoftwareSerial data(RX_PIN, TX_PIN);
unsigned long lastTime = 0;
unsigned long timerDelay = 3000;
void sensorReading(void);
void relayControl(String relay);
void setup()
{
    Serial.begin(9600);
    data.begin(9600);
    pinMode(CTL_PIN, INPUT);
    for(int i=0; i<4;i++){
        pinMode(relayPin[i],OUTPUT);
    }
}

void loop()
{
    bool ctl = digitalRead(CTL_PIN);
    DynamicJsonDocument output(1024);
    if (ctl == 1)
    {
        if (data.available() > 0)
        {
            String nodemcu = data.readStringUntil(10);
            relayControl(nodemcu);
        }
    }
    if (millis() >= lastTime + timerDelay && ctl == 0)
    {
        lastTime += timerDelay;
        if (ctl == 0)
        {
            sensorReading();
        }
    }
}

void sensorReading()
{
    // Diganti hasil baca real dari sensor
    //====================================
    float temp = 30 + (rand() % 5);
    float hum = 70 + (rand() % 10);
    float airflow = 10 + (rand() % 5);
    float press = 90000+ (rand()%1000);
    //====================================
    StaticJsonDocument<200> json;
    json["temp"] = temp;
    json["hum"] = hum;
    json["press"] = press;
    json["air"] = airflow;
    serializeJson(json, data);
    data.write(10);
}

void relayControl(String relay)
{
    Serial.println("Status relay :");
    char control[5];
    relay.toCharArray(control,5);
    for(byte i=0;i<4;i++){
        if(control[i]=='1'){
            Serial.println("Relay "+String(i)+" ON");
            digitalWrite(relayPin[i],HIGH);
        }
        else {
            Serial.println("Relay "+String(i)+" OFF");
            digitalWrite(relayPin[i],LOW);
        }
            
    }
}