/* x, y, positionList, fillColor, strokeColor, strokeWeight */
boolean drawLineFixed(JSONObject obj, int startFrame, int endFrame) {
  float x = getPosition(obj.getString("x"));
  float y = getPosition(obj.getString("y"));
  JSONArray fillColorList = obj.getJSONArray("fillColor");
  JSONArray strokeColorList = obj.getJSONArray("strokeColor");
  float objStrokeWeight = float(obj.getString("strokeWeight"));
  JSONArray positionList = obj.getJSONArray("positionList");
  float currentProgress = 1 - (float(frameCount) - startFrame) / (endFrame - startFrame);
 
  color strokeColor = color(strokeColorList.getFloat(0), strokeColorList.getFloat(1), strokeColorList.getFloat(2), strokeColorList.getFloat(3));
  color fillColor = color(fillColorList.getFloat(0), fillColorList.getFloat(1), fillColorList.getFloat(2), fillColorList.getFloat(3));

  pushMatrix();
  translate(x, y);

  strokeWeight(objStrokeWeight);
  stroke(strokeColor);
  fill(fillColor);
  for(int i = 0; i < positionList.size(); i++) {
    JSONArray pos = positionList.getJSONArray(i);
    line(pos.getFloat(0), pos.getFloat(1), pos.getFloat(2), pos.getFloat(3));
  }

  popMatrix();
  return true;
}

