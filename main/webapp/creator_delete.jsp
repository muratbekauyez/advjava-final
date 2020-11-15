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

<form method="get" action="CreatorDeleteServlet">
    <input type="text" name="id" value="<%=request.getParameter("id")%>" hidden>
    <input type="submit" value="Confirm">
</form>

</body>
</html>
