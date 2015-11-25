<%-- 
    Document   : postDetail
    Created on : Apr 11, 2014, 10:51:50 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.School"%>
<%@page import="com.tebeshir.classes.Post"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" class="no-js">
    <head>
        <jsp:include page="../inc/head.jsp" flush="true" />
        <style type="text/css">.jqstooltip { 
                position: absolute;
                left: 0px;
                top: 0px;
                visibility: hidden;
                background: rgb(0, 0, 0) transparent;
                background-color: rgba(0,0,0,0.6);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000);
                -ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#99000000, endColorstr=#99000000)";
                color: white;
                font: 10px arial, san serif;
                text-align: left;
                white-space: nowrap;
                padding: 5px;
                border: 1px solid white;
                z-index: 10000;
            }.jqsfield { color: white;font: 10px arial, san serif;text-align: left;}</style>
    </head>
    <%
        Student currentStudent = (Student) request.getAttribute("currentStudent");
        if (currentStudent == null) {
            if (session.getAttribute("currentStudent") != null) {
                currentStudent = (Student) session.getAttribute("currentStudent");
            } else {
                // session.redirect yap burayı
                //RequestDispatcher dispatcher = request.getRequestDispatcher("../welcome.jsp");
                //dispatcher.forward(request, response);
                response.sendRedirect("../welcome.jsp");
                return;
            }
        } else {
            session.setAttribute("currentStudent", currentStudent);
        }

        String uri = request.getRequestURI() + // "/people"
                (request.getQueryString() != null ? "?"
                + request.getQueryString() : "");

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

        int postID = Integer.valueOf(request.getParameter("postID"));

        Post currentPost = new Post();
        currentPost = currentPost.getPostDetailsByID(postID);

        boolean myLikeStatus = currentStudent.didILikeThisPost(currentPost.getPostID());
        boolean myFollowStatus = currentStudent.amIFollowingThisPost(currentPost.getPostID());

        Student postOwner = new Student();
        postOwner = postOwner.getStudentById(currentPost.getStudentID());
        School postOwnerSchool = new School();
        String postOwnerSchoolName = postOwnerSchool.getSchoolName(postOwner.getSchoolID());
    %>
    <body class="page-header-fixed page-footer-fixed" style="">

        <!-- BEGIN HEADER -->   
        <div class="header navbar navbar-inverse navbar-fixed-top">

            <!-- BEGIN TOP NAVIGATION BAR -->
            <div class="header-inner">

                <!-- BEGIN LOGO -->  
                <a class="navbar-brand" style="margin-left: 160px" href="../home/home.jsp">
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

                    </div>
                </div>


                <div class="row">

                    <!-- TABS BEGIN -->
                    <div class="tabbable tabbable-custom">


                        <ul class="chats">
                            <!-- TEK BİR POST ÖRNEĞİ BEGIN -->
                            <li class="in">
                                <img class="avatar img-responsive" alt="" src="../images/avatar1.jpg">
                                    <div class="message">
                                        <span class="arrow"></span>
                                        <a href="../profile/student.jsp?student2Bvisited=<%=postOwner.getStudentID()%>" class="name"><%=postOwner.getUsername()%></a>
                                        <a href="../home/home.jsp?board2Bvisited=<%=postOwner.getSchoolID()%>" class="name">(<%=postOwnerSchoolName%>)</a>
                                        <span class="datetime">- <%=dateFormat.format(currentPost.getInsertDate())%></span>
                                        <span class="body">
                                            <a href="../postDetail.jsp?postID=<%=currentPost.getPostID()%>" style="color: black"><%=currentPost.getOriginalMessage()%></a>
                                            <br/>
                                            <%
                                                for (int j = 0; j < currentPost.getPostTags().size(); j++) {
                                                    if (j == 0) {
                                            %>
                                            <a href="#tab_1_3">Tags</a>
                                            <%
                                                }
                                            %>
                                            <a href="../tag/tag.jsp?board2Bvisited=<%=currentStudent.getSchoolID()%>&tag=<%=currentPost.getPostTags().get(j).getTagId()%>">
                                                #<%=currentPost.getPostTags().get(j).getTag()%>
                                            </a>
                                            <%
                                                }
                                            %>
                                            <span class="post-social">
                                                <!-- follow button begin -->
                                                <%
                                                    if (myFollowStatus == true) {
                                                %>
                                                <span class="btn btn-xs red">
                                                    <form method="post" action="../UnfollowPost?postID=<%=currentPost.getPostID()%>&unfollowerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="dIB">
                                                        <input type="submit" class="btn btn-xs red" value="unfollow">
                                                    </form> 
                                                    <span class="count">(<%=currentPost.getFollowerCount()%>)</span>
                                                </span>
                                                <%
                                                } else {
                                                %>
                                                <span class="btn btn-xs red">
                                                    <form method="post" action="../FollowPost?postID=<%=currentPost.getPostID()%>&followerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="dIB">
                                                        <input type="submit" class="btn btn-xs red" value="follow">
                                                    </form>
                                                    <span class="count">(<%=currentPost.getFollowerCount()%>)</span>
                                                </span>
                                                <%
                                                    }
                                                %>
                                                <!-- like button begin -->
                                                <%
                                                    if (myLikeStatus == true) {
                                                %>
                                                <span class="btn btn-xs red">
                                                    <form method="post" action="../UnlikePost?postID=<%=currentPost.getPostID()%>&unlikerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="dIB">
                                                        <input type="submit" class="btn btn-xs red" value="unlike">
                                                    </form> 
                                                    <span class="count">(<%=currentPost.getLikerCount()%>)</span>
                                                </span>
                                                <%
                                                } else {
                                                %>
                                                <span class="btn btn-xs red">
                                                    <form method="post" action="../LikePost?postID=<%=currentPost.getPostID()%>&likerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="dIB">
                                                        <input type="submit" class="btn btn-xs red" value="like">
                                                    </form> 
                                                    <span class="count">(<%=currentPost.getLikerCount()%>)</span>
                                                </span>
                                                <%
                                                    }
                                                %>
                                                <!-- like button end -->    
                                                <!-- follow button end -->

                                                <a href="#newComment" class="btn btn-xs green">comment <b>(<%=currentPost.getCommenterCount()%>)</b></a>

                                            </span>
                                        </span>
                                    </div>
                            </li>
                            <!-- TEK BİR POST ÖRNEĞİ END -->
                        </ul>
                        <div class="tab-content">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#tab_1_1" data-toggle="tab"><%=currentPost.getCommenterCount()%> comments</a></li>
                                <li class=""><a href="#tab_1_2" data-toggle="tab"><%=currentPost.getLikerCount()%> likes</a></li>
                                <li class=""><a href="#tab_1_3" data-toggle="tab"><%=currentPost.getFollowerCount()%> followers</a></li>
                                <li class=""><a href="#tab_1_4" data-toggle="tab"><%=currentPost.getPostTags().size()%> tags</a></li>
                                <li class=""><a href="#tab_1_5" data-toggle="tab">similar</a></li>
                            </ul>

                            <jsp:include page="postDetailComments.jsp?postID=<%=currentPost.getPostID()%>" flush="true"/>
                            
                            <jsp:include page="postDetailLikers.jsp?postID=<%=currentPost.getPostID()%>" flush="true"/>
                            
                            <jsp:include page="postDetailFollowers.jsp?postID=<%=currentPost.getPostID()%>" flush="true"/>
                            
                            <jsp:include page="postDetailTags.jsp?postID=<%=currentPost.getPostID()%>" flush="true"/>
                            
                            <jsp:include page="postDetailSimilar.jsp?postID=<%=currentPost.getPostID()%>" flush="true"/>
                        
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
        <jsp:include page="../inc/footer.jsp" flush="true" />
        <!-- END FOOTER -->
    </body>
</html>
