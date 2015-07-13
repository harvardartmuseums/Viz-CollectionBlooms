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
}
