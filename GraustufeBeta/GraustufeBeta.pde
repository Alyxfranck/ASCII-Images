int binaryIndex = 0;
float grayScaleStep;

void setup() {
  size(5000, 5000);
  String[] lines = loadStrings("binaryData.txt");
  String binaryString = join(lines, ""); 
  float[] binaryData = new float[binaryString.length()];
  for (int i = 0; i < binaryData.length; i++) {
    binaryData[i] = binaryString.charAt(i) == '0' ? 0 : 1;
  }
  
  grayScaleStep = 255.0/(binaryData.length * 0.1);
  drawCurvesFromBinary(binaryData);
  
  save("output.jpg");
}

void drawCurvesFromBinary(float[] binaryData) {
  noFill();
  beginShape();
  
  float centerX = width / 2;
  float centerY = height / 2;
  
  for (int i = 0; i < binaryData.length - 1; i+=1) {
    int grayScaleValue = round(grayScaleStep * binaryIndex);
    binaryIndex++;
    
    float x1 = binaryData[i] == 1 ? random(0, width) : random(0, width);
    float y1 = binaryData[i] == 1 ? random(0, height) : random(0, height);
    float x2 = binaryData[i+1] == 1 ? random(0, width) : random(0, width);
    float y2 = binaryData[i+1] == 1 ? random(0, height) : random(0, height);

    x1 = constrain(x1, 0, width);
    y1 = constrain(y1, 0, height);
    x2 = constrain(x2, 0, width);
    y2 = constrain(y2, 0, height);

    float chance = random(1);

    if (chance < 0.9) {
      fill(grayScaleValue, 127);
    } else {
      noFill();
    }
    
    stroke(grayScaleValue);
    bezier(centerX, centerY, x1, y1, x2, y2, x2, y2);
  }
  endShape();
}
