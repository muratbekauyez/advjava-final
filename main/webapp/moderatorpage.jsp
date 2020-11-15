<%@ page import="java.sql.Connection" %>
<%@ page import="database.LibraryDatabase" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Creator Page</title>
</head>
<body>
<%
    if (session.getAttribute("id") == null) {//check if session is null
        response.sendRedirect("login.jsp");//redirect to login page
    } else {
        /*get the id of loginned user*/
        Integer id = Integer.parseInt(session.getAttribute("id").toString());
        Connection connection = LibraryDatabase.getInstance().getConnection();
        String query = "SELECT username FROM users WHERE id = " + id; //get the username of the user in session
        String newQuery = "SELECT roles_id FROM users_roles WHERE user_id = " + id; //get the role of user in session
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(newQuery);
            resultSet.next();
            if (resultSet.getInt(1) != 4) { //check the role if it's moderator
                request.getRequestDispatcher("mainpage.jsp").forward(request, response); //redirect to login page
            }
            resultSet = statement.executeQuery(query); //execute query to display name
            resultSet.next();
%>
<h1>Moderator page: <%=resultSet.getString(1)%>
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
        <th></th>
        <th></th>
    </tr>
    <%
        Connection connection = LibraryDatabase.getInstance().getConnection();

        String query = "SELECT title, content, id FROM threads WHERE status IN ('news') ORDER BY id";
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
        <td><a href="moderator_update.jsp?id=<%=resultSet.getInt(3)%>"> Update</a></td>
        <td><a href="moderator_delete.jsp?id=<%=resultSet.getInt(3)%>"> Delete</a></td>
    </tr>

    <%
            }
        } catch (SQLException throwables) {
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }
    %>

</table>

<h3>Add new columns</h3>
<form action="ModeratorInsertServlet" method="post">
    <table>
        <tr>
            <td><label>Title</label></td>
            <td><input type="text" name="title" placeholder="title"> <br></td>
        </tr>
        <tr>
            <td><label>Content</label></td>
            <td><textarea name="content" placeholder="Content..."></textarea> <br></td>
        </tr>

        <tr>
            <td></td>
            <td><input type="submit" name="insert" value="Add"></td>
        </tr>
    </table>
</form>

<form method="post" action="LogoutServlet">
    <input type="submit" name="logout" value="Log Out">
</form>
</body>
</html>

