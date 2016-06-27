<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.String"%>
<%@page language="java" %>
<%@page import="org.json.simple.JSONObject"%>
<%@include file="connect.jsp" %>
<% 

String userid=request.getParameter("session");
//String userid="2";
JSONObject json1 = new JSONObject();

JSONArray jArray_outer=new JSONArray();
try{
   
    
    String check = "SELECT source,destination,car_id,seats,c2c_offer_id,date,cost FROM c2c_offer where user_id=?   order by date";
    
        PreparedStatement s = conn.prepareStatement(check);
        s.setInt(1,Integer.parseInt(userid));
        ResultSet rs = s.executeQuery();
        int count=1;
        JSONObject json=null;
        while (rs.next()) {
            json = new JSONObject();
            json.put("seats", rs.getObject("seats"));
            json.put("car_id", rs.getObject("car_id"));
            json.put("offer_id", rs.getInt("c2c_offer_id"));
            json.put("date", rs.getDate("date"));
            json.put("source", rs.getObject("source"));
            json.put("destination", rs.getObject("destination"));
            json.put("cost", rs.getObject("cost"));
            int offer=rs.getInt("c2c_offer_id");
            out.println(offer);

            String check1 = "SELECT c2c_takeride_id,c2c_takeride.user_id as uid,full_name,phone,source,destination "
 + "                                FROM c2c_takeride,user "
 + "                                    where c2c_takeride.user_offering=? "
 + "                                            and c2c_takeride.user_id=user.userid "
 + "                                            and c2c_takeride.offer_id=?";
            PreparedStatement s1 = conn.prepareStatement(check1);
            s1.setInt(1,Integer.parseInt(userid));
            s1.setInt(2,offer);
            ResultSet rs1 = s1.executeQuery();
            JSONArray jsonArray=new JSONArray();
            while (rs1.next()) {
                //out.println("full_name");
                JSONObject json_inner = new JSONObject();
                json_inner.put("take_id", rs1.getObject("c2c_takeride_id"));
                json_inner.put("uid", rs1.getObject("uid"));
                json_inner.put("full_name", rs1.getObject("full_name"));
                json_inner.put("phone", rs1.getObject("phone"));
                json_inner.put("source", rs1.getObject("source"));
                json_inner.put("destination", rs1.getObject("destination"));
                jsonArray.add(json_inner);
                //out.println("Array: "+jsonArray.toString());
                
                //out.println("JSON: "+json.toString());
                
                
            }
            json.put("members",jsonArray);
            jArray_outer.add(json);
            
            
            
            }
        
        json1.put("count",jArray_outer);
       out.println(json1.toString());
       

}catch(Exception e){
    //json1.put("result",e.getMessage());
    e.printStackTrace();
}
if(conn != null && !conn.isClosed()){
        //System.out.println("Closing Database Connection");
        conn.close();
}
if(session1 !=null && session1.isConnected()){
       //System.out.println("Closing SSH Connection");
       session1.disconnect();
}
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(json1.toString()); 
%>