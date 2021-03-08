//Algebra Game
//Integrants:
//Josep Romera
//Pablo Perpiñan

String gameState;

int[] objects_x_coord;
int[] objects_y_coord;
int[] objects_x_coord2;
int[] objects_y_coord2;
// How many objects?
int amount_objects, escape;
// Radius
int circles_radius;
int N;
//Health of the player
int health;
//Player lifes
int lifes;
//NPC Speed
float npc_speed = random(1.5, 6);
//CountDown function
Timer countDownTimer;
int timeLeft; 


void setup() {
  size(800, 600);
  gameState = "START";
  amount_objects = 7;
  lifes = 3;
  health = 500;
  countDownTimer = new Timer(1000);
  timeLeft = 50;

  escape = 3;
  // Objects in screen
  objects_x_coord2 = new int[amount_objects];
  objects_y_coord2= new int[amount_objects];

  objects_x_coord = new int[escape];
  objects_y_coord = new int[escape];
  // Locate the objects (x,y)
  // Random!!!
  for (int counter=0; counter<amount_objects; counter++) {
    objects_x_coord2[counter] = (int)random(width-1);
    objects_y_coord2[counter] = (int)random(height-1);
  }
  for (int counter=0; counter<escape; counter++) {
    objects_x_coord[counter] = (int)random(width-1);
    objects_y_coord[counter] = (int)random(height-1);
  }
  // Radius for the circles is
  circles_radius = 8;
}

void draw() {
  clearBackground(); 
  if (gameState == "START") {
    startGame();
  } else if (gameState == "PLAY") {
    playGame();
  } else if (gameState == "WIN") {
    winGame();
  } else if (gameState == "LOSE") {
    loseGame();
  }
}

void startGame() {
  background(0);
  textAlign(CENTER);
  textSize(18);
  fill(255, 255, 255);
  text("Click Anywhere to Start Game", width/2, height/2);
  if (mousePressed == true) {
    gameState = "PLAY";
    countDownTimer.start();
  }
}

void playGame() {
  background(0);
  // Object's color is green
  fill(0, 255, 0);
  // We loop through the objects
  for (int counter=0; counter<escape; counter++) {
    ellipse(objects_x_coord[counter], 
      objects_y_coord[counter], 
      circles_radius, circles_radius);
    // 1- Evaluate a vector
    float vectorX, vectorY;
    vectorX=mouseX-objects_x_coord[counter];
    vectorY=mouseY-objects_y_coord[counter];
    // 2- Normalize the vector
    float magnitude = sqrt(vectorX*vectorX + vectorY*vectorY);
    vectorX/=magnitude;
    vectorY/=magnitude;
    // 3- Scale the vector

    vectorX*=npc_speed;
    vectorY*=npc_speed;
    // 4- Move the enemy
    objects_x_coord[counter]-=vectorX;
    objects_y_coord[counter]-=vectorY;
  }

  for (int counter2=0; counter2<amount_objects; counter2++) {
    ellipse(objects_x_coord2[counter2], 
      objects_y_coord2[counter2], 
      circles_radius, circles_radius);
    // 1- Evaluate a vector
    float vectorX, vectorY;
    vectorX=mouseX-objects_x_coord2[counter2];
    vectorY=mouseY-objects_y_coord2[counter2];
    // 2- Normalize the vector
    float magnitude = sqrt(vectorX*vectorX + vectorY*vectorY);
    vectorX/=magnitude;
    vectorY/=magnitude;
    // 3- Scale the vector

    vectorX*=npc_speed;
    vectorY*=npc_speed;
    // 4- Move the enemy
    objects_x_coord2[counter2]+=vectorX;
    objects_y_coord2[counter2]+=vectorY;
  }
  //Countdown
  if(countDownTimer.complete() == true){
   if (timeLeft > 1 ) {
      timeLeft--;
      countDownTimer.start();
   } else {
      lifes--;
   }
  }
  
  //Show Lifes and countdown 
  String showLifes ="Lives Left: " + lifes;
  String showCountdown ="Time Left: " + timeLeft;
  textAlign(LEFT);
  textSize(20);
  text(showLifes, 20, 50);
  text(showCountdown, 20, 70);
  
 
  
  
  //Show health bar
  fill(255, 0, 0);
  rect(55, 560, map(health, 0, 500, 0, 700), 19 );
  if(health <= 0){
    lifes--;
    health = 500;
    timeLeft = 50;
  } else if(lifes == 0){
    gameState = "LOSE";
  }

  


}

void winGame() {
  fill(0);
  text("HAS GANADO!", width/2, height/2);
  if (mousePressed == true) {
    gameState = "START";
  }
}

void loseGame() {
  background(0);
  fill(255,255,255);
  textSize(18);
  text("YOU LOSE :( ", width/2, height/2);
  
  
  //Try again button
  fill(255,255,255);
  rect(width/2-50, height/2+80, 100,60);
  fill(255,255,255);
  textSize(36);
  fill(0,255,0);
  text("Try Again", width/2, height/2+122); 
  float leftEdge = width/2-50;
  float rightEdge = width/2+50;
  float topEdge = height/2+80;
  float bottomEdge = height/2 + 140;
  
  if (mousePressed == true && 
      mouseX > leftEdge && 
      mouseX < rightEdge && 
      mouseY > topEdge && 
      mouseY < bottomEdge
      ) {
        
    gameState = "START";
    resetGame();
  }
}

void resetGame() {
  health = 500;
  lifes = 3;
  timeLeft = 50;
  objects_x_coord2 = new int[amount_objects];
  objects_y_coord2= new int[amount_objects];

  objects_x_coord = new int[escape];
  objects_y_coord = new int[escape];
  // Locate the objects (x,y)
  // Random!!!
  for (int counter=0; counter<amount_objects; counter++) {
    objects_x_coord2[counter] = (int)random(width-1);
    objects_y_coord2[counter] = (int)random(height-1);
  }
  for (int counter=0; counter<escape; counter++) {
    objects_x_coord[counter] = (int)random(width-1);
    objects_y_coord[counter] = (int)random(height-1);
  }
  // Radius for the circles is
  circles_radius = 8;
}

void clearBackground() {
  fill(255);
  rect(0, 0, width, height);
}

// Events (callbacks)
// PC moves with the mouse
void mouseMoved() {
  float[] distance_between_centers;
  float magnitude_of_vector;
  distance_between_centers =
    new float[2];  // For X and Y coords.
  boolean collided = false;

  // Collision detection code
  // 1- Find the vector
  // 2- Find the magnitude
  // 3- Evaluate distance
  // 4- Compare magnitude & distance
  // 5- Decide!
  // You should follow this sequence
  // for all the objects
  for (int counter=0; counter<amount_objects; counter++) {
    // Vector Coords.
    distance_between_centers[0]=
      mouseX - objects_x_coord2[counter];
    distance_between_centers[1]=
      mouseY - objects_y_coord2[counter];
    // Vector Magnitude.
    magnitude_of_vector = sqrt(
      distance_between_centers[0]*
      distance_between_centers[0] +
      distance_between_centers[1]*
      distance_between_centers[1]);
    // The comparison!
    // There is collision if...
    if (magnitude_of_vector<
      circles_radius+circles_radius) {
      collided = true;
    }
  }
  // We show a message
  fill(255);
  if (collided) {
    //println("YES
    //text("YES :)", 20, 380);
    health -= 1;
    
  } else {
    //println("NO");
    //text("HAS PERDIDO :(", 20, 380);
  }
  // Red for the PC
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, 
    circles_radius, circles_radius);
}
