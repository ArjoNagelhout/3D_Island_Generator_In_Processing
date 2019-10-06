// Function for generating the 2D image for a tree variant in a drawing slot
// It uses recursion to create the branches
// At the lowest level of the recursion it draws leaves (ellipses with a random leaf color)

void generateTree(int treeSlotIndex, int w, int h) {
  
  PGraphics t = createGraphics(w, h, P2D);
  t.noSmooth();
  t.beginDraw();
  
  // Generate the tree recursively
  branch(t, 4, w/2, h, -90, w, h);
  
  // Add leave effects
  t.loadPixels();
  
  for (int i = 0; i<t.pixels.length; i++) {
    if (green(t.pixels[i]) > (red(t.pixels[i])+blue(t.pixels[i]))/2) {
      t.pixels[i] = color(red(t.pixels[i]), green(t.pixels[i])+map(noise(t.pixels[i]/100.0), 0, 1, -50, 50), blue(t.pixels[i]));
      t.pixels[i] += random(-50, 50);
    }
  }
  
  t.updatePixels();
  
  t.endDraw();
  
  treeSlots[treeSlotIndex] = t;
}

// The function that calls itself with a decreasing variable "level" (this is called recursion)
void branch(PGraphics t, int level, float x, float y, float angle, float w, float h) {
  
  t.strokeWeight(level*1.5);
  
  t.stroke(#78664c);
  
  float heightMultiplier = h/200;
  
  float branchLength = random(level * 5 * heightMultiplier, level * 15 * heightMultiplier) + random(-10 * heightMultiplier, 10 * heightMultiplier);
  float angleVariance = 150.0 / level;
  if (level == 4) {
    angleVariance *= 0.2;
    t.strokeWeight(8);
  }
  angle += random(-angleVariance/2, angleVariance);
  
  float newX = x + branchLength * cos(radians(angle));
  float newY = y + branchLength * sin(radians(angle));
  
  t.line(x, y, newX, newY);
  
  if (level > 0) {
    for (int i = level; i > 0; i--) {
      branch(t, level-1, newX, newY, angle, w, h);
    }
  } else {
    t.noStroke();
    t.fill(treeLeavesColors[(int)random(treeLeavesColors.length)], random(150, 255));
    float radius = random(5, 50);
    t.ellipse(constrain(x, 0+radius/2, w-radius/2), constrain(y, radius/2, h-radius/2), radius, radius);
  }
  
  
}
