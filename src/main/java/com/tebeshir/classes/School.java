package com.tebeshir.classes;

import com.tebeshir.dao.PostgresConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Vector;

public class School {

    private int schoolID;
    private String schoolName;
    private CallableStatement callStmt;

    public ArrayList<School> getAllActiveSchools() throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<School> allSchools = new ArrayList<>();
        PostgresConnection pgConn = new PostgresConnection();
        ResultSet rs;
        try (Connection dbConn = PostgresConnection.getConnection()) {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call alex.pkgTebeshirAdmin.allSchools()}");
            callStmt.registerOutParameter(1, java.sql.Types.OTHER);
            callStmt.execute();
            rs = (ResultSet) callStmt.getObject(1);
            while (rs.next()) {
                School newSchool = new School();
                newSchool.setSchoolID(rs.getInt("boardID"));
                newSchool.setSchoolName(rs.getString("boardName"));
                allSchools.add(newSchool);
            }   PostgresConnection.closeConnection(dbConn);
        }
        callStmt.close();
        rs.close();
        return allSchools;
    }

    public String getSchoolName(int boardID) throws InstantiationException, IllegalAccessException, SQLException {
        String schoolName = null;
        PostgresConnection pgConn = new PostgresConnection();
        Connection dbConn = PostgresConnection.getConnection();
        try {
            dbConn.setAutoCommit(false);
            callStmt = dbConn.prepareCall("{? = call alex.pkgTebeshirAdmin.getSchoolNameByID(?)}");
            callStmt.registerOutParameter(1, java.sql.Types.VARCHAR);
            callStmt.setInt(2, boardID);
            callStmt.execute();
            schoolName = (String) callStmt.getObject(1);
        } catch (SQLException ex) {
        } finally {
            callStmt.close();
            PostgresConnection.closeConnection(dbConn);
        }
        return schoolName;
    }

    public int getSchoolID() {
        return schoolID;
    }

    public void setSchoolID(int schoolID) {
        this.schoolID = schoolID;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public CallableStatement getCallStmt() {
        return callStmt;
    }

    public void setCallStmt(CallableStatement callStmt) {
        this.callStmt = callStmt;
    }
}
