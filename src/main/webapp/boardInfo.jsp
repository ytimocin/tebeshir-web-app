<%-- 
    Document   : boardDetails
    Created on : Nov 28, 2013, 12:01:49 PM
    Author     : yetkin.timocin
--%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tebeshir.classes.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tebeshir.classes.Board"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <%
        Student currentStudent = (Student) session.getAttribute("currentStudent");
        if (currentStudent == null) {
            response.sendRedirect("welcome.jsp");
            return;
        }

        int boardID = currentStudent.getSchoolID();
        if (request.getParameter("boardID") != null) {
            boardID = Integer.valueOf(request.getParameter("boardID"));
        }

        Board currentBoard = new Board();
        currentBoard = currentBoard.getCurrentBoardDetails(boardID);
        ArrayList<Board> boardBarList = new ArrayList<Board>();
        ArrayList<Board> boardsChildren = new ArrayList<Board>();
        boardBarList = currentBoard.compute(boardID, boardBarList);
        boardsChildren = currentBoard.getChildren(boardID, boardsChildren);
        ArrayList<Student> boardFollowers = currentBoard.getBoardFollowers(boardID);
        int boardFollowerCount = boardFollowers.size();
        Post helperPostObj = new Post();
        ArrayList<Post> allMsgsOfThisBoard = new ArrayList<Post>();
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
        String uri = request.getRequestURI();

    %> 
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
                    <div class="pic">
                        <img src="<%=currentBoard.getBoardImageLocation()%>" 
                             alt="<%=currentBoard.getBoardName()%>" 
                             class="profile-image">
                    </div>
                             
                    <div class="links">
                        <!-- burada # yerine tebeshir.com/sad8Wse9 tarzı bir
                             linke yönlendireceğiz ve bu şekilde kaç kişi bizim
                             butonları tıklayarak ilgili okulların diğer sosyal
                             platformlarına ulaşmış bunu raporlandıracağız -->
                    </div>
                </div>

                <div class="profile-info">

                    <!-- PANO BİLGİLERİ -->
                    <div class="title-location text-ellipsis">
                        <h4 class="occupation"><%=currentBoard.getBoardName()%></h4>
                    </div>
                    
                    <ul class="location-website-fields" style="list-style:none;line-height:20px; padding-left:0">
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
                    <div id="social-icons"></div>
                </div>

                <!-- PANO BİLGİLERİ EN SAĞ FOLLOWER - POST COUNT -->
                <div class="user-stats">
                    <ul>
                        <li class="user-stat user-stat-color">
                            <i class="fa fa-group" style="padding-right:5px"></i>students <a href="#followersTab" class="bold" style="float:right; padding-left:10px"><%=boardFollowerCount%></a>
                        </li>
                        <li class="user-stat user-stat-color">
                            <i class="fa fa-comments" style="padding-right:5px"></i>posts <a href="#postsTab"  class="bold" style="float:right; padding-left:10px"><%=boardMessageCount%></a>
                        </li>
                    </ul>
                            
                    <span class="tiny-text" id="member-since">Added @ <span class="join-date"><%=currentBoard.getCreationDate()%></span>
                    </span>
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
                <a href="home.jsp?boardID=<%=boardBarList.get(j).getBoardID()%>"><%=boardBarList.get(j).getBoardName()%></a> 
                <i class="fa fa-angle-right"></i>
            </li>
            
            <%
                }
            %>


            <%
                if (boardsChildren.size() <= 0) {
            %>
            <font style="color: #c7254e">Surf!</font>
            <%
                } else {
            %>
            <a href="#" onclick="$('#crumb').toggle()">Surf!</a>
            <%
                }
            %>

            <li class="pull-right">
                <div class="dashboard-location-range">
                    <form method="post" action="SearchBoard?uri=<%=uri%>">
                        <input type="text" class="boardsearch" placeholder="Search Board..." id="boardName" name="boardName">
                        <button><i class="fa fa-search"></i></button>
                    </form>
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
                    <a href="home.jsp?boardID=<%=boardsChildren.get(k).getBoardID()%>"><%=boardsChildren.get(k).getBoardName()%></a>
                    <i class="fa fa-angle-right"></i>
                </li>

                <%
                    }
                %>
            </ul>
            <br/>
        </div>
    <script>
    jQuery(document).ready(function() {
    App.init();
    Login.init();
    });

    jQuery(function() {
    $("#boardName").autocomplete("allBoards.jsp");
    });
    </script>
