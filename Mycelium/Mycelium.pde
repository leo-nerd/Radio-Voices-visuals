int cellSize = 10;
float noiseIncr = 0.01 ;
int nRows, nCols;
FlowField field;
ArrayList<Spore> spores;
Spore mutateThis;
PShader blur;

void setup() {
  blur = loadShader("blur.glsl");
  background(0);
  //colorMode(HSB);
  //size(1920, 1200, P2D);
  fullScreen(P2D);
  //nRows = Height/cellSize;
  //nCols = Width/cellSize;
  nRows = height/cellSize;
  nCols = width/cellSize;

  field = new FlowField();
  //field.init();

  spores = new ArrayList<Spore>();
}

void draw() {

  filter(blur);
  colorMode(RGB);
  rectMode(CORNER);
  //fill(0, 1);
  //rect(0, 0, width, height);
  field.update();
  //field.display();
  //field.displayDebug();
  for (int i = spores.size()-1; i>=0; i--) {
    //for (Spore s : spores) {
    Spore s = spores.get(i);
    s.update();
    s.display();
    if (s.isDead()) spores.remove(s);
  }

  if (mutateThis != null) {
    Spore s = mutateThis.copy();
    PVector a = PVector.fromAngle(random(-PI/2));
    s.acc.add(a);
    spores.add(s);
    mutateThis.acc.add(a.mult(-1));
    //spores.remove(mutateThis);
    mutateThis = null;
    println("new spore added. spores size = ", spores.size());
  }
  //println(frameRate);
}

void keyPressed() {
  if (key == ' ') {
    //for (int i = 0; i<50; i++) {
      spores.add(new Spore(new PVector(random(width), height)));
    //}
  }
}

void mousePressed() {
  spores.add(new Spore(new PVector(mouseX, mouseY)));
}
