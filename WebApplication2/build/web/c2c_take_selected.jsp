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
String destination=request.getParameter("destination");
String date=request.getParameter("date");
String time=request.getParameter("time");
System.out.println("kkkkkkkkkkkkkkkkkkkkk"+ time);
String offer_id=request.getParameter("offer_id");
String user_offering=request.getParameter("user_offering");

System.out.println("date"+date+"src="+source+"dest="+destination+"offer_id"+ offer_id+"user_offering="+user_offering+"user_id");
int car_id=0;

SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");

java.util.Date d = sdf1.parse(date);
java.sql.Date sqlStartDate = new java.sql.Date(d.getTime()); 
System.out.println("sql_date="+sqlStartDate);

DateFormat formatter = new SimpleDateFormat("hh:mm a");
long ms = formatter.parse(time).getTime();
Time t = new Time(ms);

System.out.println(t);
     
JSONObject res = new JSONObject();
try{
        System.out.println("hello");

    String sql="insert into c2c_takeride(user_id,source,destination,date,time,offer_id,user_offering) values(?,?,?,?,?,?,?)";
    PreparedStatement statement=conn.prepareStatement(sql);
    statement.setInt(1,Integer.parseInt(user_id));
    statement.setString(2,source);
    statement.setString(3,destination);
    statement.setDate(4,sqlStartDate);
    statement.setTime(5, t);
    statement.setInt(6,Integer.parseInt(offer_id));
    statement.setInt(7,Integer.parseInt(user_offering));    
    statement.executeUpdate();
   
   String queryString = "update c2c_offer set seats=seats-1 where  c2c_offer_id = ?";
    PreparedStatement pstatement = conn.prepareStatement(queryString);
    pstatement.setInt(1,Integer.parseInt(offer_id));
    pstatement.executeUpdate();
    
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