<%@ page import="tools.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Authorisation</title>
</head>
<body>
<form method="post" action="LoginServlet">
    <input type="text" name="username" placeholder="Username"> <br>
    <input type="password" name="password" placeholder="Password"><br> <br>

    <input type="submit" name="submit" value="Submit"><br>
</form>
<%
    User user = new User(request.getParameter("username"),request.getParameter("password"));
%>
<h6><%=request.getAttribute("message")%></h6>
</body>
</html>
