/*

For Challenge 1, I want to generate a complex landscape
by making use of drawing surfaces, perlin noise, recursion and P3D

It also uses some reusable code I made in earlier weeks to help me create
this complex 3d world:
- a camera system for quickly navigating the 3d environment
(left mouse to rotate, right mouse to pan and scroll wheel to zoom in and out, space to toggle rotation)
- the terrain generation with layered perlin noise
- grid and axes drawing for seeing empty world orientation

The base idea of the code is to generate a 3D terrain: 
- with textures for the water and terrain
- with 2D images that function as foliage. 

It takes a long time to render all the foliage variants, 
so if you want to render faster you can lower the value for treeVariantAmount, rockVariantAmount, and vegetationVariantAmount

Made by Arjo Nagelhout
4 / 5 oct 2019
TUe ID year 1, quartile 1, Creative Programming, Challenge 1

*/

World world;
Camera camera;
Terrain terrain;

int worldSize = 10000;
int textureSize = 1024;

// Textures for terrain and water
PGraphics waterTexture;
PImage terrainTexture;
color[] waterColors = {#3D8BC7, #3D8BC7, #3D8BC7, #54A7C4, #84D8F5};
color[] beachColors = {#F9D199, #FDD8B5, #F6E3D4};

// Variables for generating and rendering trees
PGraphics[] treeSlots;
int treeVariantAmount = 10;
int treeWidth = 200;
int treeAmount = 120;
int[] treeX = new int[treeAmount];
int[] treeY = new int[treeAmount];
int[] treeZ = new int[treeAmount];
float[] treeS = new float[treeAmount];
float treeMinS = 1.0;
float treeMaxS = 5;
int[] treeIndex = new int[treeAmount];
color[] treeLeavesColors = {#61948b, #38786d, #2d7254, #336739, #4b7641};

// Variables for generating and rendering rocks
PGraphics[] rockSlots;
int rockVariantAmount = 10;
int rockWidth = 100;
int rockAmount = 200;
int[] rockX = new int[rockAmount];
int[] rockY = new int[rockAmount];
int[] rockZ = new int[rockAmount];
float[] rockS = new float[rockAmount];
float rockMinS = 0.5;
float rockMaxS = 1.5;
int[] rockIndex = new int[rockAmount];
color[] rockColors = {#969FB2, #787F8E, #606672, #4D525B};

// Variables for generating and rendering vegetation (grass)
PGraphics[] vegetationSlots;
int vegetationVariantAmount = 10;
int vegetationWidth = 200;
int vegetationAmount = 800;
int[] vegetationX = new int[vegetationAmount];
int[] vegetationY = new int[vegetationAmount];
int[] vegetationZ = new int[vegetationAmount];
float[] vegetationS = new float[vegetationAmount];
float vegetationMinS = 0.2;
float vegetationMaxS = 3;
int[] vegetationIndex = new int[vegetationAmount];

void setup() {
  
  fullScreen(P3D);
  noSmooth();
  
  hint(ENABLE_DEPTH_SORT);
  imageMode(CORNER);
  
  
  world = new World();
  camera = new Camera();
  
  // Generate terrain
  Noise[] noise = new Noise[] {
    new Noise(-100, 100, 0.1, 0, 1),
    new Noise(-800, 200, 0.04, 0, 200)
  };
  terrain = new Terrain(worldSize, worldSize, 40, noise);
  
  // Generate tree variants
  treeSlots = new PGraphics[treeVariantAmount];
  for (int i=0; i < treeVariantAmount; i++) {
    generateTree(i, treeWidth, (int)random(100, 500));
  }
  
  // Generate rock variants
  rockSlots = new PGraphics[rockVariantAmount];
  for (int i = 0; i < rockVariantAmount; i++) {
    generateRock(i, rockWidth, 50);
  }
  
  // Generate vegetation (grass) variants
  vegetationSlots = new PGraphics[vegetationVariantAmount];
  for (int i = 0; i < vegetationVariantAmount; i++) {
    generateVegetation(i, vegetationWidth, (int)random(50, 200));
  }
  
  // Generate water texture
  createWaterTexture(terrain);
  
  // Generate terrain texture
  createTerrainTexture(terrain);
  
  // Place trees, rocks and vegetation (grass) in the 3d environment
  placeImages(treeAmount, treeX, treeY, treeZ, treeS, treeIndex, treeVariantAmount, treeMinS, treeMaxS);
  placeImages(rockAmount, rockX, rockY, rockZ, rockS, rockIndex, rockVariantAmount, rockMinS, rockMaxS);
  placeImages(vegetationAmount, vegetationX, vegetationY, vegetationZ, vegetationS, vegetationIndex, vegetationVariantAmount, vegetationMinS, vegetationMaxS);
}


void draw() {
  background(#87CEEB);
  
  camera.update(); // Custom camera class of which the behaviour is described in the top of this document
  //world.render_origin();
  //world.render_grid(100, 20, 20);
  
  pushMatrix();
  translate(-worldSize/2, 0, -worldSize/2);
  
  terrain.render();
  
  // Draw water with the generated texture
  beginShape();
  texture(waterTexture);
  vertex(0, 0, 0, 0, 0);
  vertex(0, 0, worldSize, 0, textureSize);
  vertex(worldSize, 0, worldSize, textureSize, textureSize);
  vertex(worldSize, 0, 0, textureSize, 0);
  endShape();
  popMatrix();
  
  // Draw box below water so that you can't see under the water
  pushMatrix();
  int h = 1300;
  fill(#104A9C);
  translate(0, h/2+1, 0);
  box(worldSize, h, worldSize);
  popMatrix();
  
  // Draw trees, rocks and vegetation (grass)
  drawImages(treeSlots, treeWidth, treeAmount, treeX, treeY, treeZ, treeS, treeIndex);
  drawImages(rockSlots, rockWidth, rockAmount, rockX, rockY, rockZ, rockS, rockIndex);
  drawImages(vegetationSlots, vegetationWidth, vegetationAmount, vegetationX, vegetationY, vegetationZ, vegetationS, vegetationIndex);
}



// Functions that pass through to the custom camera class
void mousePressed() {
  camera.mousePressed_();
}

void mouseReleased() {
  camera.mouseReleased_();
}

void mouseWheel(MouseEvent event) {
  camera.mouseWheel_(event);
}

void keyPressed() {
  camera.keyPressed_();
}
