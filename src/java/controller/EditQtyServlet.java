/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CartItem;
import com.google.gson.*;

/**
 *
 * @author Duyet
 */


public class EditQtyServlet extends HttpServlet {

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
        //get parameters
        String productID = request.getParameter("code");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        //process edit quantity
        int total_price = 0;
        int subtotal = 0;
        HashMap<String, CartItem> sessionMap = (HashMap<String, CartItem>) session.getAttribute("cart");
        CartItem itemEdit = sessionMap.get(productID);
        if (itemEdit != null) {
            if (quantity == 0) {
                sessionMap.remove(productID);
            } else {
                sessionMap.get(productID).setQuantity(quantity);
                subtotal = sessionMap.get(productID).getPrice() * quantity;
            }
        }
        //reset session cart
        if (sessionMap.size() > 0) {
            for (String key : sessionMap.keySet()) {
                total_price += sessionMap.get(key).getPrice() * sessionMap.get(key).getQuantity();
            }
            session.setAttribute("cart", sessionMap);
        } else {
            session.removeAttribute("cart");
        }
        //transfer data to json using Gson package
        List result = new ArrayList();
        if (total_price > 0 && subtotal > 0) {
            result.add(0, total_price);
            result.add(1, subtotal);
        }
        String json = new Gson().toJson(result);
        response.setContentType("application/json");
        response.getWriter().write(json);

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
