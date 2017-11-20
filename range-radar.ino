#include <Servo.h>

// Ultrasonic variables
const int TRIGGER = 12;
const int ECHO = 11;
long duration;
int distance;

// Servo variables
Servo myservo;
int pos = 0;
int degree = 10;

void setup() {
  pinMode(TRIGGER, OUTPUT);
  pinMode(ECHO, INPUT);
  Serial.begin(9600);
  
  myservo.attach(9);

  
}
int sweep(){
  if(pos == 180){
    degree *= -1;
  } else if(pos == 0){
    degree = !degree;
  }
  pos += degree;
  
  myservo.write(pos);
  //delay(200);
  Serial.print(pos);
}

void aaa(){
  myservo.write(0);
  delay(500);
  myservo.write(180);
  delay(500);
}

void read_distance(){
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
    distance= duration * 0.034/2;
    // Prints the distance on the Serial Monitor
    Serial.println(distance);
}

void loop() {
  sweep();
  Serial.print(";");
  read_distance();
  delay(20);
  
  //aaa();
}
