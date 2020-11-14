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
<%
    try {
        if(!(session.getAttribute("creator").equals("yes"))){
            response.sendRedirect("login.jsp");
        }
    }catch (Exception e){
        response.sendRedirect("login.jsp");
    }
%>
<form method="get" action="CreatorDeleteServlet">
    <input type="text" name="id" value="<%=request.getParameter("id")%>" hidden>
    <input type="submit" placeholder="Confirm">
</form>

</body>
</html>
