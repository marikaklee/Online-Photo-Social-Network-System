
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
<head><title>Photo Sharing</title></head>

<body>
<h1>Marika Lee's Photoshare</h1>

Hello <b><code><%= request.getUserPrincipal().getName()  %></code></b>,
click here to
<a href="/photoshare/logout.jsp">log out</a><br>

<h1>1. Photos</h1>
<h3>Upload Pictures</h3>

<form action="index.jsp" enctype="multipart/form-data" method="post" id="uploadImage">
    Filename: <input type="file" name="filename"/><br><br>
    Caption: <input type="text" name="caption">
    <input type="submit" value="Upload"/><br/>
</form>

<%
    PictureDao pictureDao = new PictureDao();
    AlbumDao albumDao = new AlbumDao();
    try {
        Picture picture = imageUploadBean.upload(request);
        if (picture != null) {
            int aid = albumDao.getAlbumID(picture.getAlbumname());
            pictureDao.save(picture, aid);
        }
    } catch (FileUploadException e) {
        e.printStackTrace();
    }
%>

<select name="albumname" form="uploadImage">
  <%    
    List<String> albumList = albumDao.getAlbums(request.getUserPrincipal().getName());
    if(!albumList.isEmpty()){
        for(String albumName: albumList){ %>
            <option value=<%= albumName%>><%= albumName%> </option>
  <%        }
    }%>
</select>



<h3>View Pictures</h3>
<table>
    <tr>
        <%
       
            List<Integer> pictureIds = pictureDao.allPicturesIds();
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


<h1>2. Friends</h1>
<h3><a href="/photoshare/friends_search.jsp">Add Friends</a></h3>
<h3><a href="/photoshare/friends_list.jsp">List Friends</a><h3>
<h3><a href="/photoshare/topusers.jsp">Top 10 Users</a><h3>


<h1>3. Albums</h1>
<h3><a href="/photoshare/newalbum.jsp">Create Albums</a><h3>
<h3><a href="/photoshare/showpictures.jsp">View Albums</a><h3>
<h3>Delete Album</h3>
<form action="index.jsp" method="post">
    <input type="text" name="albumDelete">
    <input type="submit" value="Delete">
</form>

<% if(request.getParameter("albumDelete")!=null){
    boolean doneDelete = albumDao.delete(request.getParameter("albumDelete"));  
    if(doneDelete){%>
        <h2>Delete Successful </h2>
<%}}%>


<h1>4. Tags</h1>
<h3><a href="/photoshare/toptags.jsp">View Most Popular Tags</a><h3>





</body>
</html>
