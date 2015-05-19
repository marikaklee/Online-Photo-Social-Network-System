
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


<h2>Delete Album</h2>
<form action="index.jsp" method="post">
	<input type="text" name="albumDelete">
	<input type="submit" value="Delete">
</form>

<% if(request.getParameter("albumDelete")!=null){
	boolean doneDelete = albumDao.delete(request.getParameter("albumDelete"));	
	if(doneDelete){%>
		<h2>Delete Successful </h2>
<%}}%>
