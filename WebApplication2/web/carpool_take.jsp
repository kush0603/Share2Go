<%@page import="java.util.List"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.String"%>
<%@page import="org.json.JSONException"%>
<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" %> 
<%@include file="connect.jsp" %>
<% 
String user_id = request.getParameter("session");
String source=request.getParameter("source");
String source_lat=request.getParameter("source_lat");
String source_lng=request.getParameter("source_lng");
String destination=request.getParameter("destination");
String destination_lat=request.getParameter("destination_lat");
String destination_lng=request.getParameter("destination_lng");
String date=request.getParameter("date");
String duration=request.getParameter("duration");
String offer_id=request.getParameter("offer_id");
String user_offering=request.getParameter("user_offering");

int days= Integer.parseInt(duration);
out.println(user_id+" "+source+" "+source_lat+" "+destination+" "
        +destination_lat+" "+destination_lng+" "+date+" dur"+duration+"offer "+offer_id+" user "+user_offering+" days"+days);

SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
java.util.Date d = sdf1.parse(date);
java.sql.Date sqlStartDate = new java.sql.Date(d.getTime()); 
out.println(sqlStartDate);


     
JSONObject res = new JSONObject();
try{
    String sql="insert into carpooling_takeride(user_id,source,source_lat,source_lng,"
            + "destination,destination_lat,destination_lng,"
            + "date,duration,offer_id,user_offering,end_date) "
            + "values(?,?,?,?,?,?,?,?,?,?,?,DATE_ADD(?, INTERVAL ? DAY))";
   
    PreparedStatement statement=conn.prepareStatement(sql);
    statement.setInt(1,Integer.parseInt(user_id));
    statement.setString(2,source);
    statement.setDouble(3,Double.parseDouble(source_lat));
    statement.setDouble(4,Double.parseDouble(source_lng));
    statement.setString(5,destination);
    statement.setDouble(6,Double.parseDouble(destination_lat));
    statement.setDouble(7,Double.parseDouble(destination_lng));
    statement.setDate(8,sqlStartDate);
    statement.setInt(9,days);
    statement.setInt(10,Integer.parseInt(offer_id));
    statement.setInt(11,Integer.parseInt(user_offering)); 
     statement.setDate(12,sqlStartDate);
    statement.setInt(13,days);

    statement.executeUpdate();
  
    
    res.put("result","success");
    
    
}catch(Exception e){
    res.put("result",e.getMessage());
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
response.getWriter().write(res.toString()); 
%>