class Camera {
  // a camera system for quickly navigating the 3d environment
  // (left mouse to rotate, right mouse to pan and scroll wheel to zoom in and out)
  
  float startX, totalX, startY, totalY, totalPanX, totalPanY, totalScale, x, y;

  float rotateMultiplier = 0.01;

  boolean rotating, panning;
  
  boolean autoRotate = true;

  Camera() {
    totalPanX = width/2;
    totalPanY = height/2;
    totalScale = 1;
  }

  void update() {
    float xpan, ypan;
    if (panning) {
      xpan = totalPanX+mouseX-startX;
      ypan = totalPanY+mouseY-startY;
    } else {
      xpan = totalPanX;
      ypan = totalPanY;
    }

    translate(xpan, ypan);

    scale(totalScale);

    if (rotating) {
      x = totalX+mouseX-startX;
      y = totalY+mouseY-startY;
    } else {
      x = totalX;
      y = totalY;
    }
    
    if (autoRotate) {
      totalX += 0.25;
    }

    rotateX(-y * rotateMultiplier);
    rotateY(x * rotateMultiplier);
  }

  void mousePressed_() {
    if (mouseButton == LEFT) {
      startX = mouseX;
      startY = mouseY;
      rotating = true;
    } else if (mouseButton == RIGHT) {
      startX = mouseX;
      startY = mouseY;
      panning = true;
    }
  }

  void mouseWheel_(MouseEvent event) {
    float e = event.getCount();
    totalScale -= e/100;
    if (totalScale < 0.01) {
      totalScale = 0.01;
    }
  }

  void mouseReleased_() {
    if (mouseButton == LEFT) {
      rotating = false;
      totalX += mouseX-startX;
      totalY += mouseY-startY;
    } else if (mouseButton == RIGHT) {
      panning = false;
      totalPanX += mouseX-startX;
      totalPanY += mouseY-startY;
    }
  }
  
  void keyPressed_() {
    if (key == ' ') {
      autoRotate = !autoRotate;
    }
  }
}
