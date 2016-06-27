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
   
    String check = "SELECT full_name,email,phone FROM  user  where userid = ?";
    
        PreparedStatement s = conn.prepareStatement(check);
        s.setString(1,userid);
        ResultSet rs = s.executeQuery();
       
        if(rs.next())
                       {
                        json1.put("result","success");
                        json1.put("name",rs.getString("full_name"));
                        json1.put("email",rs.getString("email"));
                        json1.put("phone",rs.getString("phone"));
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
