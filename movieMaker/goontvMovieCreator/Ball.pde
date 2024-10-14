class Ball {
	int x;
	int y;
	float xSpeed;
	float ySpeed;
	int life;
	float diameter;
	int radius;
	color c;

	Ball(int _x,int _y,float _xSpeed,float _ySpeed, int _life, float _diameter, color _c) {
		x = _x;
		y = _y;
		xSpeed = _xSpeed;
		ySpeed = _ySpeed;
		life = _life;
		diameter = _diameter;
		radius = floor(diameter / 2) - 1;
		c = _c;

		if(xSpeed == 0) {
			xSpeed = 2;
		}

		if(ySpeed == 0) {
			ySpeed = 2;
		}
	}

	void display() {
		pushMatrix();
		fill(c, life);
		noStroke();
		translate(x, y);
		// sphere(diameter);
		triangle(0, - diameter / 2, diameter / 2, diameter / 2, - diameter / 2, diameter / 2);
		box(diameter);
		popMatrix();
		/*
		if(random(0, 2) < 1) {
			ellipse(x, y, diameter, diameter);
		} else {
			rect(x, y, diameter, diameter);
		}
		*/
	}

	boolean move() {
		x += xSpeed;
		y += ySpeed;
		if(life < 0) {
			return false;
		} else {
			life -= 3;
			return true;
		}
	}

	void checkEdgeBound() {
		if(x > width - radius || x < radius) {
			xSpeed *= -1;
		}
		if(y > height - radius || y < radius) {
			ySpeed *= -1;
		}
	}
}

