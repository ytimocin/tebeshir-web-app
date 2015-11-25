<%-- 
    Document   : postDetail
    Created on : Apr 11, 2014, 10:51:50 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.ocpsoft.pretty.time.PrettyTime"%>
<%@page import="com.tebeshir.classes.School"%>
<%@page import="com.tebeshir.classes.Post"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en" class="no-js">
    <head>
        <jsp:include page="inc/head.jsp" flush="true" />
    </head>
    <%
        Student currentStudent = (Student) session.getAttribute("currentStudent");
        int postID = 0;
        if (currentStudent == null || request.getParameter("postID") == null) {
            response.sendRedirect("welcome.jsp?message=SessionExpired");
            return;
        }
        postID = Integer.valueOf(request.getParameter("postID"));
        
        String uri = request.getRequestURI() + // "/people"
                (request.getQueryString() != null ? "?"
                + request.getQueryString() : "");
        
        PrettyTime prettyTime = new PrettyTime();

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

                    </div>
                </div>


                <div class="row">

                    <!-- TABS BEGIN -->
                    <div class="tabbable tabbable-custom">


                        <ul class="chats">
                            <!-- TEK BİR POST ÖRNEĞİ BEGIN -->
                            <li class="in">
                                <img class="avatar img-responsive" alt="" src="images/avatar.png">
                                    <div class="message">
                                        <span class="arrow"></span>
                                        <a href="student.jsp?studentID=<%=postOwner.getStudentID()%>" class="name"><%=postOwner.getUsername()%></a>
                                        <a href="home.jsp?boardID=<%=postOwner.getSchoolID()%>" class="name">(<%=postOwnerSchoolName%>)</a>
                                        <span class="datetime">- <%=prettyTime.format(currentPost.getInsertDate())%></span>
                                        <span class="body">
                                            <a href="post.jsp?postID=<%=currentPost.getPostID()%>" style="color: black"><%=currentPost.getOriginalMessage()%></a>
                                            <br/>
                                            <%
                                                for (int j = 0; j < currentPost.getPostTags().size(); j++) {
                                            %>
                                            <a href="tag.jsp?boardID=<%=currentStudent.getSchoolID()%>&tagID=<%=currentPost.getPostTags().get(j).getTagId()%>">
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
                                                <a href="/UnfollowPost?postID=<%=currentPost.getPostID()%>&unfollowerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="btn btn-xs red">
                                                    unfollow <strong>(<%=currentPost.getFollowerCount()%>)</strong>
                                                </a>
                                                <%
                                                } else {
                                                %>
                                                <a href="/FollowPost?postID=<%=currentPost.getPostID()%>&followerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="btn btn-xs red">
                                                    follow <strong>(<%=currentPost.getFollowerCount()%>)</strong>
                                                </a>
                                                <%
                                                    }
                                                %>
                                                <!-- like button begin -->
                                                <%
                                                    if (myLikeStatus == true) {
                                                %>
                                                <a href="/UnlikePost?postID=<%=currentPost.getPostID()%>&unlikerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="btn btn-xs red">
                                                    follow <strong>(<%=currentPost.getLikerCount()%>)</strong>
                                                </a>
                                                <%
                                                } else {
                                                %>
                                                <a href="/LikePost?postID=<%=currentPost.getPostID()%>&likerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="btn btn-xs red">
                                                   like <strong>(<%=currentPost.getLikerCount()%>)</strong>
                                                </a>
                                                <%
                                                    }
                                                %>
                                                <!-- like button end -->    
                                                <!-- follow button end -->

                                                <a href="#newComment" class="btn btn-xs green">
                                                    comment <strong>(<%=currentPost.getCommenterCount()%>)</strong>
                                                </a>

                                            </span>
                                        </span>
                                    </div>
                            </li>
                            <!-- TEK BİR POST ÖRNEĞİ END -->
                        </ul>
                        <div class="tab-content">
                            <ul class="nav nav-tabs">
                                <li class="active"><a href="#commentsTab" data-toggle="tab"><%=currentPost.getCommenterCount()%> comments</a></li>
                                <li class=""><a href="#likersTab" data-toggle="tab"><%=currentPost.getLikerCount()%> likes</a></li>
                                <li class=""><a href="#followersTab" data-toggle="tab"><%=currentPost.getFollowerCount()%> followers</a></li>
                                <li class=""><a href="#tagsTab" data-toggle="tab"><%=currentPost.getPostTags().size()%> tags</a></li>
                                <li class=""><a href="#similarsTab" data-toggle="tab">similars</a></li>
                            </ul>

                            <jsp:include page="shared/comments.jsp?postID=<%=currentPost.getPostID()%>" flush="true"/>

                            <jsp:include page="shared/likers.jsp?postID=<%=currentPost.getPostID()%>" flush="true"/>

                            <jsp:include page="shared/followers.jsp?postID=<%=currentPost.getPostID()%>" flush="true"/>

                            <jsp:include page="shared/tags.jsp?postID=<%=currentPost.getPostID()%>" flush="true"/>

                            <jsp:include page="shared/similars.jsp?postID=<%=currentPost.getPostID()%>" flush="true"/>

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
        <jsp:include page="inc/footer.jsp" flush="true" />
        <!-- END FOOTER -->
    </body>
</html>
