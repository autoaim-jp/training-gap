/* x, y, width, height, fillColor, strokeWeight */
boolean drawBoxFixed(JSONObject obj, int startFrame, int endFrame) {
  float x = getPosition(obj.getString("x"));
  float y = getPosition(obj.getString("y"));
  float objWidth = float(obj.getString("width"));
  float objHeight = float(obj.getString("height"));
  JSONArray colorList = obj.getJSONArray("fillColor");
  float objStrokeWeight = float(obj.getString("strokeWeight"));

  color c = color(colorList.getFloat(0), colorList.getFloat(1), colorList.getFloat(2), colorList.getFloat(3));
  strokeWeight(objStrokeWeight);
  stroke(0, 0, 0, 100);
  fill(c);
  rect(x, y, objWidth, objHeight);
  return true;
}

/* x, y, width, height, fillColor, strokeWeight, --maxAlpha, --minAlpha */
boolean drawBoxFadeOut(JSONObject obj, int startFrame, int endFrame) {
  float x = getPosition(obj.getString("x"));
  float y = getPosition(obj.getString("y"));
  float objWidth = float(obj.getString("width"));
  float objHeight = float(obj.getString("height"));
  JSONArray colorList = obj.getJSONArray("fillColor");
  float objStrokeWeight = float(obj.getString("strokeWeight"));
  float maxAlpha = getFloatValueIfDefined(obj, "maxAlpha", 255.0);
  float minAlpha = getFloatValueIfDefined(obj, "minAlpha", 0);
  float currentProgress = 1.0 - (float(frameCount) - startFrame) / (endFrame - startFrame);
  float alpha = (maxAlpha - minAlpha) * currentProgress + minAlpha;
 
  color c = color(colorList.getFloat(0), colorList.getFloat(1), colorList.getFloat(2), colorList.getFloat(3));
  strokeWeight(objStrokeWeight);
  stroke(0, 0, 0, alpha);
  fill(c);
  rect(x, y, objWidth, objHeight);
  return true;
}

/* x, y, width, height, fillColor, strokeWeight, --maxAlpha, --minAlpha */
boolean drawBoxFadeIn(JSONObject obj, int startFrame, int endFrame) {
  float x = getPosition(obj.getString("x"));
  float y = getPosition(obj.getString("y"));
  float objWidth = float(obj.getString("width"));
  float objHeight = float(obj.getString("height"));
  JSONArray colorList = obj.getJSONArray("fillColor");
  float objStrokeWeight = float(obj.getString("strokeWeight"));
  float maxAlpha = getFloatValueIfDefined(obj, "maxAlpha", 255.0);
  float minAlpha = getFloatValueIfDefined(obj, "minAlpha", 0);
  float currentProgress = (float(frameCount) - startFrame) / (endFrame - startFrame);
  float alpha = (maxAlpha - minAlpha) * currentProgress + minAlpha;
 
  color c = color(colorList.getFloat(0), colorList.getFloat(1), colorList.getFloat(2), colorList.getFloat(3));
  strokeWeight(objStrokeWeight);
  stroke(0, 0, 0, alpha);
  fill(c);
  rect(x, y, objWidth, objHeight);
  return true;
}

/* x, y, fillcolor, maxWidth, minWidth, maxHeight, minHeight, strokeWeight, --maxAlpha, --minAlpha  */
boolean drawBoxExtend(JSONObject obj, int startFrame, int endFrame) {
  float x = getPosition(obj.getString("x"));
  float y = getPosition(obj.getString("y"));
  JSONArray colorList = obj.getJSONArray("fillColor");
  float objStrokeWeight = float(obj.getString("strokeWeight"));
  float maxWidth = float(obj.getString("maxWidth"));
  float maxHeight = float(obj.getString("maxHeight"));
  float minWidth = float(obj.getString("minWidth"));
  float minHeight = float(obj.getString("minHeight"));
  float currentProgress = (float(frameCount) - startFrame) / (endFrame - startFrame);
  float maxAlpha = getFloatValueIfDefined(obj, "maxAlpha", 255.0);
  float minAlpha = getFloatValueIfDefined(obj, "minAlpha", 0);
  float alpha = (maxAlpha - minAlpha) * currentProgress + minAlpha;
  float objWidth = (abs(maxWidth) - abs(minWidth)) * currentProgress + abs(minWidth);
  float objHeight = (abs(maxHeight) - abs(minHeight)) * currentProgress + abs(minHeight);
  if(maxWidth < 0) {
    x += abs(maxWidth) - objWidth;
  }
  if(maxHeight < 0) {
    y += abs(maxHeight) - objHeight;
  }
 
  color c = color(colorList.getFloat(0), colorList.getFloat(1), colorList.getFloat(2), colorList.getFloat(3));
  strokeWeight(objStrokeWeight);
  stroke(0, 0, 0, alpha);
  fill(c);
  rect(x, y, objWidth, objHeight);
  return true;
}

/* x, y, fillColor, maxWidth, minWidth, maxHeight, minHeight, strokeWeight, --maxAlpha, --minAlpha  */
boolean drawBoxShrink(JSONObject obj, int startFrame, int endFrame) {
  float x = getPosition(obj.getString("x"));
  float y = getPosition(obj.getString("y"));
  JSONArray colorList = obj.getJSONArray("fillColor");
  float objStrokeWeight = float(obj.getString("strokeWeight"));
  float maxWidth = float(obj.getString("maxWidth"));
  float maxHeight = float(obj.getString("maxHeight"));
  float minWidth = float(obj.getString("minWidth"));
  float minHeight = float(obj.getString("minHeight"));
  float currentProgress = 1 - (float(frameCount) - startFrame) / (endFrame - startFrame);
  float maxAlpha = getFloatValueIfDefined(obj, "maxAlpha", 255.0);
  float minAlpha = getFloatValueIfDefined(obj, "minAlpha", 0);
  float alpha = (maxAlpha - minAlpha) * currentProgress + minAlpha;
  float objWidth = (abs(maxWidth) - abs(minWidth)) * currentProgress + abs(minWidth);
  float objHeight = (abs(maxHeight) - abs(minHeight)) * currentProgress + abs(minHeight);
  if(maxWidth < 0) {
    x += abs(maxWidth) - objWidth;
  }
  if(maxHeight < 0) {
    y += abs(maxHeight) - objHeight;
  }
 
  color c = color(colorList.getFloat(0), colorList.getFloat(1), colorList.getFloat(2), colorList.getFloat(3));
  strokeWeight(objStrokeWeight);
  stroke(0, 0, 0, alpha);
  fill(c);
  rect(x, y, objWidth, objHeight);
  return true;
}

