import toxi.geom.*;
import plethora.core.*;
import peasy.*;
import java.awt.event.KeyEvent;
import java.util.*;

PeasyCam cam;

PFont font;

ArrayList <ArtObject> artObjects;
ArrayList <Gallery> galleries;
ArrayList <String> classifications;
ArrayList <Ple_Agent> artAgents;

Gallery selectedGallery;
String selectedClassification;

int selectedGalleryIndex = 0;
int selectedClassificationIndex = 0;

boolean showChrome = true;
boolean showMouse = true;
boolean showFloors = false;
boolean showTrails = true;
boolean showPoints = true;
boolean showArtInfo = false;
boolean setHomeAsOrigin = true;
boolean paused = true;
boolean recording = false;

String layout = "floor";


void init() {
  if (!showChrome) {
    frame.removeNotify();
    frame.setUndecorated(true);
    frame.addNotify();
  }
  super.init();
}

void setup() {
  size(displayWidth, displayHeight, OPENGL);
  if (!showChrome) {
    frame.setLocation(0, 0);
  }

  font = createFont("Arial", 72);
  textFont(font);

  cam = new PeasyCam(this, 0, -200, 0, 600);

  artObjects = loadArtData(this);
  galleries = loadGalleryData();
  classifications = loadList("classification");

  selectedGallery = galleries.get(selectedGalleryIndex);
  selectedClassification = classifications.get(selectedClassificationIndex);

  arrangeGalleries();
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
    if (selectedClassificationIndex == 0 || ao.classification.equals(selectedClassification)) {
      ao.display(artAgents);
    }
  }

  if (showFloors) {
    for (Gallery g : galleries) {
      fill(200, 200, 200, 100);
      noStroke();
      pushMatrix();
      translate(-500, g.location.y, -500);
      rotateX(radians(90));
      rect(0, 0, 1000, 1000);
      popMatrix();
    }
  }

  if (selectedClassificationIndex > 0) {
    cam.beginHUD();
    fill(0);
    textSize(48);
    text(selectedClassification, 40, 60);
    cam.endHUD();
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
    ao.setDestination(galleries);
    
    if (setHomeAsOrigin) {
      ao.setHome(new Vec3D(0, 0, 0));
    } else {
      ao.setHome(ao.destination);
    }
    artAgents.add(ao.getAgent());
  }
}

void arrangeGalleries() {
  for (Gallery g : galleries) {
    Vec3D d;
    if (layout.equals("floor")) {
      d = new Vec3D(0, -200*(g.floor-1), 0);
    } else {
      d = new Vec3D(random(-500, 500), -200*(g.floor-1), random(-500, 500));
    }
    g.setLocation(d);
  }
}
