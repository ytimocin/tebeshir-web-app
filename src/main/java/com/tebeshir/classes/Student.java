/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.classes;

import com.tebeshir.dao.PostgresConnection;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Student {

    private int studentID;
    private String username;
    private String mail;
    private String password;
    private int schoolID;
    private int status;
    private Date registrationDate;
    private ArrayList<Post> posts;

    public Student getStudentDetailsByLoginCredentials(String loginCredential) throws InstantiationException, IllegalAccessException, SQLException {
        Student tempStudent = new Student();
        Connection dbConn = PostgresConnection.getConnection();
        ResultSet rs = null;
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call doutzen.pkgStudentOperations.getStudentDetails(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setString(2, loginCredential);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                tempStudent.setStudentID(rs.getInt("studentID"));
                tempStudent.setUsername(rs.getString("userName"));
                tempStudent.setMail(rs.getString("eMail"));
                tempStudent.setSchoolID(rs.getInt("school"));
                tempStudent.setStatus(rs.getInt("status"));
                tempStudent.setRegistrationDate(rs.getDate("registrationDate"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return tempStudent;
    }

    public Student getStudentById(int studentID) throws InstantiationException, IllegalAccessException, SQLException {
        Student tempStudent = new Student();
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        ResultSet rs = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call doutzen.pkgStudentOperations.getStudentDetailsByID(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, studentID);
            callableStatement.execute();
            rs = (ResultSet) callableStatement.getObject(1);
            while (rs.next()) {
                tempStudent.setStudentID(rs.getInt("studentID"));
                tempStudent.setUsername(rs.getString("userName"));
                tempStudent.setMail(rs.getString("eMail"));
                tempStudent.setSchoolID(rs.getInt("school"));
                tempStudent.setStatus(rs.getInt("status"));
                tempStudent.setRegistrationDate(rs.getDate("registrationDate"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return tempStudent;
    }

    public ArrayList<Post> getStudentPosts(int studentID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<Post> studentPosts = new ArrayList<>();
        PostTag tempPostTag = new PostTag();
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        ResultSet rs = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgPostOperations.allMessagesOfAStudent(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, studentID);
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
                tempPost.setPostTags(tempPostTag.getTagsOfThisPost(tempPost.getPostID()));
                studentPosts.add(tempPost);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(rs);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return studentPosts;
    }

    public ArrayList<String> getStudentActivities(int studentID) throws InstantiationException, IllegalAccessException, SQLException {
        ArrayList<String> studentActivities = new ArrayList<>();
        Connection dbConn = PostgresConnection.getConnection();
        ResultSet resultSet = null;
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call doutzen.pkgStudentOperations.getStudentActivities(?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.OTHER);
            callableStatement.setInt(2, studentID);
            callableStatement.execute();
            resultSet = (ResultSet) callableStatement.getObject(1);
            while (resultSet.next()) {
                StudentActivity tempStudentActivity = new StudentActivity();
                tempStudentActivity.setActivityID(resultSet.getInt("activity_id"));
                tempStudentActivity.setStudentID(resultSet.getInt("student_id"));
                tempStudentActivity.setActivityTime(resultSet.getDate("activity_time"));
                tempStudentActivity.setActivityType(resultSet.getInt("activity_type"));
                tempStudentActivity.setObjectID(resultSet.getInt("object_id"));
                String result = tempStudentActivity.toString();
                studentActivities.add(result);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeResultSet(resultSet);
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return studentActivities;
    }

    public boolean amIFollowingThisTag(int tagID, int studentID) throws InstantiationException, IllegalAccessException, SQLException {
        boolean result = false;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgTagOperations.isUserFollowingThisTag(?, ?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.NUMERIC);
            callableStatement.setInt(2, tagID);
            callableStatement.setInt(3, studentID);
            callableStatement.execute();
            result = (callableStatement.getBigDecimal(1).intValue() == 0);
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return result;
    }

    public boolean amIFollowingThisPost(int postID) throws InstantiationException, IllegalAccessException, SQLException {
        boolean result = false;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgPostOperations.isUserFollowingThisPost(?, ?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.NUMERIC);
            callableStatement.setInt(2, postID);
            callableStatement.setInt(3, this.studentID);
            callableStatement.execute();
            result = (callableStatement.getBigDecimal(1).intValue() == 0);
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return result;
    }

    public boolean didILikeThisPost(int postID) throws InstantiationException, IllegalAccessException, SQLException {
        boolean result = false;
        Connection dbConn = PostgresConnection.getConnection();
        CallableStatement callableStatement = null;
        try {
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call behati.pkgPostOperations.didUserLikeThisPost(?, ?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.NUMERIC);
            callableStatement.setInt(2, postID);
            callableStatement.setInt(3, this.studentID);
            callableStatement.execute();
            result = (callableStatement.getBigDecimal(1).intValue() == 0);
        } catch (SQLException ex) {
            ex.printStackTrace(System.err);
        } finally {
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return result;
    }

    public boolean updatePassword(int studentID, String newPassword) {
        boolean result = false;
        Connection dbConn = null;
        CallableStatement callableStatement = null;
        try {
            dbConn = PostgresConnection.getConnection();
            dbConn.setAutoCommit(false);
            callableStatement = dbConn.prepareCall("{? = call doutzen.pkgStudentOperations.updatePassword(?, ?)}");
            callableStatement.registerOutParameter(1, java.sql.Types.NUMERIC);
            callableStatement.setInt(2, studentID);
            callableStatement.setString(3, newPassword);
            callableStatement.execute();
            result = (callableStatement.getBigDecimal(1).intValue() == 0);
        } catch (SQLException | InstantiationException | IllegalAccessException ex) {
            Logger.getLogger(Student.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            PostgresConnection.closeStatement(callableStatement);
            PostgresConnection.commit(dbConn);
            PostgresConnection.closeConnection(dbConn);
        }
        return result;
    }

    public static void main(String args[]) throws InstantiationException, IllegalAccessException, SQLException {
        Student tempStudent = new Student();
        boolean result = tempStudent.amIFollowingThisTag(1, 1);
        System.out.println("result: " + result);
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getRegistrationDate() {
        return registrationDate;
    }

    public void setRegistrationDate(Date registrationDate) {
        this.registrationDate = registrationDate;
    }

    public int getSchoolID() {
        return schoolID;
    }

    public void setSchoolID(int schoolID) {
        this.schoolID = schoolID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public ArrayList<Post> getPosts() {
        return posts;
    }

    public void setPosts(ArrayList<Post> posts) {
        this.posts = posts;
    }
}