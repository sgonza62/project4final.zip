import processing.video.*;


Capture webcam;

color trackingColor;

float threshold = 115;

PImage testlevel;




//Enemies
float xofE1;
float yofE1;
float xspeedofE1;
float yspeedofE1;

float xofE2;
float yofE2;
float xspeedofE2;
float yspeedofE2;

float xofE3;
float yofE3;
float xspeedofE3;
float yspeedofE3;




PImage enemie;
int widthofE = 20;
int heightofE = 50;

PImage hero;
PImage endscreen;
PImage end;


//score
int scorecounter = 0;

void setup(){
  size(640, 480);
  webcam = new Capture(this,width,height, Capture.list()[18]);
  webcam.start();
  printArray(Capture.list());
 trackingColor = color(255,0, 0);
  
hero = loadImage("hero.png");
testlevel = loadImage("test level.png");
endscreen = loadImage("end screen.png");
end = loadImage("level 1c.png");
 
xspeedofE1 = 2;
yspeedofE2 = 2;
yspeedofE3 = 8;


xofE1 = 100;
yofE1 = 230;

xofE2 = 300;
yofE2 = 330;

xofE3 = 500;
yofE3 = 120;

 enemie = loadImage("enemie.png");
 

 
 
 
 
 
  
}

void captureEvent(Capture webcam){
  
  webcam.read();
  
  
  
}

void draw(){

  float matchX = 0;
  float matchY = 0;
  
  int counter = 1;
  
  float triggerx = 200;
  float triggery = 200;
  
  
  
  webcam.loadPixels();
  //background(255);
 image(webcam, 0, 0);
 
 
 //Level 1
image(testlevel,0, 0, 640, 480);
  
xofE1 = xofE1 + xspeedofE1;
yofE1 = yofE1 + yspeedofE1;

xofE2 = xofE2 + xspeedofE2;
yofE2 = yofE2 + yspeedofE2;

xofE3 = xofE3 + xspeedofE3;
yofE3 = yofE3 + yspeedofE3;

image(enemie, xofE1,yofE1);
image(enemie, xofE2,yofE2);
image(enemie, xofE3,yofE3);

 if(xofE1 < 110){
   xspeedofE1 = 5;
 }
 if (xofE1 > 635){
   xspeedofE1 = -5;
  
 }
 if ( yofE2 > 330){
  yspeedofE2 = -1;   
 }
 if (yofE2 < 230){
  yspeedofE2 = 1;
 }
 if ( yofE3 < 120){
  yspeedofE3 = 16;   
 }
  if (yofE3 > 460){
  yspeedofE3 = -16;
 }

 
 
 //Coin
 noFill();
 strokeWeight(8);
 stroke(255, 255, 0);
 ellipse(360, 300, 25, 25);
 
 //barriers
 fill(0,255,0);
 noStroke();
 rect(68, 78, 40, 500);
 rect(68, 78, 145, 50);
 rect(273, 78, 500, 50);

 

  fill(0);
  textSize(20);
  text("Score: " + scorecounter, 10, 470);
  
  
  
  
  
  
  
  
  
  
  for(int x = 0; x < webcam.width; x++){
    for(int y = 0; y < webcam.height; y++){
      int loc = x + y* webcam.width;
      color currentColor = webcam.pixels[loc];
      float r1 = red(currentColor);
      float g1 = green(currentColor);
      float b1 = blue(currentColor);
      
      float r2 = red(trackingColor);
      float g2 = green(trackingColor);
      float b2 = blue(trackingColor);
      
      float colorDiff = dist(r1, g1, b1, r2, g2, b2);
      
      if(colorDiff < threshold){
        matchX = x;
        matchY = y;
        
        counter++;
      }
    }
  }
if(counter > 0){
  fill(trackingColor);
  image(hero, matchX, matchY, 25, 65);
}


//Coin Score
  if (matchX >345 && matchX < 375 && matchY > 280 && matchY < 320 ){
  scorecounter = scorecounter + 100;
}
if (scorecounter > 100){
  scorecounter = 101;
  fill(222, 184, 135);
  noStroke();
  strokeWeight(1);
  ellipse(360, 300, 35, 35);
}
  if( matchX > 60 && matchX < 110 && matchY > 55){

    textSize(40);
    text("You Touched Poison Ivy!", 100, 300);
    scorecounter = scorecounter - 2;
  }
 if( matchX > 60 && matchX < 215 & matchY > 65 && matchY < 130){

    textSize(35);
    text("You Touched the Poisonous Plants!", 10, 300);
    scorecounter = scorecounter - 2;
 }
 if( matchX > 268 && matchX < 640 && matchY >65 && matchY < 130){

    textSize(35);
    text("You Touched the Poisonous Plants!", 10, 300);
    scorecounter = scorecounter - 2;
    
    
 }
 if(matchX > xofE1 && matchX < xofE1 + 30 && matchY > yofE1 && matchY < yofE1 + 47){
threshold = 0;
 }
if(threshold == 0){
  end();
}

if(matchX > xofE2 && matchX < xofE2 + 15 && matchY > yofE2 && matchY < yofE2 + 47){
threshold = 0;
 }
if(threshold == 0){
  end();
}
if(matchX > xofE3 && matchX < xofE3 + 15 && matchY > yofE3 && matchY < yofE3 + 47){
threshold = 0;
 }
if(threshold == 0){
  end();
}
 
 
if(matchX > 600 && matchX <640 && matchY > 400 && matchY < 480){
  threshold = 2;
}
 if (threshold ==2){
   round2();
   
   
 }
 
 
}

void round2(){
  image(end, 0,0,640,480);
  
}

  
void end(){
image(endscreen, 0, 0, 640, 480);
   textSize(30);
   text("They've Captured You!!", 150, 430);
   textSize(20);
   text("Press Space Bar to Retry", 170, 450);
   scorecounter = 0;
}

void keyPressed(){
  threshold = 115;
  scorecounter = 0;
}
  
  
  
  
  
