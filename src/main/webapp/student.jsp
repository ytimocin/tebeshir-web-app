<%-- 
    Document   : studentTemp
    Created on : Jan 26, 2014, 10:33:32 PM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.Board"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en" class="no-js">
    <%
        Student currentStudent = (Student) session.getAttribute("currentStudent");
        if (currentStudent == null) {
            response.sendRedirect("welcome.jsp?message=SessionExpired");
            return;
        }

        int studentID = currentStudent.getStudentID();
        if (request.getParameter("studentID") != null) {
            studentID = Integer.valueOf(request.getParameter("studentID"));
        }

        Student profileOwner = new Student();
        int isMyOwnProfile = 0;
        if (studentID == currentStudent.getStudentID()) {
            profileOwner = currentStudent;
            isMyOwnProfile = 1;
        } else {
            profileOwner = currentStudent.getStudentById(studentID);
        }

        Board profileOwnerBoard = new Board();
        profileOwnerBoard = profileOwnerBoard.getCurrentBoardDetails(profileOwner.getSchoolID());
    %>
    <head>
        <jsp:include page="inc/head.jsp" flush="true" />
        <style type="text/css">.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;z-index: 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}</style>
    </head>
    <!-- END HEAD -->
    <!-- BEGIN BODY -->
    <body class="page-header-fixed page-footer-fixed" style="">
        <!-- BEGIN HEADER -->
        <jsp:include page="inc/header.jsp" flush="true" />
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
                        <div class="profil" style="min-width:990px; margin-bottom: 25px">
                            <div class="title">
                                <span style="display:inline-block">
                                    <h3 class="page-title">
                                        <span class="name-field"><%=profileOwner.getUsername()%></span>
                                    </h3>
                                </span>
                            </div>

                            <div class="profile-field-content">
                                <div class="tagprofile-utility">
                                    <!-- student profile picture -->
                                    <div class="pic"><img src="images/avatar.png" alt="Koç Üniversitesi" class="profile-image" style="width: 138px;height: 138px; margin-right:5px"></div>
                                    <div class="links">
                                        <a href="#<%=profileOwner.getUsername()%>" class="btn btn-xs yellow">
                                            <i class="fa fa-envelope-o"></i>send message
                                        </a>
                                    </div>
                                </div>

                                <div class="profile-info">

                                    <div class="title-location text-ellipsis"><h4 class="occupation"><%=profileOwnerBoard.getBoardName()%></h4></div>
                                    <ul class="location-website-fields">

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
                                            about me
                                        </li>

                                    </ul>

                                    <div id="social-icons"></div>
                                </div>

                                <div class="user-stats">
                                    <ul>
                                        <li class="user-stat user-stat-color">
                                            <i class="fa fa-comment" style="padding-right:5px"></i>student total post<a href="#" class="bold" style="float:right">#</a>
                                        </li>
                                    </ul>
                                    <span class="tiny-text" id="member-since">has tebeshir since <span class="join-date"><%=profileOwner.getRegistrationDate()%></span>
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
                            <li class><a href="#activityFeedTab" data-toggle="tab">activity feed</a></li>
                                <%}%>
                            <li class="active"><a href="#postsTab" data-toggle="tab">posts</a></li>
                            <li class=""><a href="#tagsTab" data-toggle="tab">tags</a></li>
                                <%if (isMyOwnProfile == 1) {%>
                            <li class=""><a href="#studentSettingsTab" data-toggle="tab">settings</a></li>
                                <%}%>
                        </ul>
                        <div class="tab-content">

                            <jsp:include page="studentActivityFeed.jsp" flush="true"/>

                            <jsp:include page="shared/posts.jsp" flush="true">
                                <jsp:param name="studentID" value="<%=profileOwner.getStudentID()%>" />
                            </jsp:include>

                            <jsp:include page="shared/tags.jsp" flush="true">
                                <jsp:param name="studentID" value="<%=profileOwner.getStudentID()%>" />
                            </jsp:include>

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
