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
<!DOCTYPE>
<% 

String offer_id = request.getParameter("offer_id");
String start_date=request.getParameter("sdate");
String end_date=request.getParameter("end_date");
String take_id=request.getParameter("take_id");
String uid=request.getParameter("uid");

int offerid = Integer.parseInt(offer_id);
String offer_sdate="";
String offer_edate="";
int cost=0;
int offer_user=0;
int take_user = Integer.parseInt(uid);
int takeid=Integer.parseInt(take_id);

System.out.println("offer_id="+offer_id+"sdate="+start_date+"end_date="+end_date+"takeid="+take_id);
SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
java.util.Date date = sdf1.parse(start_date);
java.sql.Date sqlStartDate = new java.sql.Date(date.getTime()); 
System.out.println("sql"+sqlStartDate);

java.util.Date date1 = sdf1.parse(end_date);
java.sql.Date sqlEndDate = new java.sql.Date(date1.getTime()); 
System.out.println(sqlEndDate);

String sql= "update carpooling_takeride set status = ? where  request_id = ?";
PreparedStatement statement1=conn.prepareStatement(sql);
statement1.setString(1,"accept");
statement1.setInt(2, takeid);
statement1.executeUpdate();
   System.out.println("hello1");

String sql1= "update carpooling set seat=seat-1 where offer_id=?";

PreparedStatement statement2=conn.prepareStatement(sql1);
statement2.setInt(1,offerid);
statement2.executeUpdate();
   System.out.println("hello");
String sql2="select date,end_date,cost,user_id from carpooling where offer_id=?";
PreparedStatement s = conn.prepareStatement(sql2);    
s.setInt(1,offerid);
ResultSet rs = s.executeQuery();

if(rs.next())
{
   offer_sdate=rs.getString("date");
    offer_edate=rs.getString("end_date");
    cost=rs.getInt("cost");
    offer_user=rs.getInt("user_id");
   }       
System.out.println("hello");

java.util.Date offer_sdate1 = sdf1.parse(offer_sdate);
java.sql.Date sqlofferStart = new java.sql.Date(offer_sdate1.getTime()); 

java.util.Date offer_edate1 = sdf1.parse(offer_edate);
java.sql.Date sqlofferEnd = new java.sql.Date(offer_edate1.getTime()); 

Date final_start=sqlStartDate;
Date final_end=sqlEndDate;

int c1=sqlStartDate.compareTo(sqlofferStart);
if(c1<0)
       {
    final_start=sqlofferStart;
}

int c=sqlEndDate.compareTo(sqlofferEnd);
if(c>0)
       {
    final_end=sqlofferEnd;
}


JSONObject json = new JSONObject();
  json.put("result","success");
try{
   
    String sql3="insert into carpooling_bill(offer_id,take_id,user_offer,user_take,start_date,end_date,pay)values(?,?,?,?,?,?,(DATEDIFF(?,?)*?))";
PreparedStatement statement = conn.prepareStatement(sql3);    
 
      statement.setInt(1,offerid);
    statement.setInt(2,takeid);
    statement.setInt(3,offer_user);
    statement.setInt(4,take_user);
    statement.setDate(5,final_start);
    statement.setDate(6,final_end);
    statement.setDate(7,final_start);
    statement.setDate(8,final_end);
   statement.setInt(9,cost);
     statement.executeUpdate();
    json.put("result","success");
}catch(Exception e){
    json.put("result","fail");
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