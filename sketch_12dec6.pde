////////////////////////////////////////////////////////
// PROJECT 1: PACKITTY
// Processing for the Arts (48-757 @ 11:30AM)
// M. Yvonne Hidle (yvonnehidle@gmail.com)
//
// CREDITS:
// 1. Collision mapping based off code from Laurel Deel
//    http://www.openprocessing.org/sketch/43601
// 2. Pacman sounds
//    http://www.classicgaming.cc/classics/pacman/sounds.php
// 3. Other sounds
//    http://www.sounddogs.com
//
// GAMEPLAY:
// Use arrow keys to move
// Dodge ghosts
// Achieve goals by eating fish and kibbles
// To eat ghosts, first eat the catnip
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// GLOBAL VARIABLES
////////////////////////////////////////////////////////
// import libraries
import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;

// classes
PacKitty myKitty;
GhostA myGhostA;
GhostB myGhostB;
GhostC myGhostC;
Food myFood;

// images
PImage visibleMap;
PImage introImage;
PImage deathImage;
PImage levelImage;

// audio stuff
Minim minim;
AudioPlayer intro;
AudioPlayer kibble;
AudioPlayer fish;
AudioPlayer death;
AudioPlayer levelComplete;

// general game variables
int gamePhase;
int startTime;
float kittyStartX;
float kittyStartY;
float ghostStartX;
float ghostStartY;
int levelNum;
int goalKibbles;
int goalFish;
int goalGhosts;
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// LOAD OUR CLASSES AND SETUP THE GAME
////////////////////////////////////////////////////////
void setup()
{
size(1000,620);
imageMode(CENTER);
smooth();
  
// classes
myKitty = new PacKitty();
myGhostA = new GhostA();
myGhostB = new GhostB();
myGhostC = new GhostC();
myFood = new Food();

// images
visibleMap = loadImage("visible_map.png");
introImage = loadImage("intro-screen.png");
deathImage = loadImage("death-screen.png");
levelImage = loadImage("levelup-screen.png");

// audio stuff
minim = new Minim(this);
intro = minim.loadFile("pacman_beginning.wav");
kibble = minim.loadFile("chomp_kibble.mp3");
fish = minim.loadFile("chomp_fish.mp3");
death = minim.loadFile("pacman_death.wav");
levelComplete = minim.loadFile("pacman_levelcomplete.wav");

// general game variables
gamePhase=0;
startTime=0;
kittyStartX = 950;
kittyStartY = 550;
ghostStartX = width/2;
ghostStartY = 50;
levelNum = 1;
goalKibbles = 10;
goalFish = 1;
goalGhosts = 0;

// because the music is being annoying!
if (gamePhase == 0)
{
  intro.play();
  intro.rewind();
}
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// GAME TABLE OF CONTENTS
////////////////////////////////////////////////////////
void draw()
{ 
// intro screen
if(gamePhase == 0)
{
  showIntro();
}

// goals for level
else if(gamePhase == 1)
{
  showLevel();
}

// play game
else if(gamePhase == 2)
{
  playGame();
}

// score
else if(gamePhase == 3)
{
  upLevel();
}

else if(gamePhase == 4)
{
  score();
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// INTRO SCREEN
////////////////////////////////////////////////////////
void showIntro()
{

// show intro image!
background(introImage);

// if spacebar is pressed, show level goals
if (keyPressed==true)
{
  if (key ==' ')
  {
  gamePhase=1;
  startTime=millis();
  }
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// SHOW WHAT LEVEL YOU ARE ON
////////////////////////////////////////////////////////
void showLevel()
{
int countDown = 3000; // three seconds
  
// show intro image!
background(visibleMap);

// make transparent
pushStyle();
fill(255,100);
rect(0,0,width,height);
popStyle();

// show the goals
pushStyle();
fill(0);
textSize(20);
text("L E V E L . " + levelNum, 404, 250);

textSize(15);
text("Eat " + goalKibbles + " Kibbles", 404, 265);
text("Eat " + goalFish + " Tasty Fish", 404, 280);
text("Eat " + goalGhosts + " Ghosts", 404, 295);
popStyle();

// if countdown passes, start the game
pushStyle();
fill(255);
textSize(30);
text((countDown/1000 - ((millis()-startTime))/1000), width/2, 200);
popStyle();

if ((millis()-startTime) > countDown)
{
  gamePhase=2;
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// PLAY GAME
////////////////////////////////////////////////////////
void playGame()
{

// draw maze
background(visibleMap);

// spawn food
myFood.spawn();

// spawn characters and move them
myKitty.play();
myGhostA.play();
myGhostB.play();
myGhostC.play();

// win lose and all that
death();
win();

// transfer variables from one class to another
// to ghostA class
myGhostA.kittyRefX = myKitty.kittyX;
myGhostA.kittyRefY = myKitty.kittyY;
// to ghostB class
myGhostB.kittyRefX = myKitty.kittyX*2;
myGhostB.kittyRefY = myKitty.kittyY*2;
// to the food class
myFood.kittyRefX = myKitty.kittyX;
myFood.kittyRefY = myKitty.kittyY;
myFood.kittyRefS = myKitty.kittyW;

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// DEATH!!!
////////////////////////////////////////////////////////
void death()
{
  
float deathA = dist(myKitty.kittyX, myKitty.kittyY, myGhostA.ghostAX, myGhostA.ghostAY);
float deathB = dist(myKitty.kittyX, myKitty.kittyY, myGhostB.ghostBX, myGhostB.ghostBY);
float deathC = dist(myKitty.kittyX, myKitty.kittyY, myGhostC.ghostCX, myGhostC.ghostCY);

if (deathA < myKitty.kittyW || deathB < myKitty.kittyW || deathC < myKitty.kittyW)
{
  // pacKitty dies! 
  death.play();
  death.rewind();
  gamePhase=4;
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// WIN!!!!!!!
////////////////////////////////////////////////////////
void win()
{

if (myFood.kibbleEaten >= goalKibbles && myFood.fishEaten >= goalFish)
{ 
  // new level
  levelNum++;
  
  // up the goals!
  goalKibbles = goalKibbles+5;
  goalFish++;
  goalGhosts++;
  
  // make the ghosts faster!
  myGhostA.ghostASpeed++;
  myGhostB.ghostBSpeed++;
  myGhostC.ghostCSpeed++;
  
  // reset the character values!
  myKitty.kittyX = kittyStartX;
  myKitty.kittyY = kittyStartY;
  myGhostA.ghostAX = ghostStartX;
  myGhostA.ghostAY = ghostStartY;
  myGhostB.ghostBX = ghostStartX;
  myGhostB.ghostBY = ghostStartY;
  myGhostC.ghostCX = ghostStartX;
  myGhostC.ghostCY = ghostStartY;
  
  // reset the food placement
  myFood.foodX = myFood.makeFoodX(myFood.foodMax);
  myFood.foodY = myFood.makeFoodY(myFood.foodMax);
  myFood.tastyFishX = int( random(0, width) );
  myFood.tastyFishY = int( random(0, height) );
  
  // reset the score
  myFood.kibbleEaten = 0;
  myFood.fishEaten = 0;
  myFood.ghostsEaten = 0;
  
  // pacKitty wins this level!
  levelComplete.play();
  levelComplete.rewind();
  gamePhase=3;
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// LEVEL UP!
////////////////////////////////////////////////////////
void upLevel()
{

// level up screen image
background(levelImage);

// if spacebar is pressed, show level goals
if (keyPressed==true)
{
  if (key ==' ')
  {
  gamePhase=1;
  startTime=millis();
  }
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// SCORE
////////////////////////////////////////////////////////
void score()
{

// death screen image
background(deathImage);

// reset the character values!
myKitty.kittyX = kittyStartX;
myKitty.kittyY = kittyStartY;
myGhostA.ghostAX = ghostStartX;
myGhostA.ghostAY = ghostStartY;
myGhostB.ghostBX = ghostStartX;
myGhostB.ghostBY = ghostStartY;
myGhostC.ghostCX = ghostStartX;
myGhostC.ghostCY = ghostStartY;

// reset the food placement
myFood.foodX = myFood.makeFoodX(myFood.foodMax);
myFood.foodY = myFood.makeFoodY(myFood.foodMax);
myFood.tastyFishX = int( random(0, width) );
myFood.tastyFishY = int( random(0, height) );

// reset the score
myFood.kibbleEaten = 0;
myFood.fishEaten = 0;
myFood.ghostsEaten = 0;

// reset the goals
levelNum = 1;
goalKibbles = 10;
goalFish = 1;
goalGhosts = 0;

// reset the ghost speeds
myGhostA.ghostASpeed = 1;
myGhostB.ghostBSpeed = 1;
myGhostC.ghostCSpeed = 1;

// if R is pressed, show level 1 goals
if (keyPressed==true)
{
  if (key =='r')
  {
  gamePhase=0;
  intro.play();
  intro.rewind();
  }
}

}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// CLOSE THE AUDIO DOWN
////////////////////////////////////////////////////////
void stop()
{
intro.close();
kibble.close();
fish.close();
minim.stop();
super.stop();
}
////////////////////////////////////////////////////////
