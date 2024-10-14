/* startX, endX, startY, endY, --moveN, --textSize, --textColor, --textFont */
boolean drawLineMove(JSONObject obj, int startFrame, int endFrame, String textStr) {
  textFont(fontList.get(getStringValueIfDefined(obj, "textFont", DEFAULT_FONT)));
  textSize(getFloatValueIfDefined(obj, "textSize", DEFAULT_FONT_SIZE));
  float startX = getLinePosition(obj.getString("startX"), textStr);
  float endX = getLinePosition(obj.getString("endX"), textStr);
  float startY = getLinePosition(obj.getString("startY"), textStr);
  float endY = getLinePosition(obj.getString("endY"), textStr);
  float moveN = getFloatValueIfDefined(obj, "moveN", 1);

  float currentProgress = (float(frameCount) - startFrame) / (endFrame - startFrame);
  float moveProgress = (cos(radians(currentProgress * 180 * moveN)) + 1) / 2;
  float x = (startX - endX) * moveProgress + endX;
  float y = (startY - endY) * moveProgress + endY;
  fill(getColorIfDefined(obj, "textColor", color(51, 51, 51, 255)));
  text(textStr, x, y);
  return true;
}

/* x, y, --shakeX, --shakeY, --textSize, --textColor, --textFont */
boolean drawLineShake(JSONObject obj, String textStr) {
  textFont(fontList.get(getStringValueIfDefined(obj, "textFont", DEFAULT_FONT)));
  textSize(getFloatValueIfDefined(obj, "textSize", DEFAULT_FONT_SIZE));
  float x = getLinePosition(obj.getString("x"), textStr);
  float y = getLinePosition(obj.getString("y"), textStr);
  float shakeX = getFloatValueIfDefined(obj, "shakeX", 0);
  float shakeY = getFloatValueIfDefined(obj, "shakeY", 0);

  float randomX = x + random(shakeX);
  float randomY = y + random(shakeY);
  fill(getColorIfDefined(obj, "textColor", color(51, 51, 51, 255)));
  text(textStr, randomX, randomY);
  return true;
}

/* x, y, blinkN, --textSize, --textColor, --textFont */
boolean drawLineBlink(JSONObject obj, int startFrame, int endFrame, String textStr) {
  textFont(fontList.get(getStringValueIfDefined(obj, "textFont", DEFAULT_FONT)));
  textSize(getFloatValueIfDefined(obj, "textSize", DEFAULT_FONT_SIZE));
  float x = getLinePosition(obj.getString("x"), textStr);
  float y = getLinePosition(obj.getString("y"), textStr);
  float blinkN = float(obj.getString("blinkN"));

  float currentProgress = 1.0 - (float(frameCount) - startFrame) / (endFrame - startFrame);
  float alpha = (cos(radians(currentProgress * 360 * blinkN)) + 1) / 2 * 255;
  fill(getColorIfDefined(obj, "textColor", color(51, 51, 51, 255)));
  text(textStr, x, y);
  return true;
}

/* x, y, --textSize, --textColor, --textFont */
boolean drawLineFixed(JSONObject obj, String textStr) {
  textFont(fontList.get(getStringValueIfDefined(obj, "textFont", DEFAULT_FONT)));
  textSize(getFloatValueIfDefined(obj, "textSize", DEFAULT_FONT_SIZE));
  float x = getLinePosition(obj.getString("x"), textStr);
  float y = getLinePosition(obj.getString("y"), textStr);


  fill(getColorIfDefined(obj, "textColor", color(51, 51, 51, 255)));
  text(textStr, x, y);
 
  return true;
}

/* x, y, --minAlpha, --maxAlpha, --textSize, --textColor, --textFont */
boolean drawLineFadeOut(JSONObject obj, int startFrame, int endFrame, String textStr) {
  textFont(fontList.get(getStringValueIfDefined(obj, "textFont", DEFAULT_FONT)));
  textSize(getFloatValueIfDefined(obj, "textSize", DEFAULT_FONT_SIZE));
  float x = getLinePosition(obj.getString("x"), textStr);
  float y = getLinePosition(obj.getString("y"), textStr);
  float maxAlpha = getFloatValueIfDefined(obj, "maxAlpha", 255.0);
  float minAlpha = getFloatValueIfDefined(obj, "minAlpha", 0);

  float currentProgress = 1.0 - (float(frameCount) - startFrame) / (endFrame - startFrame);
  float alpha = (maxAlpha - minAlpha) * currentProgress + minAlpha;
  fill(getColorIfDefined(obj, "textColor", color(51, 51, 51, alpha)));
  text(textStr, x, y);
 
  return true;
}

/* x, y, --minAlpha, --maxAlpha, --textSize, --textColor, --textFont */
boolean drawLineFadeIn(JSONObject obj, int startFrame, int endFrame, String textStr) {
  textFont(fontList.get(getStringValueIfDefined(obj, "textFont", DEFAULT_FONT)));
  textSize(getFloatValueIfDefined(obj, "textSize", DEFAULT_FONT_SIZE));
  float x = getLinePosition(obj.getString("x"), textStr);
  float y = getLinePosition(obj.getString("y"), textStr);
  float maxAlpha = getFloatValueIfDefined(obj, "maxAlpha", 255.0);
  float minAlpha = getFloatValueIfDefined(obj, "minAlpha", 0);

  float currentProgress = (float(frameCount) - startFrame) / (endFrame - startFrame);
  float alpha = (maxAlpha - minAlpha) * currentProgress + minAlpha;
  fill(getColorIfDefined(obj, "textColor", color(51, 51, 51, alpha)));
  text(textStr, x, y);
 
  return true;
}

/* x, y, strokeWeight, --strokeColor, --textSize, --textColor, --textFont */
boolean drawLineUnderline(JSONObject obj, String textStr) {
  textFont(fontList.get(getStringValueIfDefined(obj, "textFont", DEFAULT_FONT)));
  float objTextSize = getFloatValueIfDefined(obj, "textSize", DEFAULT_FONT_SIZE);
  textSize(objTextSize);
  float x = getLinePosition(obj.getString("x"), textStr);
  float y = getLinePosition(obj.getString("y"), textStr);
  float strokeWeight = float(obj.getString("strokeWeight"));
  stroke(getColorIfDefined(obj, "strokeColor", color(100, 100, 100, 200)));
  /* gとかは線に重なってしまうため下線の位置を調整*/
  float adjust = objTextSize / 3;
  fill(getColorIfDefined(obj, "textColor", color(51, 51, 51, 255)));
  text(textStr, x, y);
  strokeWeight(strokeWeight);
  line(x, y + adjust, x + textWidth(textStr), y + adjust);
  return true;
}


