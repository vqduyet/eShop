/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 *
 * @author Duyet
 */
public class DAL {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public Connection getConn() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://localhost:1433;database=eShop";
            conn = DriverManager.getConnection(url, "sa", "abc123");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    public List showAll() {
        List list = new ArrayList();
        try {
            conn = getConn();
            String sql = "select * from Product";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getString(1));
                product.setProductName(rs.getString(2));
                product.setPrice(rs.getInt(3));
                list.add(product);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Product getById(String proID) {
        Product product = new Product();
        try {
            conn = getConn();
            String sql = "select * from Product where productID = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, proID);
            rs = ps.executeQuery();
            while (rs.next()) {
                product.setProductID(rs.getString(1));
                product.setProductName(rs.getString(2));
                product.setPrice(rs.getInt(3));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return product;
    }

    public boolean saveOrder(String orderID, String orderDateStr, int total, String cusName) throws ParseException {
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Date orderDate = dateFormat.parse(orderDateStr);
        java.sql.Date sqlDate = new java.sql.Date(orderDate.getTime());
        conn = getConn();
        String sql = "insert into Orders values(?,?,?,?)";
        try {
            ps = conn.prepareStatement(sql);
            ps.setString(1, orderID);
            ps.setDate(2, sqlDate);
            ps.setInt(3, total);
            ps.setString(4, cusName);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
        }
        return false;
    }

    public boolean saveOrderDetails(String orderID, HashMap<String, CartItem> sessionMap) {
        conn = getConn();
        int count = 0;
        String sql = "insert into OrderDeatails values(?,?,?,?)";
        if (sessionMap != null) {
            for (String key : sessionMap.keySet()) {
                try {
                    ps = conn.prepareStatement(sql);
                    ps.setString(1, orderID);
                    ps.setString(2, sessionMap.get(key).getProductID());                    
                    ps.setInt(3, sessionMap.get(key).getQuantity());
                    ps.setInt(4, sessionMap.get(key).getQuantity() * sessionMap.get(key).getPrice());
                    ps.executeUpdate();
                    count++;
                } catch (Exception e) {
                }
            }
        }
        return count > 0;        
    }
    
    public List searchOrder(String orderIDStr){
        List list = new ArrayList();
        ArrayList arrInfo = null;     
        
        conn = getConn();
        String sqlInfo = "select * from Orders where orderID=?";        
        try {
            ps = conn.prepareStatement(sqlInfo);
            ps.setString(1, orderIDStr);
            rs = ps.executeQuery();
            while (rs.next()) {
                arrInfo = new ArrayList();
                arrInfo.add(rs.getString(1));
                arrInfo.add(rs.getDate(2));
                arrInfo.add(rs.getInt(3));
                arrInfo.add(rs.getString(4));
                list.add(arrInfo);
            }   
        } catch (Exception e) {
        }
        return list;
    }
    
    public List searchOrderDetails(String orderIDStr){
        List list = new ArrayList();        
        ArrayList arrDetails = null;
        
        conn = getConn();        
        String sqlDetails = "select o.orderID, o.productID, p.productName, p.price, o.amount, o.totalAmount from OrderDeatails o, Product p where o.productID = p.productID and o.orderID =?";
        try {
            ps = conn.prepareStatement(sqlDetails);
            ps.setString(1, orderIDStr);
            rs = ps.executeQuery();
            while (rs.next()) {
                arrDetails = new ArrayList();
                arrDetails.add(rs.getString(2));
                arrDetails.add(rs.getString(3));
                arrDetails.add(rs.getInt(4));
                arrDetails.add(rs.getInt(5));
                arrDetails.add(rs.getInt(6));
                list.add(arrDetails);
            } 
        } catch (Exception e) {
        }
        return list;
    }
}
