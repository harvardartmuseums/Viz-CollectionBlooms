import toxi.geom.*;
import plethora.core.*;
import peasy.*;
import java.awt.event.KeyEvent;

PeasyCam cam;

PFont font;

ArrayList <ArtObject> artObjects;
ArrayList <Ple_Agent> artAgents;

Boolean showMouse = true;
Boolean showTrails = true;
Boolean showPoints = true;
Boolean showArtInfo = false;
Boolean paused = true;
Boolean recording = false;

void init() {
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  super.init();
}

void setup() {
  size(1920, 1080, OPENGL);
  frame.setLocation(1920, 0);

  font = createFont("Arial", 72);
  textFont(font);

  cam = new PeasyCam(this, 600);

  artObjects = loadData(this);

  bloom();
}

void draw() {
  if (showMouse) {
    cursor();
  } else {
    noCursor();
  }
  
  background(235);

  for (ArtObject ao : artObjects) {
    ao.display(artAgents);
  }
  
  if (recording) {
    saveFrame("output/frames####.png");
    
    cam.beginHUD();
    fill(255, 0, 0);
    textSize(48);
    text("Recording", 10, 50);
    textSize(14);
    text("FPS: " + frameRate, 10, 70);
    cam.endHUD();    
  }    
  
  cam.rotateY(radians(0.05));
}

void bloom() {
  artAgents = new ArrayList <Ple_Agent>();  

  for (ArtObject ao : artObjects) {
    ao.reset();
    artAgents.add(ao.getAgent());
  }
}


