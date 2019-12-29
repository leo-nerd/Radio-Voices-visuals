class FlowField {
  PVector[][] grid;
  float noiseFactor = 0.5;

  FlowField() {
    grid = new PVector[nRows+1][nCols+1];
  }

  //void init() {
  //  float xoff, yoff;
  //  grid = new PVector[nRows][nCols];
  //  yoff = 0;
  //  for (int row = 0; row < nRows; row++) {
  //    xoff = 0;
  //    for (int col = 0; col < nCols; col++) {
  //      float r = noise(xoff, yoff);
  //      grid[row][col] = new PVector(sin(r*TWO_PI), cos(r*TWO_PI));
  //      xoff+=noiseIncr;
  //    }
  //    yoff+=noiseIncr;
  //  }
  //}

  void update() {
    float xoff, yoff;
    yoff = 0;
    for (int row = 0; row < nRows+1; row++) {
      xoff = 0;
      for (int col = 0; col < nCols+1; col++) {
        float r = noiseFactor*noise(xoff, yoff, noiseIncr*frameCount);
        //float r = 0;
        //float r = noise(xoff, yoff);
        grid[row][col] = new PVector(cos(TWO_PI*(r-0.25-noiseFactor/2)), sin(TWO_PI*(r-0.25-noiseFactor/2)));
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
        stroke(255);
        strokeWeight(0.5);
        line(0, 0, 5*cellSize, 0);
        popMatrix();
      }
    }
  }

  void displayDebug() {
    stroke(255,255,255);
    strokeWeight(5);
    point(width/2, height/2);
    int row = floor(nRows/2);
    int col = floor(nCols/2);
    PVector v = grid[row][col];
    pushMatrix();
    translate(col*cellSize, row*cellSize);
    rotate(v.heading());
    //color c = color(map(v.heading(), -PI, PI, 0, 255), 255, 255);
    //stroke(c);
    stroke(255);
    strokeWeight(0.5);
    line(0, 0, 5*cellSize, 0);
    popMatrix();
  }
}
