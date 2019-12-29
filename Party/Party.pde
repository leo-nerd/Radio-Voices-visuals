int nRect = 5;
int nLines = 4;
float[] xCenters_rest;
float[] heightFactors;
color[] colors;
float baseHeight = 100;
ArrayList<Block> blocks;
float[] heighFactors;
float pulseHeight;
int frameRemainder;
int frameFrequency = 2;
float minWidth = 20;
float maxWidth;
float maxLineVar = 100;

float blackOutAlpha = 255;

PShader blur;

void setup() {
  blur = loadShader("blur.glsl");

  fullScreen(P2D);
  rectMode(CENTER);
  colorMode(HSB);
  noStroke();
  maxWidth = width/nRect;
  blocks = new ArrayList<Block>();
  colors = new color[nLines];
  heightFactors = new float[nLines];
  for (int i = 0; i<nRect; i++) {
    blocks.add(new Block(i));
  }

  colors[0] = #DE362F;
  colors[1] = #08815C;
  colors[2] = #1C6FA7;
  colors[3] = #E7C109;

  for (int i = 0; i < nLines; i++) {
    //colors[i] = color(map(i, 0, nLines, 0, 255), 255, 255);
    heightFactors[i] = 1 - (float)i/nLines;
  }
}

void updateY() {

  for (int i = 1; i < nRect; i++) {
    Block b = blocks.get(i);
    Block prevB = blocks.get(i-1);

    if (!b.isUpdated) {
      b.center.y = prevB.center.y;
      b.isUpdated = true;
      break;
    }
  }
}

void draw() {
  //rectMode(CENTER);
  filter(blur);
  //background(0);
  fill(0, 0, 0, blackOutAlpha);
  rect(width/2, height/2, width, height);
  noiseSeed(0);
  pulseHeight = constrain(noise(0.001*frameCount), 0, 0.5);
  //pulseHeight = 0.5;
  if (frameCount%frameFrequency==0) {

    updateY();
  }
  for (Block b : blocks) {
    b.display();
  }
}

void keyPressed(){
  //blackOutAlpha = map(key, 0, 9, 0, 255);
  if(key == 'h') blackOutAlpha = 10;
  if(key == 'g') blackOutAlpha = 255;
}
//void mouseClicked() {
//  //frameRemainder = frameCount%frameFrequency;
//  noiseSeed(1);
//  float f = noise(0.1*frameCount);
//  blocks.get(0).center.y = height/2*(1 + 0.5*f);
//  for (Block b : blocks) {
//    b.isUpdated = false;
//  }
//}
