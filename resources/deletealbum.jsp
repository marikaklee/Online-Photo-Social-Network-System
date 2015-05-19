
<%@ page import="photoshare.Picture" %>
<%@ page import="photoshare.PictureDao" %>
<%@ page import="photoshare.AlbumDao" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="imageUploadBean"
             class="photoshare.ImageUploadBean">
    <jsp:setProperty name="imageUploadBean" property="*"/>
</jsp:useBean>

<html>
<head><title>New User</title></head>

<body>
<h1>Marika's Photoshare</h1>
<h2>Add Friends</h2>

<body>

<% 
Boolean success = false;
PictureDao friendDao = new PictureDao();
success = albumDelete();
%>

<form action="index.jsp" method="post">
    <input type="text" name="albumDelete">
    <input type="submit" value="Delete">
</form>

<%if (success) {%>
	<h2>Successfully created a friendship</h2>
<% }
else { %>
	<h2>ERROR couldn't create friendship</h2>
<% } %>

<h2>Return to homepage</h2>
<a href="/photoshare/index.jsp">Click here</a>

</body>
</html>