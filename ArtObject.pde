class ArtObject {
  
  Vec3D v;

  Ple_Agent bob;
  JSONObject record;  
  int totalPageViews;
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
   
  Ple_Agent getAgent() {
    return this.bob;
  }
 
  void display(ArrayList <Ple_Agent> _artAgents) {
    stroke(primaryColor);
    
    if (!paused) {
      bob.flock(_artAgents, 80, 40, 30, 1, 0.5, 1.5);
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
