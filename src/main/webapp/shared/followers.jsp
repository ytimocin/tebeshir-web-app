<%-- 
    Document   : homeTabBoardFollowers
    Created on : Jan 7, 2014, 11:41:13 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.School"%>
<%@page import="com.tebeshir.classes.Post"%>
<%@page import="com.tebeshir.classes.Tag"%>
<%@page import="com.tebeshir.classes.Board"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Student currentStudent = (Student) session.getAttribute("currentStudent");
    if (currentStudent == null) {
        response.sendRedirect("../welcome.jsp?message=SessionExpired");
        return;
    }

    ArrayList<Student> followers = new ArrayList<Student>();
    //followers = tempBoard.getBoardFollowers(currentStudent.getSchoolID());
    int flag = 0;

    int boardID = currentStudent.getSchoolID();
    if(request.getParameter("boardID") != null) {
        boardID = Integer.valueOf(request.getParameter("boardID"));
        //followers = tempBoard.getBoardFollowers(boardID);
        flag = 1;
    }

    int tagID = 0;
    if (request.getParameter("tagID") != null) {
        tagID = Integer.valueOf(request.getParameter("tagID"));
        flag = 2;
    }

    int postID = 0;
    if (request.getParameter("postID") != null) {
        postID = Integer.valueOf(request.getParameter("postID"));
        flag = 3;
    }

    if (flag == 0 || flag == 1) {
        Board tempBoard = new Board();
        followers = tempBoard.getBoardFollowers(boardID);
    } else if (flag == 2) {
        Tag tempTag = new Tag();
        // CHECK
        followers = tempTag.getTagFollowers(tagID);
    } else if (flag == 3) {
        Post tempPost = new Post();
        followers = tempPost.getPostFollowers(postID);
    }

    // 2DO
    // 1. student avatar
    // 2.

%>
<div class="tab-pane" id="followersTab">
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
