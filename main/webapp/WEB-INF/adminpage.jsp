<%@ page import="java.sql.Connection" %>
<%@ page import="database.LibraryDatabase" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  tools.User: HP
  Date: 11/7/2020
  Time: 11:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Admin Page</title>
</head>
<body>
<%
    Integer id = Integer.parseInt(session.getAttribute("id").toString());
    Connection connection = LibraryDatabase.getInstance().getConnection();
    String query = "SELECT username FROM users WHERE id = " + id;

    try {
        Statement statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(query);
        resultSet.next();
%>
<h1>Admin page: <%=resultSet.getString(1)%></h1>
<%
    }catch (SQLException throwables) {
        System.out.println("ERROR OCCURED: " + throwables.getMessage());
    }
%>

</body>
</html>
