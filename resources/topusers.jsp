<%@ page import="photoshare.CommentDao" %>
<%@ page import="photoshare.PictureDao" %>
<%@ page import="photoshare.NewUserDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<html>
<head><title>Marika's Photoshare</title></head>

<body>
<h1>Top 10 Users</h1>
To motivate users in using the site we'd like to identify the ones who make the largest contribution and list them on the site. We'll measure the contribution of a user as the number of photos they have uploaded plus the number of comments they have left for photos belonging to other users. The top 10 users is reported here.
<br><br>


<table>
		<tr>
		<td><b>Emails</b></td>
		<td><b>Points</b></td>
		</tr>
<%
	NewUserDao userDao = new NewUserDao();
	List<Integer> points = new ArrayList();
	List<String> emails = new ArrayList();
	userDao.topUsers(points,emails);
	for(int i =0;i<points.size();i++){ %>
		<tr>
		<td> <%= emails.get(i)%> </td>
		<td> <%= Integer.toString(points.get(i))%> </td>
		</tr>
<%	} %>
</table> 



<h2><a href="/photoshare/index.jsp">Return to Home Page</a></h2>


</body>
</html>

