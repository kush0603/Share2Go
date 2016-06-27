package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;
import java.sql.*;

public final class connect_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.Vector _jspx_dependants;

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
 
  
        int lport=3807;
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
