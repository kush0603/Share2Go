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

String take_id=request.getParameter("take_id");
int takeid=Integer.parseInt(take_id);




JSONObject json = new JSONObject();
try{
String sql= "update carpooling_takeride set status=? where  request_id = ?";
PreparedStatement statement1=conn.prepareStatement(sql);
statement1.setString(1, "reject");
statement1.setInt(2, takeid);
statement1.executeUpdate();
   
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