<%@page import="org.json.simple.JSONArray"%>

<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.String"%>
<%@ page language="java" %>
<%@page import="org.json.simple.JSONObject"%>
<%@include file="connect.jsp" %>
<%
    String from = request.getParameter("source");
//String via1=request.getParameter("via1");
//String via2=request.getParameter("via2");
    String to = request.getParameter("to");
    String fromdate = request.getParameter("date");
    String fromtime = request.getParameter("time");
    String userid = request.getParameter("session");
    int days = 0;

    SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
    java.util.Date date = sdf1.parse(fromdate);
    java.sql.Date sqlStartDate = new java.sql.Date(date.getTime());
    out.println(sqlStartDate);

    DateFormat formatter = new SimpleDateFormat("hh:mm a");
    long ms = formatter.parse(fromtime).getTime();
    Time t = new Time(ms);
    out.println(t);

    JSONObject json1 = new JSONObject();
    JSONArray jsonArray = new JSONArray();

    try {

        
     
        String check = "SELECT * FROM c2c_offer,c2c_car_details,user  "
                + "where c2c_offer.user_id=user.userid "
                + "and c2c_car_details.userid=user.userid "
                + "and (c2c_offer.user_id != ?)"
                + "and c2c_offer.date =?"
                + "and (c2c_offer.source=?"
                + "or c2c_offer.via1=?"
                + "or c2c_offer.via2=?)"               
                + "and c2c_offer.destination=?"
                + "and c2c_offer.seats >=1";
        PreparedStatement s = conn.prepareStatement(check);
        s.setInt(1, Integer.parseInt(userid));
        s.setDate(2,sqlStartDate);
        s.setString(3,from);
        s.setString(4,from);
        s.setString(5,to);
        s.setString(6,to);
        


        ResultSet rs = s.executeQuery();

        int total_cols = rs.getMetaData().getColumnCount();
        int count = 1;
        while (rs.next()) {
            System.out.println("" + total_cols);
            JSONObject json = new JSONObject();
            for (int i = 0; i < total_cols; i++) {
                if (rs.getMetaData().getColumnLabel(i + 1).toLowerCase().equals("time")) {
                    String json_time = rs.getObject(i + 1).toString();
                    json.put(rs.getMetaData().getColumnLabel(i + 1).toLowerCase(), json_time);
                } else {
                    json.put(rs.getMetaData().getColumnLabel(i + 1).toLowerCase(), rs.getObject(i + 1));
                }

            }
            jsonArray.add(json);

        }
        json1.put(count, jsonArray);
        count = count + 1;
    } catch (Exception e) {
        //json1.put("result", "fail");
        e.printStackTrace();
    }
    if (conn != null && !conn.isClosed()) {
        //System.out.println("Closing Database Connection");
        conn.close();
    }
    if (session1 != null && session1.isConnected()) {
        //System.out.println("Closing SSH Connection");
        session1.disconnect();
    }
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(json1.toString());
%>