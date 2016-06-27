<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.String"%>
<%@page language="java" %>
<%@page import="org.json.simple.JSONObject"%>
<%@include file="connect.jsp" %>
<% 
String from=request.getParameter("from");
//String via1=request.getParameter("via1");
//String via2=request.getParameter("via2");
String to=request.getParameter("to");
String fromdate=request.getParameter("date");
String fromtime=request.getParameter("time");
Integer duration=Integer.parseInt(request.getParameter("duration"));
String userid=request.getParameter("session");
int days=0;

SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
java.util.Date date = sdf1.parse(fromdate);
System.out.println("final converted is ");
System.out.println(date);
java.sql.Date sqlStartDate = new java.sql.Date(date.getTime()); 


DateFormat formatter = new SimpleDateFormat("hh:mm a");
long ms = formatter.parse(fromtime).getTime();
Time t = new Time(ms);
out.println(t);




JSONObject json1 = new JSONObject();
JSONArray jsonArray=new JSONArray();
try{
   
    /*String sql="insert into carpooling_takeride(user_id,source,destination,date,time,duration) values(?,?,?,?,?,?)";
    PreparedStatement statement=conn.prepareStatement(sql);
    statement.setInt(1,Integer.parseInt(userid));
    statement.setString(2,from);
    //statement.setString(3,via1);
    //statement.setString(4,via2);
    statement.setString(3,to);
    statement.setDate(4,sqlStartDate);
    statement.setString(5,fromtime);
    statement.setInt(6,days);
    statement.executeUpdate();
    //json.put("result","success");*/
    
String lat=request.getParameter("source_lat");
String lang=request.getParameter("source_lng");
//String date=request.getParameter("date");
//String duration=request.getParameter("duration");
System.out.println(userid);
System.out.println(lat);
System.out.println(lang);
System.out.println(fromdate);
System.out.println("date is ");
//SELECT *, ( 6371 * ACOS( COS( RADIANS(12.8399389) ) * COS( RADIANS( `lat` ) ) * COS( RADIANS( `lng` ) - RADIANS(77.6770031) ) + SIN( RADIANS(12.8399389) ) * SIN( RADIANS( `lat` ) ) ) ) AS distance FROM `gis`.`carpooling`,car_details,USER HAVING distance <= 100 AND carpooling.`user_id`=user.`userid` AND carpooling.`car_id`=car_details.`car_id` ORDER BY distance ASC;
System.out.println(date);
System.out.println(sqlStartDate);

System.out.println(duration);
String check;
if(duration == 1)
       {
    check = "SELECT *, ( 6371 * acos( cos( radians("+lat+") ) * cos( radians( `lat` ) ) * cos( radians( `lng` ) - radians("+lang+") ) + sin( radians("+lat+") ) * sin( radians( `lat` ) ) ) ) AS distance FROM `gis`.`carpooling`,car_details,user HAVING distance <= dev AND  user_id !="+userid+" AND duration = 1 AND DATE(carpooling.`date`)>= DATE('"+sqlStartDate+"') and DATE('"+sqlStartDate+"')< DATE(carpooling.`end_date`)  AND  carpooling.`user_id`=user.`userid` AND carpooling.`car_id`=car_details.`car_id` AND carpooling.`seat` >=1  ORDER BY distance ASC";
    
}
else
       {
    check = "SELECT *, ( 6371 * acos( cos( radians("+lat+") ) * cos( radians( `lat` ) ) * cos( radians( `lng` ) - radians("+lang+") ) + sin( radians("+lat+") ) * sin( radians( `lat` ) ) ) ) AS distance FROM `gis`.`carpooling`,car_details,user HAVING distance <= dev AND  user_id !="+userid+" AND duration != 1 AND DATE(carpooling.`date`)>= DATE('"+sqlStartDate+"') and DATE('"+sqlStartDate+"')< DATE(carpooling.`end_date`)  AND  carpooling.`user_id`=user.`userid` AND carpooling.`car_id`=car_details.`car_id` AND carpooling.`seat` >=1  ORDER BY distance ASC";
       }
        PreparedStatement s = conn.prepareStatement(check);
        ResultSet rs = s.executeQuery();

        int total_cols = rs.getMetaData().getColumnCount();
        int count=1;
        while (rs.next()) {
            System.out.println("" + total_cols);
            JSONObject json = new JSONObject();
                for (int i = 0; i < total_cols; i++) {
                    if(rs.getMetaData().getColumnLabel(i + 1).toLowerCase().equals("time")){
                        String json_time=rs.getObject(i + 1).toString();
                        json.put(rs.getMetaData().getColumnLabel(i + 1).toLowerCase(), json_time);
                    }
                    else
                        json.put(rs.getMetaData().getColumnLabel(i + 1).toLowerCase(), rs.getObject(i + 1));
                    
                }
                    jsonArray.add(json);
                    
        }
        json1.put(count,jsonArray);
                    count=count+1;
        

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