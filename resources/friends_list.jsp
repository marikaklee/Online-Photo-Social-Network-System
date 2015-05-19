
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="photoshare.AddFriendDao" %>
<%@ page import="java.util.List" %>


<html>
<head><title>New User</title></head>

<body>
<h1>Marika's Photoshare</h1>
<h2>List of Friends</h2>


<% 
AddFriendDao friendDao = new AddFriendDao();
%>


<table>
        <%
            List<String> friends = friendDao.getFriends(request.getUserPrincipal().getName());
            for (String friend : friends) {
        %>
    <tr>
        <td>
        <%= friend %>
        </td>
    </tr>
        <%
            }
        %>
</table>

<h2><a href="/photoshare/index.jsp">Return to Home Page</a></h2>


</body>
</html>
