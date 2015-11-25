<%-- 
    Document   : homeTabPost
    Created on : Jan 7, 2014, 11:40:11 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.ocpsoft.pretty.time.PrettyTime"%>
<%@page import="com.tebeshir.classes.School"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tebeshir.classes.Post"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%
        Student currentStudent = (Student) session.getAttribute("currentStudent");
        if (currentStudent == null) {
            response.sendRedirect("../welcome.jsp?message=SessionExpired");
            return;
        }
        
        int flag = 0;
        
        Post helperPostObj = new Post();
        ArrayList<Post> allMsgsOfThisBoard = new ArrayList<Post>();
        //allMsgsOfThisBoard = helperPostObj.getAllMessagesOfThisBoard(currentStudent.getSchoolID());
        
        int boardID = currentStudent.getSchoolID();
        if (request.getParameter("boardID") != null) {
            boardID = Integer.valueOf(request.getParameter("boardID"));
            //allMsgsOfThisBoard = helperPostObj.getAllMessagesOfThisBoard(boardID);
            flag = 1;
        }
        
        int tagID = 0;
        if (request.getParameter("tagID") != null) {
            tagID = Integer.valueOf(request.getParameter("tagID"));
            //allMsgsOfThisBoard = helperPostObj.getAllMessagesOfThisBoardWithFilter(boardID, tagID);
            flag = 2;
        } else {
            // tagID can not be NULL
            response.sendRedirect("../welcome.jsp?message=SessionExpired");
            return;
        }
        
        if (flag == 0 || flag == 1) {
            allMsgsOfThisBoard = helperPostObj.getAllMessagesOfThisBoard(boardID);
        } else if (flag == 2) {
            allMsgsOfThisBoard = helperPostObj.getAllMessagesOfThisBoardWithFilter(boardID, tagID);
        }

        String uri = request.getRequestURI() + // "/people"
                (request.getQueryString() != null ? "?"
                + request.getQueryString() : "");
        
        PrettyTime prettyTime = new PrettyTime();
        
        boolean myLikeStatus = false;
        boolean myFollowStatus = false;
        

        // eğer filtre varsa diye eklendi
        // yani üye KocUniversity panosunda
        // ve random bir postun bir etiketine
        // tıkladı, bu durumda KocUniversity'yi
        // filtrelemiş olacak
        /*
         if (filterTag == null) {*/
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
        <div class="tab-pane" id="mentionsTab">

            <!-- POST ATMA ALANI BEGIN -->
            <form action="/PostNewMessage?returnPage=<%=uri%>&tagID=<%=tagID%>" method="post" id="newPost">
                <div class="chat-form">
                    <div class="input-cont">   
                        <input class="form-control" type="text" placeholder="#" name="newPost">
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
                    <img class="avatar img-responsive" alt="" src="../images/avatar.png">
                    <div class="message">
                        <span class="arrow"></span>

                        <a href="../student.jsp?studentID=<%=postOwner.getStudentID()%>" class="name">
                            <%=postOwner.getUsername()%>
                        </a>

                        <a href="../home.jsp?boardID=<%=postOwner.getSchoolID()%>" class="name">
                            (<%=postOwnerSchoolName%>)
                        </a>

                        <span class="datetime">- <%=prettyTime.format(allMsgsOfThisBoard.get(i).getInsertDate())%></span>

                        <span class="body">
                            <a href="../post.jsp?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>" style="color: black"><%=allMsgsOfThisBoard.get(i).getOriginalMessage()%></a>
                            <br/>
                            <%
                                for (int j = 0; j < allMsgsOfThisBoard.get(i).getPostTags().size(); j++) {
                            %>
                            <a href="../tag.jsp?boardID=<%=boardID%>&tagID=<%=allMsgsOfThisBoard.get(i).getPostTags().get(j).getTagId()%>">
                                #<%=allMsgsOfThisBoard.get(i).getPostTags().get(j).getTag()%>
                            </a>
                            <%
                                }
                            %>
                            <span class="post-social" style="display:block; text-align:right;padding:5px">

                                <!-- follow button begin -->
                                <%
                                    if (myFollowStatus == true) {
                                %>
                                <span class="btn btn-xs red">
                                    <form method="post" action="/UnfollowPost?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>&unfollowerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="dIB">
                                        <input type="submit" class="btn btn-xs red" value="unfollow">
                                    </form> 
                                    <span class="count">(<%=allMsgsOfThisBoard.get(i).getFollowerCount()%>)</span>
                                </span>
                                <%
                                    } else {
                                %>
                                <span class="btn btn-xs red">
                                    <form method="post" action="/FollowPost?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>&followerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="dIB">
                                        <input type="submit" class="btn btn-xs red" value="follow">
                                    </form>
                                    <span class="count">(<%=allMsgsOfThisBoard.get(i).getFollowerCount()%>)</span>
                                </span>
                                <%
                                    }
                                %>
                                <!-- follow button end -->

                                <!-- like button begin -->
                                <%
                                    if (myLikeStatus == true) {
                                %>
                                <span class="btn btn-xs red">
                                    <form method="post" action="/UnlikePost?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>&unlikerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="dIB">
                                        <input type="submit" class="btn btn-xs red" value="unlike">
                                    </form> 
                                    <span class="count">(<%=allMsgsOfThisBoard.get(i).getLikerCount()%>)</span>
                                </span>
                                <%
                                    } else {
                                %>
                                <span class="btn btn-xs red">
                                    <form method="post" action="/LikePost?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>&likerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="dIB">
                                        <input type="submit" class="btn btn-xs red" value="like">
                                    </form> 
                                    <span class="count">(<%=allMsgsOfThisBoard.get(i).getLikerCount()%>)</span>
                                </span>
                                <%
                                    }
                                %>
                                <!-- like button end -->

                                <a href="../post.jsp?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>" class="btn btn-xs green">comment <b>(<%=allMsgsOfThisBoard.get(i).getCommenterCount()%>)</b></a>

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