// A little collision detector
// for circles
// NPC's or objects will be GREEN
// and static
// PC will be red and moves with mouse
//import java.util.Scanner;
// Variables
// Object's positions
int[] objects_x_coord;
int[] objects_y_coord;
// How many objects?
int amount_objects;
// Radius
int circles_radius;
int N;
int health = 500;
//NPC Speed
float npc_speed = random(1.5,6);

// Functions
// Initialize
void setup() {
  // Our window
  size(400, 400);
  // No contours for our circles
  noStroke();
  // Arrays
  amount_objects = 10;  // Objects in screen
  objects_x_coord = new int[amount_objects];
  objects_y_coord = new int[amount_objects];
  // Locate the objects (x,y)
  // Random!!!
  for (int counter=0; counter<amount_objects; counter++) {
    objects_x_coord[counter] = (int)random(width-1);
    objects_y_coord[counter] = (int)random(height-1);
  }
  // Radius for the circles is
  circles_radius = 8;
}

// Infinite loop
void draw() {
  // Background color
  background(0);
  // Object's color is green
  fill(0, 255, 0);
  // We loop through the objects
  for (int counter=0; counter<amount_objects; counter++) {
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
    objects_x_coord[counter]+=vectorX;
    objects_y_coord[counter]+=vectorY;
  }
    fill(244, 3, 3);
  noStroke();
  rect(20, 380, map(health, 0, 500, 0, 500), 19 );
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
      mouseX - objects_x_coord[counter];
    distance_between_centers[1]=
      mouseY - objects_y_coord[counter];
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
    text(health, 20, 380);
  } else {
    //println("NO");
    //text("HAS PERDIDO :(", 20, 380);
    text(health, 20, 380);
  }

  // Red for the PC
  fill(255, 0, 0);
  ellipse(mouseX, mouseY, 
    circles_radius, circles_radius);
}
