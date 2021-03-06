<%@ page import="java.sql.Connection" %>
<%@ page import="database.LibraryDatabase" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="Styles/tableStyle.css" rel="stylesheet" type="text/css">
    <link href="Styles/cssAlternate.css" rel="stylesheet" type="text/css">
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
<h1>Students List:
    <%=resultSet.getString(1)%>
</h1>
<%
            connection.close();
        } catch (SQLException throwables) {
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }
    }
%>
<table class="container">
    <tr>
        <th>Username</th>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Major</th>
        <th>Year</th>
    </tr>
    <%
        Connection connection = LibraryDatabase.getInstance().getConnection();

        String query = "SELECT username,fname,lname,major,year \n" +
                "FROM users u JOIN users_roles ur ON u.id = ur.user_id\n" +
                "WHERE roles_id = 2;";
        Statement statement;
        ResultSet resultSet;
        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery(query);
            while (resultSet.next()) {
    %>
    <tr>
        <td>
            <%=resultSet.getString(1)%>
        </td>
        <td>
            <%=resultSet.getString(2)%>
        </td>
        <td>
            <%=resultSet.getString(3)%>
        </td>
        <td>
            <%=resultSet.getString(4)%>
        </td>
        <td>
            <%=resultSet.getInt(5)%>
        </td>
    </tr>

    <%
            }
            connection.close();
        } catch (SQLException throwables) {
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }
    %>

</table>

<div class="login-box">
    <form>
        <div class="user-box">
            <a href="mainpage.jsp" style="margin: 0 0 0 43%;">Home</a>
        </div>

    </form>
</div>
</body>
</html>