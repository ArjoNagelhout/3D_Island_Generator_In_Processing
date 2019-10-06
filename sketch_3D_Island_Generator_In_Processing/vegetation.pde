// Function for generating the 2D image for a vegetation variant in a drawing slot
// The vegetation exists of a random amount of stems, with each having a different amount of segments
// The colors get randomly chosen from an array of colors


void generateVegetation(int vegetationSlotIndex, int w, int h) {
  
  PGraphics v = createGraphics(w, h, P2D);
  v.noSmooth();
  v.beginDraw();
  v.noFill();
  
  int stemAmount = (int)random(3, 15);
  
  for (int i = 0; i < stemAmount; i++) {
    
    float x = random(10, w-10);
    float y = h;
    float angle = -90;
    
    int stemSegments = (int)random(2, 5);
    v.stroke(treeLeavesColors[(int)random(treeLeavesColors.length)]);
    for (int s = 0; s < stemSegments; s++) {
      v.strokeWeight(stemSegments-s + 1);
      
      float stemLength = (random(2, 30))/(s+1);
      
      float newX = x + stemLength * cos(radians(angle));
      float newY = y + stemLength * sin(radians(angle));
      
      v.line(x, y, newX, newY);
      
      x = newX;
      y = newY;
      
      angle += random(-30, 30);
      
      
      
    }
    
    
  }
  
  v.endDraw();
  
  vegetationSlots[vegetationSlotIndex] = v;
}
