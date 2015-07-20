String apiKey = "[YOUR API KEY GOES HERE]";
String fields = "fields=objectid,totalpageviews,colors,classification,datebegin,title,gallery";
String filters = "gallery=any";
String size = "size=100";

ArrayList <ArtObject> loadArtData(processing.core.PApplet _p5){
 return loadArtData(_p5, filters); 
}

ArrayList <ArtObject> loadArtData(processing.core.PApplet _p5, String _filters){
  ArrayList <ArtObject> aos = new ArrayList <ArtObject>(); 
  int currentPage = 1;
  String apiURL;
  apiURL = "http://api.harvardartmuseums.org/object?apikey=" + 
                    apiKey + "&" +
                    _filters + "&" +
                    fields + "&" + 
                    size;
  
  // Get the initial set of data
  JSONObject data = loadJSONObject(apiURL);
  JSONArray records = data.getJSONArray("records");
  
  println("Found " + data.getJSONObject("info").getInt("totalrecords") + " records");
  
  while (records.size() > 0) {
    println("Processing page " + currentPage);
    
    for(int i=0;i<records.size();i++) {
      JSONObject record = records.getJSONObject(i);
      ArtObject ao = new ArtObject(_p5, record);
      aos.add(ao);
    }    
    
    // Get the next page of data
    currentPage += 1;    
    data = new JSONObject();
    records = new JSONArray();
    data = loadJSONObject(apiURL + "&page=" + currentPage);
    records = data.getJSONArray("records");
  }
  
  return aos;
}

ArrayList <Gallery> loadGalleryData(){
  ArrayList <Gallery> galleries = new ArrayList <Gallery>(); 
  int currentPage = 1;
  String apiURL;
  apiURL = "http://api.harvardartmuseums.org/gallery?apikey=" + 
                    apiKey + "&" +
                    size;
  
  // Get the initial set of data
  JSONObject data = loadJSONObject(apiURL);
  JSONArray records = data.getJSONArray("records");
  
  println("Found " + data.getJSONObject("info").getInt("totalrecords") + " records");
  
  while (records.size() > 0) {
    println("Processing page " + currentPage);
    
    for(int i=0;i<records.size();i++) {
      JSONObject record = records.getJSONObject(i);
      Gallery g = new Gallery(record);
      galleries.add(g);
    }    
    
    // Get the next page of data
    currentPage += 1;    
    data = new JSONObject();
    records = new JSONArray();
    data = loadJSONObject(apiURL + "&page=" + currentPage);
    records = data.getJSONArray("records");
  }
  
  return galleries;
}

ArrayList <String> loadList(String listName) {
  ArrayList <String> al = new ArrayList();

  int currentPage = 1;
  String apiURL;
  apiURL = "http://api.harvardartmuseums.org/" + listName + "?apikey=" + 
                      apiKey + "&" +
                      "sort=name&" +
                      size;
    
  // Get the initial set of data
  JSONObject data = loadJSONObject(apiURL);
  JSONArray records = data.getJSONArray("records");
  Integer totalRecords = data.getJSONObject("info").getInt("totalrecords");
  
  println("Found " + totalRecords + " records");

  while (records.size() > 0) {
    println("Processing page " + currentPage);  
    for(int i=0;i<records.size();i++) {
      JSONObject record = records.getJSONObject(i);
      
      String name = record.getString("name");      
                     
      al.add(name);
    }
      
    // Get the next page of data
    currentPage += 1;    
    data = new JSONObject();
    records = new JSONArray();
    data = loadJSONObject(apiURL + "&page=" + currentPage);
    records = data.getJSONArray("records");
  }
  
  println("Done stepping through the lists");
  return al;
}
