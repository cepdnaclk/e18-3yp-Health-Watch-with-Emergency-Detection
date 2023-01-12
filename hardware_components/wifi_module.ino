#include <SoftwareSerial.h>
#define RX 10
#define TX 11
// Analog Pin sensor is connected to

String AP = "Dialog 4G 420";       // AP NAME
String PASS = "srilanka"; // AP PASSWORD
String API = "D21Y7XGWDORE5EML";   // Write API KEY
String HOST = "api.thingspeak.com";
String PORT = "80";
int countTrueCommand;
int countTimeCommand; 
boolean found = false; 
int valSensor = 1;
  
SoftwareSerial esp8266(RX,TX); 
const int lm35_pin = A0;

void setup() {
  Serial.begin(9600);
  esp8266.begin(9600);
  
  sendCommand("AT",5,"OK");
  sendCommand("AT+CWMODE=1",5,"OK");
  sendCommand("AT+CWJAP=\""+ AP +"\",\""+ PASS +"\"",20,"OK");
}

void loop() {
  
 String getData = "GET /update?api_key="+ API +"&field1="+getTemperatureValue();
 sendCommand("AT+CIPMUX=1",5,"OK");
 sendCommand("AT+CIPSTART=0,\"TCP\",\""+ HOST +"\","+ PORT,15,"OK");
 sendCommand("AT+CIPSEND=0," +String(getData.length()+4),4,">");
 esp8266.println(getData);
 delay(1500);
 countTrueCommand++;
 sendCommand("AT+CIPCLOSE=0",5,"OK");
}


String getTemperatureValue(){

   //delay(dhtObject.getMinimumSamplingPeriod());
   int temp_adc_val;
  float temp_val;
  temp_adc_val = analogRead(lm35_pin);	/* Read Temperature */
  temp_val = (temp_adc_val * 4.88);	/* Convert adc value to equivalent voltage */
  temp_val = (temp_val/10);	/* LM35 gives output of 10mv/°C */
  Serial.print("Temperature = ");
  Serial.print(temp_val);
  Serial.print(" Degree Celsius\n");
  return String(temp_val); 
  
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
  
  if(found == true)
  {
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
