final int MAX_BALL_N = 707;
final int START_FADE_IN_FRAME_COUNT = 15;

int lastAddBallN1;
int lastAddBallN2;
int openBoxScaleX;
int openBoxScaleY;
int openBoxX;
int openBoxY;
OpenBox openBox;
ArrayList<Ball> ballList;
boolean endDraw;
boolean initDrawFrameOpening = false;

/* (no param) */
boolean drawFrameOpening(JSONObject obj, int startFrame, int endFrame) {
	if(!initDrawFrameOpening) {
		lastAddBallN1 = 1;
		lastAddBallN2 = 1;
		openBoxScaleX = 4;
		openBoxScaleY = 4;
		openBoxX = width / 2 - OpenBox.SIZE_X  * openBoxScaleX / 2;
		openBoxY = height / 2 - OpenBox.SIZE_Y  * openBoxScaleY / 2;
		openBox = new OpenBox(openBoxX, openBoxY, openBoxScaleX, openBoxScaleY);
		ballList = new ArrayList<Ball>();
		for(int i = 0; i < 10; i++) {
			addNewBall();
		}
		endDraw = false;
		initDrawFrameOpening = true;
	}

	background(255);
	if(frameCount < START_FADE_IN_FRAME_COUNT) {
		float alpha = float(frameCount) / START_FADE_IN_FRAME_COUNT * 180;
//		println(frameCount, float(frameCount / START_FADE_IN_FRAME_COUNT), alpha);
		fill(225, 225, 225, alpha);
		strokeWeight(5);
		stroke(15, 15, 15, alpha / 2);
		openBox.draw();
		return true;
	}
	/* fps(30): 100 frame => 3.3s */
	float alpha = 255.0 - (frameCount - START_FADE_IN_FRAME_COUNT) * 5.10;
	if(alpha > 180.0) {
		alpha = 180.0;
	}
	fill(225, 225, 225, alpha);
  strokeWeight(5);
	stroke(15, 15, 15, alpha / 2);
	openBox.draw();

	int ballListSize = ballList.size();
//	println("[info] frame and ball:", frameCount, ballListSize);
	if(!endDraw) {
		/* fibonacci for about 6s */
		int newAddBallN = int(random(4, lastAddBallN1 + lastAddBallN2)) - (frameCount - START_FADE_IN_FRAME_COUNT) / 12;
		/* continuous */
//		int newAddBallN = int(random(2, min((lastAddBallN1 + lastAddBallN2) / 3, 15)));
		for (int i = 0; i < newAddBallN; i++) {
			addNewBall();
		}
		lastAddBallN2 = lastAddBallN1;
		lastAddBallN1 = newAddBallN;
	}

	if(ballListSize == 0) {
		endDraw = true;
	}

	for (int i = ballList.size() - 1; i >= 0; i--) {
		Ball ball = ballList.get(i);
		ball.display();
		boolean isMovable = ball.move();
		if(!isMovable) {
			ballList.remove(ball);
		}
		ball.checkEdgeBound();
	}

  return true;
}


/* frame count written in bash/generateMovieByProcessing.sh */
int x;
int y;
int diameter;
float resolution;
Arc arc;
boolean initDrawFramePieCountDown = false;
boolean drawFramePieCountDown(JSONObject obj, int startFrame, int endFrame) {
	if(!initDrawFramePieCountDown) {
		x = width - 30;
		y = height - 30;
		diameter = 29;
		resolution = float(endFrame) / 360.0;
		arc = new Arc(x, y, diameter, resolution, color(206, 64, 95, 220), color(255, 255, 255), true);
		initDrawFramePieCountDown = true;
	}
	arc.draw();
	return true;
}

void addNewBall() {
	int x = int(openBoxX + random(19 * openBoxScaleX, 97 * openBoxScaleX));
	int y = openBoxY + (61 - 10) * openBoxScaleY;
	int xSpeed = int(random(-20, 20));
	int ySpeed = int(random(-20, 20));
	int life = int(random(55, 130));
	int diameter = int(random(5, 40));
	int c = color(int(random(75, 255)), int(random(75, 255)) , int(random(75, 255)));
	ballList.add(new Ball(x, y, xSpeed, ySpeed, life, diameter, c));
}

