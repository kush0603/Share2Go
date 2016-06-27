<%@page import="java.sql.*"%>
<%@page import="org.json.simple.JSONObject"%>
<%@include file="connect.jsp" %>
<%
  String userid = request.getParameter("id");
  JSONObject json = new JSONObject();
  try {
    String check = "SELECT userid FROM c2c_car_details where userid=?";
    PreparedStatement s = conn.prepareStatement(check);
    s.setInt(1, Integer.parseInt(userid));

    ResultSet rs = s.executeQuery();
    if (rs.next()) {
      json.put("result", "success");
    } else {
      json.put("result", "fail");
    }


  } catch (Exception e) {
    e.printStackTrace();
  }
  if (conn != null && !conn.isClosed()) {
    //System.out.println("Closing Database Connection");
    conn.close();
  }
  if (session != null && session1.isConnected()) {
    //System.out.println("Closing SSH Connection");
    session1.disconnect();
  }
  response.setContentType("application/json");
  response.setCharacterEncoding("UTF-8");
  response.getWriter().write(json.toString());
%>