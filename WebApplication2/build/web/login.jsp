<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@include file="connect.jsp" %>

<% 
String email=request.getParameter("email");
String pwd=request.getParameter("pwd");
JSONObject json = new JSONObject();
try{
String check = "SELECT userid,email, password FROM user where email=? and password=?";
PreparedStatement s=conn.prepareStatement(check);
s.setString(1,email);
s.setString(2,pwd);
ResultSet rs = s.executeQuery();
 if (rs.next()) {
     session.setAttribute( "user_id",rs.getString("userid") );
        json.put("result", "success");
        json.put("user_id",session.getAttribute("user_id"));
 }
 else {
        json.put("result", "fail");
} 
}catch (Exception e) {
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