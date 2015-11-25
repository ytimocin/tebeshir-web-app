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
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author yetkin.timocin
 */
public class PostTag implements Serializable {

    private int tagId;
    private int postId;
    private Date postTagInsertDate;
    private int status;
    private String tag;
    private int timesSearched;
    private int creatorID;
    private Date tagPoolInsertDate;
    private Date lastUsedDate;
    private double rating;
    private int tagType;

    public ArrayList<PostTag> getTagsOfThisPost(int postID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<PostTag> tagsOfPost = new ArrayList<>();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgTagOperations.getTagsOfThisPost(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, postID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                PostTag tempPostTag = new PostTag();
                tempPostTag.setTagId(rs.getInt("tagID"));
                tempPostTag.setPostId(rs.getInt("postID"));
                tempPostTag.setPostTagInsertDate(rs.getDate("postTagInsertDate"));
                tempPostTag.setStatus(rs.getInt("status"));
                tempPostTag.setTag(rs.getString("tag"));
                tempPostTag.setTimesSearched(rs.getInt("timesSearched"));
                tempPostTag.setCreatorID(rs.getInt("creatorID"));
                tempPostTag.setTagPoolInsertDate(rs.getDate("tagPoolInsertDate"));
                tempPostTag.setLastUsedDate(rs.getDate("lastUsedDate"));
                tempPostTag.setRating(rs.getDouble("rating"));
                tempPostTag.setTagType(rs.getInt("tagType"));
                tagsOfPost.add(tempPostTag);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return tagsOfPost;
    }

    public PostTag getTagDetails(int tagID) throws InstantiationException, IllegalAccessException, SQLException {
        PostTag tempPostTag = new PostTag();
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgTagOperations.getTagDetails(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, tagID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                tempPostTag.setTagId(rs.getInt("tagID"));
                tempPostTag.setPostId(rs.getInt("postID"));
                tempPostTag.setPostTagInsertDate(rs.getDate("postTagInsertDate"));
                tempPostTag.setStatus(rs.getInt("status"));
                tempPostTag.setTag(rs.getString("tag"));
                tempPostTag.setTimesSearched(rs.getInt("timesSearched"));
                tempPostTag.setCreatorID(rs.getInt("creatorID"));
                tempPostTag.setTagPoolInsertDate(rs.getDate("tagPoolInsertDate"));
                tempPostTag.setLastUsedDate(rs.getDate("lastUsedDate"));
                tempPostTag.setRating(rs.getDouble("rating"));
                tempPostTag.setTagType(rs.getInt("tagType"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return tempPostTag;
    }

    public int getTagId() {
        return tagId;
    }

    public void setTagId(int tagId) {
        this.tagId = tagId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public Date getPostTagInsertDate() {
        return postTagInsertDate;
    }

    public void setPostTagInsertDate(Date postTagInsertDate) {
        this.postTagInsertDate = postTagInsertDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
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

    public Date getTagPoolInsertDate() {
        return tagPoolInsertDate;
    }

    public void setTagPoolInsertDate(Date tagPoolInsertDate) {
        this.tagPoolInsertDate = tagPoolInsertDate;
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
}