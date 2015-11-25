<%-- 
    Document   : postDetailComments
    Created on : Jun 12, 2014, 7:18:04 PM
    Author     : yeko
--%>

<%@page import="com.ocpsoft.pretty.time.PrettyTime"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tebeshir.classes.School"%>
<%@page import="com.tebeshir.classes.PostComment"%>
<%@page import="com.tebeshir.classes.Post"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Student currentStudent = (Student) session.getAttribute("currentStudent");
    if (currentStudent == null) {
        response.sendRedirect("../welcome.jsp?message=SessionExpired");
        return;
    }
    Post currentPost = new Post();
    
    ArrayList<PostComment> postComments = new ArrayList<PostComment>();
    
    int postID = 0;
    
    int flag = 0;
    if (request.getParameter("postID") != null) {
        postID = Integer.valueOf(request.getParameter("postID"));
        flag = 1;
    } else {
        response.sendRedirect("../home.jsp");
        return;
    }
    
    if (flag == 0) {
        response.sendRedirect("../home.jsp");
        return;
    } else if (flag == 1) {
        currentPost = currentPost.getPostDetailsByID(postID);
        postComments = currentPost.getAllCommentsOfThisPost(postID);
    }
    
    String uri = request.getRequestURI() + // "/people"
                (request.getQueryString() != null ? "?"
                + request.getQueryString() : "");
    
    PrettyTime prettyTime = new PrettyTime();
    
%>
        <div class="tab-pane active" id="commentsTab">
            <!-- POST ATMA ALANI BEGIN -->
            <!-- 2DO -->
            <form action="/CommentOnPost?postID=<%=currentPost.getPostID()%>&commenterID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" method="post" id="newPost">
                <div class="chat-form">
                    <div class="input-cont">   
                        <input class="form-control" type="text" placeholder="burada bu gereksiz olabilir" name="comment">
                    </div>
                    <div class="btn-cont"> 
                        <span class="arrow"></span>
                        <a href="#" onclick="$('#newPost').submit();" class="btn blue icn-only"><i class="fa fa-check icon-white"></i></a>
                    </div>
                </div>
            </form>
            <!-- POST ATMA ALANI END -->
    
    <%
    
    if (postComments.size() == 0) {
        out.println("No comment yet...");
    } else {
        for (int i = 0; i < postComments.size(); i++) {
            PostComment postComment = new PostComment();
            postComment = postComments.get(i);
            Student commenter = new Student();
            commenter = commenter.getStudentById(postComment.getStudentID());
            School commenterSchool = new School();
            String schoolName = commenterSchool.getSchoolName(commenter.getSchoolID());
            String commentFormatted = "(" + prettyTime.format(postComment.getInsertDate()) + ") " + commenter.getUsername() + " from " + schoolName + " said: " + postComment.getStudentComment();
            out.println(commentFormatted);
            out.println("<br/>");
        }
    }
    %>
        </div>
