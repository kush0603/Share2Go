<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@include file="connect.jsp" %>
<% 
String email=request.getParameter("email");
String pwd=request.getParameter("pwd");
String fname=request.getParameter("fname");
String contact=request.getParameter("contact");
JSONObject json = new JSONObject();
try{
   
String check = "SELECT email, phone FROM user where email=? or phone=?";
PreparedStatement s=conn.prepareStatement(check);
s.setString(1,email);
s.setString(2,contact);
ResultSet rs = s.executeQuery();
if (!rs.next()) {
    json.put("result","success");
String sql="insert into user(email,password,full_name,phone) values(?,?,?,?)";
PreparedStatement statement=conn.prepareStatement(sql);
statement.setString(1,email);
statement.setString(2,pwd);
statement.setString(3,fname);
statement.setString(4,contact);
statement.executeUpdate();
json.put("result","success");
}
else
{
    json.put("result","fail");
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