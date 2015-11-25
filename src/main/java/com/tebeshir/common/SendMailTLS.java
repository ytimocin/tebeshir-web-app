/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.common;

import com.tebeshir.classes.Student;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author yeko
 */
public class SendMailTLS {

    public int forgotPasswordMail(String email) {
        
        int returnResult = 1;
        
        try {
            
            Student student = new Student();
            student = student.getStudentDetailsByLoginCredentials(email);
            
            if (student != null) {
                returnResult = sendMail(student, email);
                // -1 : db error
                // -2 : update password error
            }
            else {
                returnResult = -3;
                // -3 : email not exists
            }
        } catch (InstantiationException | IllegalAccessException | SQLException ex) {
            Logger.getLogger(SendMailTLS.class.getName()).log(Level.SEVERE, null, ex);
        }
        return returnResult;
    }
    
    
    public int sendMail(Student student, String email) {
        
        int returnResult = -1;
        
        final String username = "info@tebeshir.com";
        final String password = "19yeko07Fener";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    @Override
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });
        
        String newPassword = String.valueOf(Long.toHexString(Double.doubleToLongBits(Math.random())));
        
        boolean updatePasswordResult = student.updatePassword(student.getStudentID(), newPassword);
        
        if (updatePasswordResult) {
            
            try {
                MimeMessage message = new MimeMessage(session);
                message.setFrom(new InternetAddress("info@tebeshir.com"));
                message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
                message.setSubject("Tebeshir Password Recovery");
                message.setText("Hello " + student.getUsername() + ",<br/><br/>You requested a new password.<br/>If you did not make"
                        + " this request click here.<br/>Your new password is " + newPassword + "<br/>"
                        + "<br/>Tebeshir Team", "utf-8", "html");
                
                Transport.send(message);
                returnResult = 0;
            } catch (MessagingException ex) {
                Logger.getLogger(SendMailTLS.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        } else {
            // update password invalid
            returnResult = -2;
        }
        
        return returnResult;
        
    }

}
