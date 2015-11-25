<%-- 
    Document   : profileDropDown
    Created on : Nov 28, 2013, 11:57:21 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%
        Student currentStudent = (Student) session.getAttribute("currentStudent");
        if (currentStudent == null) {
            response.sendRedirect("../../welcome.jsp?message=SessionExpired");
            return;
        }
    %>
    <body>
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
            <!-- AVATAR VE USERNAME -->
            <img alt="" src="../../images/avatar.png" width="29" height="29">
            <span class="username"><%=currentStudent.getUsername()%></span>
            <i class="fa fa-angle-down"></i>
        </a>
        <ul class="dropdown-menu">
            <li><a href="../../student.jsp"><i class="fa fa-user"></i> Profil</a>
            </li>
            <li><a href="../../inbox.html"><i class="fa fa-envelope"></i> Mesajlar <span class="badge badge-danger">3</span></a>
            </li>
            <li><a href="../../logout.jsp"><i class="fa fa-key"></i> Çıkış</a>
            </li>
        </ul>
