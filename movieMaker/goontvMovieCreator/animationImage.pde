/* x, y, --alpha */
boolean drawImageFixed(JSONObject obj, PImage img) {
  float x = getImgPosition(obj.getString("x"), img);
  float y = getImgPosition(obj.getString("y"), img);
  float alpha = getFloatValueIfDefined(obj, "alpha", 255.0);

  tint(255.0, alpha);
  image(img, x, y);
  return true;
}

/* x, y, --minAlpha, --maxAlpha */
boolean drawImageFadeIn(JSONObject obj, int startFrame, int endFrame, PImage img) {
  float x = getImgPosition(obj.getString("x"), img);
  float y = getImgPosition(obj.getString("y"), img);
  float maxAlpha = getFloatValueIfDefined(obj, "maxAlpha", 255.0);
  float minAlpha = getFloatValueIfDefined(obj, "minAlpha", 0);

  float currentProgress = (float(frameCount) - startFrame) / (endFrame - startFrame);
  float alpha = (maxAlpha - minAlpha) * currentProgress + minAlpha;
  tint(255.0, alpha);
  image(img, x, y);
  return true;
}

/* x, y, --minAlpha, --maxAlpha */
boolean drawImageFadeOut(JSONObject obj, int startFrame, int endFrame, PImage img) {
  float x = getImgPosition(obj.getString("x"), img);
  float y = getImgPosition(obj.getString("y"), img);
  float maxAlpha = getFloatValueIfDefined(obj, "maxAlpha", 255.0);
  float minAlpha = getFloatValueIfDefined(obj, "minAlpha", 0);

  float currentProgress = 1.0 - (float(frameCount) - startFrame) / (endFrame - startFrame);
  float alpha = (maxAlpha - minAlpha) * currentProgress + minAlpha;
  tint(255.0, alpha);
  image(img, x, y);
  return true;
}

/* x, y, --flipX, --flipY, --alpha */
boolean drawImageFlip(JSONObject obj, int startFrame, int endFrame, PImage img) {
  float x = getImgPosition(obj.getString("x"), img);
  float y = getImgPosition(obj.getString("y"), img);
  float flipX = getFloatValueIfDefined(obj, "flipX", 1);
  float flipY = getFloatValueIfDefined(obj, "flipY", 1);
  float alpha = getFloatValueIfDefined(obj, "alpha", 255.0);

  float currentProgress = (float(frameCount) - startFrame) / (endFrame - startFrame);
  float cosFlipX = cos(radians(currentProgress * 360 * flipX));
  float cosFlipY = cos(radians(currentProgress * 360 * flipY));

  tint(255.0, alpha);
  pushMatrix();
  translate(x + img.width / 2, y + img.height / 2);
  scale(cosFlipX, cosFlipY);
  imageMode(CENTER);
  image(img, 0, 0);
  imageMode(CORNER);
  popMatrix();
  return true;
}

/* x, y, rotateN, --alpha */
boolean drawImageRotate(JSONObject obj, int startFrame, int endFrame, PImage img) {
  float x = getImgPosition(obj.getString("x"), img);
  float y = getImgPosition(obj.getString("y"), img);
  float rotateN = float(obj.getString("rotateN"));
  float alpha = getFloatValueIfDefined(obj, "alpha", 255.0);

  float currentProgress = (float(frameCount) - startFrame) / (endFrame - startFrame);
  float rotateDeg = currentProgress * 360 * rotateN;

  tint(255.0, alpha);
  pushMatrix();
  translate(x + img.width/2, y + img.height/2);
  rotate(radians(rotateDeg)); 
  imageMode(CENTER);
  image(img, 0, 0);
  imageMode(CORNER);
  popMatrix();
  return true;
}

/* x, y, --minScale, --maxScale */
boolean drawImageZoomIn(JSONObject obj, int startFrame, int endFrame, PImage img) {
  float x = getImgPosition(obj.getString("x"), img);
  float y = getImgPosition(obj.getString("y"), img);
  float minScale = getFloatValueIfDefined(obj, "minScale", 0);
  float maxScale = getFloatValueIfDefined(obj, "maxScale", 0);

  float currentProgress = (float(frameCount) - startFrame) / (endFrame - startFrame);
  float scale = (maxScale - minScale) * currentProgress + minScale;

  tint(255.0, 255);
  pushMatrix();
  translate(x + img.width / 2, y + img.height / 2);
  scale(scale, scale);
  imageMode(CENTER);
  image(img, 0, 0);
  imageMode(CORNER);
  popMatrix();
  return true;
}

/* x, y, --minScale, --maxScale */
boolean drawImageZoomOut(JSONObject obj, int startFrame, int endFrame, PImage img) {
  float x = getImgPosition(obj.getString("x"), img);
  float y = getImgPosition(obj.getString("y"), img);
  float minScale = getFloatValueIfDefined(obj, "minScale", 0);
  float maxScale = getFloatValueIfDefined(obj, "maxScale", 0);

  float currentProgress = 1 - (float(frameCount) - startFrame) / (endFrame - startFrame);
  float scale = (maxScale - minScale) * currentProgress + minScale;

  tint(255.0, 255);
  pushMatrix();
  translate(x + img.width / 2, y + img.height / 2);
  scale(scale, scale);
  imageMode(CENTER);
  image(img, 0, 0);
  imageMode(CORNER);
  popMatrix();
  return true;
}

/* startX, endX, startY, endY */
boolean drawImageMove(JSONObject obj, int startFrame, int endFrame, PImage img) {
  float startX = getImgPosition(obj.getString("startX"), img);
  float endX = getImgPosition(obj.getString("endX"), img);
  float startY = getImgPosition(obj.getString("startY"), img);
  float endY = getImgPosition(obj.getString("endY"), img);

  float currentProgress = 1.0 - (float(frameCount) - startFrame) / (endFrame - startFrame);
  float x = (startX - endX) * currentProgress + endX;
  float y = (startY - endY) * currentProgress + endY;
  tint(255.0, 255);
  image(img, x, y);
  return true;
}

/* x, y, blinkN */
boolean drawImageBlink(JSONObject obj, int startFrame, int endFrame, PImage img) {
  float x = getImgPosition(obj.getString("x"), img);
  float y = getImgPosition(obj.getString("y"), img);
  float blinkN = float(obj.getString("blinkN"));

  float currentProgress = 1.0 - (float(frameCount) - startFrame) / (endFrame - startFrame);
  float alpha = (cos(radians(currentProgress * 360 * blinkN)) + 1) / 2 * 255;
  tint(255.0, alpha);
  image(img, x, y);
  return true;
}


