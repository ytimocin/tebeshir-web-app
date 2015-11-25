<%-- 
    Document   : homeTabPost
    Created on : Jan 7, 2014, 11:40:11 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.School"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Vector"%>
<%@page import="com.tebeshir.classes.Post"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>tebeshir - posts</title>
    </head>
    <%

        String uri = request.getRequestURI() + // "/people"
                (request.getQueryString() != null ? "?"
                + request.getQueryString() : "");

        int boardID = 0;

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

        if (request.getParameter("board2Bvisited") == null) {
            if (session.getAttribute("currentBoardID") == null) {
                if (session.getAttribute("currentStudent") == null) {
                    //RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp");
                    //dispatcher.forward(request, response);
                    response.sendRedirect("../welcome.jsp");
                    return;
                } else {
                    boardID = ((Student) session.getAttribute("currentStudent")).getSchoolID();
                }
            } else {
                boardID = (Integer) session.getAttribute("currentBoardID");
            }
        } else {
            boardID = Integer.valueOf(request.getParameter("board2Bvisited"));
        }

        Post helperPostObj = new Post();
        Vector<Post> allMsgsOfThisBoard = new Vector<Post>();

        Student currentStudent = (Student) session.getAttribute("currentStudent");

        boolean myLikeStatus = false;
        boolean myFollowStatus = false;

        /*
         String filterTag = null;
         if (request.getParameter("filterTag") != null) {
         filterTag = (String) request.getParameter("filterTag");
         } else {
         if (session.getAttribute("filterTag") != null) {
         filterTag = (String) session.getAttribute("filterTag");
         }
         }
         */

        // eğer filtre varsa diye eklendi
        // yani üye KocUniversity panosunda
        // ve random bir postun bir etiketine
        // tıkladı, bu durumda KocUniversity'yi
        // filtrelemiş olacak
        /*
         if (filterTag == null) {*/
        allMsgsOfThisBoard = helperPostObj.getAllMessagesOfThisBoard(boardID);
        /*
         } else {
         allMsgsOfThisBoard = helperPostObj.getAllMessagesOfThisBoardWithFilter(boardID, filterTag);
         }*/

        // 2DO
        // 1. etiket bazlı filtrelemeyi devredışı bırakılacak
        // 2. student avatar
        // 3. board bazlı PAYLAŞ butonları
%>
    <body>
        <div class="tab-pane active" id="tab_1_1">

            <!-- POST ATMA ALANI BEGIN -->
            <form action="../PostNewMessage" method="post" id="newPost">
                <div class="chat-form">
                    <div class="input-cont">   
                        <input class="form-control" type="text" placeholder="speak to your school friends..." name="newPost">
                    </div>
                    <div class="btn-cont"> 
                        <span class="arrow"></span>
                        <a href="#" onclick="$('#newPost').submit();" class="btn blue icn-only"><i class="fa fa-check icon-white"></i></a>
                    </div>
                </div>
            </form>
            <!-- POST ATMA ALANI END -->

            <ul class="chats">
                <%

                    for (int i = 0; i < allMsgsOfThisBoard.size(); i++) {
                        Student postOwner = new Student();
                        postOwner = postOwner.getStudentById(allMsgsOfThisBoard.get(i).getStudentID());
                        School postOwnerSchool = new School();
                        String postOwnerSchoolName = postOwnerSchool.getSchoolName(postOwner.getSchoolID());
                        myLikeStatus = currentStudent.didILikeThisPost(allMsgsOfThisBoard.get(i).getPostID());
                        myFollowStatus = currentStudent.amIFollowingThisPost(allMsgsOfThisBoard.get(i).getPostID());
                %>
                <!-- TEK BİR POST ÖRNEĞİ BEGIN -->
                <li class="in">
                    <img class="avatar img-responsive" alt="" src="../images/avatar1.jpg">
                    <div class="message">
                        <span class="arrow"></span>
                        <a href="../profile/student.jsp?student2Bvisited=<%=postOwner.getStudentID()%>" class="name"><%=postOwner.getUsername()%></a>
                        <a href="home.jsp?board2Bvisited=<%=postOwner.getSchoolID()%>" class="name">(<%=postOwnerSchoolName%>)</a>
                        <span class="datetime">- <%=dateFormat.format(allMsgsOfThisBoard.get(i).getInsertDate())%></span>
                        <span class="body">
                            <%=allMsgsOfThisBoard.get(i).getOriginalMessage()%>
                            <br/>
                            <%
                                for (int j = 0; j < allMsgsOfThisBoard.get(i).getPostTags().size(); j++) {
                                    if (j == 0) {
                            %>
                            <a href="#tab_1_3">Tags</a>
                            <%                                }
                            %>
                            <a href="../tag/tag.jsp?board2Bvisited=<%=boardID%>&tag=<%=allMsgsOfThisBoard.get(i).getPostTags().get(j).getTagId()%>">
                                #<%=allMsgsOfThisBoard.get(i).getPostTags().get(j).getTag()%>
                            </a>
                            <%
                                }
                            %>
                            <span class="post-socialwwew">
                                <!-- follow button begin -->
                                <%
                                    if (myFollowStatus == true) {
                                %>
                                <span class="btn btn-xs red">
                                    <form method="post" action="../UnfollowPost?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>&unfollowerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>">
                                        <input type="submit" class="btn btn-xs red" value="following">
                                    </form> <b>(<%=allMsgsOfThisBoard.get(i).getFollowerCount()%>)</b><i class="fa fa-edit"></i></span>
                                    <%
                                    } else {
                                    %>
                                <span class="btn btn-xs red">
                                    <form method="post" action="../FollowPost?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>&followerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>">
                                        <input type="submit" class="btn btn-xs red" value="follow">
                                    </form> <b>(<%=allMsgsOfThisBoard.get(i).getFollowerCount()%>)</b><i class="fa fa-edit"></i></span>
                                    <%
                                        }
                                    %>
                                <!-- follow button end -->

                                <a href="#" class="btn btn-xs red">comment <b>(2DO)</b><i class="fa fa-edit"></i></a>

                                <!-- like button begin -->
                                <%
                                    if (myLikeStatus == true) {
                                %>
                                <span class="btn btn-xs red">
                                    <form method="post" action="../UnlikePost?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>&unlikerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>">
                                        <input type="submit" class="btn btn-xs red" value="liked">
                                    </form> <b>(<%=allMsgsOfThisBoard.get(i).getLikerCount()%>)</b><i class="fa fa-edit"></i></span>
                                    <%
                                    } else {
                                    %>
                                <span class="btn btn-xs red">
                                    <form method="post" action="../LikePost?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>&likerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>">
                                        <input type="submit" class="btn btn-xs red" value="like">
                                    </form> <b>(<%=allMsgsOfThisBoard.get(i).getLikerCount()%>)</b><i class="fa fa-edit"></i></span>
                                    <%
                                        }
                                    %>
                                <!-- like button end -->

                            </span>
                        </span>
                    </div>
                </li>
                <!-- TEK BİR POST ÖRNEĞİ END -->
                <%
                    }
                %>
            </ul>
        </div>
    </body>
</html>
