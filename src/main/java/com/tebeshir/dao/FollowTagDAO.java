/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.tebeshir.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author yeko
 */
public class FollowTagDAO {

    public int followTag(int tagID, int followerID) throws InstantiationException, IllegalAccessException, SQLException {
        int result = -1;
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callStmt = null;
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call behati.pkgTagOperations.followTag(?, ?)}");
            callStmt.registerOutParameter(1, java.sql.Types.NUMERIC);
            callStmt.setInt(2, tagID);
            callStmt.setInt(3, followerID);
            callStmt.execute();
            result = callStmt.getBigDecimal(1).intValue();
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callStmt);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return result;
    }

    public int unfollowTag(int tagID, int unfollowerID) throws InstantiationException, IllegalAccessException, SQLException {
        int result = -1;
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callStmt = null;
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call behati.pkgTagOperations.unfollowTag(?, ?)}");
            callStmt.registerOutParameter(1, java.sql.Types.NUMERIC);
            callStmt.setInt(2, tagID);
            callStmt.setInt(3, unfollowerID);
            callStmt.execute();
            result = callStmt.getBigDecimal(1).intValue();
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callStmt);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return result;
    }
    
}
