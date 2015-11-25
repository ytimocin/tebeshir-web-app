<%-- 
    Document   : homeTabPost
    Created on : Jan 7, 2014, 11:40:11 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.ocpsoft.pretty.time.PrettyTime"%>
<%@page import="java.util.Collections"%>
<%@page import="com.tebeshir.cache.PostCache"%>
<%@page import="com.tebeshir.classes.School"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tebeshir.classes.Tag"%>
<%@page import="com.tebeshir.classes.Post"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%
        Student currentStudent = (Student) session.getAttribute("currentStudent");
        if (currentStudent == null) {
            response.sendRedirect("../welcome.jsp?message=SessionExpired");
            return;
        }

        Post helperPostObj = new Post();
        Tag helperTagObj = new Tag();
        ArrayList<Post> allMsgsOfThisBoard = new ArrayList<Post>();
        PostCache postCache = new PostCache();
        int flag = 0;

        int boardID = currentStudent.getSchoolID();
        if (request.getParameter("boardID") != null) {
            flag = 1;
            boardID = Integer.valueOf(request.getParameter("boardID"));
        }

        int studentID = currentStudent.getStudentID();
        if (request.getParameter("studentID") != null) {
            flag = 2;
            studentID = Integer.valueOf(request.getParameter("studentID"));
        }

        int tagID = 0;
        if (request.getParameter("tagID") != null) {
            flag = 3;
            tagID = Integer.valueOf(request.getParameter("tagID"));
            //allMsgsOfThisBoard = currentStudent.getStudentPosts(studentID);
        }

        if (flag == 0 || flag == 1) {
            allMsgsOfThisBoard = postCache.getPostsOfThisBoard(boardID);
        } else if (flag == 2) {
            allMsgsOfThisBoard = currentStudent.getStudentPosts(studentID);
        } else if (flag == 3) {
            // 2DO
            //allMsgsOfThisBoard = helperTagObj.getTagPosts(tagID);
        }

        Collections.sort(allMsgsOfThisBoard, Collections.reverseOrder());
        
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
        <div class="tab-pane active" id="postsTab">

            <%
                if (flag == 0 || flag == 1) {
            %>
            <!-- POST ATMA ALANI BEGIN -->
            <form action="/PostNewMessage?returnPage=<%=uri%>" method="post" id="newPost">
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
            <%
                } else if (flag == 3) {
            %>
            will be available soon...<br/>request to own this tag!
            <%
                }
            %>

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
                            <span class="post-social">

                                <!-- follow button begin -->
                                <%
                                    if (myFollowStatus == true) {
                                %>
                                <a href="/UnfollowPost?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>&unfollowerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="btn btn-xs red">
                                   unfollow <strong>(<%=allMsgsOfThisBoard.get(i).getFollowerCount()%>)</strong>
                                </a>
                                <%
                                } else {
                                %>
                                <a href="/FollowPost?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>&followerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="btn btn-xs red">
                                    follow <strong>(<%=allMsgsOfThisBoard.get(i).getFollowerCount()%>)</strong>
                                </a>
                                <%
                                    }
                                %>
                                <!-- follow button end -->

                                <!-- like button begin -->
                                <%
                                    if (myLikeStatus == true) {
                                %>
                                <a href="/UnlikePost?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>&unlikerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="btn btn-xs red">
                                    unlike <strong>(<%=allMsgsOfThisBoard.get(i).getLikerCount()%>)</strong>
                                </a>
                                <%
                                } else {
                                %>
                                <a href="/LikePost?postID=<%=allMsgsOfThisBoard.get(i).getPostID()%>&likerID=<%=currentStudent.getStudentID()%>&returnPage=<%=uri%>" class="btn btn-xs red">
                                    like <strong>(<%=allMsgsOfThisBoard.get(i).getLikerCount()%>)</strong>
                                </a>
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
