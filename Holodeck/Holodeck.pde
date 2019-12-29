import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

int boxWidth = 10000;
int boxDepth = 5000;
int boxHeight = 1300;
//int rectHeight = 1200;
int cellSize = 150;
PVector pos;
AniSequence zoomOut, rotate;
float posZ = 0;
float rotY = 0;

void setup() {
  //size(1920, 1200, P3D);
  fullScreen(P3D);
  rectMode(CENTER);
  background(0);
  stroke(255);
  strokeWeight(2);
  noFill();
  pos = new PVector(width/2, height/2, posZ);
  
  Ani.init(this);
  zoomOut = new AniSequence(this);
  zoomOut.beginSequence();
  zoomOut.add(Ani.to(this, 10, "posZ", 0, Ani.LINEAR));
  zoomOut.endSequence();
  
  rotate = new AniSequence(this);
  rotate.beginSequence();
  rotate.add(Ani.to(this, 20, "rotY", TWO_PI, Ani.LINEAR));
  rotate.endSequence();
}

void draw() {
  background(0);
  pushMatrix();
  translate(pos.x, pos.y, posZ);
  rotateY(rotY);
  //rect(0, 0, 100, 100);
  //pushMatrix();
  //rotateZ(PI/2);
  //for (int xOffset = -floor(boxWidth/2); xOffset < boxWidth/2; xOffset+=cellSize) {
  //  pushMatrix();
  //  translate(xOffset, 0, 0);
  //  popMatrix();
  //}
  //popMatrix();
  for (int zOffset = -ceil(boxDepth/2); zOffset < ceil(boxDepth/2); zOffset+=cellSize) {
    pushMatrix();
    translate(0, 0, zOffset);
    rect(0, 0, boxWidth, boxHeight);
    popMatrix();
  }
  pushMatrix();
  rotateY(PI/2);
  for (int xOffset = -ceil(boxWidth/2); xOffset < ceil(boxWidth/2)+1; xOffset+=cellSize) {
    pushMatrix();
    translate(0, 0, xOffset);
    rect(0, 0, boxDepth, boxHeight);
    popMatrix();
  }
  popMatrix();

  rotateX(PI/2);
  for (int yOffset = -ceil(boxHeight/2); yOffset < ceil(boxHeight/2)+1; yOffset+=cellSize) {
    pushMatrix();
    translate(0, 0, yOffset);
    rect(0, 0, boxWidth, boxDepth);
    popMatrix();
  }

  popMatrix();
}

void keyPressed() {
  if (key == 'a') pos.x -= 10;
  if (key == 'd') pos.x += 10;
  if (key == 'w') pos.z -= 10;
  if (key == 's') pos.z += 10;
  if (key == 'z') pos.z +=100;
  if (key == 'x') pos.z -=100;

  if (key == ' ') save("still pos.x="+ str(pos.x)+"still pos.y="+ str(pos.y)+".png");

  if (key == 't') {
    zoomOut.start();
  }
  
  if (key == 'r') {
    rotate.start();
  }

  println(pos.x, pos.z);
}
