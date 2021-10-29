import http.requests.*;
// https://github.com/runemadsen/HTTP-Requests-for-Processing
import java.util.Date;
import java.text.SimpleDateFormat;

public void setup() {
  size(100, 100);
  
  Sigfox t = new Sigfox(Secure.user, Secure.password);

  ArrayList<JSONObject> list = new ArrayList<JSONObject>();
 
  list = t.device_messages("C3068E",5);
  for (int i=0; i<list.size(); i++) {
    println(list.get(i).getInt("seq_n")+" "+list.get(i).getString("data")+" "+list.get(i).getString("date")+" "+list.get(i).getString("device"));
  }
  
  delay(5000);  // must have between two calls
  ArrayList<JSONObject> list2 = new ArrayList<JSONObject>();
  //String url="https://api.sigfox.com/v2/devices/C3068E/messages"; // only for test of pages
  //t.device_messages_page(url, list2);  // only for test of pages
  t.device_messages("C3068E", list2);  // overloading
  print(list2, list2.size() );
}
