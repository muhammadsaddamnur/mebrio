package ghazali;
// Generated Nov 7, 2016 2:32:28 PM by Hibernate Tools 4.3.1



/**
 * User generated by hbm2java
 */
public class User  implements java.io.Serializable {


     private String username;
     private String password;
     private String email;

    public User() {
    }

    public User(String username, String password, String email) {
       this.username = username;
       this.password = password;
       this.email = email;
    }
   
    public String getUsername() {
        return this.username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }




}

