class Sigfox {

  String login, password;
  String api_url  = "https://api.sigfox.com/v2/" ; 

  Sigfox(String lgn, String passd) {
    this.login    = login;
    this.password = passd;
  }

  JSONArray device_messages(String device, Integer ... p) {
    /*
     *
     */

    Integer limit = p.length > 0 ? p[0] : 0;
    Integer offset = p.length > 1 ? p[1] : 0;

    if (limit > 100) limit=100;  // no paging in case of limit
    
    String url = this.api_url + "devices/" + device + "/messages?limit=" + Integer.toString(limit)+"&offset="+Integer.toString(offset);

    println(url);

    GetRequest get = new GetRequest(url);
    get.addUser(Secure.user, Secure.password); 
    get.send(); 
    JSONObject response = parseJSONObject(get.getContent());
    JSONArray ret = response.getJSONArray("data");

    return ret;
  }


  JSONArray device_messages(String device, String ... s) {
    /*
     *
     */

    String b = s.length > 0 ? s[0] : "";
    String si = s.length > 1 ? s[1] : "";

    long before, since;
    if (b!="")  before = convert2Epoch(b);
    else before=0;
    if (si!="") since  = convert2Epoch(si);
    else since=0;


    String url = this.api_url + "devices/" + device + "/messages?"+"before="+before+"&since="+since;

    println(url);

    JSONArray out = new JSONArray();
    device_messages_page(url, out);
    return out;
  }



  JSONArray  device_messages_page(String url, JSONArray out ) {
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

      // concatenate Json Arrays
      for (int i = 0; i < ret.size(); i++) {
        JSONObject r = new JSONObject();
        r = ret.getJSONObject(i);
        out.append(r);
      }

      //between two calls, it seems we should wait a bit (api doc says 1r/1s!)
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

  // all messages
  JSONArray device_messages(String device) {
    // Return array of message from paging URL.
    return device_messages(device, 0);
  }

  void pprint(JSONArray jsonarray) {
    for (int i = 0; i < jsonarray.size(); i++) {  // and not length() !
      JSONObject obj = jsonarray.getJSONObject(i);
      int sq = obj.getInt("seqNumber");
      String ii = obj.getString("data");
      long tt = obj.getLong("time");
      Date da = new Date(tt);

      SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy ~ HH:mm:ss");
      String mydate = sdf.format(da);

      JSONObject dd = obj.getJSONObject("device");
      String id = dd.getString("id");
      println(sq+" "+ii+" "+mydate+" "+id);
    }
  }


  long convert2Epoch(String strDate) {
    long millis=millis();
    try {
      millis = new SimpleDateFormat("dd-MM-yyyy").parse(strDate).getTime();
    } 
    catch (Exception e) {
      e.printStackTrace();
    }

    return millis;
  }
} // Sigfox
