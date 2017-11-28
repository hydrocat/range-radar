import processing.serial.*;
Serial serial;
float stepAngle = 2;
float step = 180/stepAngle;

ArrayList<float[]> points = new ArrayList();

void setup() {
  size(600,600);
  printArray(Serial.list());
  serial = new Serial(this, Serial.list()[4], 9600);
  noStroke();
}

void draw(){
  float sqWidth = width/step;
  float sqHeight= height/step;
  int maxSquares = int(sqWidth * sqHeight);
  if( points.size() > maxSquares ){
    save("drawing!.png");
    points.clear();
  }
  String val = serial.readStringUntil('\n');
  if ( val == null ){ return; }
  print(val);
  String[] point = split(val, ";");
  float[] intpoint = new float[3];
  for( int x = 0; x< 3; x++ ){
    intpoint[x] = float(trim(point[x]));
  }
  
  points.add(intpoint);
  
  for( float[] p : points ){
    
    //printArray(p);
    fill(255 - map(p[2], 0,255, 3, 300));
    rect((p[1]/stepAngle) * sqWidth, (p[0]/stepAngle) * sqHeight, sqWidth, sqHeight);
    
  }
  
 
  
  
}