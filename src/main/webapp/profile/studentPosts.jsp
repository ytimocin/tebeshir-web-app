<%-- 
    Document   : studentPosts
    Created on : Jan 27, 2014, 11:27:45 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.School"%>
<%@page import="java.util.Vector"%>
<%@page import="com.tebeshir.classes.Post"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page import="java.text.DateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>tebeshir</title>
    </head>
    <%
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");

        Student profileOwner = new Student();
        if (session.getAttribute("profileOwner") == null) {
            //RequestDispatcher dispatcher = request.getRequestDispatcher("../welcome.jsp");
            //dispatcher.forward(request, response);
            response.sendRedirect("../welcome.jsp");
            return;
        } else {
            profileOwner = (Student) session.getAttribute("profileOwner");
        }

        Vector<Post> allMsgsOfThisStudent = new Vector<Post>();
        allMsgsOfThisStudent = profileOwner.getStudentPosts(profileOwner.getStudentID());
        // 2DO
        // 1. etiket bazlı filtrelemeyi devredışı bırakılacak
        // 2. student avatar
        // 3. board bazlı PAYLAŞ butonları

        String uri = request.getRequestURI() + (request.getQueryString() != null ? "?" + request.getQueryString() : "");

        boolean myLikeStatus = false;
        boolean myFollowStatus = false;

    %>
    <body>
        <div class="tab-pane active" id="tab_1_2">
            <ul class="chats">
                <%
                    for (int i = 0; i < allMsgsOfThisStudent.size(); i++) {
                        School postOwnerSchool = new School();
                        String postOwnerSchoolName = postOwnerSchool.getSchoolName(profileOwner.getSchoolID());
                        myLikeStatus = profileOwner.didILikeThisPost(allMsgsOfThisStudent.get(i).getPostID());
                        myFollowStatus = profileOwner.amIFollowingThisPost(allMsgsOfThisStudent.get(i).getPostID());
                %>
                <!-- TEK BİR POST ÖRNEĞİ BEGIN -->
                <li class="in">
                    <img class="avatar img-responsive" alt="" src="../images/avatar1.jpg">
                    <div class="message">
                        <span class="arrow"></span>
                        <a href="../profile/student.jsp?student2Bvisited=<%=profileOwner.getStudentID()%>" class="name"><%=profileOwner.getUsername()%></a>
                        <a href="../home/home.jsp?board2Bvisited=<%=profileOwner.getSchoolID()%>" class="name">(<%=postOwnerSchoolName%>)</a>
                        <span class="datetime">- <%=dateFormat.format(allMsgsOfThisStudent.get(i).getInsertDate())%></span>
                        <span class="body">
                            <%=allMsgsOfThisStudent.get(i).getOriginalMessage()%>
                            <br/>
                            <%
                                for (int j = 0; j < allMsgsOfThisStudent.get(i).getPostTags().size(); j++) {
                                    if (j == 0) {
                            %>
                            <a href="#tab_1_3">Tags</a>
                            <%                                }
                            %>
                            <a href="../home/home.jsp?board2Bvisited=<%=profileOwner.getSchoolID()%>">
                                #<%=allMsgsOfThisStudent.get(i).getPostTags().get(j).getTag()%>
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
                                    <form method="post" action="../UnfollowPost?postID=<%=allMsgsOfThisStudent.get(i).getPostID()%>&unfollowerID=<%=profileOwner.getStudentID()%>&returnPage=<%=uri%>">
                                        <input type="submit" class="btn btn-xs red" value="following">
                                    </form> <b>(<%=allMsgsOfThisStudent.get(i).getFollowerCount()%>)</b><i class="fa fa-edit"></i></span>
                                    <%
                                    } else {
                                    %>
                                <span class="btn btn-xs red">
                                    <form method="post" action="../FollowPost?postID=<%=allMsgsOfThisStudent.get(i).getPostID()%>&followerID=<%=profileOwner.getStudentID()%>&returnPage=<%=uri%>">
                                        <input type="submit" class="btn btn-xs red" value="follow">
                                    </form> <b>(<%=allMsgsOfThisStudent.get(i).getFollowerCount()%>)</b><i class="fa fa-edit"></i></span>
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
                                    <form method="post" action="../UnlikePost?postID=<%=allMsgsOfThisStudent.get(i).getPostID()%>&unlikerID=<%=profileOwner.getStudentID()%>&returnPage=<%=uri%>">
                                        <input type="submit" class="btn btn-xs red" value="liked">
                                    </form> <b>(<%=allMsgsOfThisStudent.get(i).getLikerCount()%>)</b><i class="fa fa-edit"></i></span>
                                    <%
                                    } else {
                                    %>
                                <span class="btn btn-xs red">
                                    <form method="post" action="../LikePost?postID=<%=allMsgsOfThisStudent.get(i).getPostID()%>&likerID=<%=profileOwner.getStudentID()%>&returnPage=<%=uri%>">
                                        <input type="submit" class="btn btn-xs red" value="like">
                                    </form> <b>(<%=allMsgsOfThisStudent.get(i).getLikerCount()%>)</b><i class="fa fa-edit"></i></span>
                                    <%
                                        }
                                    %>
                                <!-- like button end -->

                            </span>
                        </span>
                    </div>
                </li>
                <!-- TEK BİR POST ÖRNEĞİ BEGIN -->
                <%
                    }
                %>
            </ul>
        </div>
    </body>
</html>
