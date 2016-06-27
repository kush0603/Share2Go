<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.String"%>
<%@ page language="java" %>
<%@page import="org.json.simple.JSONObject"%>
<%@include file="connect.jsp" %>
<% 
String model=request.getParameter("model");
String color=request.getParameter("color");
String car_number=request.getParameter("car_number");
String licence=request.getParameter("licence");
String seats=request.getParameter("seats");
String userid=request.getParameter("session");
JSONObject json = new JSONObject();
try{
   
    String sql="insert into c2c_car_details(userid,model,color,car_number,licence,seat) values(?,?,?,?,?,?)";
    PreparedStatement statement=conn.prepareStatement(sql);
    statement.setInt(1,Integer.parseInt(userid));
    statement.setString(2,model);
    statement.setString(3,color);
    statement.setString(4,car_number);
    statement.setString(5,licence);
    statement.setInt(6,Integer.parseInt(seats));
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
