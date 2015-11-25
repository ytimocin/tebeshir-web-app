/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.classes;

import com.tebeshir.dao.PostgresConnection;
import java.io.Serializable;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 *
 * @author yetkin.timocin
 */
public class Post implements Serializable, Comparable<Post> {

    private int postID;
    private int studentID;
    private int mainBoardID;
    private String originalMessage;
    private Timestamp insertDate;
    private int status;
    private ArrayList<PostTag> postTags;
    private ArrayList<PostComment> postComments;
    private int likerCount;
    private int commenterCount;
    private int followerCount;

    public ArrayList<Post> getAllMessagesOfThisBoard(int boardID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<Post> allMessages = new ArrayList<>();
        PostTag tempPostTag = new PostTag();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgPostOperations.allMessagesOfThisBoard(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, boardID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                Post tempPost = new Post();
                tempPost.setPostID(rs.getInt("postID"));
                tempPost.setStudentID(rs.getInt("studentID"));
                tempPost.setMainBoardID(rs.getInt("mainBoardID"));
                tempPost.setOriginalMessage(rs.getString("originalMessage"));
                tempPost.setInsertDate(rs.getTimestamp("insertDate"));
                tempPost.setStatus(rs.getInt("status"));
                tempPost.setPostTags(tempPostTag.getTagsOfThisPost(tempPost.postID));
                tempPost.setLikerCount(rs.getInt("postLikerCount"));
                tempPost.setFollowerCount(rs.getInt("postFollowerCount"));
                tempPost.setCommenterCount(rs.getInt("postCommenterCount"));
                allMessages.add(tempPost);
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return allMessages;
    }
    
    public ArrayList<PostComment> getAllCommentsOfThisPost(int postID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<PostComment> postsComments = new ArrayList<>();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgPostOperations.getCommentsOfThisPost(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, postID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                PostComment postComment = new PostComment();
                postComment.setCommentID(rs.getInt("commentid"));
                postComment.setPostID(rs.getInt("postid"));
                postComment.setStudentID(rs.getInt("studentid"));
                postComment.setStudentComment(rs.getString("studentcomment"));
                postComment.setInsertDate(rs.getDate("insertdate"));
                postComment.setStatus(rs.getInt("status"));
                postsComments.add(postComment);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return postsComments;
    }
    
    public Post getPostDetailsByID(int postID) throws InstantiationException, IllegalAccessException, SQLException {
        Post returnPost = new Post();
        PostTag tempPostTag = new PostTag();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgPostOperations.getPostDetailsByID(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, postID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                returnPost.setPostID(rs.getInt("postID"));
                returnPost.setStudentID(rs.getInt("studentID"));
                returnPost.setMainBoardID(rs.getInt("mainBoardID"));
                returnPost.setOriginalMessage(rs.getString("originalMessage"));
                returnPost.setInsertDate(rs.getTimestamp("insertDate"));
                returnPost.setStatus(rs.getInt("status"));
                returnPost.setPostTags(tempPostTag.getTagsOfThisPost(returnPost.postID));
                returnPost.setLikerCount(rs.getInt("postLikerCount"));
                returnPost.setFollowerCount(rs.getInt("postFollowerCount"));
                returnPost.setCommenterCount(rs.getInt("postCommenterCount"));
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return returnPost;
    }

    public ArrayList<Post> getAllMessagesOfThisBoardWithFilter(int boardID, int tagID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<Post> allMessages = new ArrayList<>();
        PostTag tempPostTag = new PostTag();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgPostOperations.allMessagesOfThisBoardWithFilter(?, ?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, boardID);
            callableStatement.setInt(3, tagID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                Post tempPost = new Post();
                tempPost.setPostID(rs.getInt("postID"));
                tempPost.setStudentID(rs.getInt("studentID"));
                tempPost.setMainBoardID(rs.getInt("mainBoardID"));
                tempPost.setOriginalMessage(rs.getString("originalMessage"));
                tempPost.setInsertDate(rs.getTimestamp("insertDate"));
                tempPost.setStatus(rs.getInt("status"));
                tempPost.setPostTags(tempPostTag.getTagsOfThisPost(tempPost.postID));
                allMessages.add(tempPost);
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return allMessages;
    }
    
    public ArrayList<Student> getPostFollowers(int postID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<Student> postFollowers = new ArrayList<>();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgPostOperations.getPostFollowers(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, postID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                Student tempStudent = new Student();
                tempStudent = tempStudent.getStudentById(rs.getInt("studentID"));
                postFollowers.add(tempStudent);
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return postFollowers;
    }
    
    public ArrayList<Student> getPostLikers(int postID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<Student> postLikers = new ArrayList<>();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgPostOperations.getPostLikers(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, postID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                Student tempStudent = new Student();
                tempStudent = tempStudent.getStudentById(rs.getInt("studentID"));
                postLikers.add(tempStudent);
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return postLikers;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public int getMainBoardID() {
        return mainBoardID;
    }

    public void setMainBoardID(int mainBoardID) {
        this.mainBoardID = mainBoardID;
    }

    public String getOriginalMessage() {
        return originalMessage;
    }

    public void setOriginalMessage(String originalMessage) {
        this.originalMessage = originalMessage;
    }

    public Timestamp getInsertDate() {
        return insertDate;
    }

    public void setInsertDate(Timestamp insertDate) {
        this.insertDate = insertDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public ArrayList<PostTag> getPostTags() {
        return postTags;
    }

    public void setPostTags(ArrayList<PostTag> postTags) {
        this.postTags = postTags;
    }

    public ArrayList<PostComment> getPostComments() {
        return postComments;
    }

    public void setPostComments(ArrayList<PostComment> postComments) {
        this.postComments = postComments;
    }

    public int getLikerCount() {
        return likerCount;
    }

    public void setLikerCount(int likeCount) {
        this.likerCount = likeCount;
    }

    public int getCommenterCount() {
        return commenterCount;
    }

    public void setCommenterCount(int commentCount) {
        this.commenterCount = commentCount;
    }

    public int getFollowerCount() {
        return followerCount;
    }

    public void setFollowerCount(int followerCount) {
        this.followerCount = followerCount;
    }
    
    @Override
    public int compareTo(Post post) {
        return getInsertDate().compareTo(post.getInsertDate());
    }

}