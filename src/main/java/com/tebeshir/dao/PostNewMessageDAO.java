/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.dao;

import com.tebeshir.cache.PostCache;
import com.tebeshir.classes.Post;
import com.tebeshir.classes.Student;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author yetkin.timocin
 */
public class PostNewMessageDAO {

    private CallableStatement callStmt;

    public int postNewMessage(Student postOwner, String post) throws InstantiationException, IllegalAccessException, SQLException {
        int result = -1;
        ResultSet rs = null;
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call behati.pkgPostOperations.newPost(?, ?, ?, ?)}");
            callStmt.registerOutParameter(1, java.sql.Types.NUMERIC);
            callStmt.setInt(2, postOwner.getStudentID());
            callStmt.setInt(3, postOwner.getSchoolID());
            callStmt.setString(4, post);
            callStmt.setString(5, "ip");
            callStmt.execute();
            result = callStmt.getBigDecimal(1).intValue();
            if (result > 0) {
                PostgresConnection.commit(dbConn);
                PostCache postCache = new PostCache();
                Post postTemp = new Post();
                postCache.putToMap(postTemp.getPostDetailsByID(result));
            }
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
