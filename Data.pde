String apiKey = "[YOUR API KEY GOES HERE]";
String fields = "fields=objectid,totalpageviews,colors,classification,datebegin,title,gallery";
String filters = "gallery=any";
String size = "size=100";

ArrayList <ArtObject> loadData(processing.core.PApplet _p5){
  ArrayList <ArtObject> aos = new ArrayList <ArtObject>(); 
  int currentPage = 1;
  String apiURL;
  apiURL = "http://api.harvardartmuseums.org/object?apikey=" + 
                    apiKey + "&" +
                    filters + "&" +
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
