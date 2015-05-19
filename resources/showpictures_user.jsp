
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
<head><title>All Photos</title></head>

<body>
<h1>Marika's Photoshare</h1>

<h2><a href="/photoshare/index.jsp">Return to Homepage</a></h2>
<h2><a href="/photoshare/searchMyPicsbyTag.jsp">My Photos: Search by tag</a></h2>
<h2><a href="/photoshare/searchAllPicsbyTag.jsp">All Photos: Search by tag</a></h2>


<form action="showpictures.jsp"  method="post" >
        <select name="albumname">
                    <option value=all> All Albums </option>
          <%    
            AlbumDao albumDao = new AlbumDao();
            List<String> albumList = albumDao.getAllalbums();
            if(!albumList.isEmpty()){
                for(String albumName: albumList){ %>
                    <option value=<%= albumName%>><%= albumName%> </option>
          <%        }
            }%>
        </select>
    <input type="submit" value="Select Album"/><br/>
</form>


<% if(request.getParameter("albumname")!=null && request.getParameter("albumname").equals("all")) {%>
    <h2>All Pictures</h2>

  <table>
    <tr>
        <%  PictureDao pictureDao = new PictureDao();
            int aid = albumDao.getAlbumID(request.getParameter("albumname"));
            List<Integer> pictureIds = pictureDao.allPicturesforAlbum(aid);

            for (Integer pictureId : pictureIds) {
                %>
              <td><a href="/photoshare/picture.jsp?id=<%=pictureId%>">
                        <img src="/photoshare/img?t=1&picture_id=<%=pictureId%>"/>
                </a>
                </td>
                <%
                }
            %>
        </tr>
    </table>

<% } 
else if(request.getParameter("albumname")!=null) {%>

    <table>
    <tr>
        <%  PictureDao pictureDao = new PictureDao();
            int aid = albumDao.getAlbumID(request.getParameter("albumname"));
            List<Integer> pictureIds = pictureDao.allPicturesforAlbum(aid);

            for (Integer pictureId : pictureIds) {
                %>
              <td><a href="/photoshare/picture.jsp?id=<%=pictureId%>">
                        <img src="/photoshare/img?t=1&picture_id=<%=pictureId%>"/>
                </a>
                </td>
                <%
                }
            %>
        </tr>
    </table>

<% } %>




</body>
</html>
