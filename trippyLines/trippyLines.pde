int cellSize = 50;
float noiseIncr = 0.01 ;
FlowField field;

void setup() {
  colorMode(HSB);
  //size(1920, 1200, P2D);
  fullScreen(P2D);

  field = new FlowField();
  field.init();
  
  
}

void draw() {
  background(0);
  field.update();
  field.display();
  //println(field.grid[0][0].heading());
}
