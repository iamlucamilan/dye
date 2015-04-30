import colorLib.calculation.*;
import colorLib.*;
import colorLib.webServices.*;
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;


// Control P5 library import
private ControlP5 cp5;
ControlFrame cf;
ListBox l;


PImage canvas; // Canvas image
PImage brush;  // Brush Image (yes. Custom brushes)
PImage mouseCursor; // Fancy mouse cursor.

int height = 800;
int width = 800;

RandomPalette p; // Random palette from ColorLib library

void setup(){
    size(height, width);
    smooth();

    //settings for ControlP5
    cp5 = new ControlP5(this);
    cf = addControlFrame("DYE", 200,500);

    p = new RandomPalette(this);

    mouseCursor = loadImage("crosshair.png");
    cursor(mouseCursor, 0, 0);

  canvas = createImage(width,height,ARGB);
  generateBackground(); // Function to generate random brackground
  setBrush(); // Library to read the CP5 value and set the brush

}

void draw(){
  
  image(canvas,0,0);
  setBrush();
  // Blend brush pixels into canvas if mouse is pressed. Check BLEND_MODE variable
  if(mousePressed) canvas.blend(brush, 0, 0, brush.width, brush.width, (int)(mouseX-brush.width*.5), (int)(mouseY-brush.height*.5), brush.width, brush.width, REPLACE);

  // Check the keypressed to save the image or change the background gradient
  if (keyPressed) {
    if (key == 's' || key == 'S') { save("image.png"); }
    else { generateBackground(); }
  }

}

void generateBackground() {
  p = new RandomPalette(this);
  Gradient g = new Gradient(p, width);

  // Read the generated gradient and draw lot of lines
  for (int i = 0; i < g.totalSwatches(); i++) {
    stroke(g.getColor(i));
    strokeWeight(random(1,10));   
    line(i, 0, i, height); 
  }
}

void setBrush(){

  // Check the active radio button and set the right brush
  int brush_index = -1;


  for(int i=0;i<cf.control().get(RadioButton.class, "brushes").getArrayValue().length;i++) {
      if (cf.control().get(RadioButton.class, "brushes").getArrayValue()[i] == 1) {
        brush_index = i;
        break;
      }
    }

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

  // Read the value from the knob to increase brush dimension 
  int bw = (int(cf.control().get(Knob.class, "b_width").getValue()));
  brush.resize(bw,0);

  // Read from the color picker to tint che draw 
  int r = int(cf.control().get(ColorPicker.class, "picker").getArrayValue(0));
  int g = int(cf.control().get(ColorPicker.class, "picker").getArrayValue(1));
  int b = int(cf.control().get(ColorPicker.class, "picker").getArrayValue(2));
  int a = int(cf.control().get(ColorPicker.class, "picker").getArrayValue(3));
  tint(a,r,g,b);
}

/*
* CONTROL FRAME PART
* This part connfigure the external frame with p5gui setups
**/

public class ControlFrame extends PApplet {

  int w, h;
  int abc = 100;
  RadioButton r;
  ColorPicker cp;
  Knob brush_width;
  Textlabel explain_text;
  
  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    r = cp5.addRadioButton("brushes")
         .setPosition(5,10)
         .setSize(30,30)
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
          .setPosition(5, 200)
          .setColorValue(color(255, 255, 255, 255))
          ;

     brush_width = cp5.addKnob("b_width")
                   .setRange(30,800)
                   .setValue(70)
                   .setPosition(95,10)
                   .setRadius(50)
                   .setDragDirection(Knob.HORIZONTAL)
                   ;

    explain_text = cp5.addTextlabel("text_label")
                    .setText("DYE\nSelect brush type and size\nChange the tint of your brush\nPress any key to change background\nPress S to save your image")
                    .setPosition(5,280)
                    ;
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
  f.setLocation(115, 38);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}
