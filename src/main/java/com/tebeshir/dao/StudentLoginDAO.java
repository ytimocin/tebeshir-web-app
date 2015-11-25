/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class StudentLoginDAO {

    private CallableStatement callStmt;

    public int login(String userName, String password) throws InstantiationException, IllegalAccessException, SQLException {
        int result = 0;
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call doutzen.pkgStudentAuthentication.studentLogin(?, ?)}");
            callStmt.registerOutParameter(1, java.sql.Types.NUMERIC);
            callStmt.setString(2, userName);
            callStmt.setString(3, password);
            callStmt.execute();
            result = callStmt.getBigDecimal(1).intValue();
            callStmt.close();
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeStatement(callStmt);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return result;
    }
}
