<%-- 
    Document   : postDetailComments
    Created on : Jun 12, 2014, 7:18:04 PM
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
<div class="tab-pane active" id="tab_1_1">
    <!-- POST ATMA ALANI BEGIN -->
    <%=currentPostID%>
    <form action="PostNewMessage" method="post" id="newPost">
        <div class="chat-form">
            <div class="input-cont">   
                <input class="form-control" type="text" placeholder="burada bu gereksiz olabilir" name="newComment">
            </div>
            <div class="btn-cont"> 
                <span class="arrow"></span>
                <a href="#" onclick="$('#newPost').submit();" class="btn blue icn-only"><i class="fa fa-check icon-white"></i></a>
            </div>
        </div>
    </form>
    <!-- POST ATMA ALANI END -->
</div>
