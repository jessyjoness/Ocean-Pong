//ocean pong

//minim library
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
Minim soundCode;
AudioPlayer underthesea;
AudioPlayer gameovermusic;


//defining global variables
float x, y, speedX, speedY;
float diam = 10;
float rectSize = 200;
//float diamHit;
PImage bg;
PImage img;
int z;
color[] rainbow = {#FFFEFF, #F2BB77, #F2DD72, #F27329, #F22929};
//color[] rainbow = {#049DD9, #0378A6, #05C7F2, #04B2D9, #05DBF2};
PFont font;

//-------------------------------------------------------------------------------------


void setup() {
  size(920, 500);
  smooth();
  fill(255);
  noStroke();
  imageMode(CENTER);
 
  bg = loadImage("waterbackground.jpg");
  reset();
 

  //play music when program runs
  soundCode = new Minim (this);
  underthesea = soundCode.loadFile("underthesea.wav");
  underthesea.play();
}

//-------------------------------------------------------------------------------------


void reset() {
  x = width/2;
  y = height/2;

  //allows plastic to bounce 
  speedX = random(5, 5);
  speedY = random(5, 5);
}

//-------------------------------------------------------------------------------------

void draw() { 
 
  background(bg);
  img = loadImage("plastic.png");
  image(img, x/2, y);  //plastic ball
  rect(0, 0, 20, height); //left rectangle
  rect(width/2, mouseY-rectSize/2, 40, rectSize); //moving rectangle


  //allows plastic ball to bounce 
  x += speedX;
  y += speedY;


  // if plastic ball hits movable bar, invert X direction
  if ( x > width-30 && x < width -20 && y > mouseY-rectSize/2 && y < mouseY+rectSize/2 ) {
    speedX = speedX * -1;
    x = x + speedX;
    fill(rainbow[int(random(0, 5))]); //changes to random colour from array


    //ellipse(x, y, diamHit, diamHit);
    rectSize = rectSize-10;
    rectSize = constrain(rectSize, 10, 150);
  } 


  // if plastic hits wall, change direction of X
  if (x < 25) {
    speedX *= -1.1;
    speedY *= 1.1;
    x += speedX;
    fill(rainbow[int(random(0, 4))]); //changes to random colour from array
  }


  // if plastic hits up or down, change direction of Y   
  if ( y > height || y < 0 ) {
    speedY *= -1;
  }


  //orange fish
  img = loadImage("orangefish.png");
  image(img, 870, 100);
  image(img, 870, 250);
  image(img, 870, 400);

//text
  String s = "Stop the rubbish from getting to the fish!";
  font = loadFont("phos20.vlw");
  textFont(font);
  text(s, 270, 20, 100);  // Text wraps within text box
   
   
//Game Over Screen
  if (x > 1500) {
    font = loadFont("phos.vlw");
    textFont(font);
    background(255);
    fill(#d64956);
    textSize(60);
    text("GAME OVER", width / 2 - 160, 80);
    

    textSize(18);
    text("Click To Restart", 760, 480);
  
    textSize(45);
    fill(#6abab0);
    text("Keep our sea plastic free!", 185, 430);
    
    img = loadImage("deadfish.jpg");
    image(img, width/2, 250);
    
  //play game over music
   if (underthesea.isPlaying()) {
   underthesea.pause();
  soundCode = new Minim (this);
  gameovermusic = soundCode.loadFile("gameovermusic.wav");
  gameovermusic.play();
}}
  
  }
  
//-------------------------------------------------------------------------------------

//reset game when mouse pressed
void mousePressed() {
  reset();
  
    //stop game over music when game resets
    if (gameovermusic.isPlaying()) {
    gameovermusic.pause();}
    
    //ensure that only one underthesea song is playing at a time
    if (underthesea.isPlaying()) {
    underthesea.pause();}
    
    //restart underthesea music when game resets
  soundCode = new Minim (this);
  underthesea = soundCode.loadFile("underthesea.wav");
  underthesea.play();
}


//-------------------------------------------------------------------------------------

//pause music when key pressed
void keyPressed() {
  if (underthesea.isPlaying()) {
    underthesea.pause();
  } else {
    underthesea.play();
  }
}
