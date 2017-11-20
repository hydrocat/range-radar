float z;
Point[] points;
float scale = 5.0;

class Point {
  float distance, pitch, yaw;
  Point(float d, float p, float y){
    distance = d;
    pitch  = p;
    yaw = y;
  }
  Point(String d, String p, String y){
    distance = float(d);
    pitch  = float(p);
    yaw = float(y);
  }
  
  Point(float d, float p){
    distance = d;
    pitch  = p;
    yaw = 0;
  }
  
  Point(String d, String p){
    distance = float(d);
    pitch  = float(p);
    yaw = 0;
  }
}

void setup() {
  size(600,600,P3D);
  z = 0;
  String[] lines = loadStrings("teste2.txt");
  points = new Point[lines.length];
  
  for(int i = 0; i< lines.length; i++){
    String[] s = split(lines[i],';');
    points[i] = new Point(s[1],s[0]);
  }
}

void draw() {
  translate(width/2,height,0);
  rotateZ(radians(-90));
 // rotateY(radians((mouseX/float(height))*180.0));
  //rotateX(-radians((mouseY/float(height))*180.0));
  rectMode(CENTER);
  background(127);
  
  stroke(0);
  for(Point p : points){
    float x = p.distance * cos(radians(p.pitch)) * 10;
    float y = p.distance * sin(radians(p.pitch)) * 10;
    line(0,0,y,x);
  }
  line(0,0, 30 * sin(PI/2), 30 * cos(PI/2));
  line(0,0, 30 * sin(0), 30 * cos(0));
  line(0,0, 30 * sin(PI), 30 * cos(PI));
  stroke(255);
  fill(255);
  ellipse(0,0,20,20);
  z++; // The rectangle moves forward as z increments.
}