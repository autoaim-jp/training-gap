public class OpenBox {
  static final int SIZE_X = 115; 
  static final int SIZE_Y = 92;
  int scaleX = 5;
  int scaleY = 5;
  int x = 0;
  int y = 0;

  OpenBox(int _x, int _y, int _scaleX, int _scaleY) {
    x = _x;
    y = _y;
    scaleX = _scaleX;
    scaleY = _scaleY;
  }

  void draw() {
    pushMatrix();
    translate(x, y);

    /* background top */
    beginShape();
    vertex(21 * scaleX, 21 * scaleY);
    vertex(27 * scaleX, 1 * scaleY);
    vertex(89 * scaleX, 1 * scaleY);
    vertex(95 * scaleX, 21 * scaleY);
    endShape(CLOSE);

    /* left top */
    beginShape();
    vertex(21 * scaleX, 21 * scaleY);
    vertex(5 * scaleX, 41 * scaleY);
    vertex(1 * scaleX, 81 * scaleY);
    vertex(19 * scaleX, 61 * scaleY);
    endShape();

    /* right top */
    beginShape();
    vertex(95 * scaleX, 21 * scaleY);
    vertex(113 * scaleX, 41 * scaleY);
    vertex(115 * scaleX, 81 * scaleY);
    vertex(97 * scaleX, 61 * scaleY);
    endShape();

    /* bottom */
    beginShape();
    vertex(27 * scaleX, 61 * scaleY);
    vertex(29 * scaleX, 47 * scaleY);
    vertex(87 * scaleX, 47 * scaleY);
    vertex(89 * scaleX, 61 * scaleY);
    endShape();

    /* foreground top */
    beginShape();
    vertex(97 * scaleX, 61 * scaleY);
    vertex(103 * scaleX, 75 * scaleY);
    vertex(13 * scaleX, 75 * scaleY);
    vertex(19 * scaleX, 61 * scaleY);
    endShape(CLOSE);

    /* foreground side */
    beginShape();
    vertex(96 * scaleX, 75 * scaleY);
    vertex(93 * scaleX, 91 * scaleY);
    vertex(23 * scaleX, 91 * scaleY);
    vertex(20 * scaleX, 75 * scaleY);
    endShape();

    /* left side */
    beginShape();
    vertex(19 * scaleX, 61 * scaleY);
    vertex(21 * scaleX, 21 * scaleY);
    vertex(29 * scaleX, 47 * scaleY);
    endShape();

    /* right side */
    beginShape();
    vertex(87 * scaleX, 47 * scaleY);
    vertex(95 * scaleX, 21 * scaleY);
    vertex(97 * scaleX, 61 * scaleY);
    endShape();

    strokeWeight(0);

    /* background side */
    beginShape();
    vertex(21 * scaleX, 21 * scaleY);
    vertex(95 * scaleX, 21 * scaleY);
    vertex(87 * scaleX, 47 * scaleY);
    vertex(29 * scaleX, 47 * scaleY);
    endShape();

    /* left side */
    beginShape();
    vertex(21 * scaleX, 21 * scaleY);
    vertex(29 * scaleX, 47 * scaleY);
    vertex(27 * scaleX, 61 * scaleY);
    vertex(19 * scaleX, 61 * scaleY);
    endShape();

    /* right side */
    beginShape();
    vertex(87 * scaleX, 47 * scaleY);
    vertex(95 * scaleX, 21 * scaleY);
    vertex(97 * scaleX, 61 * scaleY);
    vertex(89 * scaleX, 61 * scaleY);
    endShape();

    popMatrix();
  }
}
