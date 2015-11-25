<%-- 
    Document   : homeTabBoardFollowers
    Created on : Jan 7, 2014, 11:41:13 AM
    Author     : yetkin.timocin
--%>

<%@page import="com.tebeshir.classes.School"%>
<%@page import="com.tebeshir.classes.Board"%>
<%@page import="java.util.Vector"%>
<%@page import="com.tebeshir.classes.Post"%>
<%@page import="com.tebeshir.classes.Student"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>tebeshir - board followers</title>
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
        Vector<Student> boardFollowers = tempBoard.getBoardFollowers(boardID);

        // 2DO
        // 1. student avatar
        // 2. 

    %>
    <body>
        <div class="tab-pane" id="tab_1_3">
            <div class="slimScrollDiv" style="position: relative; overflow: hidden; width: auto; height: 290px;">
                <div class="scroller" style="height: 290px; overflow: hidden; width: auto;" data-always-visible="1" data-rail-visible1="1">
                    <!-- FOLLOWER EXAMPLE BEGIN -->
                    <div class="row">
                        <%
                            for (int i = 0; i < boardFollowers.size(); i++) {
                                School followerSchool = new School();
                                String schoolName = followerSchool.getSchoolName(boardFollowers.get(i).getSchoolID());
                        %>
                        <div class="col-md-6 col-lg-4 user-info">
                            <img alt="" src="../images/avatar.png" class="img-responsive">
                            <div class="details">
                                <div>
                                    <a href="../profile/student.jsp?student2Bvisited=<%=boardFollowers.get(i).getStudentID()%>"><%=boardFollowers.get(i).getUsername()%></a>
                                    <span class="label label-sm label-success label-mini"><%=schoolName%></span>
                                </div>
                                <div><%=boardFollowers.get(i).getRegistrationDate()%></div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <!-- FOLLOWER EXAMPLE END -->
                </div>
                <div class="slimScrollBar" style="background-color: rgb(161, 178, 189); width: 7px; position: absolute; top: 0px; opacity: 0.4; display: block; border-top-left-radius: 7px; border-top-right-radius: 7px; border-bottom-right-radius: 7px; border-bottom-left-radius: 7px; z-index: 99; right: 1px; height: 254.84848484848484px; background-position: initial initial; background-repeat: initial initial;"></div><div class="slimScrollRail" style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-top-left-radius: 7px; border-top-right-radius: 7px; border-bottom-right-radius: 7px; border-bottom-left-radius: 7px; background-color: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px; background-position: initial initial; background-repeat: initial initial;"></div>                                    
            </div>
        </div>
    </body>
</html>