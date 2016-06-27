<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.String"%>
<%@ page language="java" %>
<%@page import="org.json.simple.JSONObject"%>
<%@include file="connect.jsp" %>
<% 
String from=request.getParameter("from");
String via1=request.getParameter("via1");
String via2=request.getParameter("via2");
String to=request.getParameter("to");
String fromdate=request.getParameter("date");
String fromtime=request.getParameter("time");
String cost=request.getParameter("cost");
String comment=request.getParameter("comment");
String seats=request.getParameter("seats");
String userid=request.getParameter("session");
int days=0;
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

String check1 = "SELECT * FROM c2c_offer where user_id=? and DATE(c2c_offer.date)=DATE('"+sqlStartDate+"')";
PreparedStatement s1 = conn.prepareStatement(check1);
s1.setInt(1, Integer.parseInt(userid));

ResultSet rs = s1.executeQuery();
    if (rs.next()) {
      json.put("result", "present");
    } 
    else {
            try{
                String sql="insert into c2c_offer(user_id,source,via1,via2,destination,date,time,cost,comment,seats,car_id) values(?,?,?,?,?,?,?,?,?,?,?)";
                PreparedStatement statement=conn.prepareStatement(sql);
                statement.setInt(1,Integer.parseInt(userid));
                statement.setString(2,from);
                statement.setString(3,via1);
                statement.setString(4,via2);
                statement.setString(5,to);
                statement.setDate(6,sqlStartDate);
                statement.setTime(7,t);
                statement.setInt(8,Integer.parseInt(cost));
                statement.setString(9,comment);
                statement.setInt(10,Integer.parseInt(seats));
                statement.setInt(11,car_id);
                statement.executeUpdate();
                json.put("result","success");
            }catch(Exception e){
                json.put("result","fail");
                e.printStackTrace();
            }
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