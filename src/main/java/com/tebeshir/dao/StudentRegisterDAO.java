/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class StudentRegisterDAO {

    private String schoolName;
    private String schoolCounty;
    private String schoolCity;
    private String schoolCountry;
    private String schoolContinent;
    private CallableStatement callStmt;

    public int registerNewStudent(String userName, String userMail, String password, String school) throws InstantiationException, IllegalAccessException, SQLException {
        int result = 0;
        PostgresConnection pgConn = new PostgresConnection();
        Connection dbConn = pgConn.getConnection();
        callStmt = dbConn.prepareCall("{? = call alex.pkgTebeshirAdmin.getSchoolIdByName(?)}");
        callStmt.registerOutParameter(1, java.sql.Types.NUMERIC);
        callStmt.setString(2, school);
        callStmt.execute();
        int schoolID = callStmt.getBigDecimal(1).intValue();
        pgConn.closeConnection(dbConn);
        dbConn.close();
        if (schoolID == 0) {
            return -1;
        }
        pgConn = new PostgresConnection();
        dbConn = pgConn.getConnection();
        dbConn.setAutoCommit(false);
        callStmt = dbConn.prepareCall("{? = call doutzen.pkgStudentRegistration.firstTimeRegistration(?, ?, ?, ?)}");
        callStmt.registerOutParameter(1, java.sql.Types.NUMERIC);
        callStmt.setString(2, userName);
        callStmt.setString(3, userMail);
        callStmt.setString(4, password);
        callStmt.setInt(5, schoolID);
        callStmt.execute();
        result = callStmt.getBigDecimal(1).intValue();
        if (result <= 0) {
            dbConn.rollback();
            result = -1;
        } else {
            dbConn.commit();
        }
        PostgresConnection.closeConnection(dbConn);
        dbConn.close();
        callStmt.close();
        return result;
    }
}