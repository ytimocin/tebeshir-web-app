<%-- 
    Document   : homeTabBoard
    Created on : Jan 13, 2014, 3:46:36 PM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.Tag"%>
<%@page import="java.util.Vector"%>
<%@page import="com.tebeshir.classes.Board"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>tebeshir board tags</title>
    </head>
    <%
        int boardID = 0;

        if (request.getParameter("board2Bvisited") == null) {
            if (session.getAttribute("currentBoardID") == null) {
                if (session.getAttribute("currentStudent") == null) {
                    //RequestDispatcher dispatcher = request.getRequestDispatcher("../welcome.jsp");
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

        Board tempBoard = new Board();
        Vector<Tag> boardTags = tempBoard.getBoardTags(boardID);
    %>
    <body>
        <div class="tab-pane" id="tab_1_3">
            <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 290px;">
                <div class="scroller" style="height: 290px; overflow: hidden; width: auto;">
                    <!-- TAG EXAMPLE BEGIN -->
                    <div class="row">
                        <%
                            for (int i = 0; i < boardTags.size(); i++) {
                        %>
                        <div class="col-lg-4 col-md-6 user-info">
                            <img alt="" src="../images/hashtag/tebeshir_hashtag_45_45.jpg" class="img-responsive">
                            <div class="details">
                                <div>
                                    <a href="../tag/tag.jsp?board2Bvisited=<%=boardID%>&tag=<%=boardTags.get(i).getTagID()%>"><%=boardTags.get(i).getTag()%></a>
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
                <div class="slimScrollBar" style="background-color: rgb(161, 178, 189); width: 7px; position: absolute; top: 0px; opacity: 0.4; display: block; border-top-left-radius: 7px; border-top-right-radius: 7px; border-bottom-right-radius: 7px; border-bottom-left-radius: 7px; z-index: 99; right: 1px; height: 254.84848484848484px; background-position: initial initial; background-repeat: initial initial;"></div><div class="slimScrollRail" style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-top-left-radius: 7px; border-top-right-radius: 7px; border-bottom-right-radius: 7px; border-bottom-left-radius: 7px; background-color: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px; background-position: initial initial; background-repeat: initial initial;"></div>                                    
            </div>
        </div>
    </body>
</html>
