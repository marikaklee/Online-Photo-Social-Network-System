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


public class LikeDao {
  private static final String NEW_LIKE_STMT = "INSERT INTO " +
      "Likes (pictureid, userid) VALUES (?, ?)";
  
  private static final String WHO_LIKE_STMT = "SELECT email FROM Likes, Users WHERE likes.userid = users.user_id AND likes.pictureid = ? ";
  
  private static final String NUM_LIKED_STMT = "SELECT " +
      "COUNT(*) FROM Likes WHERE pictureid = ?";
  
 private static final String GET_UID_OWNER = "SELECT " +
      "\"user_id\" FROM Users WHERE \"email\" = ?";
  
  public int numLiked(int pid){
    PreparedStatement stmt = null;
    Connection conn = null;
    ResultSet rs = null;
    List<String> people = new ArrayList();
    try {
      conn = DbConnection.getConnection();
      stmt = conn.prepareStatement(NUM_LIKED_STMT);
      stmt.setInt(1, pid);
      rs = stmt.executeQuery();
      if (!rs.next()) {
        return -1;
      }
      return rs.getInt(1);
      
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
  
  public List<String> whoLiked(int pid){
    PreparedStatement stmt = null;
    Connection conn = null;
    ResultSet rs = null;
    List<String> people = new ArrayList();
    try {
      conn = DbConnection.getConnection();
      stmt = conn.prepareStatement(WHO_LIKE_STMT);
	stmt.setInt(1,pid);
	rs = stmt.executeQuery();
	while(rs.next()){
		people.add(rs.getString("email"));
	}
	return people;
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

  public boolean createLike(String username,int pid){
    PreparedStatement stmt = null;
    Connection conn = null;
    ResultSet rs = null;
    try {
      conn = DbConnection.getConnection();
      stmt = conn.prepareStatement(GET_UID_OWNER);
      stmt.setString(1, username);
      rs = stmt.executeQuery();
      

      if (!rs.next()) {
        return false;
      }
      
      int uid = rs.getInt(1);
      try { stmt.close(); }
      catch (Exception e) { }
      

      stmt = conn.prepareStatement(NEW_LIKE_STMT);
      stmt.setInt(1, pid);
      stmt.setInt(2, uid);
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
        catch (SQLException e) { ; 
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





}
