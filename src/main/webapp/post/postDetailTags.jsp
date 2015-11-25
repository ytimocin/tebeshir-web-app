<%-- 
    Document   : postDetailTags
    Created on : Jun 12, 2014, 8:00:24 PM
    Author     : yeko
--%>

<%@page import="com.tebeshir.classes.Post"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Post currentPost = new Post();
    String currentPostID = (String)request.getParameter("postID");
    currentPost = currentPost.getPostDetailsByID(Integer.valueOf(currentPostID));
%>
<div class="tab-pane" id="tab_1_4">
    <!-- POST ATMA ALANI BEGIN -->
    tags
    <!-- POST ATMA ALANI END -->
</div>
