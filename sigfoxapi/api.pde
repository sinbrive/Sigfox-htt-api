class Sigfox {

  String login, password;
  String api_url  = "https://api.sigfox.com/v2/" ; 

  Sigfox(String lgn, String passd) {
    this.login    = login;
    this.password = passd;
  }

  ArrayList<JSONObject> device_messages(String device, int limit) {
    /*
     *
     */

    ArrayList<JSONObject> retList = new ArrayList<JSONObject>();
    String url = this.api_url + "devices/" + device + "/messages?limit=" + Integer.toString(limit);

    GetRequest get = new GetRequest(url);
    get.addUser(Secure.user, Secure.password); 
    get.send(); 
    JSONObject response = parseJSONObject(get.getContent());
    JSONArray ret = response.getJSONArray("data");

    ArrayList<JSONObject> result = new ArrayList<JSONObject>();
    result = extractData(ret);
    retList.addAll(result);

    return retList;
  }


  ArrayList<JSONObject> device_messages(String device, ArrayList<JSONObject> out ) {  
    /*
     *  get all the messages pages
     */
    String url = this.api_url + "devices/" + device + "/messages";

    device_messages_page(url, out);

    return out;
  }


  ArrayList<JSONObject>  device_messages_page(String url, ArrayList<JSONObject> out ) {
    // Return array of message from paging URL.

    GetRequest get = new GetRequest(url);
    get.addUser(Secure.user, Secure.password); 
    get.send(); 
    try {
      JSONObject response = parseJSONObject(get.getContent());
      JSONArray ret = response.getJSONArray("data");
      //println("ret:"+ret);
      String new_page = response.getJSONObject("paging").getString("next");  // ok
      println(new_page);

      ArrayList<JSONObject> result = new ArrayList<JSONObject>();
      result = extractData(ret);
      out.addAll(result);

      //between two calls, it seems we should wait a bit
      delay(6000);
      if (new_page!=null) this.device_messages_page(new_page, out);
      else return out;
    }
    catch(Exception e) {
      println(e);
    }
    //println(out);
    return out;
  }

  ArrayList<JSONObject> extractData(JSONArray in) {
    ArrayList<JSONObject> out = new ArrayList<JSONObject>();
    for (int i = 0; i < in.size(); i++) {  // and not length() !
      JSONObject obj = in.getJSONObject(i);
      int sq = obj.getInt("seqNumber");
      String ii = obj.getString("data");
      long tt = obj.getLong("time");
      Date t = new Date(tt);

      SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy ~HH:mm:ss");
      String mydate = sdf.format(t);

      JSONObject dd = obj.getJSONObject("device");
      String id = dd.getString("id");


      JSONObject retJson = new JSONObject();
      retJson.put("seq_n", sq);  // int
      retJson.put("data", ii);
      retJson.put("date", mydate);
      retJson.put("device", id);
      out.add(retJson);
    }
    return out;
  }
}
