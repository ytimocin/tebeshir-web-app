<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tebeshir.classes.Board"%>
<%
    Board newBoard = new Board();
    ArrayList<String> allBoards = newBoard.getAllBoardNames();

    String boardQuery = request.getParameter("q");
    
    String boardName = null;
    for (int i = 0; i < allBoards.size(); i++) {
        boardName = allBoards.get(i);
        if (boardName.toLowerCase().startsWith(boardQuery.toLowerCase())) {
            out.println(boardName);
        }
    }
%>