/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.classes;

import java.sql.SQLException;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author yetkin.timocin
 */
public class StudentActivity {

    private int activityID;
    private int studentID;
    private java.util.Date activityTime;
    private int activityType;
    private int objectID;

    public int getActivityID() {
        return activityID;
    }

    public void setActivityID(int activityID) {
        this.activityID = activityID;
    }

    public int getStudentID() {
        return studentID;
    }

    public void setStudentID(int studentID) {
        this.studentID = studentID;
    }

    public Date getActivityTime() {
        return activityTime;
    }

    public void setActivityTime(Date activityTime) {
        this.activityTime = activityTime;
    }

    public int getActivityType() {
        return activityType;
    }

    public void setActivityType(int activityType) {
        this.activityType = activityType;
    }

    public int getObjectID() {
        return objectID;
    }

    public void setObjectID(int objectID) {
        this.objectID = objectID;
    }

    public String toString() {
        String result = null;
        try {
            Student tempStudent = new Student();
            tempStudent = tempStudent.getStudentById(this.studentID);
            if (this.activityType == 1) {
                result = tempStudent.getUsername() + " followed post with id " + this.objectID;
            } else if (this.activityType == 2) {
                result = tempStudent.getUsername() + " unfollowed post with id " + this.objectID;
            } else if (this.activityType == 3) {
                result = tempStudent.getUsername() + " liked post with id " + this.objectID;
            } else if (this.activityType == 4) {
                result = tempStudent.getUsername() + " unliked post with id " + this.objectID;
            } else if (this.activityType == 5) {
                result = tempStudent.getUsername() + " followed tag with id " + this.objectID;
            } else if (this.activityType == 4) {
                result = tempStudent.getUsername() + " unfollowed tag with id " + this.objectID;
            }
        } catch (InstantiationException ex) {
            Logger.getLogger(StudentActivity.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(StudentActivity.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(StudentActivity.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
}
