
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="photoshare.AlbumDao" %>
<jsp:useBean id="album"
             class="photoshare.Album" />
<jsp:setProperty name="album" property="*"/>

<html>
<head><title>Marika's Photoshare</title></head>

<body>
<h1>Create New Album</h1>
<!-- We want to show the form unless we successfully create a new user -->
<% boolean showForm = true;
   String err = null; %>

<% if (!album.getAname().equals("")) {
	AlbumDao albumDao = new AlbumDao();
   	boolean success=albumDao.create(request.getUserPrincipal().getName(),album.getAname());
	if(success){
		showForm = false;
	}
   }
%>

<% if (err != null) { %>
<font color=red><b>Error: <%= err %></b></font>
<% } %>

<% if (showForm) { %>

<form action="newalbum.jsp" method="post">
  Album Name: <input type="text" name="aname"/><br>
  <input type="submit" value="Create"/><br/>
</form>

<% }
   else { %>

<h2>Success!</h2>

<p>A new album has been created with the name <%= album.getAname() %></a>.

<% } %>

<h2><a href="/photoshare/index.jsp">Return to Home Page</a></h2>



</body>
</html>
