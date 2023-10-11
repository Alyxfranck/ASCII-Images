
int shapeSize = 1;
int binaryIndex = 0;
color[] colors;

void setup() {
  size(5000, 5000);
    colors = new color[] {
    color(63, 81, 181),
    color(156, 39, 176),
    color(233, 30, 99),
    color(244, 67, 54),
    color(255, 152, 0),
    color(205, 220, 57)
  };
  
  String[] lines = loadStrings("binaryData.txt"); // Load data from file
  String binaryString = join(lines, "");
  float[] binaryData = new float[binaryString.length()];
  for (int i = 0; i < binaryData.length; i++) {
    binaryData[i] = binaryString.charAt(i) == '0' ? 0 : 1;
  }

  drawShapesFromBinary(binaryData);
  // Generiere einen Seed basierend auf den binären Daten
 long seed = binaryString.hashCode();
 randomSeed(seed); // Initialisiere den Zufallsgenerator mit dem Seed
  
    
  save("output.jpg");
}

void drawShapesFromBinary(float[] binaryData) {
  push(); // Save the current state of the canvas
  for (int i = 0; i < binaryData.length; i++) {
    color fillColor = colors[i % colors.length];
    if (binaryData[i] == 1) {
      fill(fillColor);
      float x = random(width);
      float y = random(height);
      float diameter = random(20, 50);
      ellipse(x, y, diameter, diameter);
    } else {
      if (i % 4 == 0) {
        fill(fillColor);
      } else {
        fill(fillColor, 127); // Use semi-transparent color
      }
      float x = random(width);
      float y = random(height);
      float rectWidth = random(1, 100);
      float rectHeight = random(1, 290);
      rect(x, y, rectWidth, rectHeight);
    }
  }
  pop(); // 
    }
