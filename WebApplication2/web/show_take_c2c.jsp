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
   
    
    String check = "SELECT c2c_takeride.date,c2c_takeride.source,c2c_takeride.destination,full_name,phone,cost FROM c2c_takeride,user,c2c_offer where c2c_takeride.user_id=? and c2c_offer_id=offer_id and c2c_takeride.user_offering= user.userid order by date";
    
        PreparedStatement s = conn.prepareStatement(check);
        s.setInt(1,Integer.parseInt(userid));
        ResultSet rs = s.executeQuery();
        int count=1;
        JSONObject json=null;
        out.println("hello");
        while (rs.next()) {
             out.println("hello1");
            json = new JSONObject();
            json.put("date", rs.getDate("date"));
            json.put("source", rs.getObject("source"));
            json.put("destination", rs.getObject("destination"));
            json.put("owner name", rs.getObject("full_name"));
            json.put("owner pno", rs.getObject("phone"));
            json.put("cost", rs.getObject("cost"));
           jArray_outer.add(json);
            out.println(json);

            
            
            
            
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
        