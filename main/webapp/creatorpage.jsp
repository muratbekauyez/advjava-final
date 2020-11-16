<%@ page import="java.sql.Connection" %>
<%@ page import="database.LibraryDatabase" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <title>Creator Page</title>
    <link href="Styles/tableStyle.css" rel="stylesheet" type="text/css">
    <link href="Styles/cssAlternate.css" rel="stylesheet" type="text/css">
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
            if (resultSet.getInt(1) != 3) { //check the role if it's creator
                request.getRequestDispatcher("mainpage.jsp").forward(request, response); //redirect to login page
            }else{
                resultSet = statement.executeQuery(query); //execute query to display name
                resultSet.next();
            }


%>
<h1>Creator page: 
    <%=resultSet.getString(1)%>
        </h1>
<%
        } catch (SQLException throwables) {
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }

    }

%>
<table class="container">
    <tr>
        <th>Title</th>
        <th>Content</th>
        <th></th>
        <th></th>
    </tr>
    <%
        Connection connection = LibraryDatabase.getInstance().getConnection();

        String query = "SELECT title, content, id FROM threads WHERE status IN ('club','event') ORDER BY id";
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
        <td><a href="creator_update.jsp?id=<%=resultSet.getInt(3)%>">Update</a></td>
        <td><a href="creator_delete.jsp?id=<%=resultSet.getInt(3)%>">Delete</a></td>
    </tr>

    <%
            }
        } catch (SQLException throwables) {
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }
    %>

</table>
    
    
<h3 style="text-align: center;">Add new columns</h3>
<form action="CreatorInsertServlet" method="post">
    <table class="container">
        <tbody>
        <tr>
            <td><label>Title</label></td>
            <td><input type="text" name="title" placeholder="Title"> <br></td>
        </tr>
        <tr>
            <td><label>Content</label></td>
            <td><textarea name="content" placeholder="Content..."></textarea> <br></td>
        </tr>
        <tr>
            <td><label>Type</label></td>
            <td>
                <select name="type">
                    <option value="club">Club</option>
                    <option value="event">Event</option>
                </select>
            </td>
        </tr>

        <tr>
            <td></td>
            <td>
                <button type="submit" name="insert" class="insertButton">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
                Add
            </button>
            </td>
        </tr>
            </tbody>
    </table>

</form>

    
    
    
<div class="login-box">
<form method="post" action="LogoutServlet">
    <button type="submit" name="logout" style="margin-left: 29%;">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
                Log Out
            </button>
</form>
</div>

</body>
</html>
