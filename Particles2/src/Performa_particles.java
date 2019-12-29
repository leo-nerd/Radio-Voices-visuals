import java.util.ArrayList;
import processing.core.PApplet;
import processing.core.PVector;
import toxi.geom.*;
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.physics2d.constraints.*;

public class Performa_particles extends PApplet {
	ArrayList<Particle> particles;
	VerletPhysics2D physics;
	GravityBehavior2D gravity;
//	Circle circConstraintBoundary;
//	CircularConstraint constraint;
	AttractionBehavior2D repulsion;

	public static void main(String[] args) {
		PApplet.main("Performa_particles");
	}

	public void settings() {
		//		size(860, 600);
		//		size(1920, 1200);
		//		size(1920, 1080);
		size(1920, 900);
	}

	public void setup() {
		physics = new VerletPhysics2D();
		gravity = new GravityBehavior2D(Vec2D.Y_AXIS.scale(0.1f));
		physics.addBehavior(gravity);
		repulsion = new AttractionBehavior2D(new Vec2D(width/2, height), Util.constraintRadius, -10.0f);
		particles = new ArrayList<Particle>();
//		createParticles(500);
//		for (Particle p : particles) {
//			physics.addParticle(p);
//			physics.addBehavior(p.repulsion);
//		}
		physics.addBehavior(repulsion);
		physics.setWorldBounds(new Rect(0, 0, width, height-10));
		physics.setDrag(0.02f);
		rectMode(CENTER);
	}

	public void draw() {
		if (particles.size() < Util.numParticles) {
			if (frameCount % floor(frameRate/4) == 0) {
				addParticle();
			}
		}
		physics.update();
		fill(0, 0, 0, 30);
		noStroke();
		rect(width/2, height/2, width, height);
		for (Particle p : particles) {
			p.display();
		}
	}

	public PVector vec2DToPVector(Vec2D _v) {
		PVector pv = new PVector(_v.x, _v.y);
		return pv;
	}

	public Vec2D pVectorToVec2D (PVector _v) {
		Vec2D pv = new Vec2D(_v.x, _v.y);
		return pv;
	}

	public void createParticles(int _i) {
		for(int i = 0; i < _i; i++) {
			Particle p = new Particle(this, random(width), random(height));
			particles.add(p);
		}
	}
	
	public void addParticle() {
		Particle p = new Particle(this, random(width), 0);
		particles.add(p);
		physics.addParticle(p);
		physics.addBehavior(p.repulsion);
	}

	public void mouseDragged() {
//		repulsion.setAttractor(new Vec2D(mouseX, mouseY));
		repulsion.setAttractor(new Vec2D(mouseX, height));
	}
}
