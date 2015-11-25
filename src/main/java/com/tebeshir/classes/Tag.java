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
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Vector;

/**
 *
 * @author yetkin.timocin
 */
public class Tag {
    
    private int tagID;
    private String tag;
    private int timesSearched;
    private int creatorID;
    private int ownerID;
    private Date insertDate;
    private Date lastUsedDate;
    private double rating;
    private int tagType;
    private int status;
    // önemli: bir etiket kaç ayrı postta geçmiş //
    private int distinctPostCount;
    private int tagFollowerCount;
    
    public ArrayList<Tag> getTagsOfThisPost(int postID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<Tag> tagsOfPost = new ArrayList<>();
        ResultSet resultSet = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgTagOperations.getTagsOfThisPost(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, postID);
            callableStatement.execute();
            resultSet = (ResultSet) callableStatement.getObject(1);
            while (resultSet.next()) {
                Tag tempTag = new Tag();
                tempTag = tempTag.getTagDetails(resultSet.getInt("tagID"));
                tagsOfPost.add(tempTag);
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(resultSet);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return tagsOfPost;
    }
    
    public Tag getTagDetails(int tagID) throws InstantiationException, IllegalAccessException, SQLException {
        Tag tempTag = new Tag();
        ResultSet resultSet = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgTagOperations.getTagDetails(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, tagID);
            callableStatement.execute();
            resultSet = (ResultSet) callableStatement.getObject(1);
            while (resultSet.next()) {
                tempTag.setTagID(resultSet.getInt("tagID"));
                tempTag.setTag(resultSet.getString("tag"));
                tempTag.setTimesSearched(resultSet.getInt("timesSearched"));
                tempTag.setCreatorID(resultSet.getInt("creatorID"));
                tempTag.setOwnerID(resultSet.getInt("creatorID"));
                tempTag.setInsertDate(resultSet.getTimestamp("tagPoolInsertDate"));
                tempTag.setLastUsedDate(resultSet.getTimestamp("lastUsedDate"));
                tempTag.setRating(resultSet.getDouble("rating"));
                tempTag.setTagType(resultSet.getInt("tagType"));
                tempTag.setStatus(resultSet.getInt("status"));
                tempTag.setDistinctPostCount(resultSet.getInt("tagOccurence"));
                tempTag.setTagFollowerCount(resultSet.getInt("tagFollowerCount"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(resultSet);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return tempTag;
    }
    
    public ArrayList<Student> getTagFollowers(int tagID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<Student> tagFollowers = new ArrayList<>();
        ResultSet resultSet = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgTagOperations.getTagFollowers(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, tagID);
            callableStatement.execute();
            resultSet = (ResultSet) callableStatement.getObject(1);
            while (resultSet.next()) {
                Student tempStudent = new Student();
                tempStudent = tempStudent.getStudentById(resultSet.getInt("studentID"));
                tagFollowers.add(tempStudent);
            }
        } catch (IllegalAccessException | InstantiationException | SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(resultSet);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return tagFollowers;
    }
    
    public int getTagID() {
        return tagID;
    }
    
    public void setTagID(int tagID) {
        this.tagID = tagID;
    }
    
    public String getTag() {
        return tag;
    }
    
    public void setTag(String tag) {
        this.tag = tag;
    }
    
    public int getTimesSearched() {
        return timesSearched;
    }
    
    public void setTimesSearched(int timesSearched) {
        this.timesSearched = timesSearched;
    }
    
    public int getCreatorID() {
        return creatorID;
    }
    
    public void setCreatorID(int creatorID) {
        this.creatorID = creatorID;
    }
    
    public Date getInsertDate() {
        return insertDate;
    }
    
    public void setInsertDate(Date insertDate) {
        this.insertDate = insertDate;
    }
    
    public Date getLastUsedDate() {
        return lastUsedDate;
    }
    
    public void setLastUsedDate(Date lastUsedDate) {
        this.lastUsedDate = lastUsedDate;
    }
    
    public double getRating() {
        return rating;
    }
    
    public void setRating(double rating) {
        this.rating = rating;
    }
    
    public int getTagType() {
        return tagType;
    }
    
    public void setTagType(int tagType) {
        this.tagType = tagType;
    }
    
    public int getStatus() {
        return status;
    }
    
    public void setStatus(int status) {
        this.status = status;
    }
    
    public int getOwnerID() {
        return ownerID;
    }
    
    public void setOwnerID(int ownerID) {
        this.ownerID = ownerID;
    }
    
    public int getDistinctPostCount() {
        return distinctPostCount;
    }
    
    public void setDistinctPostCount(int distinctPostCount) {
        this.distinctPostCount = distinctPostCount;
    }
    
    public int getTagFollowerCount() {
        return tagFollowerCount;
    }
    
    public void setTagFollowerCount(int followerCount) {
        this.tagFollowerCount = followerCount;
    }
}