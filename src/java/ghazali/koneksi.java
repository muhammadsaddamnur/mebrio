/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ghazali;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author ghazali
 */
public class koneksi {
    static Connection con;
    public static Connection getConnection()
    {
        try
        {            
            if(con==null)
            {
                Class.forName("com.mysql.jdbc.Driver");                    
                con= DriverManager.getConnection("jdbc:mysql://localhost:3306/Jsp_Upload?user=root&password=");          
            }
        }
        catch (Exception ex)
        {
            ex.printStackTrace();
        }        
        return con;
    }
    
    public static void CloseConnection()
    {
        if(con!=null)
        {
            try
            {
                con.close();
                con = null;
            }
            catch (SQLException ex)
            {
                ex.printStackTrace();
            }            
        }
        
    }
    
    public static ResultSet getResultFromSqlQuery(String SqlQueryString)
    {
        System.out.println("in funcation");
        ResultSet rs=null;
        if(con==null)
        {
            getConnection();
        }
        try
        {
            rs = con.createStatement().executeQuery(SqlQueryString);
        }
        catch (SQLException ex)
        {
            ex.printStackTrace();
        }             
        return rs;
    }
            
    
    public static void main(String args[])
    {
        getResultFromSqlQuery("select * from documents");
        CloseConnection();
        System.out.println("con done" + (con==null));                
    }
    
}
