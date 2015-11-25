<%-- 
    Document   : activityFeed
    Created on : Jan 27, 2014, 1:50:25 PM
    Author     : yetkin.timocin
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%
        Student currentStudent = (Student) session.getAttribute("currentStudent");
        if (currentStudent == null) {
            response.sendRedirect("welcome.jsp?message=SessionExpired");
            return;
        }

        ArrayList<String> activities = new ArrayList<String>();
        activities = currentStudent.getStudentActivities(currentStudent.getStudentID());
    %>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>activity feed</title>
    </head>
    <body>
        <div class="tab-pane" id="activityFeedTab">
            <%
                for (int i = 0; i < activities.size(); i++) {
                    out.println(activities.get(i));
                    out.println("<br/>");
                }
            %>

        </div>
    </body>
</html>