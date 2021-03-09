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
int initial_time = 50;
float positionPlayer_X;
float positionPlayer_Y;

int enemies;

void setup() {
  size(800, 600);
  gameState = "START";
  lifes = 3;
  health = 500;
  countDownTimer = new Timer(1000);
  timeLeft = initial_time;

/*
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
  */
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
    if (keyPressed) {
  if( key >= '0' && key <= '9' && enemies <99){
    
    //enemies*=10;
    //enemies+=key-48;
    enemies=key-48;
  }
  if( key == BACKSPACE || key == DELETE ){
    enemies/=10;
  }
  if( key == ENTER && enemies > 0){
    // Use value.
    resetGame();
    gameState = "PLAY";
  }
  if( key == ENTER && enemies == 0){
    text("You need to select at least one enemy!!!", width/2, height/2+60);
  }
  }
  text(enemies, width/2, height/2);
  text("Select the amount of enemies and press ENTER", width/2, height/2-60);
  /*
  if (mousePressed == true) {
    gameState = "PLAY";
    countDownTimer.start();
  }
  */
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
    vectorX=positionPlayer_X-objects_x_coord[counter];
    vectorY=positionPlayer_Y-objects_y_coord[counter];
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
    vectorX=positionPlayer_X-objects_x_coord2[counter2];
    vectorY=positionPlayer_Y-objects_y_coord2[counter2];
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
      positionPlayer_X - objects_x_coord2[counter];
    distance_between_centers[1]=
      positionPlayer_Y - objects_y_coord2[counter];
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
    health -= 3;
    //IMPORTANTE, AQUI SE RESETEAN LOS ENEMIGOS QUE TE GOLPEAN
  } 
  
  //Countdown
  if (countDownTimer.complete() == true) {
    if (timeLeft > 1 ) {
      timeLeft--;
      countDownTimer.start();
    } else {
      lifes--;
      timeLeft = initial_time;
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
  if (health <= 0) {
    lifes--;
    health = 500;
    timeLeft = initial_time;
  } else if (lifes == 0) {
    gameState = "LOSE";
  }
  
    // Red for the PC
  fill(255, 0, 0);
  ellipse(positionPlayer_X, positionPlayer_Y, 
    circles_radius, circles_radius);
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
  fill(255, 255, 255);
  textSize(18);
  text("YOU LOSE :( ", width/2, height/2);


  //Try again button
  fill(255, 255, 255);
  rect(width/2-50, height/2+80, 100, 60);
  fill(255, 255, 255);
  textSize(36);
  fill(0, 255, 0);
  text("Try Again", width/2, height/2+122); 
  float leftEdge = width/2-50;
  float rightEdge = width/2+50;
  float topEdge = height/2+80;
  float bottomEdge = height/2 + 140;

  if (mousePressed == true && 
    positionPlayer_X > leftEdge && 
    positionPlayer_X < rightEdge && 
    positionPlayer_Y > topEdge && 
    positionPlayer_Y < bottomEdge
    ) {

    gameState = "START";
    resetGame();
  }
}

void resetGame() {
  amount_objects = enemies / 3;
    escape = enemies / 3;
  health = 500;
  lifes = 3;
  timeLeft = initial_time;
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
  positionPlayer_X = mouseX;
  positionPlayer_Y = mouseY;
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
       positionPlayer_Y = positionPlayer_Y - 10;
    } else if (keyCode == DOWN) {
      positionPlayer_Y = positionPlayer_Y +10;
    } 
    else if (keyCode == RIGHT) {
       positionPlayer_X = positionPlayer_X + 10;
    } else if (keyCode == LEFT) {
      positionPlayer_X = positionPlayer_X -10;
    } 
  }
}
