class FlowField {
  PVector[][] grid;
  int nRows, nCols;

  FlowField() {
    nRows = floor(height/cellSize)+5;
    nCols = floor(width/cellSize)+5;
    grid = new PVector[nRows][nCols];
  }

  void init() {
    float xoff, yoff;
    yoff = 0;
    for (int row = 0; row < nRows; row++) {
      xoff = 0;
      for (int col = 0; col < nCols; col++) {
        float r = noise(xoff, yoff);
        grid[row][col] = new PVector(sin(r*TWO_PI), cos(r*TWO_PI));
        xoff+=noiseIncr;
      }
      yoff+=noiseIncr;
    }
  }

  void update() {
    float xoff, yoff;
    yoff = 0;
    for (int row = 0; row < nRows; row++) {
      xoff = 0;
      for (int col = 0; col < nCols; col++) {
        float r = noise(xoff, yoff, noiseIncr*frameCount);
        grid[row][col] = new PVector(sin(r*TWO_PI), cos(r*TWO_PI));
        xoff+=noiseIncr;
      }
      yoff+=noiseIncr;
    }
  }

  void display() {
    for (int row = 0; row < nRows; row++) {
      for (int col = 0; col < nCols; col++) {
        PVector v = grid[row][col];
        pushMatrix();
        translate(col*cellSize, row*cellSize);
        rotate(v.heading());
        //color c = color(map(v.heading(), -PI, PI, 0, 255), 255, 255);
        //stroke(c);
        strokeWeight(5);
        stroke(0, 0, 255);
        line(-cellSize, 0, cellSize, 0);
        popMatrix();
      }
    }
  }
}
