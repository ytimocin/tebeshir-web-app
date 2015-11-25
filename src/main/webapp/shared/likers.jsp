<%-- 
    Document   : postDetailLikers
    Created on : Jun 12, 2014, 8:00:01 PM
    Author     : yeko
--%>

<%@page import="com.tebeshir.classes.School"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page import="com.tebeshir.classes.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Post currentPost = new Post();
    String currentPostID = (String)request.getParameter("postID");
    ArrayList<Student> followers = new ArrayList<Student>();
    followers = currentPost.getPostLikers(Integer.valueOf(currentPostID));
%>
<div class="tab-pane" id="likersTab">
    <!-- FOLLOWER EXAMPLE BEGIN -->
    <div class="row">
        <%
            for (int i = 0; i < followers.size(); i++) {
                School followerSchool = new School();
                String schoolName = followerSchool.getSchoolName(followers.get(i).getSchoolID());
        %>
        <div class="col-md-6 col-lg-4 user-info">
            <img alt="" src="../images/avatar.png" class="img-responsive">
            <div class="details">
                <div>
                    <a href="../student.jsp?studentID=<%=followers.get(i).getStudentID()%>"><%=followers.get(i).getUsername()%></a>
                    <span class="label label-sm label-success label-mini"><%=schoolName%></span>
                </div>
                <div><%=followers.get(i).getRegistrationDate()%></div>
            </div>
        </div>
        <%
            }
        %>
    </div>
    <!-- FOLLOWER EXAMPLE END -->
</div>
