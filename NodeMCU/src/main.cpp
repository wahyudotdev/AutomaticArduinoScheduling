#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <WiFiClient.h>
#include <ArduinoJson.h>
#include <SoftwareSerial.h>
#define RX_PIN      D6
#define TX_PIN      D5
#define CTL_PIN     D2

const char *ssid = "y";
const char *password = "11111111";

//Your Domain name with URL path or IP address with path
String serverName = "http://192.168.43.44:3000/";
unsigned long lastTime = 0;
unsigned long timerDelay = 5000;

SoftwareSerial data(RX_PIN, TX_PIN);

void sensorData(int temp, int hum, int press, int air);
String relayData(void);
void setup()
{
    Serial.begin(9600);
    data.begin(9600);
    WiFi.begin(ssid, password);
    pinMode(CTL_PIN,OUTPUT);
    Serial.println("Connecting");
    while (WiFi.status() != WL_CONNECTED)
    {
        delay(500);
        Serial.print(".");
    }
    Serial.println("");
    Serial.print("Connected to WiFi network with IP Address: ");
    Serial.println(WiFi.localIP());
}

void loop()
{
    DynamicJsonDocument output(1024);
    if (millis() >= lastTime + timerDelay)
    {
        digitalWrite(CTL_PIN,HIGH);
        lastTime += timerDelay;
        delay(100);
        data.write(relayData().c_str());
        data.write(10);
        delay(200);
        digitalWrite(CTL_PIN,LOW);
    }
    if(data.available()>0){
        String receive = data.readStringUntil(10);
        DeserializationError error = deserializeJson(output, receive);
        if (error)
        {
            Serial.print(F("deserializeJson() failed: "));
            Serial.println(error.c_str());
            return;
        }
        int temp = output["temp"];
        int hum = output["hum"];
        int press = output["press"];
        int air = output["air"];
        Serial.println("Temp : "+String(temp)+"\r\nHum : "+String(hum)+"\r\nPress : "+String(press)+"\r\nAir : "+air);
        sensorData(temp, hum, press, air);
    }
    delay(50);
}

String relayData()
{
    DynamicJsonDocument output(1024);
    String payload;
    if (WiFi.status() == WL_CONNECTED)
    {
        HTTPClient http;
        String serverPath = serverName + "noderelay";
        http.begin(serverPath.c_str());
        http.GET();
        int httpResponseCode = http.GET();
        if (httpResponseCode > 0)
        {
            String result = http.getString();
            deserializeJson(output, result);
            int relay1 = output["relay1"];
            int relay2 = output["relay2"];
            int relay3 = output["relay3"];
            int relay4 = output["relay4"];
            char buff[8];
            sprintf(buff,"%d%d%d%d",relay1,relay2,relay3,relay4);
            Serial.println(buff);
            return buff;
        }
        else
        {
            Serial.print("Error code: ");
            Serial.println(httpResponseCode);
        }
        http.end();
    }
    else
    {
        Serial.println("WiFi Disconnected");
    }
}
void sensorData(int temp, int hum, int press, int air)
{
    if (WiFi.status() == WL_CONNECTED)
    {
        HTTPClient http;
        String serverPath = serverName + "nodemcu?temp=" + String(temp) + "&hum=" + String(hum) + "&press=" + String(press) + "&air=" + String(air);
        http.begin(serverPath.c_str());
        http.GET();
        http.end();
    }
    else
    {
        Serial.println("WiFi Disconnected");
    }
}