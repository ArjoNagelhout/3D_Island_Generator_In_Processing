// Function for generating the 2D image for a rock variant in a drawing slot
void generateRock(int rockSlotIndex, int w, int h) {
  
  // Create a drawing surface where the rock will be rendered on
  // The rock consists of different circles drawn on top of each other, 
  // with a check to keep them within the drawing surface
  // After that perlin noise is added to make it look less flat. 
  // It then gets stored in a drawing slot
  
  PGraphics r = createGraphics(w, h, P2D);
  r.noSmooth();
  r.beginDraw();
  r.noStroke();
  int rockPieces = (int)random(5, 10);
  float minSegmentSize = 10;
  
  int w_ = (int)random(40, w);
  
  // Draw circles
  for (int p = 0; p < rockPieces; p++) {
    
    r.fill(rockColors[(int)random(rockColors.length)]);
    
    int pieceSegments = (int)random(5, 10);
    
    for (int s = 0; s < pieceSegments; s++) {
      float x = random(minSegmentSize/2, w_-minSegmentSize/2);
      float y = h + random(-10, 10);
      
      float radius = random(1, 25);
      
      if (x + radius > w_) {
        radius = w_-x;
      }
      if (x-radius < 0) {
        radius = x;
      }

      r.ellipse((w/2 - w_/2)+x, y, radius * 2, radius * 2);
    }
    
  }
  
  // Add noise
  r.loadPixels();
  for (int i = 0; i < r.pixels.length; i++) {
    float x = i % w;
    float y = i / w;
    float n = map(noise(x/10, y/10), 0, 1, -50, 50);
    if (alpha(r.pixels[i]) > 0) {
      r.pixels[i] = color(red(r.pixels[i])+n, green(r.pixels[i])+n, blue(r.pixels[i])+n);
      r.pixels[i] += random(-50, 50);
    }
  }
  r.updatePixels();
  
  r.endDraw();
  
  rockSlots[rockSlotIndex] = r;
}
