void setup() {
  size(5000, 5000);
  String[] lines = loadStrings("binaryData.txt");
  String binaryString = join(lines, ""); 
  float[] binaryData = new float[binaryString.length()];
  for (int i = 0; i < binaryData.length; i++) {
    binaryData[i] = binaryString.charAt(i) == '0' ? 0 : 1;
   randomSeed(123);
  }
  draw(binaryData);
    save("output.jpg");
}
void draw(float[] binaryData) {
  noFill();
  beginShape();
  for (int i = 0; i < binaryData.length - 1; i+=100) {
    float x1 = binaryData[i] == 1 ? random(0, width) : random(0, width);
    float y1 = binaryData[i] == 1 ? random(0, height) : random(0, height);
    float x2 = binaryData[i+1] == 1 ? random(0, width) : random(0, width);
    float y2 = binaryData[i+1] == 1 ? random(0, height) : random(0, height);
    // Ensure the curves stay inside the canvas
    x1 = constrain(x1, 0, width);
    y1 = constrain(y1, 0, height);
    x2 = constrain(x2, 0, width);
    y2 = constrain(y2, 0, height);
// Random chance to apply transparency
    float chance = random(1); // Get a random number between 0 and 1
    if (chance < 0.0) { // 1% chance to apply transparency
      // Determine the curve's color based on the binary data
      fill (127); // Add alpha transparency to fill
    } 
    else {
      noFill(); // No fill for most of the curves
    }
    // Determine the curve's color based on the binary data
    stroke(0);
    // Draw the curve
    bezier(x1, y1, x1, y2, x2, y1, x2, y2);
  }
  endShape();
}
