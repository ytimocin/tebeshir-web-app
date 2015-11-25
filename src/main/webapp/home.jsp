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
            response.sendRedirect("welcome.jsp");
            return;
        }

        // başka board görüntülenmesi için
        int boardID = currentStudent.getSchoolID();
        if (request.getParameter("boardID") != null) {
            boardID = Integer.valueOf(request.getParameter("boardID"));
        }
    %>
    <!-- BEGIN BODY -->
    <body class="page-header-fixed page-footer-fixed">

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
                        <jsp:include page="boardInfo.jsp?boardID=<%=boardID%>" flush="true"/>
                    </div>
                </div>


                <div class="row">

                    <!-- TABS BEGIN -->
                    <div class="tabbable tabbable-custom">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="#postsTab" data-toggle="tab">posts</a></li>
                            <li class=""><a href="#followersTab" data-toggle="tab">students</a></li>
                            <li class=""><a href="#tagsTab" data-toggle="tab">tags</a></li>
                        </ul>
                        <div class="tab-content">

                            <!-- POST DIV BEGIN -->
                            <jsp:include page="shared/posts.jsp?boardID=<%=boardID%>" flush="true"/>
                            <!-- POST DIV END -->

                            <!-- FOLLOWER DIV BEGIN -->
                            <jsp:include page="shared/followers.jsp?boardID=<%=boardID%>" flush="true"/>
                            <!-- FOLLOWER DIV END -->

                            <!-- TAGS DIV BEGIN -->
                            <jsp:include page="shared/tags.jsp?boardID=<%=boardID%>" flush="true"/>
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
                2014 © Tebeshir
            </div>
            <div class="footer-tools">
                <span class="go-top">
                    <i class="fa fa-angle-up"></i>
                </span>
            </div>
        </div>
        <!-- BEGIN FOOTER -->
        <jsp:include page="inc/footer.jsp" flush="true" />
        <!-- END FOOTER -->
    </body>
    <!-- END BODY -->
</html>