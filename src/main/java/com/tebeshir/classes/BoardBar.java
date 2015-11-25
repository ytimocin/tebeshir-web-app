/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.classes;

import com.tebeshir.dao.PostgresConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author yetkin.timocin
 */
public class BoardBar {

    private int boardID;
    private String boardName;
    private String imageLocation;

    public BoardBar(int boardID, String boardName, String imageLocation) {
        this.boardID = boardID;
        this.boardName = boardName;
        this.imageLocation = imageLocation;
    }

    public static ArrayList<BoardBar> compute(int boardId, ArrayList<BoardBar> _initalList) throws InstantiationException, IllegalAccessException, SQLException {
        CallableStatement callStmt = null;
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();

        if (_initalList == null) {
            _initalList = new ArrayList<>();
        }

        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call alex.pkgBoardOperations.getBoardDetails(?)}");
            callStmt.registerOutParameter(1, java.sql.Types.OTHER);
            callStmt.setInt(2, boardId);
            callStmt.execute();
            rs = (ResultSet) callStmt.getObject(1);

            if (rs.next()) {
                final int parentBoardId = rs.getInt("parentBoardID");
                final String boardName = rs.getString("boardName");
                final String imageLocation = rs.getString("imageLocation");
                if (parentBoardId != 0) {
                    compute(parentBoardId, _initalList);
                }
                _initalList.add(new BoardBar(boardId, boardName, imageLocation));
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callStmt);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }

        return _initalList;
    }

    public static ArrayList<BoardBar> getChildren(int boardId, ArrayList<BoardBar> _initalList) {
        Connection dbConn = null;
        CallableStatement callStmt = null;
        ResultSet rs = null;

        if (_initalList == null) {
            _initalList = new ArrayList<>();
        }

        try {
            dbConn = PostgresConnection.getConnection();
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call alex.pkgBoardOperations.getBoardsChildren(?)}");
            callStmt.registerOutParameter(1, java.sql.Types.OTHER);
            callStmt.setInt(2, boardId);
            callStmt.execute();
            rs = (ResultSet) callStmt.getObject(1);
            while (rs.next()) {
                _initalList.add(new BoardBar(rs.getInt("boardID"), rs.getString("boardName"), rs.getString("imageLocation")));
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callStmt);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }

        return _initalList;
    }

    public int getBoardID() {
        return boardID;
    }

    public void setBoardID(int boardID) {
        this.boardID = boardID;
    }

    public String getBoardName() {
        return boardName;
    }

    public void setBoardName(String boardName) {
        this.boardName = boardName;
    }

    public String getImageLocation() {
        return imageLocation;
    }

    public void setImageLocation(String imageLocation) {
        this.imageLocation = imageLocation;
    }    
    
    public static void main(String[] args) throws IllegalAccessException, InstantiationException, SQLException {
        ArrayList<BoardBar> panolar = BoardBar.compute(22, null);

        for (BoardBar b : panolar) {
            System.out.println(b.getBoardID() + ": " + b.getBoardName() + " image_dir: " + b.getImageLocation());
        }
    }
}
