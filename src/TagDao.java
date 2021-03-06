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


public class TagDao {
 
  private static final String TAG_STMT = "" +
						"SELECT pid " +
						"FROM Tag " +
						"WHERE word= ? ";


  private static final String NEW_TAG_STMT = "INSERT INTO " +
      "Tag (pid, word) VALUES (?, ?)";
  private static final String MY_TOP_TAG_STMT = "" +
						"SELECT t.word, COUNT(*) as total " +
						"FROM Tag t, Pictures p, Albums a, Users u " +
						"WHERE u.user_id = a.ownid AND a.aid = p.myalbumid AND p.pid = t.pid AND u.email = ? " +
						"GROUP BY t.word " +
						"ORDER BY total DESC " +
						"LIMIT 5 ";
  
  private static final String TOP_TAG_STMT = "SELECT word, COUNT(word) as total FROM Tag GROUP BY word ORDER BY total desc";
  private static final String CON_TAG_STMT = "SELECT pid FROM Tag WHERE word = ? INTERSECT SELECT pid FROM Tag WHERE word = ?";

  



 private static final String COUNT_TAG_STMT = "" +
 						"SELECT COUNT(*) " +
						"FROM Tag " +
						"WHERE pid = ? ";

  private static final String GET_TAGS_FOR_PID_STMT = "SELECT word, COUNT(*) as total " +
							"FROM Tag WHERE ";





							
  private static final String WORD_NOT_EQUAL = "word != ? "; 
  private static final String PID_IS_EQUAL = "pid = ? ";
  private static final String GROUP_BY_TAG = "GROUP BY word ORDER BY total DESC";
  
  private static final String SEARCH_PID_STMT = "SELECT pid FROM Tag WHERE word = ? ";
  private static final String INTERSECT_STMT = "INTERSECT ";
  


  public List<String> myTopTags(String username){
    PreparedStatement stmt = null;
    Connection conn = null;
    ResultSet rs = null;
    List<String> tags = new ArrayList();
    try {
      conn = DbConnection.getConnection();
      stmt = conn.prepareStatement(MY_TOP_TAG_STMT);
	stmt.setString(1,username);
	rs = stmt.executeQuery();
	while(rs.next()){
		tags.add(rs.getString("word"));
	}
	return tags;
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

  public List<Integer> searchTags(List<String> tags, List<Integer> points){
    PreparedStatement stmt = null;
    Connection conn = null;
    ResultSet rs = null;
    List<Integer> pictures = new ArrayList();
    List<Integer> temp = new ArrayList();
    int min;
    int minindex;
    boolean exists = false;
    try {
      conn = DbConnection.getConnection();
	
	
	if(temp.size()>0){
		stmt = conn.prepareStatement(COUNT_TAG_STMT);
		stmt.setInt(1,temp.get(0));
		rs = stmt.executeQuery();
		if(!rs.next()){
			return null;	
		}
		min = rs.getInt(1);	
		minindex = 0;
		try { stmt.close(); }
		catch (SQLException e) { ; }
		for(int i = 1;i<temp.size();i++){
			stmt = conn.prepareStatement(COUNT_TAG_STMT);
			stmt.setInt(1,temp.get(i));
			rs = stmt.executeQuery();
			if(!rs.next()){
				return null;	
			}
			if(rs.getInt(1) < min){
				min = rs.getInt(1);	
				minindex = i;
			}
			try { stmt.close(); }
			catch (SQLException e) { ; }
		}
		pictures.add(temp.get(minindex));	
		points.add(2);
		temp = new ArrayList();
	}

	stmt = conn.prepareStatement(ONE_TAG_STMT);
	stmt.setString(1,tags.get(0));
	rs = stmt.executeQuery();
	while(rs.next()){
		for(Integer checkpid : pictures)
			if(checkpid==rs.getInt("pid"))
				exists = true;
		if(!exists){
			temp.add(rs.getInt("pid"));
		}
		else
			exists = false;
	}
        try { stmt.close(); }
        catch (SQLException e) { ; }

	stmt = conn.prepareStatement(ONE_TAG_STMT);
	stmt.setString(1,tags.get(1));
	rs = stmt.executeQuery();
	while(rs.next()){
		for(Integer checkpid : pictures)
			if(checkpid==rs.getInt("pid"))
				exists = true;
		if(!exists){
			temp.add(rs.getInt("pid"));
		}
		else
			exists = false;
	}
        try { stmt.close(); }
        catch (SQLException e) { ; }
	

	stmt = conn.prepareStatement(ONE_TAG_STMT);
	stmt.setString(1,tags.get(2));
	rs = stmt.executeQuery();
	while(rs.next()){
		for(Integer checkpid : pictures)
			if(checkpid==rs.getInt("pid"))
				exists = true;
		if(!exists){
			temp.add(rs.getInt("pid"));
		}
		else
			exists = false;
	}
        try { stmt.close(); }
        catch (SQLException e) { ; }

	stmt = conn.prepareStatement(ONE_TAG_STMT);
	stmt.setString(1,tags.get(3));
	rs = stmt.executeQuery();
	while(rs.next()){
		for(Integer checkpid : pictures)
			if(checkpid==rs.getInt("pid"))
				exists = true;
		if(!exists){
			temp.add(rs.getInt("pid"));
		}
		else
			exists = false;
	}
        try { stmt.close(); }
        catch (SQLException e) { ; }

	stmt = conn.prepareStatement(ONE_TAG_STMT);
	stmt.setString(1,tags.get(4));
	rs = stmt.executeQuery();
	while(rs.next()){
		for(Integer checkpid : pictures)
			if(checkpid==rs.getInt("pid"))
				exists = true;
		if(!exists){
			temp.add(rs.getInt("pid"));
		}
		else
			exists = false;
	}
        try { stmt.close(); }
        catch (SQLException e) { ; }
	

	if(temp.size()>0){
		stmt = conn.prepareStatement(COUNT_TAG_STMT);
		stmt.setInt(1,temp.get(0));
		rs = stmt.executeQuery();
		if(!rs.next()){
			return null;	
		}
		min = rs.getInt(1);	
		minindex = 0;
		try { stmt.close(); }
		catch (SQLException e) { ; }
		for(int i = 1;i<temp.size();i++){
			stmt = conn.prepareStatement(COUNT_TAG_STMT);
			stmt.setInt(1,temp.get(i));
			rs = stmt.executeQuery();
			if(!rs.next()){
				return null;	
			}
			if(rs.getInt(1) < min){
				min = rs.getInt(1);	
				minindex = i;
			}
			try { stmt.close(); }
			catch (SQLException e) { ; }
		}
		pictures.add(temp.get(minindex));	
		points.add(1);
		temp = new ArrayList();
	}


	return pictures;
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
  
 

  public boolean createTag(String tag,int pid){
  	System.out.println("CREATE TAG method is called");
    PreparedStatement stmt = null;
    Connection conn = null;
    ResultSet rs = null;
    try {
      conn = DbConnection.getConnection();
      stmt = conn.prepareStatement(NEW_TAG_STMT);
      stmt.setInt(1, pid);
      stmt.setString(2,tag);
      stmt.executeUpdate();
      System.out.println("statement is exceuted");
	return true;
    } 
    catch (SQLException e) {
      e.printStackTrace();
      throw new RuntimeException(e);
    } 
    finally 
    {
      if (rs != null) {
        try { rs.close(); }
        catch (SQLException e) { ; }
        rs = null;
        System.out.println("if rs is not null");
      }
      
      if (stmt != null) {
        try { stmt.close(); }
        catch (SQLException e) { ; }
        stmt = null;
        System.out.println("if stmt is not null");
      }
      
      if (conn != null) {
        try { conn.close(); }
        catch (SQLException e) { ; }
        conn = null;
        System.out.println("if conn is not null");
      }
    }
  }



  public List<String> recommended_tags(List<String> searchTags){
    PreparedStatement stmt = null;
    Connection conn = null;
    ResultSet rs = null;
    List<String> result = new ArrayList();
    List<Integer> pids = new ArrayList();
    String query = "";
    try {
     	query += SEARCH_PID_STMT;
	for(int i = 1;i<searchTags.size();i++){
		query += INTERSECT_STMT;
		query += SEARCH_PID_STMT;
	}
	conn = DbConnection.getConnection();
        stmt = conn.prepareStatement(query);

	for(int i = 0;i<searchTags.size();i++){
		stmt.setString(i+1,searchTags.get(i));
	}
	rs = stmt.executeQuery();


	while(rs.next()){
		pids.add(rs.getInt("pid"));
	}

        query = "";	
        query += GET_TAGS_FOR_PID_STMT;
	query +=" ( ";
	query += PID_IS_EQUAL;
	for(int i = 1;i<pids.size();i++){
	 	query += "OR ";
		query += PID_IS_EQUAL;
	}
	query +=" ) AND ( ";
	for(int j = 0;j<searchTags.size();j++){
		query += WORD_NOT_EQUAL;
		if(j==searchTags.size()-1)
			query += " ) ";
		else
			query += " AND ";
	}
	query += GROUP_BY_TAG;
	stmt = conn.prepareStatement(query);
	
	for(int i = 0;i<pids.size();i++){
		stmt.setInt(i+1,pids.get(i));
	}
	for(int j = pids.size();j<searchTags.size()+pids.size();j++){
		stmt.setString(j+1,searchTags.get(j-pids.size()));
	}
	rs = stmt.executeQuery();
	while(rs.next()){
		result.add(rs.getString("word"));
	}
        
	try { stmt.close(); }
        catch (SQLException e) { ; }


	return result;
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
