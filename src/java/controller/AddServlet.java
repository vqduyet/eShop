/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CartItem;
import model.DAL;
import model.Product;

/**
 *
 * @author Duyet
 */
public class AddServlet extends HttpServlet {

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
        
        HttpSession session = request.getSession();
        String productID = request.getParameter("id");
        int qty = Integer.parseInt(request.getParameter("qty"));
        
        HashMap itemArray = new HashMap();
        DAL dal = new DAL();
        Product product = dal.getById(productID);
        if (product.getProductID().equals(productID)) {
            CartItem cartItem = new CartItem(product.getProductID(), product.getProductName(), product.getPrice(), qty);
            itemArray.put(productID, cartItem);
        }

        if (session.getAttribute("cart") != null) {
            HashMap<String, CartItem> sessionMap = (HashMap<String, CartItem>) session.getAttribute("cart");
            if (sessionMap.containsKey(productID)) {
                int quantity = sessionMap.get(productID).getQuantity();
                sessionMap.get(productID).setQuantity(qty);                
            } else {
                sessionMap.putAll(itemArray);                
            }            
            session.setAttribute("cart", sessionMap);            
        } else {
            session.setAttribute("cart", itemArray);
        }
        request.getRequestDispatcher("ListServlet").forward(request, response);
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
