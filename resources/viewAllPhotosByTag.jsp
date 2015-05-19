<html>
<head><title>View All Photos By Tag</title></head>

<body>
<h1>Marika's Photoshare</h1>
<h2>Show Albums</h2>

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
	<h2>Search for a friend by email</h2>
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


<h2>Return to homepage</h2>
<a href="/photoshare/index.jsp">Click here</a>

</body>
</html>
