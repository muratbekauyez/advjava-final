<%@ page import="java.sql.Connection" %>
<%@ page import="database.LibraryDatabase" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    if(!(session.getAttribute("creator").equals("yes"))){
        response.sendRedirect("login.jsp");
    }
%>
<form method="get" action="CreatorUpdateServlet">
    <input type="text" name="id" value="<%=request.getParameter("id")%>" hidden>
    <input type="text" name="title" placeholder="Title"> <br>
    <textarea name="content" placeholder="Content"></textarea><br>
    <input type="submit" value="Submit" name="update">
</form>
</body>
</html>
