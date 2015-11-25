<%-- 
    Document   : activityFeed
    Created on : Jan 27, 2014, 1:50:25 PM
    Author     : yetkin.timocin
--%>

<%@page import="java.util.Vector"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%        
        Student currentStudent = new Student();
        if (session.getAttribute("currentStudent") == null) {
            //RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp");
            //dispatcher.forward(request, response);
            response.sendRedirect("../welcome.jsp");
            return;
        } else {
            currentStudent = (Student) session.getAttribute("currentStudent");
        }
        
        Student student2Bvisited = new Student();
        if (request.getParameter("student2Bvisited") != null) {
            student2Bvisited = student2Bvisited.getStudentById(Integer.valueOf(request.getParameter("student2Bvisited")));
        } else {
            student2Bvisited = null;
        }
        
        Student profileOwner = null;
        int isMyOwnProfile = 0;
        if (student2Bvisited == null) {
            profileOwner = currentStudent;
        } else {
            profileOwner = student2Bvisited;
        }
        
        if (currentStudent.getStudentID() == profileOwner.getStudentID()) {
            isMyOwnProfile = 1;
        } else {
            isMyOwnProfile = 0;
        }
        
        Vector<String> activities = new Vector<String>();
        activities = currentStudent.getStudentActivities(currentStudent.getStudentID());
        session.setAttribute("profileOwner", profileOwner);
    %>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>activity feed</title>
    </head>
    <body>
        <div class="tab-pane" id="tab_1_1">
            <%                
                for (int i = 0; i < activities.size(); i++) {
                    out.println(activities.get(i));
                    out.println("<br/>");
                }
            %>

        </div>
    </body>
</html>
