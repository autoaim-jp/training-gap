float getLinePosition(String _valueList, String textStr) {
  final float PSEUDO_FONT_HEIGHT = 50;
  float result = 0;

  String[] valueList = _valueList.split(" ");
  for(int i = 0; i < valueList.length; i++) {
    String value = valueList[i];
    if (value.equals("X_LINE_CENTER")) {
      float textWidth = textWidth(textStr);
      float X_LINE_CENTER = width / 2 - textWidth / 2;
      result += X_LINE_CENTER;
    } else if (value.equals("X_CENTER")) {
      result += width / 2;
    } else if (value.equals("LEFT")) {
      result += 0;
    } else if (value.equals("RIGHT")) {
      result += width;
    } else if (value.equals("LINE_LEFT_IN")) {
      result += textWidth(textStr);
    } else if (value.equals("LINE_RIGHT_IN")) {
      result += width - textWidth(textStr);

    } else if (value.equals("Y_LINE_CENTER")) {
      float Y_LINE_CENTER = height / 2 - PSEUDO_FONT_HEIGHT / 2;
      result += Y_LINE_CENTER;
    } else if (value.equals("TOP")) {
      result += 0;
    } else if (value.equals("BOTTOM")) {
      result += height;
    } else if (value.equals("LINE_TOP_IN")) {
      result += PSEUDO_FONT_HEIGHT;
    } else if (value.equals("Y_CENTER")) {
      result += height / 2;
    } else {
      result += float(value);
    }
  }
  return result;
}

float getImgPosition(String _valueList, PImage img) {
  float result = 0;

  String[] valueList = _valueList.split(" ");
  for(int i = 0; i < valueList.length; i++) {
    String value = valueList[i];
    if (value.equals("X_IMG_CENTER")) {
      float X_IMG_CENTER = width / 2 - img.width / 2;
      result += X_IMG_CENTER;
    } else if (value.equals("X_CENTER")) {
      result += width / 2;
    } else if (value.equals("LEFT")) {
      result += 0;
    } else if (value.equals("RIGHT")) {
      result += width;
/*
      // useless
      } else if (value.equals("IMG_LEFT_IN")) {
      result += img.width;
*/
    } else if (value.equals("IMG_RIGHT_IN")) {
      result += width - img.width;
    } else if (value.equals("TOP")) {
      result += 0;
    } else if (value.equals("BOTTOM")) {
      result += height;
    } else if (value.equals("IMG_BOTTOM_IN")) {
      result += height - img.height;
    } else if (value.equals("Y_IMG_CENTER")) {
      float textHeight = 50;
      float Y_IMG_CENTER = height / 2 - img.height / 2;
      result += Y_IMG_CENTER;
    } else if (value.equals("Y_CENTER")) {
      result += height / 2;
    } else {
      result += float(value);
    }
  }
  return result;
}

float getPosition(String _valueList) {
  float result = 0;

  String[] valueList = _valueList.split(" ");
  for(int i = 0; i < valueList.length; i++) {
    String value = valueList[i];

    if (value.equals("X_CENTER")) {
      result += width / 2;
    } else if (value.equals("LEFT")) {
      result += 0;
    } else if (value.equals("RIGHT")) {
      result += width;
    } else if (value.equals("TOP")) {
      result += 0;
    } else if (value.equals("BOTTOM")) {
      result += height;
    } else if (value.equals("Y_CENTER")) {
      result += height / 2;
    } else {
      result += float(value);
    }
  }
  return result;
}

boolean mainDraw(JSONObject obj, int startFrame, int endFrame) {
  String type = obj.getString("type");
  if(type.equals("textMove")) {
    String textStr = obj.getString("text");
    drawLineMove(obj, startFrame, endFrame, textStr);
  } else if(type.equals("textShake")) {
    String textStr = obj.getString("text");
    drawLineShake(obj, textStr);
  } else if(type.equals("textFixed")) {
    String textStr = obj.getString("text");
    drawLineFixed(obj, textStr);
  } else if(type.equals("textBlink")) {
    String textStr = obj.getString("text");
    drawLineBlink(obj, startFrame, endFrame, textStr);
  } else if(type.equals("textFadeIn")) {
    String textStr = obj.getString("text");
    drawLineFadeIn(obj, startFrame, endFrame, textStr);
  } else if(type.equals("textFadeOut")) {
    String textStr = obj.getString("text");
    drawLineFadeOut(obj, startFrame, endFrame, textStr);
  } else if(type.equals("textUnderlineFixed")) {
    String textStr = obj.getString("text");
    drawLineUnderline(obj, textStr);

  } else if(type.equals("imageFixed")) {
    String fileName = obj.getString("fileName");
    drawImageFixed(obj, imageList.get(fileName));
  } else if(type.equals("imageFadeIn")) {
    String fileName = obj.getString("fileName");
    drawImageFadeIn(obj, startFrame, endFrame, imageList.get(fileName));
  } else if(type.equals("imageFadeOut")) {
    String fileName = obj.getString("fileName");
    drawImageFadeOut(obj, startFrame, endFrame, imageList.get(fileName));
  } else if(type.equals("imageRotate")) {
    String fileName = obj.getString("fileName");
    drawImageRotate(obj, startFrame, endFrame, imageList.get(fileName));
  } else if(type.equals("imageFlip")) {
    String fileName = obj.getString("fileName");
    drawImageFlip(obj, startFrame, endFrame, imageList.get(fileName));
  } else if(type.equals("imageZoomIn")) {
    String fileName = obj.getString("fileName");
    drawImageZoomIn(obj, startFrame, endFrame, imageList.get(fileName));
  } else if(type.equals("imageZoomOut")) {
    String fileName = obj.getString("fileName");
    drawImageZoomOut(obj, startFrame, endFrame, imageList.get(fileName));
  } else if(type.equals("imageMove")) {
    String fileName = obj.getString("fileName");
    drawImageMove(obj, startFrame, endFrame, imageList.get(fileName));
  } else if(type.equals("imageBlink")) {
    String fileName = obj.getString("fileName");
    drawImageBlink(obj, startFrame, endFrame, imageList.get(fileName));

  } else if(type.equals("boxFixed")) {
    drawBoxFixed(obj, startFrame, endFrame);
  } else if(type.equals("boxFadeOut")) {
    drawBoxFadeOut(obj, startFrame, endFrame);
  } else if(type.equals("boxFadeIn")) {
    drawBoxFadeIn(obj, startFrame, endFrame);
  } else if(type.equals("boxExtend")) {
    drawBoxExtend(obj, startFrame, endFrame);
  } else if(type.equals("boxShrink")) {
    drawBoxShrink(obj, startFrame, endFrame);

  } else if(type.equals("lineFixed")) {
    drawLineFixed(obj, startFrame, endFrame);

  } else if(type.equals("tagLineShake")) {
    drawTagLineShake(obj);

  } else if(type.equals("vertexFixed")) {
    drawVertexFixed(obj, startFrame, endFrame);

  } else if(type.equals("frameOpening")) {
    drawFrameOpening(obj, startFrame, endFrame);
  } else if(type.equals("framePieCountDown")) {
    drawFramePieCountDown(obj, startFrame, endFrame);
  } else if(type.equals("@fixedScene")) {
  } else {
    println("[fatal] unknown type: " + type);
    return false;
  }
  return true;
}


float getFloatValueIfDefined(JSONObject obj, String key, float defaultValue) {
  if(obj.getString(key) != null) {
    return float(obj.getString(key));
  } else {
    return defaultValue;
  }
}

String getStringValueIfDefined(JSONObject obj, String key, String defaultValue) {
  if(obj.getString(key) != null) {
    return obj.getString(key);
  } else {
    return defaultValue;
  }
}

color getColorIfDefined(JSONObject obj, String key, color defaultColor) {
  if(obj.isNull(key)) {
    return defaultColor;
  } else {
    JSONArray colorList = obj.getJSONArray(key);
    return color(colorList.getFloat(0), colorList.getFloat(1), colorList.getFloat(2), colorList.getFloat(3));
  }
}


