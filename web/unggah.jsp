<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="ghazali.koneksi"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<style>
        @import url(https://fonts.googleapis.com/css?family=Roboto:300);

.login-page {
  width: 1024px;
  padding: 8% 0 0;
  margin: auto;
}
.form {
  position: relative;
  z-index: 1;
  background: #FFFFFF;
  max-width: 1024px;
  margin: 0 auto 100px;
  padding: 45px;
  text-align: center;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}
.form input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #f2f2f2;
  width: 100%;
  border: 0;
  margin: 0 0 15px;
  padding: 15px;
  box-sizing: border-box;
  font-size: 14px;
}
.form button {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: #4CAF50;
  width: 100%;
  border: 0;
  padding: 15px;
  color: #FFFFFF;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
.form button:hover,.form button:active,.form button:focus {
  background: #43A047;
}
.form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
.form .message a {
  color: #4CAF50;
  text-decoration: none;
}
.form .register-form {
  display: none;
}
.container {
  position: relative;
  z-index: 1;
  max-width: 300px;
  margin: 0 auto;
}
.container:before, .container:after {
  content: "";
  display: block;
  clear: both;
}
.container .info {
  margin: 50px auto;
  text-align: center;
}
.container .info h1 {
  margin: 0 0 15px;
  padding: 0;
  font-size: 36px;
  font-weight: 300;
  color: #1a1a1a;
}
.container .info span {
  color: #4d4d4d;
  font-size: 12px;
}
.container .info span a {
  color: #000000;
  text-decoration: none;
}
.container .info span .fa {
  color: #EF3B3A;
}
body {
  background: #76b852; /* fallback for old browsers */
  background: -webkit-linear-gradient(right, #76b852, #8DC26F);
  background: -moz-linear-gradient(right, #76b852, #8DC26F);
  background: -o-linear-gradient(right, #76b852, #8DC26F);
  background: linear-gradient(to left, #76b852, #8DC26F);
  font-family: "Roboto", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;      
}    
        </style>
<!DOCTYPE html>
<html>
    
     <%
        if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
        %>
            You are not logged in<br/>
            <a href="index.jsp">Please Login</a>
        <%} else {
        %>

        <%
        }
        %>
        
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <div class="login-page">
            <div class="form">
                <form class="login-form">
                    <p class="message">
        upload file page...!!!
        <%
            
            String user = String.valueOf(session.getAttribute("userid"));
            String rtempfile = File.createTempFile("temp","1").getParent();            
            MultipartRequest multi = new MultipartRequest(request,rtempfile, 15*1024*1024);     // maximum size 15 MB
            
            Enumeration files = multi.getFileNames();
            

            String st="insert into documents(filename, type,content, upload_by) values (?,?,?,?)";
            PreparedStatement psmt=koneksi.getConnection().prepareStatement(st);
            
                        
            String name="";
            String fileExtesion="";
            File ff =null;
            FileInputStream fin =null;
            
            while (files.hasMoreElements())
            {
                    name=(String)files.nextElement();                                        
                    ff = multi.getFile(name);
                    fileExtesion = ff.getName().substring(ff.getName().lastIndexOf("."));
                    
                    boolean fileAllowed = fileExtesion.equalsIgnoreCase(".txt")||
                                          fileExtesion.equalsIgnoreCase(".pdf")||
                                          fileExtesion.equalsIgnoreCase(".doc")||
                                          fileExtesion.equalsIgnoreCase(".docx")||
                                          fileExtesion.equalsIgnoreCase(".xls")||
                                          fileExtesion.equalsIgnoreCase(".xlsx");
                    
                    if((ff!=null)&&fileAllowed)
                    {

                            try
                            {
                                    fin=new FileInputStream(ff);
                                    psmt.setString(1, ff.getName());
                                    psmt.setString(2, fileExtesion);
                                    psmt.setBinaryStream(3,(InputStream)fin, (int)(ff.length()));
                                    psmt.setString(4, user);        // pass the user name or id 
                                    boolean sss = psmt.execute();
                                    
                                    out.print("uploaded successfully..");
                                    out.print("<br/> Go to page");
                            }

                            catch(Exception e)
                            {
                                    out.print("Failed due to " + e);
                            }

                            finally
                            {
                            // next statement is must otherwise file will not be deleted from the temp as fin using f.
                             // its necessary to put outside otherwise at the time of exception file will not be closed.
                                    fin.close();
                                    ff.delete();
                            }
                    }
                    else
                    {
                           out.print("Please select the correct file...");
                    }// end of if and else
            }// end of while
                                   
            koneksi.CloseConnection();            
        %>
        <a href="home.jsp">Home Page</a>
        </p>
                </form>
            </div>
        </div>
    </body>
</html>
