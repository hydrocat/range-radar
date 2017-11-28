import processing.serial.*;
Serial serial;
float z;
//Point[] points = new Point[180];
ArrayList<Point> points;
float scale = 5.0;
//String [] lines;
int index = -1;
float transZ = 0;
int counter = 0; 

float cx=0,cy=0,cz=0,angx=0,angy=0,angz=0;

class Point {
  float distance, pitch, yaw;
  Point(float d, float p, float y){
    distance = radians(d);
    pitch  = radians(p);
    yaw = radians(y);
  }
  Point(String d, String p, String y){
    distance = radians(float(d));
    pitch  = radians(float(p));
    yaw = radians(float(y));
  }
  
  Point(float d, float p){
    distance = radians(d);
    pitch  = radians(p);
    yaw = radians(0);
  }
  
  Point(String d, String p){
    distance = radians(float(d));
    pitch  = radians(float(p));
    yaw = 0;
  }
}

void setup() {
  size(600,600,P3D);
  z = 0;
  //lines = loadStrings("teste.txt");
  points = new ArrayList<Point>();
  printArray(Serial.list());
  serial = new Serial(this, Serial.list()[4], 9600);

/*  for(int i = 0; i< lines.length; i++){
    String[] s = split(lines[i],';');
    points[i] = new Point(s[1],s[0]);
  }*/
}

void mousePressed(){
  transZ += (height/2) - mouseY;
}

void kp(){
   if( key == 's' ){
     cz += 10;
   } else if (key == 'w'){
     cz -= 10;
   } else if ( key == 'a'){
     cx -= 10;
   } else if ( key == 'd'){
     cx += 10;
   }
}

void draw() {
//  delay(100);
  //camera(width, height, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  translate(height/2,width/2,-20);
  rotateZ(radians(90));
  rotateY(radians( (width/2) - (mouseX/float(height))*180.0));
  rotateX(radians(45));
  rotateX(-radians((width/2) - (mouseY/float(height))*180.0));
  rectMode(CENTER);
  background(127);
  
  String val = serial.readStringUntil('\n');
  //String val = lines[index];

  if ( val == null ){ return; }
 // print("valor do serial");
 // println(val);
  String[] valsplit = split(val, ";");
  points.add(new Point("30"/*valsplit[2]*/, valsplit[0], valsplit[1]));
  
  if ( counter > 1000){
     counter = 0;
     points.clear();
  }
  
  stroke(0);
  for(Point p : points){
   // print(p);
    float x = abs(p.distance * cos(p.pitch) * cos(p.yaw) * 10);
    float y = abs(p.distance * sin(p.pitch) * sin(p.yaw) * 10);
    float z = abs(p.distance * cos(p.pitch) * 10);
    println("X "+x);
    println("Y "+y);
    println("Z "+z);
    //translate(x,y,z);
    //box(10);
    line(0,0,0,y,x,z);
    //ranslate(height/2,width/2,transZ);
  }
  line(0,0, 30 * sin(PI/2), 30 * cos(PI/2));
  line(0,0, 30 * sin(0), 30 * cos(0));
  line(0,0, 30 * sin(PI), 30 * cos(PI));
  stroke(255);
  fill(255);
  //ellipse(0,0,20,20);
  z++; // The rectangle moves forward as z increments.
  
}