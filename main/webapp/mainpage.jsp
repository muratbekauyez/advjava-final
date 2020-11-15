<%@ page import="java.sql.Connection" %>
<%@ page import="database.LibraryDatabase" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Profile</title>
</head>
<body>
<%

    if (session.getAttribute("id") == null) {//check if session is null
        response.sendRedirect("login.jsp");//redirect to login page
    } else {
        Integer id = Integer.parseInt(session.getAttribute("id").toString());
        Connection connection = LibraryDatabase.getInstance().getConnection();
        String query = "SELECT username FROM users WHERE id = " + id;

        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            resultSet.next();
%>
<h1>Main Page: <%=resultSet.getString(1)%>
</h1>
<%
        } catch (SQLException throwables) {
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }
    }
%>
<table>
    <tr>
        <th>Title</th>
        <th>Content</th>

    </tr>
    <%
        Connection connection = LibraryDatabase.getInstance().getConnection();

        String query = "SELECT title, content FROM threads";
        Statement statement;
        ResultSet resultSet;
        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
    %>
    <tr>
        <td><%=resultSet.getString(1)%></td>
        <td><%=resultSet.getString(2)%></td>
    </tr>

    <%
            }
        } catch (SQLException throwables) {
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }
    %>

</table>

<form method="post" action="LogoutServlet">
    <input type="submit" name="logout" value="Log Out">
</form>
<br>
<a href="students.jsp">Students List</a>

</body>
</html>
