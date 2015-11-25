<%-- 
    Document   : notificationDropDown
    Created on : Nov 28, 2013, 11:54:20 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>tebeshir - notification dropdown</title>
    </head>
    <%
        Student currentStudent = (Student) request.getAttribute("currentStudent");
        if (currentStudent == null) {
            if (session.getAttribute("currentStudent") != null) {
                currentStudent = (Student) session.getAttribute("currentStudent");
            } else {
                //RequestDispatcher dispatcher = request.getRequestDispatcher("../index.jsp");
                //dispatcher.forward(request, response);
                response.sendRedirect("../welcome.jsp");
                return;
            }
        }
    %>
    <body>
        <a href="#" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
            <i class="fa fa-warning"></i>
            <span class="badge">1</span>
        </a>
        <ul class="dropdown-menu extended notification">
            <li>
                <p>You have 14 new notifications</p>
            </li>
            <li>
                <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 250px;">
                    <ul class="dropdown-menu-list scroller" style="height: 250px; overflow: hidden; width: auto;">
                        <li>
                            <a href="#">
                                <span class="label label-sm label-icon label-success"><i class="fa fa-plus"></i></span>
                                New user registered. 
                                <span class="time">Just now</span>
                            </a>
                        </li>
                        <li>  
                            <a href="#">
                                <span class="label label-sm label-icon label-danger"><i class="fa fa-bolt"></i></span>
                                Server #12 overloaded. 
                                <span class="time">15 mins</span>
                            </a>
                        </li>
                        <li>  
                            <a href="#">
                                <span class="label label-sm label-icon label-warning"><i class="fa fa-bell-o"></i></span>
                                Server #2 not responding.
                                <span class="time">22 mins</span>
                            </a>
                        </li>
                        <li>  
                            <a href="#">
                                <span class="label label-sm label-icon label-info"><i class="fa fa-bullhorn"></i></span>
                                Application error.
                                <span class="time">40 mins</span>
                            </a>
                        </li>
                        <li>  
                            <a href="#">
                                <span class="label label-sm label-icon label-danger"><i class="fa fa-bolt"></i></span>
                                Database overloaded 68%. 
                                <span class="time">2 hrs</span>
                            </a>
                        </li>
                        <li>  
                            <a href="#">
                                <span class="label label-sm label-icon label-danger"><i class="fa fa-bolt"></i></span>
                                2 user IP blocked.
                                <span class="time">5 hrs</span>
                            </a>
                        </li>
                        <li>  
                            <a href="#">
                                <span class="label label-sm label-icon label-warning"><i class="fa fa-bell-o"></i></span>
                                Storage Server #4 not responding.
                                <span class="time">45 mins</span>
                            </a>
                        </li>
                        <li>  
                            <a href="#">
                                <span class="label label-sm label-icon label-info"><i class="fa fa-bullhorn"></i></span>
                                System Error.
                                <span class="time">55 mins</span>
                            </a>
                        </li>
                        <li>  
                            <a href="#">
                                <span class="label label-sm label-icon label-danger"><i class="fa fa-bolt"></i></span>
                                Database overloaded 68%. 
                                <span class="time">2 hrs</span>
                            </a>
                        </li>
                    </ul><div class="slimScrollBar" style="background-color: rgb(161, 178, 189); width: 7px; position: absolute; top: 0px; opacity: 0.4; display: none; border-top-left-radius: 7px; border-top-right-radius: 7px; border-bottom-right-radius: 7px; border-bottom-left-radius: 7px; z-index: 99; right: 1px; height: 152.4390243902439px; background-position: initial initial; background-repeat: initial initial;"></div><div class="slimScrollRail" style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-top-left-radius: 7px; border-top-right-radius: 7px; border-bottom-right-radius: 7px; border-bottom-left-radius: 7px; background-color: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px; background-position: initial initial; background-repeat: initial initial;"></div></div>
            </li>
            <li class="external">   
                <a href="#">See all notifications <i class="m-icon-swapright"></i></a>
            </li>
        </ul>
    </body>
</html>
