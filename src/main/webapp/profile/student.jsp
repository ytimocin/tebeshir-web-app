<%-- 
    Document   : studentTemp
    Created on : Jan 26, 2014, 10:33:32 PM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.Board"%>
<%@page import="com.tebeshir.classes.School"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en" class="no-js">
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

        Board profileOwnerBoard = new Board();
        profileOwnerBoard = profileOwnerBoard.getCurrentBoardDetails(profileOwner.getSchoolID());

        session.setAttribute("profileOwner", profileOwner);
    %>
    <head>
        <jsp:include page="inc/head.jsp" flush="true" />
        <style type="text/css">.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;z-index: 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}</style>
    </head>
    <!-- END HEAD -->
    <!-- BEGIN BODY -->
    <body class="page-header-fixed page-footer-fixed" style="">
        <!-- BEGIN HEADER -->   
        <div class="header navbar navbar-inverse navbar-fixed-top">
            <!-- BEGIN TOP NAVIGATION BAR -->
            <div class="header-inner">

                <!-- BEGIN LOGO -->  
                <a class="navbar-brand" href="../home/home.jsp">
                    <img src="../images/logo.png" alt="logo" class="img-responsive">
                </a>
                <!-- END LOGO -->

                <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                <a href="javascript:;" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <img src="../images/menu-toggler.png" alt="">
                </a>
                <!-- END RESPONSIVE MENU TOGGLER -->


                <!-- BEGIN TOP NAVIGATION MENU -->
                <ul class="nav navbar-nav pull-right">

                    <!-- BEGIN NOTIFICATION DROPDOWN -->
                    <li class="dropdown" id="header_notification_bar">                        
                        <jsp:include page="../home/notificationDropDown.jsp" flush="true"/>
                    </li>
                    <!-- END NOTIFICATION DROPDOWN -->


                    <!-- BEGIN INBOX DROPDOWN -->
                    <li class="dropdown" id="header_inbox_bar">
                        <jsp:include page="../home/inboxDropDown.jsp" flush="true"/>                        
                    </li>
                    <!-- END INBOX DROPDOWN -->


                    <!-- BEGIN USER DROPDOWN -->
                    <li class="dropdown user">
                        <jsp:include page="../home/profileDropDown.jsp" flush="true"/>
                    </li>
                    <!-- END USER DROPDOWN -->                    

                </ul>
                <!-- END TOP NAVIGATION MENU -->
            </div>
            <!-- END TOP NAVIGATION BAR -->
        </div>
        <!-- END HEADER -->
        <div class="clearfix"></div>
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN PAGE -->
            <div class="page-content">

                <!-- BEGIN PAGE HEADER-->
                <div class="row">
                    <div class="col-md-12">
                        <!-- BEGIN PAGE TITLE & BREADCRUMB-->			
                        <div class="profil" style="min-width:990px">
                            <div class="title">
                                <span style="display:inline-block">
                                    <h3 class="page-title">
                                        <span class="name-field"><%=profileOwner.getUsername()%></span>
                                    </h3>
                                </span>
                            </div>

                            <div class="profile-field-content">
                                <div class="tagprofile-utility" style="width: 289px;border-right: 1px solid #e5e5e5;border-color: #e5e5e5;margin-right: 29px;position: relative;display:inline-block">
                                    <!-- student profile picture -->
                                    <div class="pic" style="display:inline-block"><img src="../images/avatar1.jpg" alt="Koç Üniversitesi" class="profile-image" style="width: 138px;height: 138px; margin-right:5px"></div>
                                    <div class="links" style="display:inline-block">
                                        <i class="fa fa-envelope-o"></i><a href="#" style="padding-left:5"> send message to <%=profileOwner.getUsername()%></a><br/>
                                    </div>
                                </div>

                                <div class="profile-info" style="display:inline-block; vertical-align:middle">

                                    <div class="title-location text-ellipsis"><h4 class="occupation"><%=profileOwnerBoard.getBoardName()%></h4></div>
                                    <ul class="location-website-fields" style="list-style:none;line-height:20px; padding-left:0">

                                        <!-- student gender -->
                                        <li>
                                            <i class="fa fa-female"></i>
                                            Kadın<br />
                                            <i class="fa fa-male"></i>
                                            Erkek
                                        </li>

                                        <!-- student info -->
                                        <li>
                                            <i class="fa fa-pencil"></i>
                                            Kendi hakkımda yazdığım şeyler (140 Karakter)
                                        </li>

                                    </ul>

                                    <div id="social-icons"></div>
                                </div>

                                <div class="user-stats" style="display: inline-block; vertical-align: middle; right: 35px; position: absolute; text-align: left;">
                                    <ul style="list-style:none; line-height:27px; padding:0">
                                        <li class="user-stat user-stat-color" style="border-bottom: 1px solid #e5e5e5;">
                                            <i class="fa fa-comment" style="padding-right:5px"></i>student total post<a href="#" class="bold" style="float:right">#</a>
                                        </li>
                                    </ul>
                                    <span class="tiny-text" id="member-since" style="text-transform: uppercase;margin: 18px 0 -3px;display: block;color: #999;">has tebeshir since <span class="join-date"><%=profileOwner.getRegistrationDate()%></span>
                                    </span>
                                </div>

                            </div>
                        </div>
                        <!-- END PAGE TITLE & BREADCRUMB-->
                    </div>
                </div>
                <div class="row">


                    <div class="tabbable tabbable-custom">
                        <ul class="nav nav-tabs">
                            <%if (isMyOwnProfile == 1) {%>
                            <li class><a href="#tab_1_1" data-toggle="tab">activity feed</a></li>
                                <%}%>
                            <li class="active"><a href="#tab_1_2" data-toggle="tab">posts</a></li>
                            <li class=""><a href="#tab_1_3" data-toggle="tab">tags</a></li>
                                <%if (isMyOwnProfile == 1) {%>
                            <li class=""><a href="#tab_1_4" data-toggle="tab">settings</a></li>
                                <%}%>
                        </ul>
                        <div class="tab-content">

                            <jsp:include page="activityFeed.jsp" flush="true"/>

                            <jsp:include page="studentPosts.jsp" flush="true"/>

                            <jsp:include page="studentTags.jsp" flush="true"/>

                            <jsp:include page="studentSettings.jsp" flush="true"/>

                        </div>
                    </div>
                </div>
                <!-- END PAGE HEADER-->

                <div class="clearfix"></div>

            </div>
            <!-- END PAGE -->
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->
        <jsp:include page="inc/footer.jsp" flush="true" />
        <!-- END FOOTER -->

    </body>                                                      <!-- END BODY -->
</html>
