// This is a class for rendering a grid and the origin with axes
// This helps in the earlier stages of creating a 3d world, because you can easily see the placement of objects

class World {
  
  // Renders a grid
  void render_grid(float cell_size, float _width, float _length) {
        stroke(150);
        strokeWeight(0.5);
        float offset_x = (_width * cell_size) / 2;
        float offset_z = (_length * cell_size) / 2;
        float offset_y = 0.01;
        for (int i=0; i < _width + 1; i++) {
            line(i * cell_size - offset_x, offset_y, -offset_z, i *
                 cell_size - offset_x, offset_y, _length * cell_size - offset_z);
        }

        for (int i=0; i < _length + 1; i++) {
            line(-offset_x, offset_y, i * cell_size - offset_z, _width *
                 cell_size - offset_x, offset_y, i * cell_size - offset_z);
        }
                 
    }
    
    // Renders the 3 axes (X, Y and Z)
    void render_origin() {
        

        strokeWeight(3);
        stroke(255);
        fill(255);
        line(-100, 0, 0, 0, 0, 0);
        line(0, 100, 0, 0, 0, 0);
        line(0, 0, -100, 0, 0, 0);
        text("-X", -100, 0, 0);
        text("+Y", 0, 100, 0);
        text("-Z", 0, 0, -100);

        fill(255, 0, 0);
        stroke(255, 0, 0);
        line(0, 0, 0, 100, 0, 0);
        text("+X", 100, 0, 0);

        fill(0, 255, 0);
        stroke(0, 255, 0);
        line(0, 0, 0, 0, -100, 0);
        text("-Y", 0, -100, 0);

        fill(0, 0, 255);
        stroke(0, 0, 255);
        line(0, 0, 0, 0, 0, 100);
        text("+Z", 0, 0, 100);
        
    }
  
}
