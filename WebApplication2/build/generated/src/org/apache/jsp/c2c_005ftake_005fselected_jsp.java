package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.util.List;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.sql.*;
import java.lang.String;
import org.json.JSONException;
import org.json.JSONArray;
import org.json.JSONObject;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import java.sql.*;

public final class c2c_005ftake_005fselected_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.Vector _jspx_dependants;

  static {
    _jspx_dependants = new java.util.Vector(1);
    _jspx_dependants.add("/connect.jsp");
  }

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public Object getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write(" \n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
 
  
        int lport=3806;
        String rhost="127.0.0.1";
        String host="ec2-52-77-226-177.ap-southeast-1.compute.amazonaws.com";
        int rport=3306;
        String user="ubuntu";
        String password="root";
        String dbuserName = "root";
        String dbpassword = "root";
        String url = "jdbc:mysql://localhost:"+lport+"/gis";
        String driverName="com.mysql.jdbc.Driver";
        Connection conn = null;
        Statement stmt=null;
        Session session1= null;
        try{
            //Set StrictHostKeyChecking property to no to avoid UnknownHostKey issue
            java.util.Properties config1 = new java.util.Properties(); 
            config1.put("StrictHostKeyChecking", "no");
            JSch jsch = new JSch();
            session1=jsch.getSession(user, host, 22);
            session1.setPassword(password);
            jsch.addIdentity("F:/gis/sample.pem");
            session1.setConfig(config1);
            session1.connect();
            out.println("Connected");
            //mysql database connectivity
            
            session1.setPortForwardingL(lport,rhost,rport);
               

                //mysql database connectivity
                Class.forName(driverName).newInstance();
                conn = DriverManager.getConnection(url, dbuserName, dbpassword);
                
       }
        catch(Exception ex){
            out.println(ex);}
         
        
 
      out.write("  \n");
      out.write('\n');
      out.write('\n');
 
String user_id = request.getParameter("session");
String source=request.getParameter("source");
//String source_lat=request.getParameter("source_lat");
//String source_lng=request.getParameter("source_lng");
String destination=request.getParameter("destination");
//String destination_lat=request.getParameter("destination_lat");
//String destination_lng=request.getParameter("destination_lng");
String date=request.getParameter("date");
String time=request.getParameter("start_time");
System.out.println("kkkkkkkkkkkkkkkkkkkkk"+ time);
//String duration=request.getParameter("duration");
String offer_id=request.getParameter("offer_id");
String user_offering=request.getParameter("user_offering");

//int days=0;
int car_id=0;

//SimpleDateFormat sdf1 = new SimpleDateFormat("dd/MM/yyyy");
DateFormat df1 = new SimpleDateFormat("dd/MM/yyyy");

java.util.Date d = df1.parse(date);
java.sql.Date sqlStartDate = new java.sql.Date(d.getTime()); 
out.println(sqlStartDate);

DateFormat formatter = new SimpleDateFormat("hh:mm a");
long ms = formatter.parse(time).getTime();
Time t = new Time(ms);

/*if(duration=="15 days")
    days=15;
else if(duration=="1 month")
    days=30;
else
    days=60;*/

     
JSONObject res = new JSONObject();
try{
    System.out.println("yoyoyoyoyoyoyoyoyo");   
//    String sql="insert into carpooling_takeride(user_id,source,source_lat,source_lng,destination,destination_lat,destination_lng,date,duration,offer_id,user_offering) values(?,?,?,?,?,?,?,?,?,?,?)";
    String sql="insert into c2c_takeride(user_id,source,destination,date,time,offer_id,user_offering) values(?,?,?,?,?,?,?)";
    PreparedStatement statement=conn.prepareStatement(sql);
    statement.setInt(1,Integer.parseInt(user_id));
    statement.setString(2,source);
//    statement.setDouble(3,Double.parseDouble(source_lat));
//    statement.setDouble(4,Double.parseDouble(source_lng));
    statement.setString(3,destination);
//    statement.setDouble(6,Double.parseDouble(destination_lat));
//    statement.setDouble(7,Double.parseDouble(destination_lng));
    statement.setDate(4,sqlStartDate);
    statement.setTime(5, t);
    statement.setInt(6,Integer.parseInt(offer_id));
    statement.setInt(7,Integer.parseInt(user_offering));    
    statement.executeUpdate();
    System.out.println("iiiiiiiiiiiiiiiiiiiiiiiiiii");

/*    String queryString = "update c2c_car_details set seats=seats-1 where car_id = (select car_id from c2c_offer where c2c_offer_id = ?)";
    PreparedStatement pstatement = conn.prepareStatement(queryString);
    pstatement.setInt(1,Integer.parseInt(offer_id));
    pstatement.executeUpdate();*/
    
    res.put("result","success");
    
    
}catch(Exception e){
    res.put("result",e.getMessage());
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
response.getWriter().write(res.toString()); 

    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
