class ArtObject {
  
  Vec3D v;
  Vec3D destination;

  Ple_Agent bob;
  JSONObject record;  
  int totalPageViews;
  int floorNumber = -1;
  String galleryNumber = null;
  String title;
  String classification;
  color primaryColor = color(255, 0, 0);
  processing.core.PApplet p5;
  
  ArtObject(processing.core.PApplet _p5, JSONObject _record) {
    record = _record;
    p5 = _p5;
    
    //Extract some data from the object record
    totalPageViews = record.getInt("totalpageviews");
    title = record.getString("title");
    classification = record.getString("classification");
    
    try {
      floorNumber = record.getJSONObject("gallery").getInt("floor");
      galleryNumber = record.getJSONObject("gallery").getString("gallerynumber");
    } catch(Exception ex) {}
    
    try {
      JSONArray colors = record.getJSONArray("colors");
      primaryColor = unhex("FF" + colors.getJSONObject(0).getString("color").substring(1));
    } catch(Exception ex) {}
    
    this.reset();
  }
 
  void reset() {
    v = new Vec3D(0, 0, 0);
    
    bob = new Ple_Agent(p5, v);    
        
    //generate a random initial velocity
    Vec3D initialVelocity = new Vec3D (random(-1, 1), random(-1, 1), random(-1, 1));

    //set some initial values:
    //initial velocity
    bob.setVelocity(initialVelocity);
  }

  void setHome(Vec3D _v) {
    v.x = _v.x;
    v.y = _v.y;
    v.z = _v.z; 
  }

  void setDestination(ArrayList <Gallery> _galleries) {
    if (floorNumber > -1) {
      for (Gallery g : _galleries) {
        if (g.galleryNumber.equals(galleryNumber)) {
          destination = g.location;
        }
      }
    }
  }
   
  Ple_Agent getAgent() {
    return this.bob;
  }
 
  void display(ArrayList <Ple_Agent> _artAgents) {
    stroke(primaryColor);
    
    if (!paused) {
      bob.flock(_artAgents, 80, 40, 30, 1, 0.5, 1.5);
      if (destination != null) {
        bob.arrive(destination);
      }
      bob.update();
    }

    bob.dropTrail(5, totalPageViews/5);
    
    if (showTrails) {
      strokeWeight(1);
      bob.drawTrail(totalPageViews);
    }

    if (showPoints) {
      strokeWeight(3);
      bob.displayPoint();
    }
    
    if (showArtInfo) {
      fill(primaryColor);
      textSize(4);
      text(this.title, bob.loc.x, bob.loc.y, bob.loc.z);
    }      
  }
  
}
