
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;
import java.util.*;

private ControlP5 cp5;
Accordion accordion;
ControlFrame cf;

int def;

void setup() {
  size(400, 400);
  cp5 = new ControlP5(this);
  // by calling function addControlFrame() a
  // new frame is created and an instance of class
  // ControlFrame is instanziated.
  cf = addControlFrame("extra", 150,600);
  // add Controllers to the 'extra' Frame inside 
  // the ControlFrame class setup() method below.
}

void draw() {
  // this is the canvas window
  background(255);
  
}

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(10, 10);
  f.setResizable(true);
  f.setVisible(true);
  return p;
}

// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {
  int w, h;
  int abc = 100;
  
  public void setup() {
    size(w, h);
    frameRate(25);
    cp5 = new ControlP5(this);
    // group number 1, contains 2 bangs
    Group g1 = cp5.addGroup("Shapes")
                  .setBackgroundColor(color(0, 64))
                  .setBackgroundHeight(150)
                  ;
                  
    List l = Arrays.asList("Triangle", "Square", "Penta");
    /* add a ScrollableList, by default it behaves like a DropdownList */
    cp5.addScrollableList("dropdown")
       .setPosition(100, 100)
       .setSize(200, 100)
       .setBarHeight(20)
       .setItemHeight(20)
       .addItems(l)
       .moveTo(g1)
       // .setType(ScrollableList.LIST) // currently supported DROPDOWN and LIST
       ;
       
    
    /*cp5.addBang("bang")
       .setPosition(10,20)
       .setSize(100,100)
       .moveTo(g1)
       .plugTo(this,"shuffle");
       ;*/
       
    // group number 2, contains a radiobutton
    Group g2 = cp5.addGroup("Thickness")
                  .setBackgroundColor(color(0, 64))
                  .setBackgroundHeight(150)
                  ;
    
    cp5.addRadioButton("radio")
       .setPosition(10,20)
       .setItemWidth(20)
       .setItemHeight(20)
       .addItem("black", 0)
       .addItem("red", 1)
       .addItem("green", 2)
       .addItem("blue", 3)
       .addItem("grey", 4)
       .setColorLabel(color(255))
       .activate(2)
       .moveTo(g2)
       ;
  
    // group number 3, contains a bang and a slider
    Group g3 = cp5.addGroup("Colors")
                  .setBackgroundColor(color(0, 64))
                  .setBackgroundHeight(150)
                  ;
    
    cp5.addBang("shuffle")
       .setPosition(10,20)
       .setSize(40,50)
       .moveTo(g3)
       ;
       
    cp5.addSlider("hello")
       .setPosition(60,20)
       .setSize(100,20)
       .setRange(100,500)
       .setValue(100)
       .moveTo(g3)
       ;
       
    cp5.addSlider("world")
       .setPosition(60,50)
       .setSize(100,20)
       .setRange(100,500)
       .setValue(200)
       .moveTo(g3)
       ;
  
    // create a new accordion
    // add g1, g2, and g3 to the accordion.
    accordion = cp5.addAccordion("acc")
                   .setPosition(0,0)
                   .setWidth(150)
                   .addItem(g1)
                   .addItem(g2)
                   .addItem(g3)
                   ;
                   
    cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.open(0,1,2);}}, 'o');
    cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.close(0,1,2);}}, 'c');
    cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.setWidth(300);}}, '1');
    cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.setPosition(0,0);accordion.setItemHeight(190);}}, '2'); 
    cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.setCollapseMode(ControlP5.ALL);}}, '3');
    cp5.mapKeyFor(new ControlKey() {public void keyEvent() {accordion.setCollapseMode(ControlP5.SINGLE);}}, '4');
    cp5.mapKeyFor(new ControlKey() {public void keyEvent() {cp5.remove("myGroup1");}}, '0');
    
    accordion.open(0,1,2);
    
    // use Accordion.MULTI to allow multiple group 
    // to be open at a time.
    accordion.setCollapseMode(Accordion.MULTI);
    
    // when in SINGLE mode, only 1 accordion  
    // group can be open at a time.  
    // accordion.setCollapseMode(Accordion.SINGLE);    
    
    
  }

  public void draw() {
    // this is the palette canvas
    background(0);
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


  
