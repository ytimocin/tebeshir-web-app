/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.servlet;

import com.tebeshir.dao.StudentLoginDAO;
import com.tebeshir.classes.Student;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class StudentLoginServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.lang.InstantiationException
     * @throws java.sql.SQLException
     * @throws java.lang.IllegalAccessException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, InstantiationException, IllegalAccessException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            StudentLoginDAO studentLogin = new StudentLoginDAO();
            int loginResult = studentLogin.login(request.getParameter("loginUserName"), request.getParameter("loginPassword"));

            if (loginResult == 0) {
                Student currentStudent = new Student();
                currentStudent = currentStudent.getStudentDetailsByLoginCredentials(request.getParameter("loginUserName"));
                HttpSession session = request.getSession(true);
                session.setAttribute("currentStudent", currentStudent);
                //RequestDispatcher dispatcher = request.getRequestDispatcher("/home/home.jsp");
                //dispatcher.forward(request, response);
                response.sendRedirect("home.jsp");
                return;
            } else {
                //request.setAttribute("loginError", "Wrong Combination!");
                //RequestDispatcher dispatcher = request.getRequestDispatcher("welcome.jsp");
                //dispatcher.forward(request, response);
                response.sendRedirect("welcome.jsp");
                return;
            }
        } catch (InstantiationException | IllegalAccessException | SQLException | IOException ex) {
            Logger.getLogger(LikePostServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
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
        } catch (Exception ex) {
            Logger.getLogger(StudentLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
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
        } catch (Exception ex) {
            Logger.getLogger(StudentLoginServlet.class.getName()).log(Level.SEVERE, "StudentLoginLog.txt", ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "StudentLoginServlet";
    }// </editor-fold>
}
