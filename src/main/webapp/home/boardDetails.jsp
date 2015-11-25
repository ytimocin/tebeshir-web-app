<%-- 
    Document   : boardDetails
    Created on : Nov 28, 2013, 12:01:49 PM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.Post"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tebeshir.classes.Board"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.tebeshir.classes.BoardBar"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>tebeshir - board details</title>
    </head>
    <%
        Student currentStudent = (Student) request.getAttribute("currentStudent");
        if (currentStudent == null) {
            if (session.getAttribute("currentStudent") != null) {
                currentStudent = (Student) session.getAttribute("currentStudent");
            } else {
                //RequestDispatcher dispatcher = request.getRequestDispatcher("../index.jsp");
                //dispatcher.forward(request, response);
                response.sendRedirect("../welcome.jsp");
                return;
            }
        }

        int boardID = currentStudent.getSchoolID();

        if (request.getParameter("board2Bvisited") != null) {
            boardID = Integer.valueOf(request.getParameter("board2Bvisited"));
        }

        int tagID = 0;
        if (request.getParameter("tag") != null) {
            tagID = Integer.valueOf(request.getParameter("filterTag"));
        } else {
            if (session.getAttribute("filterTag") != null) {
                tagID = (Integer) session.getAttribute("filterTag");
            }
        }

        session.setAttribute("currentBoardID", boardID);

        Board currentBoard = new Board();
        currentBoard = currentBoard.getCurrentBoardDetails(boardID);
        LinkedList<Board> boardBarList = new LinkedList<Board>();
        LinkedList<Board> boardsChildren = new LinkedList<Board>();
        boardBarList = currentBoard.compute(boardID, boardBarList);
        boardsChildren = currentBoard.getChildren(boardID, boardsChildren);
        Vector<Student> boardFollowers = currentBoard.getBoardFollowers(boardID);
        int boardFollowerCount = boardFollowers.size();
        Post helperPostObj = new Post();
        Vector<Post> allMsgsOfThisBoard = new Vector<Post>();
        allMsgsOfThisBoard = helperPostObj.getAllMessagesOfThisBoard(boardID);

        // eğer filtre varsa diye eklendi
        // yani üye KocUniversity panosunda
        // ve random bir postun bir etiketine
        // tıkladı, bu durumda KocUniversity'yi
        // filtrelemiş olacak

        int boardMessageCount = allMsgsOfThisBoard.size();
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Date date = new Date();
        String now = dateFormat.format(date);

    %>
    <body>
        <div class="profil" style="min-width:990px">

            <div class="title">
                <span style="display:inline-block">
                    <h3 class="page-title">
                        <span class="name-field"><%=currentBoard.getBoardName()%></span>
                        <small class="tagname-field">#<%=currentBoard.getBoardName()%></small>
                    </h3>
                </span>
            </div>

            <div class="profile-field-content">
                <div class="tagprofile-utility">
                    <div class="pic"><img src="../<%=currentBoard.getBoardImageLocation()%>" alt="Koç Üniversitesi" class="profile-image"></div>
                    <div class="links" style="display:inline-block">
                        <!-- burada # yerine tebeshir.com/sad8Wse9 tarzı bir
                             linke yönlendireceğiz ve bu şekilde kaç kişi bizim
                             butonları tıklayarak ilgili okulların diğer sosyal
                             platformlarına ulaşmış bunu raporlandıracağız -->
                    </div>
                </div>

                <div class="profile-info" style="display:inline-block; vertical-align:middle">

                    <!-- PANO BİLGİLERİ -->
                    <div class="title-location text-ellipsis">
                        <h4 class="occupation"><%=currentBoard.getBoardName()%></h4>
                    </div>
                    <ul class="location-website-fields">

                        <li>
                            <i class="fa fa-map-marker"></i>
                            <%=currentBoard.getAddressLine1()%><br />
                            <a class="location-link" href="#" style="color:#494949; padding-left:20px"><%=currentBoard.getAddressLine2()%></a>
                        </li>

                        <li>
                            <i class="fa fa-laptop"></i>
                            <a target="_blank" class="header-link-color" href="#"><%=currentBoard.getWebPage()%></a>
                        </li>

                        <li class="fields">
                            <i class="fa fa-phone"></i>
                            <%=currentBoard.getTelNo1()%>
                        </li>
                    </ul>

                    <div id="social-icons">
                    </div> <!-- #social-icons -->

                </div>

                <!-- PANO BİLGİLERİ EN SAĞ FOLLOWER - POST COUNT -->
                <div class="user-stats" style="display: inline-block;vertical-align: middle;right: 25px;position: absolute;text-align: left;">
                    <ul style="list-style:none; line-height:27px; padding:0">
                        <li class="user-stat user-stat-color" style="border-bottom: 1px solid #e5e5e5;">
                            <i class="fa fa-group" style="padding-right:5px"></i>Takipçileri <a href="" class="bold" style="float:right; padding-left:10px"><%=boardFollowerCount%></a>
                        </li>
                        <li class="user-stat user-stat-color" style="border-bottom: 1px solid #e5e5e5;">
                            <i class="fa fa-comments" style="padding-right:5px"></i>Post Sayısı <a href=""  class="bold" style="float:right; padding-left:10px"><%=boardMessageCount%></a>
                        </li>
                    </ul>
                    <span class="tiny-text" id="member-since" style="text-transform: uppercase;margin: 18px 0 -3px;display: block;color: #999;">Member Since: <span class="join-date"><%=currentBoard.getCreationDate()%></span></span>
                </div>
                <!-- PANO BİLGİLERİ EN SAĞ FOLLOWER - POST COUNT -->

            </div>
        </div>

        <ul class="page-breadcrumb breadcrumb">
            <i class="fa fa-globe" style="padding-right:5px"></i>

            <%
                for (int j = 0; j < boardBarList.size(); j++) {
            %>
            <li>
                <a href="home.jsp?board2Bvisited=<%=boardBarList.get(j).getBoardID()%>"><%=boardBarList.get(j).getBoardName()%></a> 
                <i class="fa fa-angle-right"></i>
            </li>
            <%
                }
            %>


            <%
                if (boardsChildren.size() <= 0) {
            %>
            <font style="color: #c7254e">Surf!</font>
            <%            } else {
            %>
            <a href="#" onclick="$('#crumb').toggle()">Surf!</a>
            <%                }
            %>
            <li class="pull-right">
                <div id="dashboard-report-range" class="dashboard-location-range tooltips" data-placement="top" data-original-title="Change dashboard date range" style="display: block;">
                    <i class="fa fa-calendar"></i>
                    <span><%=now%></span>  
                </div>
            </li>
        </ul>

        <div id="crumb" style="display:none">
            <ul class="page-breadcrumb breadcrumb">
                <i class="fa fa-globe" style="padding-right:5px"></i>
                <%
                    for (int k = 0; k < boardsChildren.size(); k++) {
                %>
                <li>
                    <a href="home.jsp?board2Bvisited=<%=boardsChildren.get(k).getBoardID()%>"><%=boardsChildren.get(k).getBoardName()%></a>
                    <i class="fa fa-angle-right"></i>
                </li>

                <%
                    }
                %>
            </ul>
            <br/>
        </div>
    </body>
</html>
