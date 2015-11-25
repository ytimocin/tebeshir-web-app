<%-- 
    Document   : homeTabBoard
    Created on : Jan 13, 2014, 3:46:36 PM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.Tag"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tebeshir.classes.Board"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Student currentStudent = (Student) session.getAttribute("currentStudent");
    if (currentStudent == null) {
        response.sendRedirect("../welcome.jsp?message=SessionExpired");
        return;
    }

    Board tempBoard = new Board();
    ArrayList<Tag> boardTags = new ArrayList<Tag>();
    //boardTags = tempBoard.getBoardTags(currentStudent.getSchoolID());
    int flag = 0;

    int boardID = currentStudent.getSchoolID();
    if(request.getParameter("boardID") != null) {
        boardID = Integer.valueOf(request.getParameter("boardID"));
        //boardTags = tempBoard.getBoardTags(boardID);
        flag = 1;
    }

    int studentID = currentStudent.getStudentID();
    if (request.getParameter("studentID") != null) {
        studentID = Integer.valueOf(request.getParameter("studentID"));
        // 2DO = getStudentTags
        //boardTags = tempBoard.getBoardTags(boardID);
        flag = 2;
    }

    int postID = 0;
    if (request.getParameter("postID") != null) {
        postID = Integer.valueOf(request.getParameter("postID"));
        flag = 3;
    }

    if (flag == 0 || flag == 1) {
        boardTags = tempBoard.getBoardTags(boardID);
    } else if (flag == 2) {
        boardTags = tempBoard.getStudentTags(studentID);
    } else if (flag == 3) {
        Tag tempPostTag = new Tag();
        boardTags = tempPostTag.getTagsOfThisPost(postID);
    }
%>
<div class="tab-pane" id="tagsTab">
        <!-- TAG EXAMPLE BEGIN -->
        <div class="row">
            <%
                for (int i = 0; i < boardTags.size(); i++) {
            %>
            <div class="col-lg-4 col-md-6 user-info">
                <img alt="" src="../images/hashtag/tebeshir_hashtag_45_45.jpg" class="img-responsive">
                <div class="details">
                    <div>
                        <a href="../tag.jsp?boardID=<%=boardID%>&tagID=<%=boardTags.get(i).getTagID()%>"><%=boardTags.get(i).getTag()%></a>
                        <span class="label label-sm label-success label-mini"><%=boardTags.get(i).getDistinctPostCount()%> post</span>
                        <span class="label label-sm label-success label-mini"><%=boardTags.get(i).getTagFollowerCount()%> takipçi</span>
                    </div>
                    <div><%=boardTags.get(i).getInsertDate()%></div>
                </div>
            </div>
            <%
                }
            %>
        </div>
        <!-- TAG EXAMPLE END -->
</div>