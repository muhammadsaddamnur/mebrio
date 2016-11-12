
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.io.OutputStream"%>
<%@page import="ghazali.koneksi"%>
<%
    String doc_id = request.getParameter("Doc_id");     
    ResultSet rs = koneksi.getResultFromSqlQuery("select FileName, type, content from documents where Doc_id = " + doc_id);
    rs.next();
    
    response.reset();
                             
    if(rs.getString(2)==".txt")
    {
        response.setContentType("application/octet-stream");
    }
    else if(rs.getString(2)==".pdf")
    {
        response.setContentType("application/pdf");
    }
    else if((rs.getString(2)==".doc")||rs.getString(2)==".docx")
    {
        response.setContentType("application/msword");
    }
    else if((rs.getString(2)==".xls")||(rs.getString(2)==".xlsx"))
    {
        response.setContentType("application/vnd.ms-excel");
    }
    response.addHeader("Content-Disposition","attachment; filename="+rs.getString(1));
    Blob blb = rs.getBlob(3);
    byte[] bdata = blb.getBytes(1, (int) blb.length());
    
    OutputStream output =  response.getOutputStream();
    output.write(bdata);
    output.close();
              
    rs.close();
    koneksi.CloseConnection(); 
%>