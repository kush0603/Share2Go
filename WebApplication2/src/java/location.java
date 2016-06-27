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
public class location {
    public static void main(String from[]) throws JSONException{
        JSONParser jsonParser=new JSONParser();
        String url_create_product = "https://maps.googleapis.com/maps/api/directions/json";
        List<NameValuePair> params = new ArrayList<NameValuePair>();
            params.add(new BasicNameValuePair("origin","raipur"));
            params.add(new BasicNameValuePair("waypoints","durg|"));
            params.add(new BasicNameValuePair("destination","nagpur"));
            params.add(new BasicNameValuePair("key","AIzaSyDu2ViqMXoKDhA_f0qaJlyqRj172R53JYw"));
           
            JSONObject json = jsonParser.makeHttpRequest(url_create_product, "GET", params);
            System.out.println(json);
            int distance[];
            int duration[];
           // JSONObject jsonData = new JSONObject(json);
            //System.out.println(json);
        JSONArray jsonRoutes = json.getJSONArray("routes");
        for (int i = 0; i < jsonRoutes.length(); i++) {
            JSONObject jsonRoute = jsonRoutes.getJSONObject(i);
            
            JSONArray jsonLegs = jsonRoute.getJSONArray("legs");
            duration=new int[jsonLegs.length()];
            distance=new int[jsonLegs.length()];
            for(int j=0;j<jsonLegs.length();j++)
            {
            JSONObject jsonLeg = jsonLegs.getJSONObject(j);
            JSONObject jsonDistance = jsonLeg.getJSONObject("distance");
            JSONObject jsonDuration = jsonLeg.getJSONObject("duration");
            String jsonEndLocation = jsonLeg.getString("end_address");
            String jsonStartLocation = jsonLeg.getString("start_address");

            distance[j] =  jsonDistance.getInt("value");
            duration[j] =  jsonDuration.getInt("value");
            System.out.println(distance[j]+" "+duration[j]+" "+jsonEndLocation+" "+jsonStartLocation);
     
            }
    }
    
}
}