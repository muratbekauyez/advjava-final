<%@ page import="java.sql.Connection" %>
<%@ page import="database.LibraryDatabase" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="Styles/css.css" rel="stylesheet" type="text/css">
</head>

<body>
<div class="login-box">
    <h2>moderator_update.jsp</h2>
    <form method="get" action="ModeratorUpdateServlet">
        <div class="user-box">
            <input type="text" name="id" value="<%=request.getParameter("id")%>" hidden>
            <label>

            </label>
        </div>
        <div class="user-box">
            <input type="text" name="title">
            <label>Title</label>
        </div>
        <div class="user-box">
            <textarea name="content"></textarea>
            <label>Content</label>
        </div>
        <button type="submit" name="update">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            Submit
        </button>
    </form>
</div>
</body>
</html>
