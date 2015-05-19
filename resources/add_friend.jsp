
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="photoshare.AddFriendDao" %>
<jsp:useBean id="friend"
             class="photoshare.AddFriendBean" />
<jsp:setProperty name="friend" property="*"/>

<html>
<head><title>New User</title></head>

<body>
<h1>Marika's Photoshare</h1>


<body>

<% 
Boolean success = false;
AddFriendDao friendDao = new AddFriendDao();
success = friendDao.createFriendship(friend.getFrienda(),friend.getFriendb());
%>



<%if (success) {%>
	<h2>Successfully created a friendship</h2>
<% }
else { %>
	<h2>ERROR couldn't create friendship</h2>
<% } %>

<h2><a href="/photoshare/index.jsp">Return to Home Page</a></h2>


</body>
</html>
