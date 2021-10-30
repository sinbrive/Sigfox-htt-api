import http.requests.*;
import java.util.Date;
import java.text.SimpleDateFormat;

public void setup() {
  size(100, 100);

  Sigfox t = new Sigfox(Secure.user, Secure.password);

  JSONArray jsonarray = new JSONArray();

  //jsonarray = t.device_messages("C3068E", 6); // limit<=100 
  //jsonarray = t.device_messages("C3068E", 20, 3); // limit and  offset  
  
  //jsonarray = t.device_messages("C3068E",  "19-10-2021", "15-10-2021");  // before & since

  //jsonarray = t.device_messages("C3068E", "15-10-2021");  // before

  //jsonarray = t.device_messages("C3068E");  // all messages

  t.pprint(jsonarray);

}
