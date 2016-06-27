<%@page import="com.jcraft.jsch.JSch"%>
<%@page import="com.jcraft.jsch.Session"%>
<%@page import="java.sql.*"%>
<% 
  
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
         
        
 %>  
