/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.servlet;

import com.tebeshir.cache.PostCache;
import com.tebeshir.classes.Student;
import com.tebeshir.dao.PostNewMessageDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author yetkin.timocin
 */
public class PostNewMessage extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.InstantiationException
     * @throws java.lang.IllegalAccessException
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, InstantiationException, IllegalAccessException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try {

            Student currentStudent = new Student();
            HttpSession currentSession = request.getSession();

            if (currentSession.getAttribute("currentStudent") == null) {
                RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp?message=SessionExpired");
                dispatcher.forward(request, response);
            } else {
                currentStudent = (Student) currentSession.getAttribute("currentStudent");
            }

            String newPost = (String) request.getParameter("newPost");
            
            String returnPage = request.getParameter("returnPage");
            
            if (request.getParameter("tagID") != null) {
                returnPage = returnPage  + "&tagID=" + request.getParameter("tagID");
            }

            PostNewMessageDAO newMsg = new PostNewMessageDAO();
            int result = newMsg.postNewMessage(currentStudent, newPost);

            if (result != 0) {
                request.setAttribute("postNewMessage", "oopss...");
                response.sendRedirect(returnPage);
                return;
            } else {
                request.setAttribute("postNewMessage", "posted...");
                response.sendRedirect(returnPage);
                return;
            }

        } catch (ServletException | IOException | InstantiationException | IllegalAccessException | SQLException ex) {
            Logger.getLogger(LikePostServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (InstantiationException ex) {
            Logger.getLogger(PostNewMessage.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(PostNewMessage.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(PostNewMessage.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (InstantiationException ex) {
            Logger.getLogger(PostNewMessage.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(PostNewMessage.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(PostNewMessage.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Post New Message";
    }// </editor-fold>
}
