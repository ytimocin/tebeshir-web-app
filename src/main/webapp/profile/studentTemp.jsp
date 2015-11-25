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
        }

        Student profileOwner = null;
        int isMyOwnProfile = 0;
        if (student2Bvisited == null) {
            profileOwner = currentStudent;
            isMyOwnProfile = 1;
        } else {
            profileOwner = student2Bvisited;
            isMyOwnProfile = 0;
        }

        Board profileOwnerBoard = new Board();
        profileOwnerBoard = profileOwnerBoard.getCurrentBoardDetails(profileOwner.getSchoolID());
    %>
    <head>
        <meta charset="utf-8">
        <title><%=profileOwner.getUsername()%>'s tebeshir</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="description">
        <meta content="" name="author">
        <meta name="MobileOptimized" content="320">
        <!-- BEGIN GLOBAL MANDATORY STYLES -->          
        <link href="../styles/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="../styles/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="../styles/uniform.default.css" rel="stylesheet" type="text/css">
        <!-- END GLOBAL MANDATORY STYLES -->
        <!-- BEGIN PAGE LEVEL PLUGIN STYLES -->
        <link href="../styles/daterangepicker-bs3.css" rel="stylesheet" type="text/css">
        <link href="../styles/fullcalendar.css" rel="stylesheet" type="text/css">
        <link href="../styles/jqvmap.css" rel="stylesheet" type="text/css">
        <link href="../styles/jquery.easy-pie-chart.css" rel="stylesheet" type="text/css">
        <!-- END PAGE LEVEL PLUGIN STYLES -->
        <!-- BEGIN THEME STYLES --> 
        <link href="../styles/style-metronic.css" rel="stylesheet" type="text/css">
        <link href="../styles/style.css" rel="stylesheet" type="text/css">
        <link href="../styles/style-responsive.css" rel="stylesheet" type="text/css">
        <link href="../styles/plugins.css" rel="stylesheet" type="text/css">                                            
        <link href="../styles/timeline.css" rel="stylesheet" type="text/css">
        <link href="../styles/tasks.css" rel="stylesheet" type="text/css">
        <link href="../styles/default.css" rel="stylesheet" type="text/css" id="style_color">
        <link href="../styles/custom.css" rel="stylesheet" type="text/css">

        <link rel="stylesheet" type="text/css" href="../styles/bootstrap-editable.css"/>
        <link rel="stylesheet" type="text/css" href="../styles/address.css"/>
        <!-- END THEME STYLES -->
        <link rel="shortcut icon" href="favicon.ico">
        <style type="text/css">.jqstooltip { position: absolute;left: 0px;top: 0px;visibility: hidden;background: rgb(0, 0, 0) transparent;background-color: rgba(0,0,0,0.6);filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";color: white;font: 10px arial, san serif;text-align: left;white-space: nowrap;padding: 5px;border: 1px solid white;z-index: 10000;}.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}</style></head>
    <!-- END HEAD -->
    <!-- BEGIN BODY -->
    <body class="page-header-fixed page-footer-fixed" style="">
        <!-- BEGIN HEADER -->   
        <div class="header navbar navbar-inverse navbar-fixed-top">
            <!-- BEGIN TOP NAVIGATION BAR -->
            <div class="header-inner">

                <!-- BEGIN LOGO -->  
                <a class="navbar-brand" href="home.jsp">
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
                                        <i class="fa fa-envelope-o"></i><a href="#" style="padding-left:5">send message to <%=profileOwner.getUsername()%></a><br/>
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

                                    <div id="social-icons">&nbsp;</div>
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
                            <li class="active"><a href="#tab_1_1" data-toggle="tab">activity feed</a></li>
                            <li class=""><a href="#tab_1_2" data-toggle="tab">messages</a></li>
                            <li class=""><a href="#tab_1_3" data-toggle="tab">tags</a></li>
                                <%if (isMyOwnProfile == 1) {%>
                            <li class=""><a href="#tab_1_4" data-toggle="tab">settings</a></li>
                                <%}%>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="tab_1_1">
                                <ul class="timeline">
                                    <li class="timeline-grey">
                                        <div class="timeline-time">
                                            <span class="date">4/17/13</span>
                                            <span class="time">12:11</span>
                                        </div>
                                        <div class="timeline-icon"><i class="fa fa-times"></i></div>
                                        <div class="timeline-body">
                                            <h5>Yetkin Timocin</h5>
                                            <div class="timeline-content">
                                                Caulie dandelion maize lentil collard greens radish arugula sweet pepper water spinach kombu courgette lettuce. Celery coriander bitterleaf epazote radicchio shallot winter purslane collard greens spring onion squash lentil. Artichoke salad bamboo shoot black-eyed pea brussels sprout garlic kohlrabi.
                                            </div>
                                            <div class="timeline-footer">
                                                <a href="#" class="nav-link pull-right">
                                                    Read more <i class="m-icon-swapright m-icon-white"></i>                              
                                                </a>     
                                            </div>
                                        </div>
                                    </li>

                                </ul>
                                <div class="chat-form">
                                    <div class="input-cont">   
                                        <input class="form-control" type="text" placeholder="Ne düşünüyorsun?">
                                    </div>
                                    <div class="btn-cont"> 
                                        <span class="arrow"></span>
                                        <a href="" class="btn blue icn-only"><i class="fa fa-check icon-white"></i></a>
                                    </div>
                                </div>

                                <ul class="chats">
                                    <li class="in">
                                        <img class="avatar img-responsive" alt="" src="images/avatar1.jpg">
                                        <div class="message">
                                            <span class="arrow"></span>
                                            <a href="#" class="name">Berkant Eskicioğlu</a>
                                            <span class="datetime">- 16 Kasım 2012 11:09</span>
                                            <span class="body">
                                                Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
                                                <span class="post-social" style="display:block; text-align:right;padding:5px">
                                                    <div class="btn-group">
                                                        <button class="btn blue btn-xs dropdown-toggle" type="button" data-toggle="dropdown">
                                                            Paylaş <i class="fa fa-angle-down"></i>
                                                        </button>
                                                        <ul class="dropdown-menu" role="menu" style="text-align:left">
                                                            <li style="margin:0; padding:0"><a href="#">Facebook</a></li>
                                                            <li style="margin:0; padding:0"><a href="#">Twitter</a></li>
                                                        </ul>
                                                    </div>                                                
                                                    <a href="#" class="btn btn-xs red">Yorum Yaz <i class="fa fa-edit"></i></a>
                                                </span>
                                            </span>
                                        </div>
                                    </li>
                                    <li class="in">
                                        <img class="avatar img-responsive" alt="" src="images/avatar2.jpg">
                                        <div class="message">
                                            <span class="arrow"></span>
                                            <a href="#" class="name">Yetkin Timocin</a>
                                            <span class="datetime">- 16 Kasım 2012 11:09</span>
                                            <span class="body">
                                                Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
                                                <span class="post-social" style="display:block; text-align:right;padding:5px">
                                                    <div class="btn-group">
                                                        <button class="btn blue btn-xs dropdown-toggle" type="button" data-toggle="dropdown">
                                                            Paylaş <i class="fa fa-angle-down"></i>
                                                        </button>
                                                        <ul class="dropdown-menu" role="menu" style="text-align:left">
                                                            <li style="margin:0; padding:0"><a href="#">Facebook</a></li>
                                                            <li style="margin:0; padding:0"><a href="#">Twitter</a></li>
                                                        </ul>
                                                    </div>                                                
                                                    <a href="#" class="btn btn-xs red">Yorum Yaz <i class="fa fa-edit"></i></a>
                                                </span>
                                            </span>
                                        </div>
                                    </li>
                                    <li class="in">
                                        <img class="avatar img-responsive" alt="" src="images/avatar1.jpg">
                                        <div class="message">
                                            <span class="arrow"></span>
                                            <a href="#" class="name">Berkant Eskicioğlu</a>
                                            <span class="datetime">- 16 Kasım 2012 11:09</span>
                                            <span class="body">
                                                Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
                                                <span class="post-social" style="display:block; text-align:right;padding:5px">
                                                    <div class="btn-group">
                                                        <button class="btn blue btn-xs dropdown-toggle" type="button" data-toggle="dropdown">
                                                            Paylaş <i class="fa fa-angle-down"></i>
                                                        </button>
                                                        <ul class="dropdown-menu" role="menu" style="text-align:left">
                                                            <li style="margin:0; padding:0"><a href="#">Facebook</a></li>
                                                            <li style="margin:0; padding:0"><a href="#">Twitter</a></li>
                                                        </ul>
                                                    </div>                                                
                                                    <a href="#" class="btn btn-xs red">Yorum Yaz <i class="fa fa-edit"></i></a>
                                                </span>
                                            </span>
                                        </div>
                                    </li>
                                    <li class="in">
                                        <img class="avatar img-responsive" alt="" src="images/avatar3.jpg">
                                        <div class="message">
                                            <span class="arrow"></span>
                                            <a href="#" class="name">Richard Doe</a>
                                            <span class="datetime">at Jul 25, 2012 11:09</span>
                                            <span class="body">
                                                Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
                                            </span>
                                        </div>
                                    </li>
                                    <li class="in">
                                        <img class="avatar img-responsive" alt="" src="images/avatar3.jpg">
                                        <div class="message">
                                            <span class="arrow"></span>
                                            <a href="#" class="name">Richard Doe</a>
                                            <span class="datetime">at Jul 25, 2012 11:09</span>
                                            <span class="body">
                                                Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
                                            </span>
                                        </div>
                                    </li>
                                    <li class="in">
                                        <img class="avatar img-responsive" alt="" src="images/avatar1.jpg">
                                        <div class="message">
                                            <span class="arrow"></span>
                                            <a href="#" class="name">Bob Nilson</a>
                                            <span class="datetime">at Jul 25, 2012 11:09</span>
                                            <span class="body">
                                                Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
                                            </span>
                                        </div>
                                    </li>
                                    <li class="in">
                                        <img class="avatar img-responsive" alt="" src="images/avatar3.jpg">
                                        <div class="message">
                                            <span class="arrow"></span>
                                            <a href="#" class="name">Richard Doe</a>
                                            <span class="datetime">at Jul 25, 2012 11:09</span>
                                            <span class="body">
                                                Lorem ipsum dolor sit amet, consectetuer adipiscing elit, 
                                                sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
                                            </span>
                                        </div>
                                    </li>
                                    <li class="in">
                                        <img class="avatar img-responsive" alt="" src="images/avatar1.jpg">
                                        <div class="message">
                                            <span class="arrow"></span>
                                            <a href="#" class="name">Bob Nilson</a>
                                            <span class="datetime">at Jul 25, 2012 11:09</span>
                                            <span class="body">
                                                Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. sed diam nonummy nibh euismod tincidunt ut laoreet.
                                            </span>
                                        </div>
                                    </li>
                                </ul>

                            </div>
                            <div class="tab-pane" id="tab_1_2">
                                <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 290px;"><div class="scroller" style="height: 290px; overflow: hidden; width: auto;" data-always-visible="1" data-rail-visible1="1">
                                        <div class="row">
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Robert Nilson</a> 
                                                        <span class="label label-sm label-success label-mini">Approved</span>
                                                    </div>
                                                    <div>29 Jan 2013 10:45AM</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Lisa Miller</a> 
                                                        <span class="label label-sm label-info">Pending</span>
                                                    </div>
                                                    <div>19 Jan 2013 10:45AM</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Eric Kim</a> 
                                                        <span class="label label-sm label-info">Pending</span>
                                                    </div>
                                                    <div>19 Jan 2013 12:45PM</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Lisa Miller</a> 
                                                        <span class="label label-sm label-danger">In progress</span>
                                                    </div>
                                                    <div>19 Jan 2013 11:55PM</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Eric Kim</a> 
                                                        <span class="label label-sm label-info">Pending</span>
                                                    </div>
                                                    <div>19 Jan 2013 12:45PM</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Lisa Miller</a> 
                                                        <span class="label label-sm label-danger">In progress</span>
                                                    </div>
                                                    <div>19 Jan 2013 11:55PM</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div><a href="#">Eric Kim</a> <span class="label label-sm label-info">Pending</span></div>
                                                    <div>19 Jan 2013 12:45PM</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Lisa Miller</a> 
                                                        <span class="label label-sm label-danger">In progress</span>
                                                    </div>
                                                    <div>19 Jan 2013 11:55PM</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div><a href="#">Eric Kim</a> <span class="label label-sm label-info">Pending</span></div>
                                                    <div>19 Jan 2013 12:45PM</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Lisa Miller</a> 
                                                        <span class="label label-sm label-danger">In progress</span>
                                                    </div>
                                                    <div>19 Jan 2013 11:55PM</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Eric Kim</a> 
                                                        <span class="label label-sm label-info">Pending</span>
                                                    </div>
                                                    <div>19 Jan 2013 12:45PM</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Lisa Miller</a> 
                                                        <span class="label label-sm label-danger">In progress</span>
                                                    </div>
                                                    <div>19 Jan 2013 11:55PM</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div><div class="slimScrollBar" style="background-color: rgb(161, 178, 189); width: 7px; position: absolute; top: 0px; opacity: 0.4; display: block; border-top-left-radius: 7px; border-top-right-radius: 7px; border-bottom-right-radius: 7px; border-bottom-left-radius: 7px; z-index: 99; right: 1px; height: 254.84848484848484px; background-position: initial initial; background-repeat: initial initial;"></div><div class="slimScrollRail" style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-top-left-radius: 7px; border-top-right-radius: 7px; border-bottom-right-radius: 7px; border-bottom-left-radius: 7px; background-color: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px; background-position: initial initial; background-repeat: initial initial;"></div></div>
                            </div>
                            <div class="tab-pane" id="tab_1_3">
                                <div class="row">
                                    <div class="col-md-12">
                                        <table id="user" class="table table-bordered table-striped">
                                            <tbody>
                                                <tr>
                                                    <td style="width:15%">Username</td>
                                                    <td style="width:50%"><a href="#" id="username" data-type="text" data-pk="1" data-original-title="Enter username">superuser</a></td>
                                                    <td style="width:35%"><span class="text-muted">Simple text field</span></td>
                                                </tr>
                                                <tr>
                                                    <td>First name</td>
                                                    <td><a href="#" id="firstname" data-type="text" data-pk="1" data-placement="right" data-placeholder="Required" data-original-title="Enter your firstname"></a></td>
                                                    <td><span class="text-muted">Required text field, originally empty</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Sex</td>
                                                    <td><a href="#" id="sex" data-type="select" data-pk="1" data-value="" data-original-title="Select sex"></a></td>
                                                    <td><span class="text-muted">Select, loaded from js array. Custom display</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Group</td>
                                                    <td><a href="#" id="group" data-type="select" data-pk="1" data-value="5" data-source="/groups" data-original-title="Select group">Admin</a></td>
                                                    <td><span class="text-muted">Select, loaded from server. <strong>No buttons</strong> mode</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Status</td>
                                                    <td><a href="#" id="status" data-type="select" data-pk="1" data-value="0" data-source="/status" data-original-title="Select status">Active</a></td>
                                                    <td><span class="text-muted">Error when loading list items</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Plan vacation?</td>
                                                    <td><a href="#" id="vacation" data-type="date" data-viewformat="dd.mm.yyyy" data-pk="1" data-placement="right" data-original-title="When you want vacation to start?">25.02.2013</a></td>
                                                    <td><span class="text-muted">Datepicker</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Date of birth</td>
                                                    <td><a href="#" id="dob" data-type="combodate" data-value="1984-05-15" data-format="YYYY-MM-DD" data-viewformat="DD/MM/YYYY" data-template="D / MMM / YYYY" data-pk="1"  data-original-title="Select Date of birth"></a></td>
                                                    <td><span class="text-muted">Date field (combodate)</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Setup event</td>
                                                    <td><a href="#" id="event" data-type="combodate" data-template="D MMM YYYY  HH:mm" data-format="YYYY-MM-DD HH:mm" data-viewformat="MMM D, YYYY, HH:mm" data-pk="1"  data-original-title="Setup event date and time"></a></td>
                                                    <td><span class="text-muted">Datetime field (combodate)</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Meeting start</td>
                                                    <td><a href="#" id="meeting_start" data-type="datetime" data-pk="1" data-url="/post" data-placement="right" title="Set date & time">15/03/2013 12:45</a></td>
                                                    <td><span class="text-muted">Bootstrap datetime</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Comments</td>
                                                    <td><a href="#" id="comments" data-type="textarea" data-pk="1" data-placeholder="Your comments here..." data-original-title="Enter comments">awesome<br>user!</a></td>
                                                    <td><span class="text-muted">Textarea. Buttons below. Submit by <i>ctrl+enter</i></span></td>
                                                </tr>
                                                <tr>
                                                    <td>Type State</td>
                                                    <td><a href="#" id="state" data-type="typeahead" data-pk="1" data-placement="right" data-original-title="Start typing State.."></a></td>
                                                    <td><span class="text-muted">Bootstrap typeahead</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Fresh fruits</td>
                                                    <td><a href="#" id="fruits" data-type="checklist" data-value="2,3" data-original-title="Select fruits"></a></td>
                                                    <td><span class="text-muted">Checklist</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Tags</td>
                                                    <td><a href="#" id="tags" data-type="select2" data-pk="1" data-original-title="Enter tags">html, javascript</a></td>
                                                    <td><span class="text-muted">Select2 (tags mode)</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Country</td>
                                                    <td><a href="#" id="country" data-type="select2" data-pk="1" data-value="BS" data-original-title="Select country"></a></td>
                                                    <td><span class="text-muted">Select2 (dropdown mode)</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Address</td>
                                                    <td><a href="#" id="address" data-type="address" data-pk="1" data-original-title="Please, fill address"></a></td>
                                                    <td><span class="text-muted">Your custom input, several fields</span></td>
                                                </tr>
                                                <tr>
                                                    <td>Notes</td>
                                                    <td>
                                                        <div id="note" data-pk="1" data-type="wysihtml5" data-toggle="manual" data-original-title="Enter notes">
                                                            <h3>WYSIWYG</h3>
                                                            WYSIWYG means <i>What You See Is What You Get</i>.<br>
                                                            But may also refer to:
                                                            <ul>
                                                                <li>WYSIWYG (album), a 2000 album by Chumbawamba</li>
                                                                <li>"Whatcha See is Whatcha Get", a 1971 song by The Dramatics</li>
                                                                <li>WYSIWYG Film Festival, an annual Christian film festival</li>
                                                            </ul>
                                                            <i>Source:</i> <a href="http://en.wikipedia.org/wiki/WYSIWYG_(disambiguation)">wikipedia.org</a> 
                                                        </div>
                                                    </td>
                                                    <td><a href="#" id="pencil"><i class="fa fa-pencil"></i> [edit]</a><br><span class="text-muted">Wysihtml5 (bootstrap only).<br>Toggle by another element</span></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            <div class="tab-pane" id="tab_1_2">
                                <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 290px;"><div class="scroller" style="height: 290px; overflow: hidden; width: auto;" data-always-visible="1" data-rail-visible1="1">
                                        <div class="row">
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Robert Nilson</a> 
                                                        <span class="label label-sm label-success label-mini">Approved</span>
                                                    </div>
                                                    <div>29 Jan 2013 10:45AM</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Lisa Miller</a> 
                                                        <span class="label label-sm label-info">Pending</span>
                                                    </div>
                                                    <div>19 Jan 2013 10:45AM</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Eric Kim</a> 
                                                        <span class="label label-sm label-info">Pending</span>
                                                    </div>
                                                    <div>19 Jan 2013 12:45PM</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Lisa Miller</a> 
                                                        <span class="label label-sm label-danger">In progress</span>
                                                    </div>
                                                    <div>19 Jan 2013 11:55PM</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Eric Kim</a> 
                                                        <span class="label label-sm label-info">Pending</span>
                                                    </div>
                                                    <div>19 Jan 2013 12:45PM</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Lisa Miller</a> 
                                                        <span class="label label-sm label-danger">In progress</span>
                                                    </div>
                                                    <div>19 Jan 2013 11:55PM</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div><a href="#">Eric Kim</a> <span class="label label-sm label-info">Pending</span></div>
                                                    <div>19 Jan 2013 12:45PM</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Lisa Miller</a> 
                                                        <span class="label label-sm label-danger">In progress</span>
                                                    </div>
                                                    <div>19 Jan 2013 11:55PM</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div><a href="#">Eric Kim</a> <span class="label label-sm label-info">Pending</span></div>
                                                    <div>19 Jan 2013 12:45PM</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Lisa Miller</a> 
                                                        <span class="label label-sm label-danger">In progress</span>
                                                    </div>
                                                    <div>19 Jan 2013 11:55PM</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Eric Kim</a> 
                                                        <span class="label label-sm label-info">Pending</span>
                                                    </div>
                                                    <div>19 Jan 2013 12:45PM</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 user-info">
                                                <img alt="" src="images/avatar.png" class="img-responsive">
                                                <div class="details">
                                                    <div>
                                                        <a href="#">Lisa Miller</a> 
                                                        <span class="label label-sm label-danger">In progress</span>
                                                    </div>
                                                    <div>19 Jan 2013 11:55PM</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div><div class="slimScrollBar" style="background-color: rgb(161, 178, 189); width: 7px; position: absolute; top: 0px; opacity: 0.4; display: block; border-top-left-radius: 7px; border-top-right-radius: 7px; border-bottom-right-radius: 7px; border-bottom-left-radius: 7px; z-index: 99; right: 1px; height: 254.84848484848484px; background-position: initial initial; background-repeat: initial initial;"></div><div class="slimScrollRail" style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-top-left-radius: 7px; border-top-right-radius: 7px; border-bottom-right-radius: 7px; border-bottom-left-radius: 7px; background-color: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px; background-position: initial initial; background-repeat: initial initial;"></div></div>
                            </div>
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
        <!-- BEGIN PLUGINS USED BY X-EDITABLE -->
        <script type="text/javascript" src="../scripts/select2.min.js"></script>
        <script type="text/javascript" src="../scripts/wysihtml5-0.3.0.js"></script> 
        <script type="text/javascript" src="../scripts/bootstrap-wysihtml5.js"></script>
        <script type="text/javascript" src="../scripts/bootstrap-datepicker.js"></script>
        <script type="text/javascript" src="../scripts/bootstrap-datetimepicker.js"></script>
        <script type="text/javascript" src="../scripts/moment.min.js"></script>
        <script type="text/javascript" src="../scripts/jquery.mockjax.js"></script>
        <script type="text/javascript" src="../scripts/bootstrap-editable.min.js"></script>
        <script type="text/javascript" src="../scripts/address.js"></script>
        <script type="text/javascript" src="../scripts/wysihtml5.js"></script>   
        <!-- END X-EDITABLE PLUGIN -->

        <!-- END PAGE LEVEL PLUGINS -->
        <!-- BEGIN PAGE LEVEL SCRIPTS -->
        <script src="../scripts/index.js" type="text/javascript"></script>
        <script src="../scripts/tasks.js" type="text/javascript"></script>        
        <!-- END PAGE LEVEL SCRIPTS -->  

        <!-- END JAVASCRIPTS -->

    </body>                                                      <!-- END BODY -->
</html>