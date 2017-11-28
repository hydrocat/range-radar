#include <Servo.h>

#define separator ";"
#define step 2
#define maxAngle 180
#define readDelay 100

// Ultrasonic variables
const int TRIGGER = 12;
const int ECHO = 11;
long duration;

// Servo variables
Servo myservoa; //holds the sensor, pitch
Servo myservob; // yaw


void setup() {
  pinMode(TRIGGER, OUTPUT);
  pinMode(ECHO, INPUT);
  Serial.begin(9600);
  
  myservoa.attach(9);
  myservob.attach(10);

  
}

float rd(){
    delay(50);
    float distance;
    // Clears the TRIGGER
    digitalWrite(TRIGGER, LOW);
    delayMicroseconds(2);
    // Sets the TRIGGER on HIGH state for 10 micro seconds
    digitalWrite(TRIGGER, HIGH);
    delayMicroseconds(10);
    digitalWrite(TRIGGER, LOW);
    // Reads the ECHO, returns the sound wave travel time in microseconds
    duration = pulseIn(ECHO, HIGH);
    // Calculating the distance
    distance= duration * 0.034/2.0;
    // Prints the distance on the Serial Monitor
    return distance;
}

float read_distance(){
  float r = 0;
  for( int x = 0; x< 10; x++){ r += rd(); }
    return r/10.0;
}

void makeReading(){
      for(int yaw = 0; yaw < 180; yaw += step){
      myservob.write(yaw);
      delay(80);
      for(int pitch = 0; pitch < 180; pitch += step) {
        myservoa.write(pitch);
        if( pitch == 0){
          delay(500);
        }
        Serial.print(pitch);
        Serial.print(separator);
        Serial.print(yaw);
        Serial.print(separator);
        Serial.print(read_distance());
        Serial.println();
        delay(readDelay);
      }
    }
}

int sweep(){
  makeReading();
}

void loop() {
  sweep();
}
