PShape shape;
int shapeSize = 100;
int binaryIndex = 0;
float grayScaleStep;

void setup() {
  size(5000, 5000);
  shape = createShape(RECT, 0, 0, shapeSize, shapeSize);
  String[] lines = loadStrings("binaryData.txt"); 
  String binaryString = join(lines, ""); 
  float[] binaryData = new float[binaryString.length()];
  for (int i = 0; i < binaryData.length; i++) {
    binaryData[i] = binaryString.charAt(i) == '0' ? 0 : 1;
  }
  
  grayScaleStep = 255.0/binaryData.length;
  drawShapesFromBinary(binaryData);
  
   save("output.jpg");
}


void drawShapesFromBinary(float[] binaryData) {
  push(); // Save the current state of the canvas
  for (int i = 0; i < binaryData.length; i++) {
    int grayScaleValue = round(grayScaleStep * binaryIndex);
    binaryIndex++;
    if (binaryData[i] == 1) {
      fill(255 - grayScaleValue);
      float x = random(width);
      float y = random(height);
      float diameter = random(1, 100);
      ellipse(x, y, diameter, diameter);
    } else {
      if (i % 4 == 0) {
        fill(255 - grayScaleValue);
      } else {
        fill(grayScaleValue);
      }
      float x = random(width);
      float y = random(height);
      float rectWidth = random(1, 100);
      float rectHeight = random(1, 300);
      rect(x, y, rectWidth, rectHeight);
    }
  }
  pop(); // Restore the previous state of the canvas
  shapeMode(CENTER);
  shape(shape, width/2, height/2);
}
