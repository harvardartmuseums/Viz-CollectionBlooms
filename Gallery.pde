class Gallery {
  String galleryNumber;
  int floor;
  Vec3D location;
  
  Gallery(JSONObject _record) {
    galleryNumber = _record.getString("gallerynumber");
    floor = _record.getInt("floor");
  }
  
  void setLocation(Vec3D _location) {
    location = _location;
  }  
  
  void display() {
    if (showGalleries) {
      fill(#000000);
      textSize(14);
      text(this.galleryNumber, this.location.x, this.location.y, this.location.z);
    }
  }
}