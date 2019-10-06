// These are functions for generating the textures for the water and terrain

void createWaterTexture(Terrain terrain) {
  
  float maxY = 200;
  
  PGraphics w = createGraphics(textureSize, textureSize, P2D);
  w.noSmooth();
  w.beginDraw();
  
  w.background(#0f5e9c);
  w.noStroke();
  
  // Add waves
  w.loadPixels();
  for (int i = 0; i < w.pixels.length; i++) {
    float noiseValue = noise((i % w.width)/10.0, (i/w.width)/10.0);
    w.pixels[i] = lerpColor(color(#0f5e9c), color(#0e719c), noiseValue);
  }
  w.updatePixels();
  
  // Add foam / lighter water to the coast line
  for (int r = 0; r < terrain.rows; r++) {
    for (int c = 0; c < terrain.columns; c++) {
      float y = terrain.yValues[r][c];
      
      float percentageX = (c * terrain.scale) / terrain.w;
      float percentageZ = (r * terrain.scale) / terrain.h;
      
      if (y > 0 && y < maxY) {
        
        float percentageAboveWater = y/maxY;
        
        int colorIndex = waterColors.length - (int)(percentageAboveWater * waterColors.length);
        
        colorIndex = constrain(colorIndex, 0, waterColors.length-1);
        w.fill(waterColors[colorIndex]);
        
        w.ellipse(percentageX * w.width, percentageZ * w.height, 10, 10);
      }
    }
  }
  
  w.endDraw();
  waterTexture = w;
}

void createTerrainTexture(Terrain terrain) {
  
  PGraphics t = createGraphics(textureSize, textureSize, P2D);
  t.noSmooth();
  t.beginDraw();
  
  t.background(#509460);
  t.noStroke();
  
  
  // Add variation to ground color
  t.loadPixels();
  
  for (int i = 0; i < t.pixels.length; i++) {
    
    float noiseValue = noise((i % t.width)/10.0, (i/t.width)/10.0);
    
    if (noiseValue > 0.5) {
      t.pixels[i] = color(#3d8556);
    }
    t.pixels[i] += random(0, 100);
  }
  t.updatePixels();
  
  // Add sand near to coast line
  for (int r = 0; r < terrain.rows; r++) {
    for (int c = 0; c < terrain.columns; c++) {
      float y = terrain.yValues[r][c];
      
      float percentageX = (c * terrain.scale) / terrain.w;
      float percentageZ = (r * terrain.scale) / terrain.h;
      
      if (y < 0 && y > -100+map(noise((float)r/50.0, (float)c/50.0), 0, 1, -50, 150)) {
        t.fill(beachColors[(int)random(beachColors.length)]);
        t.ellipse(percentageX * t.width, percentageZ * t.height, 10, 10);
      }
    }
  }
  
  t.endDraw();
  terrainTexture = t;
  terrain.terrain.setTexture(terrainTexture);
}
