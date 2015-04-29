import colorLib.calculation.*;
import colorLib.*;
import colorLib.webServices.*;
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

private ControlP5 cp5;
ControlFrame cf;
ListBox l;

PImage canvas;
PImage brush;
PImage mouseCursor;

int height = 800;
int width = 800;

RandomPalette p;

color[] c = new color[4];

void setup(){
    size(height, width);
    smooth();

    //settings for ControlP5
    cp5 = new ControlP5(this);
    cf = addControlFrame("Dye_settings", 200,500);

    p = new RandomPalette(this);


    mouseCursor = loadImage("crosshair.png");
    cursor(mouseCursor, 0, 0);

    c[0] = color(255, 0, 0);
    c[1] = color(255, 255, 0);
    c[2] = color(255, 0, 128);
    c[3] = color(128, 0, 255);

  canvas = createImage(width,height,ARGB);
  generateBackground(); 
  setBrush();

}

void draw(){
  

  image(canvas,0,0);
  setBrush();
  //draw cursor
  //blend brush pixels into canvas if mouse is pressed
  if(mousePressed) canvas.blend(brush, 0, 0, brush.width, brush.width, (int)(mouseX-brush.width*.5), (int)(mouseY-brush.height*.5), brush.width, brush.width, LIGHTEST);
  
  if (keyPressed) { generateBackground(); }

  //println(cf.control().get(RadioButton.class, "brushes").getValueLabel());

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

void setBrush(){

  //if (cf.control().get(RadioButton.class, "brushes").getItems())
  int brush_index = -1;

  for(int i=0;i<cf.control().get(RadioButton.class, "brushes").getArrayValue().length;i++) {
      if (cf.control().get(RadioButton.class, "brushes").getArrayValue()[i] == 1) {
        brush_index = i;
        break;
      }
    }

  print(brush_index);

  switch(brush_index) {
    case 0: 
      brush = loadImage("circle.png");  
      break;
    case 1: 
      brush = loadImage("emoji_blu.png");  
      break;
    case 2: 
      brush = loadImage("emoji_fuxia.png");  
      break;
    case 3: 
      brush = loadImage("emoji_giallo.png");  
      break;
    case 4: 
      brush = loadImage("hen.png");  
      break;
    case 5: 
      brush = loadImage("corgi.png");  
      break;
    default:             
      brush = loadImage("circle.png");   
      break;
  }

  //brush = loadImage("white_noise.png");
  //tint(0, 153, 204, 126);
  int r = int(cf.control().get(ColorPicker.class, "picker").getArrayValue(0));
  int g = int(cf.control().get(ColorPicker.class, "picker").getArrayValue(1));
  int b = int(cf.control().get(ColorPicker.class, "picker").getArrayValue(2));
  int a = int(cf.control().get(ColorPicker.class, "picker").getArrayValue(3));
  tint(a,r,g,b);
}


// public void saveImage(int theValue) {
//   int m = millis();
//   save("image_"+m".png");
// }

// public void saveImage(int theValue) {
//   println("a button event from colorA: "+theValue);
//   int m = millis();
//   save("cross.tga");
// }

  



/*

* CONTROL FRAME PART
*
*
*
*
**/

public class ControlFrame extends PApplet {

  int w, h;

  int abc = 100;
  RadioButton r;
  ColorPicker cp;
  
  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    // cp5.addSlider("abc").setRange(0, 255).setPosition(10,10);
    // cp5.addSlider("def").plugTo(parent,"def").setRange(0, 255).setPosition(10,30);
    r = cp5.addRadioButton("brushes")
         .setPosition(10,10)
         .setSize(20,10)
         .setColorForeground(color(120))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(1)
         .setSpacingColumn(0)
         .addItem("CIRCLE",1)
         .addItem("BLUE",2)
         .addItem("FUXIA",3)
         .addItem("YELLOW",4)
         .addItem("HEN",5)
         .addItem("CORGI",6)
         ;

    cp = cp5.addColorPicker("picker")
          .setPosition(10, 130)
          .setColorValue(color(255, 255, 255, 255))
          ;

    // cp5.addButton("saveImage")
    //  .setValue(1)
    //  .setPosition(100,100)
    //  .setSize(200,19)
    //  ;
  }

  public void draw() {
      background(abc);
  }
  
  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }

  public ControlP5 control() {
    return cp5;
  }
  
  ControlP5 cp5;
  Object parent;
}



ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}
