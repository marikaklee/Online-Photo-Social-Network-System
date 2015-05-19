
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="photoshare.TagDao" %>
<%@ page import="java.util.List" %>

<html>
<head><title>Search all photos by tags</title></head>

<body>
<h1>Marika's Photoshare</h1>
<h2>Show Albums</h2>

<h2>TOP TAGS</h2>
<table>
	    <tr>
		<td>Tag</td>
		<td>Rank</td>
	    </tr>
	<%
	    TagDao tagDao = new TagDao();
	    List<String> tags = tagDao.topTags();
		int i = 0;
	    for (String tag : tags) {i++;
	%>
	    <tr>
		<td><a href="/photoshare/searchAllPicsbyTag.jsp?tag=<%= tag %>"><%= tag %> </a><br></td>
		<td><%= i %></td>
	    </tr>
	<%
	    }
	%>
</table>
</body>
</html>
