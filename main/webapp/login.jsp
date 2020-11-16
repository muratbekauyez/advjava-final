<%@ page import="tools.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Authorisation</title>
    <link href="Styles/css.css" rel="stylesheet" type="text/css">
</head>

<body>
    <div class="login-box">
        <h2>login.jsp</h2>
        <form method="post" action="LoginServlet">
            <div class="user-box">
                <input type="text" name="username">
                <label>Username</label>
            </div>

            <div class="user-box">
                <input type="password" name="password">
                <label>Password</label>
            </div>

            <button type="submit" name="submit">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
                Submit
            </button>
            <h6>
                <%=request.getAttribute("message")%>
        </h6>
        </form>
    </div>

<%
%>


</body></html>
