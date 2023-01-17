#include <Wire.h>
#include "MAX30100_PulseOximeter.h"
#include <SoftwareSerial.h>
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#define RX 10
#define TX 11
#define REPORTING_PERIOD_MS     1000
Adafruit_MPU6050 mpu;

// Create a PulseOximeter object
PulseOximeter pox;

// Time at which the last beat occurred
uint32_t tsLastReport = 0;


String AP = "Jaya3_miA2lite";       // AP NAME
String PASS = "abcd12345"; // AP PASSWORD
String API = "IA21PGALU2J720E8";   // Write API KEY
String HOST = "api.thingspeak.com";
String PORT = "80";
String field = "field1";
int countTrueCommand;
int countTimeCommand; 
boolean found = false; 
int valSensor = 1;
String temp_value;
SoftwareSerial esp8266(RX,TX); 
const int lm35_pin = A0;


String arrayHeartRate[2];
String accelerationValues[3];
String accelerationPreviousValues[3];

// Callback routine is executed when a pulse is detected
void onBeatDetected() {
    Serial.println("Beat!");
}


void setup() {
    Serial.begin(9600);
    
    esp8266.begin(9600);
    sendCommand("AT",5,"OK");
    sendCommand("AT+CWMODE=1",5,"OK");
    sendCommand("AT+CWJAP=\""+ AP +"\",\""+ PASS +"\"",20,"OK");

    Serial.print("Initializing pulse oximeter..");

    // Initialize sensor
    if (!pox.begin()) {
        Serial.println("FAILED");
        for(;;);
    } else {
        Serial.println("SUCCESS");
    }

  // Configure sensor to use 7.6mA for LED drive
  pox.setIRLedCurrent(MAX30100_LED_CURR_7_6MA);

    // Register a callback routine
    pox.setOnBeatDetectedCallback(onBeatDetected);

    //-------------------------------MPU------------------------------------
      if (!mpu.begin()) {
    Serial.println("Failed to find MPU6050 chip");
    while (1) {
      delay(10);
    }
  }
  Serial.println("MPU6050 Found!");

  // set accelerometer range to +-8G
  mpu.setAccelerometerRange(MPU6050_RANGE_8_G);

  // set gyro range to +- 500 deg/s
  mpu.setGyroRange(MPU6050_RANGE_500_DEG);

  // set filter bandwidth to 21 Hz
  mpu.setFilterBandwidth(MPU6050_BAND_21_HZ);
    //----------------------------------------------------------------------
}

void loop() {
   getHeartRate();
   getTemperature();
   getAcceleration();

   

   if(arrayHeartRate[0].toDouble()>0.0 &&arrayHeartRate[1].toInt()>0 && temp_value.toDouble() > 20.0 && temp_value.toDouble() < 60.0){
      String getData = "GET /update?api_key="+ API +"&field1="+ temp_value +"&field2="+  accelerationValues[0] +"&field3="+  accelerationValues[1] +"&field4="+  accelerationValues[2] +"&field5="+arrayHeartRate[0]+"&field6="+arrayHeartRate[1];
      //Serial.print("test-------------------------"+String(temp_val));
      sendCommand("AT+CIPMUX=1",5,"OK");
      //AT+CIPSTART="TCP","116.228.221.51","8500"
      sendCommand("AT+CIPSTART=0,\"TCP\",\""+ HOST +"\","+ PORT,30,"OK");
      //delay(3000); 
      sendCommand("AT+CIPSEND=0," +String(getData.length()+4),15,">");
      Serial.print(getData);
      esp8266.println(getData);
    
      countTrueCommand++;
      sendCommand("AT+CIPCLOSE=0",5,"OK");
   }
  
}

void getHeartRate(){
  // Read from the sensor
        pox.update();

    // Grab the updated heart rate and SpO2 levels
    

        //Serial.print("Heart rate:");
        Serial.print(pox.getHeartRate());
        // Serial.print("bpm / SpO2:");
        Serial.print(pox.getSpO2());
        // Serial.println("%");
        arrayHeartRate[0] = String(pox.getHeartRate());
        arrayHeartRate[1] = String(pox.getSpO2());
    
}

void getAcceleration(){
/* Get new sensor events with the readings */
  sensors_event_t a, g, temp;
  mpu.getEvent(&a, &g, &temp);

  /* Print out the values */
  Serial.print("Acceleration X: ");
  Serial.print(a.acceleration.x);
  Serial.print(", Y: ");
  Serial.print(a.acceleration.y);
  Serial.print(", Z: ");
  Serial.print(a.acceleration.z);
  Serial.println(" m/s^2");

  Serial.println("");
 // Serial.println("Test ---------------------------- Acceleration X: "+String(a.acceleration.x));
  accelerationValues[0] = String(a.acceleration.x);
  accelerationValues[1] = String(a.acceleration.y);
  accelerationValues[2] = String(a.acceleration.z);
  
  Serial.println("Test ---------------------------- Acceleration X: "+ accelerationValues[0]);
  
}

void getTemperature(){
  int temp_adc_val;
  float temp_val;
  temp_adc_val = analogRead(lm35_pin);  /* Read Temperature */
  temp_val = (temp_adc_val * 4.88); /* Convert adc value to equivalent voltage */
  temp_val = (temp_val/10); /* LM35 gives output of 10mv/°C */
  // Serial.print("Temperature = ");
  // Serial.print(temp_val);
  temp_value = String(temp_val);
  // Serial.print(" Degree Celsius\n");
}

void sendCommand(String command, int maxTime, char readReplay[]) {
  Serial.print(countTrueCommand);
  Serial.print(". at command => ");
  Serial.print(command);
  Serial.print(" ");
  while(countTimeCommand < (maxTime*1))
  {
    esp8266.println(command);//at+cipsend
    if(esp8266.find(readReplay))//ok
    {
      found = true;
      break;
    }
  
    countTimeCommand++;
  }
  
  if(found == true){
    Serial.println("OYI");
    countTrueCommand++;
    countTimeCommand = 0;
  }
  
  if(found == false)
  {
    Serial.println("Fail");
    countTrueCommand = 0;
    countTimeCommand = 0;
  }
  
  found = false;
 }
