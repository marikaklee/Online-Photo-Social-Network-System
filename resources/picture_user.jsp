
<%@ page import="photoshare.CommentDao" %>
<%@ page import="photoshare.LikeDao" %>
<%@ page import="photoshare.PictureDao" %>
<%@ page import="photoshare.TagDao" %>
<%@ page import="org.apache.commons.fileupload.FileUploadException" %>
<%@ page import="java.util.List" %>
<html>
<head><title>Photo Sharing test </title></head>

<body>
<h1>Picture Info</h1><br>


<%  
int pictureId = Integer.valueOf(request.getParameter("id"));
LikeDao likeDao = new LikeDao();
PictureDao pictureDao = new PictureDao();
%>


<img src="/photoshare/img?picture_id=<%= pictureId %>" alt=" " style="width: 60%;max-height: 100%" /><br><br>

<h2>Tags</h2>


	<%
	    TagDao tagDao = new TagDao();
	    List<String> tags = tagDao.topTags();
		int i = 0;
	    for (String tag : tags) {i++;
	%>
	    <tr>
		<td><%= tag %> </a><br></td>
		
	    </tr>
	<%
	    }
	%>



<h2>Caption: <%= pictureDao.getCaption(pictureId)%> </h2>

<h2>Add Tags: <a href="/photoshare/addtags.jsp?id=<%= pictureId %>">Here</a></h2> 

<h2>Remove an image: 
<form action="removepic.jsp?id=<%= request.getParameter("id")%>" method ="post">
	<input type="submit" value="Remove Photo">
</form></h2>

<h2>Recommend Tags: <a href="/photoshare/tagrecommend.jsp?id=<%= pictureId %>">Here</a></h2>



<h2>Number of Likes: <%= likeDao.numLiked(pictureId)%> </h2>

<h2>Likers: </h2>
	<% for(String wholike: likeDao.whoLiked(pictureId)){ %>
		<%=wholike%><br>
	<%} %> 



<h2>Comment:  </h2><form action="picture.jsp?id=<%= request.getParameter("id") %>" method="post">
	<input type="text" name="comment"/>  
	<input type="submit" value="Submit">	
</form>  

<% 
CommentDao commentDao = new CommentDao();
Boolean success = false;

if(request.getParameter("comment")!=null){
	int pid = Integer.parseInt(request.getParameter("id"));
	if(request.getUserPrincipal()!=null)
		success = commentDao.create(request.getUserPrincipal().getName(),request.getParameter("comment"),pid);	
	else
		success = commentDao.create("ANONYMOUS",request.getParameter("comment"),pid);
}

if(success){%>
<h2>Successfully created comment</h2>
<%}
%> 

<h2>Comments: </h2> 
<%
if(request.getParameter("id")!=null){
	int pid2 = Integer.parseInt(request.getParameter("id"));
	List<String> comments = commentDao.getAllComments(pid2);	
	
	for(String comment: comments){ %>
		<%= comment%> <br>
	<%}

}%>




<h2><a href="/photoshare/login.jsp">Return to Login Page</a></h2>



</body>
</html>

