
<%@ page import="photoshare.CommentDao" %>
<%@ page import="photoshare.LikeDao" %>
<%@ page import="photoshare.PictureDao" %>
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

<h3>1. Caption: <%= pictureDao.getCaption(pictureId)%> </h3>

<h3>2. Number of Likes: <%= likeDao.numLiked(pictureId)%> </h3>

<h3>3. Likers: </h3>
	<% for(String wholike: likeDao.whoLiked(pictureId)){ %>
		<%=wholike%><br>
	<%} %> 



<h3>4. Comment:  </h3><form action="picture_nonuser.jsp?id=<%= request.getParameter("id") %>" method="post">
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

<h3>5. Comments: </h3> 
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

