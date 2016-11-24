/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CartItem;
import model.DAL;

/**
 *
 * @author Duyet
 */
public class OrderServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();

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

        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Date date = new Date();

        HttpSession session = request.getSession();
        List<CartItem> list = new ArrayList();
        if (session.getAttribute("cart") != null) {
            HashMap<String, CartItem> sessionMap = (HashMap<String, CartItem>) session.getAttribute("cart");
            for (String key : sessionMap.keySet()) {
                list.add(sessionMap.get(key));
            }
        }
        request.setAttribute("list", list);
        request.setAttribute("date", dateFormat.format(date));
        request.getRequestDispatcher("checkout.jsp").forward(request, response);

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
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        DAL dal = new DAL();
        boolean res = false;

        String orderID = session.getId();
        String orderDateStr = request.getParameter("orderDate");
        int total = Integer.parseInt(request.getParameter("total"));
        String cusName = request.getParameter("cusName").trim();
        HashMap<String, CartItem> sessionMap = (HashMap<String, CartItem>) session.getAttribute("cart");
        if (sessionMap != null) {
            try {
                res = dal.saveOrder(orderID, orderDateStr, total, cusName);
                res &= dal.saveOrderDetails(orderID, sessionMap);                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        if (res) { 
            List<CartItem> list = new ArrayList();
            List info = new ArrayList();
            
            info.add(orderID);
            info.add(cusName);
            info.add(orderDateStr);
            info.add(total);
            
            for (String key : sessionMap.keySet()) {   
                list.add(sessionMap.get(key));
            }
            
            request.setAttribute("infoList", info);
            request.setAttribute("list", list);
            session.setAttribute("orderStatus", true);
            request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);            
        } else {
            session.setAttribute("orderStatus", false);
            request.getRequestDispatcher("orderError.jsp").forward(request, response);            
        }

        /*
         out.println("Post Order");
         out.println("<br/>Customer Name: " + cusName);
         out.println("<br/>Customer Name: " + orderDateStr);
         out.println("<br/>Customer Name: " + total);
         out.println("<br/>Customer Name: " + orderID);
         */
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
