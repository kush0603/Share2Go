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
String from=request.getParameter("from");
String to=request.getParameter("to");
String fromdate=request.getParameter("date");
String fromtime=request.getParameter("time");
String duration=request.getParameter("duration");
String cost=request.getParameter("cost");
String comment=request.getParameter("comment");
String userid=request.getParameter("session");
String distance=request.getParameter("distance");
String journeytime=request.getParameter("journeytime");
String lat=request.getParameter("lat");
String lng=request.getParameter("lng");
String latd=request.getParameter("lat_d");
String lngd=request.getParameter("lng_d");

String seat=request.getParameter("seat");
String dev=request.getParameter("dev");
String devtime=request.getParameter("devtime");

int car_id=0;
try{
   
    String sql="select car_id from car_details where userid=?";
    PreparedStatement statement=conn.prepareStatement(sql);
    statement.setInt(1,Integer.parseInt(userid));
    ResultSet rs = statement.executeQuery();
 if (rs.next()) {
     car_id=Integer.parseInt(rs.getString("car_id"));
 }
}catch(Exception e1){
    out.println(e1.getMessage());
}
SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
java.util.Date date = sdf1.parse(fromdate);
java.sql.Date sqlStartDate = new java.sql.Date(date.getTime()); 
out.println(sqlStartDate);

DateFormat formatter = new SimpleDateFormat("hh:mm a");
long ms = formatter.parse(fromtime).getTime();
Time t = new Time(ms);
out.println(t);



     
JSONObject json = new JSONObject();
try{
   
    String sql="insert into carpooling(user_id,source,destination,date,time,"
            + "duration,cost,comment,car_id,lat,lng,distance,journeytime,dev"
            + ",devtime,seat,lat_d,lng_d,end_date) "
            + "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,DATE_ADD(?, INTERVAL ? DAY))";
    
    PreparedStatement statement=conn.prepareStatement(sql);
    statement.setInt(1,Integer.parseInt(userid));
    statement.setString(2,from);
    statement.setString(3,to);
    statement.setDate(4,sqlStartDate);
    statement.setTime(5,t);
    statement.setInt(6,Integer.parseInt(duration));
    statement.setInt(7,Integer.parseInt(cost));
    statement.setString(8,comment);
    statement.setInt(9,car_id);
    statement.setDouble(10,Double.valueOf(lat));
    statement.setDouble(11,Double.valueOf(lng));
    statement.setInt(12,Integer.parseInt(distance));
    statement.setInt(13,Integer.parseInt(journeytime));
    statement.setInt(14,Integer.parseInt(dev));
    statement.setInt(15,Integer.parseInt(devtime));
    statement.setInt(16,Integer.parseInt(seat));
 statement.setDouble(17,Double.valueOf(latd));
    statement.setDouble(18,Double.valueOf(lngd));
      statement.setDate(19,sqlStartDate);
      statement.setInt(20,Integer.parseInt(duration)-1);
    statement.executeUpdate();
    json.put("result","success");
}catch(Exception e){
    json.put("result",e.getMessage());
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
response.getWriter().write(json.toString()); 
%>