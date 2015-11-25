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
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author yetkin.timocin
 */
public class Board {

    private int boardID;
    private String boardName;
    private String boardImageLocation;
    private int parentBoardID;
    private int boardType;
    private int boardDepth;
    private int boardStatus;
    private Date creationDate;
    private String addressLine1;
    private String addressLine2;
    private String webPage;
    private String telNo1;
    private ArrayList<Board> boardsParents;
    private ArrayList<Board> boardsChildren;
    private ArrayList<SocialNetwork> boardSocialNetworkLinks;

    public static void main(String args[]) {
        try {
            //List<Board> allBoards = new ArrayList<Board>();
            Board tempBoard = new Board();
            /*allBoards = tempBoard.getAllBoards();
            for (int i = 0; i < allBoards.size(); i++) {
                for (int j = 0; j < allBoards.get(i).getBoardsChildren().size(); j++) {
                    System.out.println(allBoards.get(i).getBoardName());
                    System.out.println(allBoards.get(i).getBoardsParents().get(j).getBoardName());
                    System.out.println(allBoards.get(i).getBoardsChildren().get(j).getBoardName());
                }
            }*/
            
            ArrayList<Integer> leaves = new ArrayList<Integer>();
            leaves = tempBoard.getBoardLeaves(17);
            for (Integer leaf : leaves) {
                System.out.println("leaf # " + leaf);
            }
            
            /*
        } catch (InstantiationException ex) {
            Logger.getLogger(Board.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(Board.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(Board.class.getName()).log(Level.SEVERE, null, ex);*/
        } catch (Throwable ex) {
            Logger.getLogger(Board.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Board(int boardID, String boardName, String boardImageLocation) {
        this.setBoardID(boardID);
        this.setBoardName(boardName);
        this.setBoardImageLocation(boardImageLocation);
    }

    public Board() {
    }

    public ArrayList<Board> getAllBoards() throws InstantiationException, IllegalAccessException, SQLException, Throwable {
        ArrayList<Board> allActiveBoards = new ArrayList<>();
        CallableStatement callableStatement = null;
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call alex.pkgBoardOperations.getAllActiveBoards() }");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                Board currentBoard = new Board();
                ArrayList<Board> currentBoardsParents = new ArrayList<>();
                ArrayList<Board> currentBoardsChildren = new ArrayList<>();
                currentBoard.setBoardID(rs.getInt("boardID"));
                currentBoard.setBoardName(rs.getString("boardName"));
                currentBoard.setParentBoardID(rs.getInt("parentBoardID"));
                currentBoard.setBoardType(rs.getInt("boardType"));
                currentBoard.setBoardDepth(rs.getInt("boardDepth"));
                currentBoard.setBoardStatus(rs.getInt("boardStatus"));
                currentBoardsParents = Board.compute(currentBoard.getBoardID(), currentBoardsParents);
                currentBoard.setBoardsParents(currentBoardsParents);
                currentBoardsChildren = Board.getChildren(currentBoard.getBoardID(), currentBoardsChildren);
                currentBoard.setBoardsChildren(currentBoardsChildren);
                allActiveBoards.add(currentBoard);
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return allActiveBoards;
    }
    
    public ArrayList<String> getAllBoardNames() {
        ArrayList<String> allActiveBoards = new ArrayList<>();
        CallableStatement callableStatement = null;
        ResultSet rs = null;
        Connection dbConn = null;
        try {
            dbConn = PostgresConnection.getConnection();
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call alex.pkgBoardOperations.getAllActiveBoardNames() }");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                allActiveBoards.add(rs.getString("boardName"));
            }
        } catch (SQLException | InstantiationException | IllegalAccessException ex) {
            Logger.getLogger(Board.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return allActiveBoards;
    }

    public ArrayList<Integer> getBoardLeaves(int boardID) {
        ArrayList<Integer> boardLeaves = new ArrayList<>();
        CallableStatement callableStatement = null;
        ResultSet rs = null;
        Connection dbConn = null;
        try {
            dbConn = PostgresConnection.getConnection();
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call alex.pkgBoardOperations.getBoardLeaves(?) }");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, boardID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                boardLeaves.add(rs.getInt("boardID"));
            }
        } catch (SQLException | InstantiationException | IllegalAccessException ex) {
            Logger.getLogger(Board.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return boardLeaves;
    }

    public static ArrayList<Board> compute(int boardId, ArrayList<Board> _initalList) throws InstantiationException, IllegalAccessException, SQLException {
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
                _initalList.add(new Board(boardId, boardName, imageLocation));
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

    public static ArrayList<Board> getChildren(int boardId, ArrayList<Board> _initalList) {
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
                _initalList.add(new Board(rs.getInt("boardID"), rs.getString("boardName"), rs.getString("imageLocation")));
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

    private ArrayList<SocialNetwork> boardsSocialNetworkLinks(int boardID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<SocialNetwork> boardsSocialNetworkLinks = new ArrayList<>();
        CallableStatement callableStatement = null;
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call alex.pkgTebeshirAdmin.boardsSocialNetworkLinks(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, boardID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                SocialNetwork tempSoNet = new SocialNetwork();
                tempSoNet.setSocialNetworkID(rs.getInt("socialNetworkWebSiteID"));
                tempSoNet.setSocialNetworkLinkForABoard(rs.getString("link"));
                tempSoNet.setIsVisible(rs.getInt("isVisible"));
                tempSoNet.setSocialNetworkName(rs.getString("socialNetworkName"));
                tempSoNet.setImageLocation(rs.getString("logoLocation"));
                tempSoNet.setStatus(rs.getInt("status"));
                boardsSocialNetworkLinks.add(tempSoNet);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return boardsSocialNetworkLinks;
    }

    public Board getCurrentBoardDetails(int boardID) throws InstantiationException, IllegalAccessException, SQLException {
        Board currentBoard = new Board();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call alex.pkgBoardOperations.getBoardDetails(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, boardID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                currentBoard.setBoardName(rs.getString("boardName"));
                currentBoard.setParentBoardID(rs.getInt("parentBoardID"));
                currentBoard.setBoardType(rs.getInt("boardType"));
                currentBoard.setBoardDepth(rs.getInt("boardDepth"));
                currentBoard.setBoardStatus(rs.getInt("boardStatus"));
                currentBoard.setBoardImageLocation(rs.getString("imageLocation"));
                currentBoard.setCreationDate(rs.getDate("creationDate"));
                currentBoard.setAddressLine1(rs.getString("address1"));
                currentBoard.setAddressLine2(rs.getString("address2"));
                currentBoard.setWebPage(rs.getString("webpage"));
                currentBoard.setTelNo1(rs.getString("telno1"));
                ArrayList<Board> currentBoardsParents = new ArrayList<>();
                ArrayList<Board> currentBoardsChildren = new ArrayList<>();
                currentBoard.setBoardsParents(Board.compute(currentBoard.getBoardID(), currentBoardsParents));
                currentBoard.setBoardsParents(Board.getChildren(currentBoard.getBoardID(), currentBoardsChildren));
                currentBoard.setBoardSocialNetworkLinks(currentBoard.boardsSocialNetworkLinks(currentBoard.getBoardID()));
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return currentBoard;
    }
    
    public int getBoardIdByName(String boardName) {
        int result = 0;
        Connection dbConn = null;
        CallableStatement callableStatement = null;
        try {
            dbConn = PostgresConnection.getConnection();
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call alex.pkgBoardOperations.getBoardIdByName(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.NUMERIC);
            callableStatement.setString(2, boardName);
            callableStatement.execute();
            result = callableStatement.getBigDecimal(1).intValue();
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return result;
    }

    public ArrayList<Student> getBoardFollowers(int boardID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<Student> boardFollowers = new ArrayList<>();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call alex.pkgBoardOperations.getBoardFollowers(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, boardID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                Student tempStudent = new Student();
                tempStudent = tempStudent.getStudentById(rs.getInt("studentID"));
                boardFollowers.add(tempStudent);
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return boardFollowers;
    }

    public ArrayList<Tag> getBoardTags(int boardID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<Tag> boardTags = new ArrayList<>();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call alex.pkgBoardOperations.getBoardTags(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, boardID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                Tag tempTag = new Tag();
                tempTag = tempTag.getTagDetails(rs.getInt("tagID"));
                boardTags.add(tempTag);
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return boardTags;
    }

    public ArrayList<Tag> getStudentTags(int studentID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<Tag> boardTags = new ArrayList<>();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgTagOperations.getTagsStudentIsFollowing(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, studentID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                Tag tempTag = new Tag();
                tempTag = tempTag.getTagDetails(rs.getInt("tagID"));
                boardTags.add(tempTag);
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return boardTags;
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

    public String getBoardImageLocation() {
        return boardImageLocation;
    }

    public void setBoardImageLocation(String boardImageLocation) {
        this.boardImageLocation = boardImageLocation;
    }

    public int getParentBoardID() {
        return parentBoardID;
    }

    public void setParentBoardID(int parentBoardID) {
        this.parentBoardID = parentBoardID;
    }

    public int getBoardType() {
        return boardType;
    }

    public void setBoardType(int boardType) {
        this.boardType = boardType;
    }

    public int getBoardDepth() {
        return boardDepth;
    }

    public void setBoardDepth(int boardDepth) {
        this.boardDepth = boardDepth;
    }

    public int getBoardStatus() {
        return boardStatus;
    }

    public void setBoardStatus(int boardStatus) {
        this.boardStatus = boardStatus;
    }

    public ArrayList<Board> getBoardsParents() {
        return boardsParents;
    }

    public void setBoardsParents(ArrayList<Board> boardsParents) {
        this.boardsParents = boardsParents;
    }

    public ArrayList<Board> getBoardsChildren() {
        return boardsChildren;
    }

    public void setBoardsChildren(ArrayList<Board> boardsChildren) {
        this.boardsChildren = boardsChildren;
    }

    public ArrayList<SocialNetwork> getBoardSocialNetworkLinks() {
        return boardSocialNetworkLinks;
    }

    public void setBoardSocialNetworkLinks(ArrayList<SocialNetwork> boardSocialNetworkLinks) {
        this.boardSocialNetworkLinks = boardSocialNetworkLinks;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public String getAddressLine1() {
        return addressLine1;
    }

    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    public String getAddressLine2() {
        return addressLine2;
    }

    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    public String getWebPage() {
        return webPage;
    }

    public void setWebPage(String webPage) {
        this.webPage = webPage;
    }

    public String getTelNo1() {
        return telNo1;
    }

    public void setTelNo1(String telNo1) {
        this.telNo1 = telNo1;
    }

}