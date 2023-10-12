import gifAnimation.*;

GifMaker gifExport;
boolean recording = false;
int lineIndex = 0;
float t = 3;
float[] binaryData;

void setup() {
  size(500, 500);
  randomSeed(123);

  gifExport = new GifMaker(this, "relevant.gif");
  gifExport.setRepeat(0);
  gifExport.setQuality(255);
  frameRate(30);

  String[] lines = loadStrings("Bound2.txt");
  String binaryString = join(lines, "");
  binaryData = new float[binaryString.length()];
  for (int i = 0; i < binaryData.length; i++) {
    binaryData[i] = binaryString.charAt(i) == '0' ? 0 : 1;
  }
}

void draw() {
  background(255);

  for (int i = 0; i < lineIndex; i += 32) {
    drawFullCurve(binaryData, i);
  }

  if (lineIndex < binaryData.length - 32) {
    drawPartialCurve(binaryData, lineIndex, t);
    t += 0.1;

    if (t > 1) {
      t = 0;
      lineIndex += 48;
    }
  }

  if (recording) {
    gifExport.setDelay(1);
    gifExport.addFrame();
  }
}

void keyPressed() {
  if (key == 'r') {
    recording = !recording;
  }

  if (key == 'q') {
    gifExport.finish();
    println("GIF exported");
    noLoop();
  }
}

void drawFullCurve(float[] binaryData, int i) {
  drawBezier(binaryData, i, 1);
}

void drawPartialCurve(float[] binaryData, int i, float t) {
  drawBezier(binaryData, i, t);
}

void drawBezier(float[] binaryData, int i, float t) {
  float x1 = binaryToDecimal(binaryData, i, 8) / 255.0 * width;
  float y1 = binaryToDecimal(binaryData, i + 8, 8) / 255.0 * height;
  float x2 = binaryToDecimal(binaryData, i + 16, 8) / 255.0 * width;
  float y2 = binaryToDecimal(binaryData, i + 32, 8) / 255.0 * height;

  float chance = random(1);
  if (chance < 0.01) {
    fill( 127);
  } else {
    noFill();
  }

  stroke(0);
  
  if (t < 1) {
    float x = bezierPoint(width/2, x1, x2, width/2, t);
    float y = bezierPoint(height/2, y1, y2, height/2, t);
    line(width/2, height/2, x, y);
  } else {
    bezier(width/2, height/2, x1, y1, x2, y2, width/2, height/2);
  }
}

int binaryToDecimal(float[] binaryData, int startIndex, int length) {
  int decimal = 0;
  for (int i = 0; i < length; i++) {
    decimal += binaryData[startIndex + i] * pow(2, length - i - 1);
  }
  return decimal;
}
