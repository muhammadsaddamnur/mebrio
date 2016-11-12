<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="ghazali.*,org.hibernate.*,org.hibernate.cfg.*" %>
<%!
 Session session1 = null;
%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String email = request.getParameter("email");
    

    try
    {
        Configuration cf=new Configuration();
        cf.configure();
        SessionFactory sessionFactory = cf.buildSessionFactory();
        session1 =sessionFactory.openSession();
        User e=new User(username,password,email);
        session1.save(e);
        session1.flush();
        session1.close();
        response.sendRedirect("thank.jsp");
    } catch(Exception e)
    {
        response.sendRedirect("duplicateuser.jsp");
    }
%>
    



