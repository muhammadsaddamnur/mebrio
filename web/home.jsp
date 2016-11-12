
<%@page import="ghazali.koneksi"%>
<%@page import="java.sql.ResultSet"%>
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
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function verify()
            {
                if(document.getElementById('filename').value=="")
                {
                    alert('Please select the file');
                    return false;                
                }
                else
                {
                    return true;
                }
            }
        </script>
    </head>
    <body>
        
        
        <%
        if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
        %>
        <div class="login-page">
            <div class="form">
                <form class="login-form">
                    <p class="message"> You are not logged in<br/>
                        <a href="index.jsp">Please Login</a> </p>
                </form>
            </div
        <div>
        <%} else {
        %>
            
        
        
        
        <div class="login-page">
            <div class="form">
                <h3> <p class="message"> Selamat Datang <%=session.getAttribute("userid")%> (<a href="logout.jsp">Keluar</a>) </p> </h3>  <br>
                <h2> <p class="message"> Upload File Kamu Disini</p> </h2> <br>
                
        <form enctype="multipart/form-data" action="unggah.jsp" onsubmit="return verify()" method="post" class="login-form" >
            Pilih File <input type="file" name="filename" id="filename" accept=".txt, application/pdf, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel, application/vnd.openxmlformats-officedocument.wordprocessingml.document,application/msword" />
            <input type="submit" value="Upload"/>
        </form>
        <br/>
        <table border="1" cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <tr><th>File Name</th><th>Uploaded By</th><th>File Type</th><th>Upload Time</th><th>Action</th></tr>
            <%
                ResultSet rs = koneksi.getResultFromSqlQuery("select doc_id,filename,type, upload_time, upload_by from documents where upload_by='" + session.getAttribute("userid") + "'");
                int count =0;
                while(rs.next())
                {
                   out.println("<tr>"
                           + "<td>"+rs.getString(2)+"</td>"
                           + "<td>"+rs.getString(5)+"</td>"
                           + "<td>"+rs.getString(3)+"</td>"
                           + "<td>"+rs.getString(4)+"</td>"
                           + "<td><a href='unduh.jsp?Doc_id="+rs.getInt(1) +"'> Download </a></td>"                                                      
                           + "</tr>");
                   count++;
                }
                rs.close();
                koneksi.CloseConnection();
                if(count==0)
                {
                    out.println("<tr><td colspan='4'> No File Found..!! </td></tr>");
                }
            %>        
            </tr>
        </table>
            
            </div>
    </div>
            
            
            
            <%
        }
        %>
    </body>
</html>
