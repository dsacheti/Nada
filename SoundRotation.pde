//This software is based on basicRotationWithSin which was distributed to the students of this course

//Maxim class
Maxim mmm;
//three audio players
AudioPlayer pp;
AudioPlayer pp1;
AudioPlayer pp2;

boolean tocar;//variable to control if there is any sound playing
float avgPower;//store averagePower of sound playing
float radix;//control max radius of rose of elements that are painted in canvas
float magnify = 300; // This is how big we want the rose to be.
float rotation = 0; // rotation : this is basically how far round the circle we are going to go
float radius = 0; // radius : this is basically how far from the origin we are.
int elements = 256;// This is the number of points and lines we will calculate at once. 1000 is alot actually.


void setup() {
  size(768,700);
  rectMode(CENTER);
  colorMode(HSB);
  mmm = new Maxim(this);
  //setup first player
  pp = mmm.loadFile("sequence.wav");
  pp.setLooping(true);
  pp.setAnalysing(true);
  
  //setup second player
  pp1 = mmm.loadFile("do_fall.wav");
  pp1.setLooping(true);
  pp1.setAnalysing(true);
  
  //setup third player
  pp2 = mmm.loadFile("bellish.wav");
  pp2.setLooping(true);
  pp2.setAnalysing(true);  
  
  radix = 0;
  tocar = false;
  
  
}
 
void draw() {
  //incrementing maximum radius control
  radix = radix+0.01;
  //getting the average power of the sound that is playing
  if(pp.isPlaying()){
    avgPower = pp.getAveragePower();
  }else if(pp1.isPlaying()){
    avgPower = pp1.getAveragePower();
  }else if(pp2.isPlaying()){
    avgPower = pp2.getAveragePower();
  }
  //if any sound is playing increment rotation control with average power
  if(tocar){
  rotation = rotation +avgPower;
  }else{
    rotation = rotation;
  }
  background(0);
  //setting up the actually radious of elements
  radius = map(radix, 0, width, 0, 10);
 //resenting the variable that increments the radius
  if(radix >=30){
    radix = 10;
  }

  float spacing = TWO_PI/elements; 
  translate(width*0.5,height*0.5);
  
  
  strokeWeight(2);
  for (int i = 0; i < elements;i++) {
      strokeWeight(1);
      stroke(i*2-100,255,255);
      noFill();
      pushMatrix();
      rotate(spacing*i*rotation);
      //translation with a calculation including mouse height position
      translate(sin(mouseY+spacing*i*avgPower)*magnify, 0);
      line(0,-15,0,15);
      line(-15,0,15,0);
      noStroke();
      fill(i*2-100,255,255,100);
      ellipse(0,0,25,25);
      popMatrix();
  }
}
//pressing mouse stops or start playing:
//"pp" player if the click is in left hand of canvas
//"pp1" player if the click is in middle of canvas
//"pp2" player if the click is in right hand of canvas
void mousePressed(){
  tocar = !tocar;
  if(tocar){
    if(mouseX<width/3){
      pp.play();
    }else if(mouseX>width/3 && mouseX<width*2/3){
      pp1.play();
    }else if(mouseX>width*2/3){
      pp2.play();
    }
  }else{
    //if sounds are stopped rotation also stops
    pp.stop();
    pp1.stop();
    pp2.stop();
    rotation = 0;
  }
}
 
