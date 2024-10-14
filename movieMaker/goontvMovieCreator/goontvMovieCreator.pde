import java.util.Map;
import java.util.Iterator;
import java.text.SimpleDateFormat;
import java.util.Date;

final String BACKGROUND_DIR_PATH = "src/background/";
final String IMAGE_DIR_PATH = sketchPath() + "/asset/";
final int DEFAULT_FONT_SIZE = 50;
final String JSON_FILE_ENV = "ANIMATION_JSON_FILE_PATH";
final String MOVIE_RESULT_DIR_ENV = "MOVIE_OUTPUT_DIR";
final String THUBMNAIL_RESULT_DIR_ENV = "THUBMNAIL_OUTPUT_DIR";
final String DEFAULT_FONT = "Source Han Sans";
final int THUMBNAIL_FRAME_ID_MIN = 82;
final int THUMBNAIL_FRAME_ID_MAX = 92;

JSONArray componentList;
PImage backgroundImage;
HashMap<String, PImage> imageList;
String movieResultDirPath = null;
String thumbnailResultDirPath = null;
HashMap<String, PFont> fontList;
String today = null;

int totalFrame = 0;
int sceneId = 0;

void setup() {
  /* printArray(PFont.list()); */
  Date date = new Date();
  SimpleDateFormat df = new SimpleDateFormat("yyyy年MM月dd日");
  today = df.format(date);
  Map<String, String> env = System.getenv();
  Iterator<String> ite1 = env.keySet().iterator();
  Iterator<String> ite2 = env.values().iterator();

  String jsonFilePath = null;
  while (ite1.hasNext()) {
    String var = ite1.next();
    if(var.equals(JSON_FILE_ENV)) {
      jsonFilePath = ite2.next();
    } else if(var.equals(MOVIE_RESULT_DIR_ENV)) {
      movieResultDirPath = ite2.next();
    } else if(var.equals(THUBMNAIL_RESULT_DIR_ENV)) {
      thumbnailResultDirPath = ite2.next();
    } else {
      ite2.next();
    }
  }
  if(jsonFilePath == null || movieResultDirPath == null || thumbnailResultDirPath == null) {
    exit();
  }

  JSONObject json = loadJSONObject(jsonFilePath);

  totalFrame = json.getInt("totalFrame");
  componentList = json.getJSONArray("componentList");

  /* load image */
  backgroundImage = loadImage(BACKGROUND_DIR_PATH + "bg2.jpg");
  imageList = new HashMap<String, PImage>();

  File imageDir = new File(IMAGE_DIR_PATH);
  String[] fileNameList = imageDir.list();
  if (fileNameList != null) {
    for(int i = 0; i < fileNameList.length; i++) {
      println("[info] load image: " + fileNameList[i]);
      imageList.put(fileNameList[i], loadImage(IMAGE_DIR_PATH + fileNameList[i]));
    }
  } else{
    println("[fatal] image dir not found: " + imageDir.toString());
    exit();
  }
  /* canvas, font */
  size(1920, 1080, P3D);
  fontList = new HashMap<String, PFont>();
  fontList.put("Source Han Sans", createFont("Source Han Sans", 50));
  fontList.put("Source Han Sans Bold", createFont("Source Han Sans Bold", 50));
  textFont(fontList.get(DEFAULT_FONT));
  smooth();
}

void draw() {
  println("[info] frame:" + frameCount);
  if (frameCount >= totalFrame) {
    print("[info] done\n");
    exit();
    return;
  }
  background(backgroundImage);

  int skipFrame = 0;
  for (int i = 0; i < componentList.size(); i++) {
    JSONObject component = componentList.getJSONObject(i);
    int startFrame = component.getInt("startFrame");
    int endFrame = component.getInt("endFrame");
    JSONArray objectList = component.getJSONArray("objectList"); 
    if (frameCount >= startFrame && frameCount <= endFrame) {
      for (int j = 0; j < objectList.size(); j++) {
        JSONObject obj = objectList.getJSONObject(j);
        String type = obj.getString("type");
        if (type.equals("@fixedScene")) {
          if (skipFrame != 0) {
            println("[error] two @fixedScene detected. invalid animation json.");
            exit();
          }
          /*
          skipFrame = endFrame - startFrame;
          sceneId = sceneId + 1;
          */
        }
        boolean result = mainDraw(obj, startFrame, endFrame);
        if(!result) {
          exit();
        }
      }
    }
  }
  
  saveFrame(movieResultDirPath + "scene_" + sceneId + "_frame_#######.jpg");
/*
// TODO: skip mode
  if (skipFrame != 0) {
    frameCount = frameCount + skipFrame;
    sceneId = sceneId + 1;
  }
*/
  /*
  if(frameCount >= THUMBNAIL_FRAME_ID_MIN && frameCount <= THUMBNAIL_FRAME_ID_MAX && frameCount % 2 == 0) {
    saveFrame(thumbnailResultDirPath + today  + "_" + frameCount + ".jpg");
  }
  */
}
