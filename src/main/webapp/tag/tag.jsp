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
        <meta charset="utf-8"/>
        <title>Tebeshir - Öğrenci Merkezi</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <meta content="" name="description"/>
        <meta content="" name="author"/>
        <meta name="MobileOptimized" content="320"/>
        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="../styles/font-awesome.min.css" rel="stylesheet" type="text/css"/>
        <link href="../styles/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../styles/uniform.default.css" rel="stylesheet" type="text/css"/>
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN PAGE LEVEL PLUGIN STYLES -->
        <link href="../styles/daterangepicker-bs3.css" rel="stylesheet" type="text/css"/>
        <link href="../styles/fullcalendar.css" rel="stylesheet" type="text/css"/>
        <link href="../styles/jqvmap.css" rel="stylesheet" type="text/css"/>
        <link href="../styles/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css"/>
        <!-- END PAGE LEVEL PLUGIN STYLES -->
        <!-- BEGIN THEME STYLES --> 
        <link href="../styles/style-metronic.css" rel="stylesheet" type="text/css"/>
        <link href="../styles/style.css" rel="stylesheet" type="text/css"/>
        <link href="../styles/style-responsive.css" rel="stylesheet" type="text/css"/>
        <link href="../styles/plugins.css" rel="stylesheet" type="text/css"/>
        <link href="../styles/timeline.css" rel="stylesheet" type="text/css"/>
        <link href="../styles/tasks.css" rel="stylesheet" type="text/css"/>
        <link href="../styles/default.css" rel="stylesheet" type="text/css" id="style_color"/>
        <link href="../styles/custom.css" rel="stylesheet" type="text/css"/>
        <!-- END THEME STYLES -->
        <link rel="shortcut icon" href="favicon.ico"/>
        <style type="text/css">.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;z-index: 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}</style>
    </head>
    <!-- END HEAD -->
    <%
        Student currentStudent = (Student) request.getAttribute("currentStudent");
        if (currentStudent == null) {
            if (session.getAttribute("currentStudent") != null) {
                currentStudent = (Student) session.getAttribute("currentStudent");
            } else {
                //RequestDispatcher dispatcher = request.getRequestDispatcher("../welcome.jsp");
                //dispatcher.forward(request, response);
                response.sendRedirect("../welcome.jsp");
                return;
            }
        } else {
            session.setAttribute("currentStudent", currentStudent);
        }
    %>
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
                        <jsp:include page="boardDetails.jsp" flush="true"/>
                    </div>
                </div>


                <div class="row">

                    <!-- TABS BEGIN -->
                    <div class="tabbable tabbable-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#tab_1_1" data-toggle="tab">tagged posts</a></li>
                            <li class=""><a href="#tab_1_2" data-toggle="tab">tag posts</a></li>
                            <li class=""><a href="#tab_1_3" data-toggle="tab">followers</a></li>
                        </ul>
                        <div class="tab-content">

                            <!-- POST DIV BEGIN -->
                            <jsp:include page="postsToTag.jsp" flush="true"/>
                            <!-- POST DIV END -->

                            <!-- FOLLOWER DIV BEGIN -->
                            <jsp:include page="tagPosts.jsp" flush="true"/>
                            <!-- FOLLOWER DIV END -->

                            <!-- TAGS DIV BEGIN -->
                            <jsp:include page="tagFollowers.jsp" flush="true"/>
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
        <!-- END FOOTER -->
        <!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
        <!-- BEGIN CORE PLUGINS -->   
        <!--[if lt IE 9]>
        <script src="scripts/respond.min.js"></script>
        <script src="scripts/excanvas.min.js"></script> 
        <![endif]-->   
        <script src="../scripts/jquery-1.10.2.min.js" type="text/javascript"></script>
        <script src="../scripts/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>   
        <!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
        <script src="../scripts/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
        <script src="../scripts/bootstrap.min.js" type="text/javascript"></script>
        <script src="../scripts/twitter-bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="../scripts/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="../scripts/jquery.blockui.min.js" type="text/javascript"></script>  
        <script src="../scripts/jquery.cookie.min.js" type="text/javascript"></script>
        <script src="../scripts/jquery.uniform.min.js" type="text/javascript"></script>
        <!-- END CORE PLUGINS -->
        <!-- BEGIN PAGE LEVEL PLUGINS -->
        <script src="../scripts/jqvmap/jquery.vmap.js" type="text/javascript"></script>   
        <script src="../scripts/jqvmap/maps/jquery.vmap.russia.js" type="text/javascript"></script>
        <script src="../scripts/jqvmap/maps/jquery.vmap.world.js" type="text/javascript"></script>
        <script src="../scripts/jqvmap/maps/jquery.vmap.europe.js" type="text/javascript"></script>
        <script src="../scripts/jqvmap/maps/jquery.vmap.germany.js" type="text/javascript"></script>
        <script src="../scripts/jqvmap/maps/jquery.vmap.usa.js" type="text/javascript"></script>
        <script src="../scripts//jqvmap/data/jquery.vmap.sampledata.js" type="text/javascript"></script>  
        <script src="../scripts/flot/jquery.flot.js" type="text/javascript"></script>
        <script src="../scripts/flot/jquery.flot.resize.js" type="text/javascript"></script>
        <script src="../scripts/jquery.pulsate.min.js" type="text/javascript"></script>
        <script src="../scripts/moment.min.js" type="text/javascript"></script>
        <script src="../scripts/daterangepicker.js" type="text/javascript"></script>     
        <!-- IMPORTANT! fullcalendar depends on jquery-ui-1.10.3.custom.min.js for drag & drop support -->
        <script src="../scripts/fullcalendar.min.js" type="text/javascript"></script>
        <script src="../scripts/jquery.easy-pie-chart.js" type="text/javascript"></script>
        <script src="../scripts/jquery.sparkline.min.js" type="text/javascript"></script>  
        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="../scripts/index.js" type="text/javascript"></script>
        <script src="../scripts/tasks.js" type="text/javascript"></script>        
        <!-- END PAGE LEVEL SCRIPTS -->  

        <!-- END JAVASCRIPTS -->

    </body>                                                      <!-- END BODY -->
</html>