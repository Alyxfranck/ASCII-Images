int binaryIndex = 0;
float grayScaleStep;

void setup() {
  size(5000, 5000);


  background (255);
  String[] lines = loadStrings("binaryData.txt");
  String binaryString = join(lines, ""); 
  float[] binaryData = new float[binaryString.length()];
  for (int i = 0; i < binaryData.length; i++) {
    binaryData[i] = binaryString.charAt(i) == '0' ? 0 : 1;
  }
 
  // Generiere einen Seed basierend auf den binären Daten
 long seed = binaryString.hashCode();
 randomSeed(seed); // Initialisiere den Zufallsgenerator mit dem Seed
 
  grayScaleStep = 255.0/(binaryData.length * 0.4 );
  draw(binaryData);

  save("output.jpg");
}

    
void draw(float[] binaryData) {
  noFill();
  beginShape();

  for (int i = 0; i < binaryData.length - 32; i += 32) { // 32 bits at a time
    float x1 = binaryToDecimal(binaryData, i, 8) / 255.0 * width; // convert first 8 bits to decimal and use as x1
    float y1 = binaryToDecimal(binaryData, i + 8, 8) / 255.0 * height; // convert next 8 bits to decimal and use as y1
    int grayScaleValue = round(binaryToDecimal(binaryData, i + 16, 8)); // convert next 8 bits to decimal and use as grayscale value
    float x2 = binaryToDecimal(binaryData, i + 24, 8) / 255.0 * width; // convert next 8 bits to decimal and use as control point x
    float y2 = binaryToDecimal(binaryData, i + 32, 8) / 255.0 * height; // convert next 8 bits to decimal and use as control point y

    // Apply transparency with a random chance
    float chance = random(1);
    if (chance < 0.05) {
      fill(grayScaleValue, 127); 
    } else {
      noFill();
    }

    // Set the stroke color and draw the Bezier curve
    stroke(grayScaleValue);
   
    bezier(width/2, height/2, x1, y1, x2, y2, width/2, height/2);
 
}
  endShape();
}

int binaryToDecimal(float[] binaryData, int startIndex, int length) {
  int decimal = 0;
  for (int i = 0; i < length; i++) {
    decimal += binaryData[startIndex + i] * pow(2, length - i - 1);
  }
  return decimal;
}
