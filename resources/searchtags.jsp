
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="photoshare.PictureDao" %>
<%@ page import="java.util.List" %>

<html>
<head><title>Search all photos by tags</title></head>

<body>
<% boolean showSearch = true; %>

<% if(request.getParameter("tag")!=null) {%>
	<h2>Pictures based on the tag <%= request.getParameter("tag") %></h2>
	<table>
	    <tr>
		<%
		    PictureDao pictureDao = new PictureDao();
		    List<Integer> pictureIds = pictureDao.allPicturesbyTag(request.getParameter("tag"));
		    for (Integer pictureId : pictureIds) {
		%>
		<td><a href="/photoshare/picture.jsp?id=<%= pictureId %>">
		    <img src="/photoshare/img?t=1&picture_id=<%= pictureId %>"/>
		</a>
		</td>
		<%
		    }
		%>
	    </tr>
	</table>
<% } %>



<%if (showSearch) {%>
	<h2>Search my Photos by Tags</h2>
	<form action="searchAllPicsbyTag.jsp" method="post">
	  Tag: <input type="text" name="tag"/><br>
	  <input type="submit" value="Search"/><br/>
	</form>
<% } %>

</body>
</html>
