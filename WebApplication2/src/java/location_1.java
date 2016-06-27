
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author LENOVO
 */
public class location_1 {
    public String Find() throws JSONException{
        Parser jsonParser=new Parser();
        String url_create_product = "https://maps.googleapis.com/maps/api/directions/json";
        List<NameValuePair> params = new ArrayList<NameValuePair>();
            params.add(new BasicNameValuePair("origin","durg"));
            params.add(new BasicNameValuePair("destination","bhilai"));
            params.add(new BasicNameValuePair("key","AIzaSyDu2ViqMXoKDhA_f0qaJlyqRj172R53JYw"));
           
            JSONObject json = jsonParser.makeHttpRequest(url_create_product, "GET", params);
            System.out.println(json);
            return json.toString();
           /* JSONArray jsonRoutes = json.getJSONArray("routes");
       for (int i = 0; i < jsonRoutes.length(); i++) {
            JSONObject jsonRoute = (JSONObject)jsonRoutes.get(i);
            
            JSONArray jsonLegs = jsonRoute.getJSONArray("legs");
            JSONObject jsonLeg = jsonLegs.getJSONObject(0);
            JSONObject jsonDistance = jsonLeg.getJSONObject("distance");
            JSONObject jsonDuration = jsonLeg.getJSONObject("duration");
            JSONObject jsonEndLocation = jsonLeg.getJSONObject("end_location");
            JSONObject jsonStartLocation = jsonLeg.getJSONObject("start_location");

            String distance =  (String)jsonDistance.get("text");
            String duration =  (String)jsonDuration.get("text");
            System.out.println(distance+" "+duration);
      */
    }
    
}

