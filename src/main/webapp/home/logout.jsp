<%-- 
    Document   : logout
    Created on : Jan 7, 2014, 9:24:40 AM
    Author     : yetkin.timocin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            session.invalidate();
            response.sendRedirect("../welcome.jsp");
            return;
        %>
    </body>
</html>
