import processing.core.PApplet;
import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;

public class Particle extends VerletParticle2D{
//	PApplet p;
	Performa_particles p;
	AttractionBehavior2D repulsion;
	
	public Particle(Performa_particles _p, float _x, float _y) {
		super(_x, _y);
		p = _p;
		repulsion = new AttractionBehavior2D(this, Util.particleRadius*2, -1.0f, 0.01f);
//		repulsion = new AttractionBehavior2D(this, Util.particleRadius*2, -1.0f);
	}
	
	public void display() {
		float speed = getVelocity().magnitude(); 
		p.pushMatrix();
		p.translate(x, y);
		
		p.colorMode(p.HSB);
		int numPart = p.particles.size();
		p.stroke(200, PApplet.map(speed*numPart, 1, 10*Util.numParticles, 0, 255), PApplet.map(speed, 0.0f, 10.0f, 10.0f, 255.0f));
		p.strokeWeight(PApplet.map(speed, 0.0f, 10.0f, 0.1f, 5.0f));
		p.line(-5*p.random(-Util.particleRandomLineInterval, Util.particleRandomLineInterval),-5*p.random(-Util.particleRandomLineInterval, Util.particleRandomLineInterval), 5*p.random(-Util.particleRandomLineInterval, Util.particleRandomLineInterval), 5*p.random(-Util.particleRandomLineInterval, Util.particleRandomLineInterval));
		p.popMatrix();
	}
	
	void polygon(float x, float y, float radius, int npoints) {
		float angle = p.TWO_PI / npoints;
		p.beginShape();
		for (float a = 0; a < p.TWO_PI; a += angle) {
			float sx = x + p.cos(a) * radius;
			float sy = y + p.sin(a) * radius;
			p.vertex(sx, sy);
		}
		p.endShape(p.CLOSE);
	}
}