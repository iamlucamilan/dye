import colorLib.calculation.*;
import colorLib.*;
import colorLib.webServices.*;

PImage canvas;
PImage brush;

int height = 800;
int width = 800;

RandomPalette p;

color[] c = new color[4];

void setup(){
    size(height, width);
    smooth();

    p = new RandomPalette(this);


    // mouseCursor = loadImage("crosshair.png");
    // cursor(mouseCursor, 0, 0);

    c[0] = color(255, 0, 0);
    c[1] = color(255, 255, 0);
    c[2] = color(255, 0, 128);
    c[3] = color(128, 0, 255);

  canvas = createImage(width,height,ARGB);
  brush = loadImage("brush.png");
}

void draw(){
  image(canvas,0,0);
  //draw cursor
  //blend brush pixels into canvas if mouse is pressed
  if(mousePressed) canvas.blend(brush, 0, 0, brush.width, brush.width, (int)(mouseX-brush.width*.5), (int)(mouseY-brush.height*.5), brush.width, brush.width,MULTIPLY);
  
  if (keyPressed) {
  //   p = new RandomPalette(this);
  //   Gradient g = new Gradient(p, width);

  //   for (int i = 0; i < g.totalSwatches(); i++) {
  //     stroke(g.getColor(i));
  //     line(i, 0, i, width); 
  //   }
  // }

  generateBackground(); 
    }
}

void generateBackground() {
  p = new RandomPalette(this);
  Gradient g = new Gradient(p, width);

  for (int i = 0; i < g.totalSwatches(); i++) {
    stroke(g.getColor(i));
    strokeWeight(random(1,10)); 
    line(i, 0, i, height); 
  }
}
