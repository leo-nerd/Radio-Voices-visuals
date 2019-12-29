class Spore {
  PVector pos, vel, acc;
  float maxSpeed = 1;
  float radius = 2;
  float mutationRandom;
  int lifeSpan = 1500;

  Spore(PVector _loc) {
    pos = _loc;
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void update() {
    PVector force = field.grid[floor(pos.y/cellSize)][floor(pos.x/cellSize)];
    acc.add(force.mult(0.01));
    vel.add(acc);
    vel.add(new PVector(random(-0.05, 0.05), 0));
    //vel.sub(PVector.fromAngle(vel.heading()).mult(0.005)); //damping
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
    if (pos.x < 0) pos.x = width;
    if (pos.x > width) pos.x = 0;
    if (pos.y < 0) pos.y = height;
    if (pos.y > height) pos.y = 0;
    //if(pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) spores.remove(this);
    mutationRandom = random(1);
    if (mutationRandom < 0.5 && mutationRandom > 0.499)
    {
      mutateThis = this;
    }
    lifeSpan--;
  }

  void display() {
    colorMode(HSB);
    pushMatrix();
    translate(pos.x, pos.y);
    //rotate(vel.heading()+radians(180));
    //stroke(255, 0, 0);
    //point(0, 0);
    rotate(vel.heading());
    float sat = map(vel.mag(), maxSpeed, maxSpeed*1.1, 0, 100);
    fill(255, sat, 255);
    noStroke();
    rect(0, 0, radius, radius);
    //float angle = TWO_PI / 20;
    //beginShape();
    //for (float a = 0; a < TWO_PI; a += angle) {
    //  float sx = pos.x + cos(a) * radius;
    //  float sy = pos.y + sin(a) * radius;
    //  vertex(sx, sy);
    //}
    //endShape(CLOSE);
    //line(0, 0, cellSize/2, 0);
    popMatrix();
  }

  Spore copy() {
    Spore s = new Spore(pos.copy());
    s.vel = vel.copy();
    s.acc = acc.copy();
    return s;
  }

  boolean isDead() {
    if (lifeSpan <= 0) {
      return true;
    } else {
      return false;
    }
  }
}
