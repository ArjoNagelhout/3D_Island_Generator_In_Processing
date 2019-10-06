// Place images at a random position and store this in the corresponding array. 
// Calculate the y value with the depth information of the terrain
void placeImages(int amount, int[] x, int[] y, int[] z, float[] s, int[] index, int variantAmount, float minS, float maxS) {
  for (int i=0; i < amount; i++) {
    
    boolean underwater = true;
    while (underwater) {
      underwater = false;
      x[i] = (int)random(-worldSize/2, worldSize/2);
      z[i] = (int)random(-worldSize/2, worldSize/2);
      y[i] = (int)terrain.XZtoY(x[i], z[i]);
      
      if (y[i] > 0) {
        underwater = true;
      }
    }
    s[i] = random(minS, maxS);
    
    index[i] = (int)random(variantAmount);
  }
}

// Draw the images at the calculated positions
// Make them always face the camera, since they are 2 dimensional
void drawImages(PGraphics[] slots, int w, int amount, int[] x, int[] y, int[] z, float[] s, int[] index) {
  for (int i=0; i < amount; i++) {
    pushMatrix();
    
    translate(x[i] + w/2, y[i], z[i]);
    scale(s[i]);
    rotateY(-camera.x * camera.rotateMultiplier);
    rotateX(camera.y * camera.rotateMultiplier);
    translate(-w/2, -slots[index[i]].height, 0);
    image(slots[index[i]], 0, 0);
    popMatrix();
  }
}
