
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="photoshare.NewUserDao" %>

<html>
<head><title>Marika's Photoshare </title></head>

<body>
<h1>Search for Friends</h1>


<% boolean showSearch = true; %>

<% 
String email  = request.getParameter("email");
String output = "";
if (email!=null && !email.equals("")) {
	NewUserDao userDao = new NewUserDao();		
	output = userDao.search(email);
	if(output != null)
		showSearch =false;
}
%>



<%if (showSearch) {%>
	<h3>Please input your friend's email: </h3>
	<form action="friends_search.jsp" method="post">
	  Email Address: <input type="text" name="email"/><br>
	  <input type="submit" value="Search"/><br/>
	</form>
<% }
else { %>
	<h2>Search Results</h2>
	<%= output %>
	<form action="addfriend.jsp" method="post">
		<input type="hidden" name="frienda" value= <%= request.getUserPrincipal().getName()%> ><br>
		<input type="hidden" name="friendb" value= <%= email%> ><br>
		<input type="submit" value="Add Friend">
	</form>
<% } %>


<h2><a href="/photoshare/index.jsp">Return to Home Page</a></h2>


</body>
</html>
