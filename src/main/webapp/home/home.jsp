<%-- 
    Document   : index
    Created on : Nov 28, 2013, 11:19:14 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" class="no-js">
    <head>
        <jsp:include page="inc/head.jsp" flush="true" />
    </head>
    <!-- END HEAD -->
    <%
        Student currentStudent = (Student) session.getAttribute("currentStudent");
        if (currentStudent == null) {
            response.sendRedirect("../welcome.jsp");
            return;
        }
        
        // başka board görüntülenmesi için
        int boardID = 0;
        if (request.getParameter("boardID") != null) {
            boardID = Integer.valueOf(request.getParameter("boardID"));
        } else {
            boardID = currentStudent.getSchoolID();
        }
    %>
    <!-- BEGIN BODY -->
    <body class="page-header-fixed page-footer-fixed" style="">

        <!-- BEGIN HEADER -->   
        <div class="header navbar navbar-inverse navbar-fixed-top">

            <!-- BEGIN TOP NAVIGATION BAR -->
            <div class="header-inner">

                <!-- BEGIN LOGO -->  
                <a class="navbar-brand" style="margin-left: 160px" href="home.jsp">
                    <img src="../images/logo.png" alt="logo" class="img-responsive">
                </a>
                <!-- END LOGO -->

                <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                <a href="javascript:;" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <img src="../images/menu-toggler.png" alt="">
                </a> 
                <!-- END RESPONSIVE MENU TOGGLER -->


                <!-- BEGIN TOP NAVIGATION MENU -->
                <ul class="nav navbar-nav pull-right" style="margin-right: 150px">

                    <!-- BEGIN NOTIFICATION DROPDOWN -->
                    <li class="dropdown" id="header_notification_bar">                        
                        <jsp:include page="notificationDropDown.jsp" flush="true"/>
                    </li>
                    <!-- END NOTIFICATION DROPDOWN -->


                    <!-- BEGIN INBOX DROPDOWN -->
                    <li class="dropdown" id="header_inbox_bar">
                        <jsp:include page="inboxDropDown.jsp" flush="true"/>                        
                    </li>
                    <!-- END INBOX DROPDOWN -->


                    <!-- BEGIN USER DROPDOWN -->
                    <li class="dropdown user">
                        <jsp:include page="profileDropDown.jsp" flush="true"/>
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
                        <jsp:include page="boardDetails.jsp" flush="true"/>
                    </div>
                </div>


                <div class="row">

                    <!-- TABS BEGIN -->
                    <div class="tabbable tabbable-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab_1_1" data-toggle="tab">posts</a></li>
                            <li class=""><a href="#tab_1_2" data-toggle="tab">followers</a></li>
                            <li class=""><a href="#tab_1_3" data-toggle="tab">tags</a></li>
                        </ul>
                        <div class="tab-content">

                            <!-- POST DIV BEGIN -->
                            <jsp:include page="../posts.jsp?boardID=<%=(boardID==0)?currentStudent.getStudentID():boardID%>" flush="true"/>
                            <!-- POST DIV END -->

                            <!-- FOLLOWER DIV BEGIN -->
                            <jsp:include page="followers.jsp?boardID=<%=(boardID==0)?currentStudent.getStudentID():boardID%>" flush="true"/>
                            <!-- FOLLOWER DIV END -->

                            <!-- TAGS DIV BEGIN -->
                            <jsp:include page="tags.jsp?boardID=<%=(boardID==0)?currentStudent.getStudentID():boardID%>" flush="true"/>
                            <!-- TAGS DIV END -->
                        </div>
                    </div>
                    <!-- TABS END -->

                </div>
                <!-- END PAGE HEADER-->

                <div class="clearfix"></div>

            </div>
            <!-- END PAGE -->
        </div>
        <!-- END CONTAINER -->
        <!-- BEGIN FOOTER -->
        <div class="footer">
            <div class="footer-inner">
                2013 © Tebeshir
            </div>
            <div class="footer-tools">
                <span class="go-top">
                    <i class="fa fa-angle-up"></i>
                </span>
            </div>
        </div>
        <!-- BEGIN FOOTER -->
        <jsp:include page="../inc/footer.jsp" flush="true" />
        <!-- END FOOTER -->
    </body>                                                      <!-- END BODY -->
</html>