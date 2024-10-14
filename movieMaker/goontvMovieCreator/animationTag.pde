/* x, y, --shakeX, --shakeY, --textSize, --textColor */
boolean drawTagLineShake(JSONObject obj) {
  if(obj.isNull("textSize")) {
    textSize(DEFAULT_FONT_SIZE);
  } else {
    float objTextSize = float(obj.getString("textSize"));
    textSize(objTextSize);
  }
  String[] tagList = obj.getJSONArray("tagList").getStringArray();
  String tagLine = join(tagList, ",");
  float shakeX = getFloatValueIfDefined(obj, "shakeX", 0);
  float shakeY = getFloatValueIfDefined(obj, "shakeY", 0);
  float y = getLinePosition(obj.getString("y"), tagLine);

  float startX = width / 2 - textWidth(tagLine) / 2;
  for(int i = 0; i < tagList.length; i++) {
    String tag = tagList[i];
    float randomX = startX + random(shakeX);
    float randomY = y + random(shakeY);
    fill(getColorIfDefined(obj, "textColor", color(51, 51, 51, 255)));
    text(tag, randomX, randomY);
    startX += textWidth(tag + ",");
  }

  return true;
}


