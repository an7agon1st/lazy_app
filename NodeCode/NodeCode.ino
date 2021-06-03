/**************************************************************************
 * Pin D7 and D8 are reserved for indicator LEDs
 * Pins D0 - D6 are for connecting devices
 * TODO: Fix True false flip error

 **************************************************************************/

// include EEPROM
#include <EEPROM.h>

// for the WIFI and firebase
#include <ESP8266WiFi.h>
#include "FirebaseESP8266.h"

// firebase credentials
#define FIREBASE_HOST "YOUR_RTDB_LINK_$$$.firebaseio.com"  //Change to your Firebase RTDB project ID e.g. Your_Project_ID.firebaseio.com
#define FIREBASE_AUTH "ENTER_YOUR_AUTH_$$$" //Change to your Firebase RTDB secret password

//Define Firebase Data objects
FirebaseData firebaseRead;
FirebaseData firebaseWrite;

FirebaseData firebaseLive;

#define GreenLED D7
#define RedLED D8

String dbAddr = "/DB_ADDR_$$$";

String deviceName = "/DEVICE_NAME_$$$";

// wifi data
struct {
  // fetch these when MCU starts
  char ssid[32] = "";
  char password[32] = "";
} wifiData;

// if cant connect to wifi after 5 tries, try to connect to backup wifi and fetch new details
char* bkpSSID = "LazyApp020221";
char* bkpPassword = "123400000";
bool backupWifi = false;

// devices connected
int device = 0;

// initialize all devices to off
int deviceStatus[] = {0,0,0,0,0,0,0};
int devices[] = {D0, D1, D2, D3, D4, D5, D6};

void setup() {
  Serial.begin(9600);
  while (!Serial) {
    ; // wait for serial port to connect. Needed for native USB port only
  }

  Serial.println("Hello!");

  // Initialize LED pin
  pinMode(GreenLED, OUTPUT);
  pinMode(RedLED, OUTPUT);

  // initialize Device pins
  pinMode(D0, OUTPUT);
  pinMode(D1, OUTPUT);
  pinMode(D2, OUTPUT);
  pinMode(D3, OUTPUT);
  pinMode(D4, OUTPUT);
  pinMode(D5, OUTPUT);
  pinMode(D6, OUTPUT);

  // initialize WIFI
  initializeWifi();
  Serial.print("Wifi Initialized");
  // firebase init

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  Serial.println("FFbase connected");

  // get number of devices
  Firebase.getInt(firebaseRead, dbAddr + deviceName + "/device");
  device = firebaseRead.intData();
  Serial.println("Number of devices: " + String(device));
  delay(1000);

  // if its backup wifi, fetch new wifi deatils from firebase
  if(backupWifi){
    fetchNewWifi();
  }

  Serial.flush();
}

void loop() {
  Serial.println("Looping\n\n");
  int dev = device;
  while(dev>=0){
    if(Firebase.getBool(firebaseLive, dbAddr + deviceName + deviceName + String(dev))){
      Serial.println("Device " + String(dev) + ": " + String(firebaseLive.boolData()));

      // if data has changed
      if(firebaseLive.boolData() != deviceStatus[dev]){
        deviceStatus[dev] = firebaseLive.boolData();
        digitalWrite(devices[dev], deviceStatus[dev]);
      }

    }

    dev--;
  }


   delay(3000);

}

void initializeWifi() {

  digitalWrite(GreenLED, HIGH);
  digitalWrite(RedLED, HIGH);

  uint addr = 0;
  // fetch wifi data from EEPROM

  EEPROM.begin(512);
  EEPROM.get(addr, wifiData);

  WiFi.begin(wifiData.ssid, wifiData.password);

  int tries = 0;


  //Serial.println("Connecting to saved wifi");

  while (WiFi.status() != WL_CONNECTED) {

    //Serial.println("SSID: "+ String(wifiData.ssid));
    //Serial.println("Password: "+ String(wifiData.password));
    delay(500);
    Serial.println("Connecting to Wifi...\n\n" + String(wifiData.ssid) + "\n" + String(wifiData.password));
    if(tries >= 10) {
      Serial.println("Cannot connect wifi, please activate backup wifi");
      Serial.println("Box291120\n\n1234500000");
      break;
    }
    tries += 1;
  }

  // if normal wifi connected
  digitalWrite(GreenLED, HIGH);
  digitalWrite(RedLED, LOW);

  // connect to backup wifi if tries fail
  if(tries >= 10){
    digitalWrite(GreenLED, LOW);
    digitalWrite(RedLED, HIGH);
    //Serial.println("Connecting to backup wifi");

    // connect to backup wifi
    WiFi.begin(bkpSSID, bkpPassword);

    // connecting to backup wifi
    while (WiFi.status() != WL_CONNECTED) {
      delay(500);
      Serial.println("Connecting to bkp Wifi...\n\2490Avlon\n\n1234500000");
    }

    digitalWrite(GreenLED, HIGH);
    digitalWrite(RedLED, LOW);
    backupWifi = true;
    //Serial.println("Connected to backup wifi \n");
  }

  //Serial.print("Connected with IP: ");
  //Serial.println(WiFi.localIP());

  Serial.flush();
}

void fetchNewWifi() {
  //Serial.println("Fetching new wifi data from database");
  Serial.println("Fetching new wifi data");

  // get new ssid
  if(Firebase.getString(firebaseRead, dbAddr + "/ssid")){
    char newSSID[32];
    firebaseRead.stringData().toCharArray(newSSID, 32);
    strncpy(wifiData.ssid, newSSID, 32);
  } else {
    //Serial.println(firebaseRead.errorReason());
    while(true) {
      Serial.println("Error, check your internet!");
    }
  }

  //get new password
  if(Firebase.getString(firebaseRead, dbAddr + "/password")){
    char newPassword[32];
    firebaseRead.stringData().toCharArray(newPassword, 32);
    strncpy(wifiData.password, newPassword, 32);
  } else {
    //Serial.println(firebaseRead.errorReason());
    while(true) {
      Serial.println("Error, check your internet!");
    }
  }

  Serial.println("SSID: " + String(wifiData.ssid) + "\n\n" + "Password: " + String(wifiData.password));

  // save new details
  uint addr = 0;
  EEPROM.begin(512);
  EEPROM.put(addr, wifiData);
  EEPROM.commit();

  //Serial.println("Data Saved to EEPROM");

  Serial.println("Data Saved\nRestart device to connect to new wifi");

}
