////////////////////////////////////////////////////////
// DRAWS AND MOVES PACKITTY
// Inherits maze class for movement parameters
////////////////////////////////////////////////////////


class PacKitty extends Maze
{
////////////////////////////////////////////////////////
// GLOBAL VARIABLES
////////////////////////////////////////////////////////
// shapes
PShape packitty = loadShape("packitty.svg");

// floats and ints
float kittyW=50;                 // width
float kittyH=kittyW;             // height
float kittyX=950;                 // x position
float kittyY=550;                 // y position
float kittySpeed=3;              // speed of packitty
float lipBottom=radians(30);     // upper lip degree
float lipTop=radians(330);       // lower lip degree


// booleans
boolean lipBottomClosed=false;   // is packitty's bottom lip closed?
boolean lipTopClosed=false;      // is packitty's top lip closed?
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// VARIABLES VALUES (CONSTRUCTOR)
////////////////////////////////////////////////////////
PacKitty()
{
// take the variables from the maze class
// we need them to make packitty move
super();

// define style
noStroke();
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// DRAWING PACKITTY
////////////////////////////////////////////////////////
void spawn(float kittyX, float kittyY)
{
// open and close packitty's mouth smoothly
// bottom lip
if (lipBottom > radians(0) && lipBottomClosed == false)
{
  lipBottom=lipBottom-radians(1);
}

if (lipBottom < radians(0))
{
  lipBottomClosed=true;
}

if (lipBottomClosed == true)
{
  lipBottom=lipBottom+radians(1);
}

if (lipBottom > radians(30))
{
  lipBottomClosed=false;
}

// top lip
if (lipTop < radians(360) && lipTopClosed == false)
{
  lipTop=lipTop+radians(1);
}

if (lipTop > radians(360))
{
  lipTopClosed=true;
}

if (lipTopClosed == true)
{
  lipTop=lipTop-radians(1);
}

if (lipTop < radians(330))
{
  lipTopClosed=false;
}

// packitty's body & mouth
fill(137, 172, 191);
arc(kittyX, kittyY, kittyW, kittyH, lipBottom, lipTop);

// packitty's accessories!
shapeMode(CENTER);
shape(packitty, kittyX-6, kittyY-4, 100, 100);
}
////////////////////////////////////////////////////////


////////////////////////////////////////////////////////
// MOVE PACKITTY
////////////////////////////////////////////////////////
void play()
{
// booleans
boolean up_left = false;
boolean up_right = false;
boolean down_right = false;
boolean down_left = false;
boolean kittyState1 = false;      // is packitty looking up?
boolean kittyState2 = false;      // is packitty looking down?
boolean kittyState3 = false;      // is packitty looking left?
boolean kittyState4 = true;      // is packitty looking right?

// rotate packitty up, down, right, and left
if (key == CODED)
{
  
  
// move packitty up
// check for walls
if (keyCode == UP)
{
kittyState1=true;
kittyState2=false;
kittyState3=false;
kittyState4=false;

// this checks for walls
if (kittyY >= kittyW/2 + kittySpeed)
{
up_left = collisionMap[int(kittyX - kittyW/2)][int(kittyY - kittySpeed - kittyW/2)];
up_right = collisionMap[int(kittyX + kittyW/2)][int(kittyY - kittySpeed - kittyW/2)];
down_right = collisionMap[int(kittyX + kittyW/2)][int(kittyY - kittySpeed + kittyW/2)];
down_left = collisionMap[int(kittyX - kittyW/2)][int(kittyY - kittySpeed + kittyW/2)];

// corner tracker
//pushStyle();
//stroke(0,255,0);
//strokeWeight(5);
//point(int(kittyX - kittyW/2),int(kittyY - kittySpeed - kittyW/2));
//point(int(kittyX + kittyW/2),int(kittyY - kittySpeed - kittyW/2));
//point(int(kittyX + kittyW/2),int(kittyY - kittySpeed + kittyW/2));
//point(int(kittyX - kittyW/2),int(kittyY - kittySpeed + kittyW/2));
//popStyle();

// if there are no walls move
if (up_left && up_right && down_right && down_left) 
{
kittyY -= kittySpeed;
}}} 
  
  
// move packitty down
// check for walls
else if (keyCode == DOWN)
{
kittyState2=true;
kittyState3=false;
kittyState4=false;
kittyState1=false;

// this checks for walls
if (kittyY <= height - kittyW/2 - kittySpeed)
{
up_left = collisionMap[int(kittyX - kittyW/2)][int(kittyY + kittySpeed - kittyW/2)];
up_right = collisionMap[int(kittyX + kittyW/2)][int(kittyY + kittySpeed - kittyW/2)];
down_right = collisionMap[int(kittyX + kittyW/2)][int(kittyY + kittySpeed + kittyW/2)];
down_left = collisionMap[int(kittyX - kittyW/2)][int(kittyY + kittySpeed + kittyW/2)];

//corner tracker
//pushStyle();
//stroke(255,255,0);
//strokeWeight(5);
//point(int(kittyX - kittyW/2),int(kittyY + kittySpeed - kittyW/2));
//point(int(kittyX + kittyW/2),int(kittyY + kittySpeed - kittyW/2));
//point(int(kittyX + kittyW/2),int(kittyY + kittySpeed + kittyW/2));
//point(int(kittyX - kittyW/2),int(kittyY + kittySpeed + kittyW/2));
//popStyle();

// if there are no walls you may move
if (up_left && up_right && down_right && down_left)
{
kittyY += kittySpeed;
}}}


// move packitty left
// check for walls
else if (keyCode == LEFT)
{
kittyState3=true;
kittyState4=false;
kittyState1=false;
kittyState2=false;

// this checks for walls
if (kittyX >= kittyW/2 + kittySpeed)
{
up_left = collisionMap[int(kittyX - kittySpeed - kittyW/2)][int(kittyY - kittyW/2)];
up_right = collisionMap[int(kittyX + kittySpeed - kittyW/2)][int(kittyY - kittyW/2)];
down_right = collisionMap[int(kittyX - kittySpeed + kittyW/2)][int(kittyY + kittyW/2)];
down_left = collisionMap[int(kittyX - kittySpeed - kittyW/2)][int(kittyY + kittyW/2)];

//corner tracker
//pushStyle();
//strokeWeight(5);
//stroke(255,0,0);
//point(int(kittyX - kittySpeed - kittyW/2),int(kittyY - kittyW/2));
//point(int(kittyX + kittySpeed + kittyW/2),int(kittyY - kittyW/2));
//point(int(kittyX - kittySpeed + kittyW/2),int(kittyY + kittyW/2));
//point(int(kittyX - kittySpeed - kittyW/2),int(kittyY + kittyW/2));
//popStyle();

// if there are no walls move
if (up_left && up_right && down_right && down_left) 
{
kittyX -= kittySpeed;
}}}
  

// move packitty right
// check for walls
else if (keyCode == RIGHT)
{
kittyState4=true;
kittyState1=false;
kittyState2=false;
kittyState3=false;

// this checks for walls
if (kittyX <= width - kittyW/2 - kittySpeed)
{
up_left = collisionMap[int(kittyX + kittySpeed - kittyW/2)][int(kittyY - kittyW/2)];
up_right = collisionMap[int(kittyX + kittySpeed + kittyW/2)][int(kittyY - kittyW/2)];
down_right = collisionMap[int(kittyX + kittySpeed + kittyW/2)][int(kittyY + kittyW/2)];
down_left = collisionMap[int(kittyX + kittySpeed - kittyW/2)][int(kittyY + kittyW/2)];

//corner tracker
//pushStyle();
//stroke(0,0,255);
//strokeWeight(5);
//point(int(kittyX + kittySpeed - kittyW/2),int(kittyY - kittyW/2));
//point(int(kittyX + kittySpeed + kittyW/2),int(kittyY - kittyW/2));
//point(int(kittyX + kittySpeed + kittyW/2),int(kittyY + kittyW/2));
//point(int(kittyX + kittySpeed - kittyW/2),int(kittyY + kittyW/2));
//popStyle();

// if there are no walls move
if (up_left && up_right && down_right && down_left) 
{
kittyX += kittySpeed;
}}}
  
  
// left portal
if (kittyY < 570 && kittyY > 290 && kittyX < 55)
{
kittyX=940;
kittyY=150;
}

// right portal
if (kittyX < 1000 && kittyX > 950 && kittyY < 220)
{
kittyX=60;
kittyY=500;
}

// check for problems
//println("kittyX: "+kittyX+" ||| kittyY: "+kittyY);
}


// this is where the actual rotation of packitty happens
// rotate packitty UP
if (kittyState1==true)
{
pushMatrix();
  translate(kittyX, kittyY);
  rotate(radians(-90));
  spawn(0, 0);
popMatrix();
}

// rotate packitty DOWN
else if (kittyState2==true)
{
pushMatrix();
  translate(kittyX, kittyY);
  rotate(radians(90));
  spawn(0, 0);
popMatrix();
}

// rotate packitty LEFT
else if (kittyState3==true)
{
pushMatrix();
  scale(-1, 1);
  spawn(-kittyX, kittyY);
popMatrix();
}

// rotate packitty RIGHT
else if (kittyState4==true)
{
pushMatrix();
  spawn(kittyX, kittyY);
popMatrix();
}

// check for problems
//println("X: "+kittyX+" Y: "+kittyY);

}
////////////////////////////////////////////////////////

}

