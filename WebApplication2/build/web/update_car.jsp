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

JSONObject json1 = new JSONObject();

try{
   
    String check = "SELECT model,color,car_number,licence,seats FROM  car_details  where userid = ?";
    
        PreparedStatement s = conn.prepareStatement(check);
        s.setString(1,userid);
        ResultSet rs = s.executeQuery();
       
        if(rs.next())
                       {
                        json1.put("result","success");
                        json1.put("model",rs.getString("model"));
                        json1.put("color",rs.getString("color"));
                        json1.put("car_number",rs.getString("car_number"));
                        json1.put("licence",rs.getString("licence"));
                        json1.put("seats",rs.getInt("seats"));
                       }
        else
                       {
            json1.put("result","fail");
        }
                        
        }catch(Exception e){
   

          e.printStackTrace();
}
if(conn != null && !conn.isClosed()){
        conn.close();
}
if(session1 !=null && session1.isConnected()){
       session1.disconnect();
}
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(json1.toString()); 
%>
