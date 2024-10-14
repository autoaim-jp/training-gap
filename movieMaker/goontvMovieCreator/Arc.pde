class Arc {
	int x;
	int y;
	int diameter;
	float resolution;
	int fillColor;
	int emptyColor;
	boolean isCountdown;

	Arc(int _x, int _y, int _diameter, float _resolution, int _fillColor, int _emptyColor, boolean _isCountdown) {
		x = _x;
		y = _y;
		diameter = _diameter;
		resolution = _resolution;
		fillColor = _fillColor;
		emptyColor = _emptyColor;
		isCountdown = _isCountdown;
	}

	void draw() {
		int ellipseColor;
		int arcColor;
		if(isCountdown) {
			ellipseColor = fillColor;
			arcColor = emptyColor;
		} else {
			ellipseColor = emptyColor;
			arcColor = fillColor;
		}
		stroke(fillColor);

		/* ellipse */
		fill(ellipseColor);
		strokeWeight(2);
		ellipse(x, y, diameter, diameter);

		/* arc */
		fill(arcColor);
		strokeWeight(0);
		arc(x, y, diameter, diameter, PI + HALF_PI, PI + HALF_PI + radians(frameCount / resolution), PIE);
	}
}

