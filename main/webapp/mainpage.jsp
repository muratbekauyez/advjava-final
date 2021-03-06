<%@ page import="java.sql.Connection" %>
<%@ page import="database.LibraryDatabase" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Profile</title>
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
<!---->
<h1>Main Page:
    <%=resultSet.getString(1)%>
</h1>
<script>
    function searchBook() {
        var xhttp = new XMLHttpRequest();
        var title = document.getElementById("searchId").value;
        xhttp.onreadystatechange = function () {
            if (this.readyState == 4 && this.status == 200) {
                var bookList = JSON.parse(this.responseText);
                if (bookList.length > 0) {
                    document.getElementById("title").value = bookList[0].title;
                    document.getElementById("content").value = bookList[0].content;
                } else {
                    document.getElementById("searchId").value = "Nothing was found by " + title;
                }
            }
        };
        xhttp.open("POST", "${pageContext.request.contextPath}/LoginServlet", true);
        xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        xhttp.send("submit=search&title=" + title);
    }
</script>

<%
            connection.close();
        } catch (SQLException throwables) {
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }
    }
%>
<div class="login-box" style="margin-top: 10%">
    <form action="#">
        <div class="user-box">
            <input type="text" id="searchId" placeholder="" name="search">
            <label>Title name</label>
        </div>
        <button type="button" name="search" value="Search" onclick="searchBook()" style="margin: auto 29%;">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            Search
        </button>
    </form>
</div>
<table class="container">
    <tr>
        <th>Title</th>
        <th>Content</th>

    </tr>
    <tr>
        <th><textarea type="text" id="title"></textarea></th>

        <th><textarea type="text" id="content" readonly></textarea></th>
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
        <td>
            <%=resultSet.getString(1)%>
        </td>
        <td>
            <%=resultSet.getString(2)%>
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



<div class="login-box" style="margin-top: %;">
    <form method="post" action="LogoutServlet">
        <button type="submit" name="logout" style="margin-left: 29%;">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            Log Out
        </button>
        <br>
        <br>
        <div class="user-box">
            <a href="students.jsp" style="margin: 0 0 0 35%;">Students List</a>
        </div>
    </form>

</div>
</body>
</html>
