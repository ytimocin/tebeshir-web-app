/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tebeshir.servlet;

import com.tebeshir.dao.LikePostDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author yetkin.timocin
 */
public class UnlikePostServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            int postID = Integer.valueOf(request.getParameter("postID"));
            int unlikerID = Integer.valueOf(request.getParameter("unlikerID"));
            String returnPage = request.getParameter("returnPage");
            LikePostDAO unlikePost = new LikePostDAO();
            int result = unlikePost.unlikePost(postID, unlikerID);
            if (result == 0) {
                //request.setAttribute("unlikePostMessage", "unliked...");
                //RequestDispatcher dispatcher = request.getRequestDispatcher(returnPage);
                //dispatcher.forward(request, response);
                response.sendRedirect(returnPage);
                return;
            } else {
                //request.setAttribute("unlikePostMessage", "ooppss!");
                //RequestDispatcher dispatcher = request.getRequestDispatcher(returnPage);
                //dispatcher.forward(request, response);
                response.sendRedirect(returnPage);
                return;
            }
        } catch (InstantiationException | IllegalAccessException | SQLException ex) {
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
        processRequest(request, response);
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
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
