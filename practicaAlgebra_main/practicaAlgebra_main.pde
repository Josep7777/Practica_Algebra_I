//Algebra Game
//Integrants:
//Josep Romera
//Pablo Perpiñan

String gameState;

int[] objects_x_coord;
int[] objects_y_coord;
int[] objects_x_coord2;
int[] objects_y_coord2;
int[] objects_x_coord3;
int[] objects_y_coord3;
int[] rec_objects_x_coord;
int[] rec_objects_y_coord;
int rectangles_width, rectangles_height;
// How many objects?
int amount_objects, escape, random;
// Radius
int circles_radius;
int N;
//Health of the player
int health;
//Player lifes
int lifes;
//NPC Speed
float npc_speed = random(1.5, 6);
float randomvalue = random(1.5, 6);
//CountDown function
Timer countDownTimer;
int timeLeft; 
int initial_time = 50;
float positionPlayer_X;
float positionPlayer_Y;

int enemies;
int amount_rectangles;

void setup() {
  size(800, 600);
  gameState = "START";
  lifes = 3;
  health = 500;
  countDownTimer = new Timer(1000);
  timeLeft = initial_time;


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
  } else if (gameState == "BOSS") {
    bossGame();
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
    if ( key >= '0' && key <= '9' && enemies <99) {

      //enemies*=10;
      //enemies+=key-48;
      enemies=key-48;
    }
    if ( key == BACKSPACE || key == DELETE ) {
      enemies/=10;
    }
    if ( key == ENTER && enemies > 0) {
      // Use value.
      resetGame();
      gameState = "PLAY";
    }
    if ( key == ENTER && enemies == 0) {
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
  background(107, 11, 219);
  // Object's color is green
  //PORTALS
  fill(221, 229, 14);
  ellipse(400, 100, 100, 30);
  fill(75, 136, 255);
  ellipse(30, 300, 30, 100);
  ellipse(400, 570, 100, 30);
  ellipse(770, 300, 30, 100);

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

  for (int counter3=0; counter3<random; counter3++) {
    ellipse(objects_x_coord3[counter3], 
      objects_y_coord3[counter3], 
      circles_radius, circles_radius);
    // 1- Evaluate a vector
    float vectorX, vectorY;
    vectorX=mouseX-objects_x_coord3[counter3];
    vectorY=mouseY-objects_y_coord3[counter3];
    // 2- Normalize the vector
    float magnitude = sqrt(vectorX*vectorX + vectorY*vectorY);
    vectorX/=magnitude;
    vectorY/=magnitude;
    // 3- Scale the vector

    vectorX*=npc_speed;
    vectorY*=npc_speed;
    // 4- Move the enemy
    objects_x_coord3[counter3]+=vectorX;
    objects_y_coord3[counter3]+=vectorY;
    //objects_x_coord3[counter3]+=vectorX *randomvalue;
    //objects_y_coord3[counter3]+=vectorY *randomvalue;
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
  String showLifes ="Lives Left:   " + lifes;
  String showCountdown ="Time Left:   " + timeLeft;
  String showPuntuation ="Puntuation: 0";



  fill(0);
  //fill(201,191,191);
  rect(0, 0, 800, 75 );
  //Show health bar
  fill(201, 191, 191);
  rect(200, 35, 535, 19 );
  textAlign(LEFT);
  textSize(20);
  text(showLifes, 20, 25);
  text(showCountdown, 20, 45);
  text(showPuntuation, 20, 65);
  fill(255, 0, 0);
  rect(200, 35, map(health, 0, 500, 0, 535), 19 );
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

  fill(200, 64, 255);

  // We loop through all the rectangles
  for (int counter=0; counter<amount_rectangles; counter++) {
    rect((float)rec_objects_x_coord[counter], 
      (float)rec_objects_y_coord[counter], 
      (float)rectangles_width, 
      (float)rectangles_height);
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

void bossGame() {
}

void resetGame() {
  amount_objects = enemies / 3;
  escape = enemies / 3;
  random = enemies / 3;
  health = 500;
  lifes = 3;
  random = 5;
  timeLeft = initial_time;

  amount_rectangles = 8;

  rec_objects_x_coord = new int[amount_rectangles];
  rec_objects_y_coord = new int[amount_rectangles];
  // Locate the rectangles, randomly
  for (int counter=0; counter<amount_rectangles; counter++) {
    rec_objects_x_coord[counter] = (int)random(width - 5);
    rec_objects_y_coord[counter] = (int)random(80, height -8);
  }
  // Set the sizes for the rectangles
  rectangles_width = 30;
  rectangles_height = 15;

  objects_x_coord2 = new int[amount_objects];
  objects_y_coord2= new int[amount_objects];

  objects_x_coord = new int[escape];
  objects_y_coord = new int[escape];

  objects_x_coord3 = new int[random];
  objects_y_coord3 = new int[random];
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
  for (int counter=0; counter<random; counter++) {
    objects_x_coord3[counter] = (int)random(width-1);
    objects_y_coord3[counter] = (int)random(height-1);
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

  boolean collided = true;
  // Collision detector for AABB's
  // 1- Find the coords for the two rectangles
  // 2- Comparison of the limits
  // 3- Decide!
  // We find xmin,xmax,ymin,ymax
  // for the P.C.

  // Xcenter - width/2
  float xmin1= mouseX -
    (rectangles_width/2.0);

  // Xcenter + width/2
  float xmax1=mouseX +
    (rectangles_width/2.0);

  // Ycenter + height/2
  float ymin1=mouseY +
    (rectangles_height/2.0);

  // Ycenter - height/2
  float ymax1=mouseY -
    (rectangles_height/2.0);

  // Let's follow the same
  // sequence with the rest of the
  // objects - rectangles
  for (int counter=0; counter<amount_rectangles; counter++) {
    // Evaluate the values for
    // the NPC rectangle
    float xmin2=rec_objects_x_coord[counter]
      -(rectangles_width/2.0);
    float xmax2=rec_objects_x_coord[counter]
      +(rectangles_width/2.0);
    // Watch out! processing and the
    // Y axis!!! (reversed)
    float ymin2=rec_objects_y_coord[counter]
      +(rectangles_height/2.0);
    float ymax2=rec_objects_y_coord[counter]
      -(rectangles_height/2.0);
    // Collision state
    collided = true;
    // There is no collision if...
    if ((xmax1<xmin2)|| // 1 vs 2
      (ymax1>ymin2)|| // 1 vs 2
      (xmax2<xmin1)|| // 2 vs 1
      (ymax2>ymin1)) // 2 vs 1
      collided = false;
    // Text in white
    fill(255);
    // Feedback to the user
    if (collided) text("YES!!!", 20, 380);
    //else text("NO :(", 20, 380);
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      positionPlayer_Y = positionPlayer_Y - 10;
    } else if (keyCode == DOWN) {
      positionPlayer_Y = positionPlayer_Y +10;
    } else if (keyCode == RIGHT) {
      positionPlayer_X = positionPlayer_X + 10;
    } else if (keyCode == LEFT) {
      positionPlayer_X = positionPlayer_X -10;
    }
  }
}
