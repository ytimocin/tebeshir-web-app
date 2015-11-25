<%-- 
    Document   : profileDropDown
    Created on : Nov 28, 2013, 11:57:21 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>tebeshir - profile drop down</title>
    </head>
    <%
        Student currentStudent = (Student) request.getAttribute("currentStudent");
        if (currentStudent == null) {
            if (session.getAttribute("currentStudent") != null) {
                currentStudent = (Student) session.getAttribute("currentStudent");
            } else {
                //RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
                //dispatcher.forward(request, response);
                response.sendRedirect("../welcome.jsp");
                return;
            }
        }
    %>
    <body>
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
            <!-- AVATAR VE USERNAME -->
            <img alt="" src="../images/avatar1_small.jpg">
            <span class="username"><%=currentStudent.getUsername()%></span>
            <i class="fa fa-angle-down"></i>
        </a>
        <ul class="dropdown-menu">
            <li><a href="../profile/student.jsp"><i class="fa fa-user"></i> Profil</a>
            </li>
            <li><a href="../page_calendar.html"><i class="fa fa-calendar"></i> Ajanda</a>
            </li>
            <li><a href="../inbox.html"><i class="fa fa-envelope"></i> Mesajlar <span class="badge badge-danger">3</span></a>
            </li>
            <li class="divider"></li>
            <li><a href="javascript:;" id="trigger_fullscreen"><i class="fa fa-move"></i> Tam Ekran</a>
            </li>
            <li><a href="extra_lock.html"><i class="fa fa-lock"></i> Ekranı Kilitle</a>
            </li>
            <li><a href="logout.jsp"><i class="fa fa-key"></i> Çıkış</a>
            </li>
        </ul>
    </body>
</html>
