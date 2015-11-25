<%-- 
    Document   : inboxDropDown
    Created on : Nov 28, 2013, 11:56:20 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>tebeshir - inbox drop down</title>
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

        // 2DO
        // 1. new messages count
        // 2. 
    %>
    <body>
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
            <i class="fa fa-envelope"></i>
            <span class="badge">5</span>
        </a>
        <ul class="dropdown-menu extended inbox">
            <li>
                <p>You have 12 new messages</p>
            </li>                            
            <li>
                <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 250px;">
                    <ul class="dropdown-menu-list scroller" style="height: 250px; overflow: hidden; width: auto;">                                        <li>  
                        <li>
                            <a href="../inbox.html?a=view">
                                <span class="photo"><img src="../images/avatar1.jpg" alt=""></span>
                                <span class="subject">
                                    <span class="from">Berkant Eskicioğlu</span>
                                    <span class="time">2 hrs</span>
                                </span>
                                <span class="message">
                                    Vivamus sed nibh auctor nibh congue nibh. auctor nibh
                                    auctor nibh...
                                </span>
                            </a>
                        </li>
                    </ul>                                    
                    <div class="slimScrollBar" style="background-color: rgb(161, 178, 189); width: 7px; position: absolute; top: 0px; opacity: 0.4; display: block; border-top-left-radius: 7px; border-top-right-radius: 7px; border-bottom-right-radius: 7px; border-bottom-left-radius: 7px; z-index: 99; right: 1px; background-position: initial initial; background-repeat: initial initial;"></div><div class="slimScrollRail" style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-top-left-radius: 7px; border-top-right-radius: 7px; border-bottom-right-radius: 7px; border-bottom-left-radius: 7px; background-color: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px; background-position: initial initial; background-repeat: initial initial;"></div>
                </div>
            </li>                            
            <li class="external">
                <a href="../inbox.html">See all messages <i class="m-icon-swapright"></i></a>
            </li>
        </ul>
    </body>
</html>
