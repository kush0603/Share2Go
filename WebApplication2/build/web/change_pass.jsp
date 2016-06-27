<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@include file="connect.jsp" %>
<% 
String new_pass=request.getParameter("new_pwd");
String old_pass=request.getParameter("old_pwd");
String user_id=request.getParameter("session");
JSONObject json = new JSONObject();
try{
   
String check = "SELECT  userid from user where userid=? and password=?";
PreparedStatement s=conn.prepareStatement(check);
s.setString(1,user_id);
s.setString(2,old_pass);
ResultSet rs = s.executeQuery();
if (!rs.next()) {
    
    json.put("result","fail");
       }
else
       {
String sql="update user set password=? where userid=?";
PreparedStatement statement=conn.prepareStatement(sql);
statement.setString(1,new_pass);
statement.setString(2,user_id);
statement.executeUpdate();
json.put("result","success");
}
}catch(Exception e){
    e.printStackTrace();
}
if(conn != null && !conn.isClosed()){
                //System.out.println("Closing Database Connection");
                conn.close();
            }
            if(session !=null && session1.isConnected()){
                //System.out.println("Closing SSH Connection");
                session1.disconnect();
            }
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(json.toString());

%>