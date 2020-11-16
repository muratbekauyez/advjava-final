<%@ page import="java.sql.Connection" %>
<%@ page import="database.LibraryDatabase" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<!--<head>-->
    <title>Title</title>
    <link href="Styles/css.css" rel="stylesheet" type="text/css">
</head>
<body>
    <div class="login-box">
        <h2>moderator_delete.jsp</h2>
        <form method="get" action="ModeratorDeleteServlet">
            <div class="user-box">
                <input type="text" name="id" value="<%=request.getParameter("id")%>" hidden>
                <label>

                </label>
            </div>
            <button type="submit">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
                Confirm
            </button>
        </form>
    </div>

</body>
</html>
