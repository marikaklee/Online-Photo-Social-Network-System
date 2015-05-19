package photoshare;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;


public class NewUserDao {
  private static final String CHECK_EMAIL_STMT = "SELECT " +
      "COUNT(*) FROM Users WHERE email = ?";

  private static final String NEW_USER_STMT = "INSERT INTO " +
      "Users (email, password, firstname, lastname, gender, dob) VALUES (?, ?, ?, ?, ?, ?)";

  private static final String SEARCH_USER_STMT = "SELECT " +
      "\"firstname\",\"lastname\" FROM Users WHERE email = ?";

private static final String GRAND_TOTAL_STMT = " " +
    "SELECT results.email, SUM(results.total) as grandTotal " +
    "FROM   ((SELECT u.email, COUNT(*) as total " +
      "FROM Users u, Pictures p, Albums a  " +
      "WHERE u.user_id = a.ownid AND a.aid = p.myalbumid " +
      "GROUP BY u.email " +
      "ORDER BY total DESC) " + 
      "UNION ALL " +
      "(SELECT u.email ,COUNT(*) as total " +
      "FROM users u, comments c " +
      "WHERE u.user_id = c.owner " +
      "GROUP BY u.email " +
      "ORDER BY total DESC))   as results " +
    "WHERE results.email != \'ANONYMOUS\' " + 
    "GROUP BY results.email " +
    "ORDER BY grandTotal DESC " +
    "LIMIT 10 ";

  
public void topUsers(List<Integer> points,List<String> emails){
    PreparedStatement stmt = null;
    Connection conn = null;
    ResultSet rs = null;
    try {
      conn = DbConnection.getConnection();
      stmt = conn.prepareStatement(GRAND_TOTAL_STMT);
      rs = stmt.executeQuery();
      while(rs.next()){
  emails.add(rs.getString(1));  
  points.add(rs.getInt(2));
     }
  return;
    } catch (SQLException e) {
      e.printStackTrace();
      throw new RuntimeException(e);
    } finally {
      if (rs != null) {
        try { rs.close(); }
        catch (SQLException e) { ; }
        rs = null;
      }
      
      if (stmt != null) {
        try { stmt.close(); }
        catch (SQLException e) { ; }
        stmt = null;
      }
      
      if (conn != null) {
        try { conn.close(); }
        catch (SQLException e) { ; }
        conn = null;
      }
    }
  

  }


  public String search(String email){
    PreparedStatement stmt = null;
    Connection conn = null;
    ResultSet rs = null;
    try {
      conn = DbConnection.getConnection();
      stmt = conn.prepareStatement(SEARCH_USER_STMT);
      stmt.setString(1, email);
      rs = stmt.executeQuery();


      String firstname;
      String lastname;
      if (!rs.next()) {
        return null;
      }
      else{
  firstname = rs.getString("firstname");
  lastname = rs.getString("lastname");
      }
  return email + " " + firstname + " " + lastname;
    } catch (SQLException e) {
      e.printStackTrace();
      throw new RuntimeException(e);
    } finally {
      if (rs != null) {
        try { rs.close(); }
        catch (SQLException e) { ; }
        rs = null;
      }
      
      if (stmt != null) {
        try { stmt.close(); }
        catch (SQLException e) { ; }
        stmt = null;
      }
      
      if (conn != null) {
        try { conn.close(); }
        catch (SQLException e) { ; }
        conn = null;
      }
    }
  }

  public boolean create(String email, String password, String first, String last, String gender, String dob) {
    PreparedStatement stmt = null;
    Connection conn = null;
    ResultSet rs = null;
    try {
      conn = DbConnection.getConnection();
      stmt = conn.prepareStatement(CHECK_EMAIL_STMT);
      stmt.setString(1, email);
      rs = stmt.executeQuery();
      if (!rs.next()) {
   
        return false;
      }
      int result = rs.getInt(1);
      if (result > 0) {
  
        return false; 
      }
      
      try { stmt.close(); }
      catch (Exception e) { }

      stmt = conn.prepareStatement(NEW_USER_STMT);
      stmt.setString(1, email);
      stmt.setString(2, password);
      stmt.setString(3, first);
      stmt.setString(4, last);
      stmt.setString(5, gender);

      Date date = null;
      try{
        date = new SimpleDateFormat("yyyy-MM-dd").parse(dob);
      }
      catch(Exception e){}
      stmt.setDate(6,new java.sql.Date(date.getTime()));




      
      stmt.executeUpdate();

      return true;
    } catch (SQLException e) {
      e.printStackTrace();
      throw new RuntimeException(e);
    } finally {
      if (rs != null) {
        try { rs.close(); }
        catch (SQLException e) { ; }
        rs = null;
      }
      
      if (stmt != null) {
        try { stmt.close(); }
        catch (SQLException e) { ; }
        stmt = null;
      }
      
      if (conn != null) {
        try { conn.close(); }
        catch (SQLException e) { ; }
        conn = null;
      }
    }
  }
}