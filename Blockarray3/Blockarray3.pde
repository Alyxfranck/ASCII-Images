PShape shape;
int shapeSize = 308;
int binaryIndex = 0;
float grayScaleStep;

void setup() {
  size(5000, 5000);
  shape = createShape(RECT, 0, 0, shapeSize, shapeSize);
  
  String[] lines = loadStrings("binaryData.txt"); // Load data from file
  String binaryString = join(lines, "");
  float[] binaryData = new float[binaryString.length()];
  for (int i = 0; i < binaryData.length; i++) {
    binaryData[i] = binaryString.charAt(i) == '0' ? 0 : 1;
  }
   // Generiere einen Seed basierend auf den binären Daten
 long seed = binaryString.hashCode();
 randomSeed(seed); // Initialisiere den Zufallsgenerator mit dem Seed
  grayScaleStep = 255.0/binaryData.length;
  draw(binaryData);
  
  save("output.jpg");
}

void draw(float[] binaryData) {
  push(); 
  for (int i = 0; i < binaryData.length; i++) {
    int grayScaleValue = round(grayScaleStep * binaryIndex);
    binaryIndex++;
    if (binaryData[i] == 1) {
      fill(255);
      float x = random(width);
      float y = random(height);
      shape(shape, x, y);
    } else {
      if (i % 2 == 0) {
        fill(255 - grayScaleValue);
      } else {
        fill(grayScaleValue);
      }
      float x = random(width);
      float y = random(height);
      float rectWidth = random(1, 1000);
      float rectHeight = random(1, 29);
      rect(x, y, rectWidth, rectHeight);
    }
  }
  pop(); // Restore the previous state of the canvas
  shapeMode(CENTER);
  shape(shape, width/2, height/2);
}
