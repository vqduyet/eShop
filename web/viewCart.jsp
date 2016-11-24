<%-- 
    Document   : viewCart
    Created on : Nov 24, 2016, 2:07:28 AM
    Author     : Duyet
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1"/>        
        <link rel="icon" href="resources/images/sites/favicon.png" type="image/x-icon" />

        <link rel="stylesheet" type="text/css" href="resources/bootstrap/css/bootstrap.css"/>
        <link rel="stylesheet" type="text/css" href="resources/css/style.css"/>
        <script type="text/javascript" src="resources/jquery/jquery.js"></script>
        <script type="text/javascript" src="resources/bootstrap/js/bootstrap.js"></script>
        <title>View Cart</title>
    </head>
    <body>
        <div class="container-fluid">
            <!--header-->
            <c:import url="header.jsp"/>
            <!--end of header-->
            <!--contents-->
            <div id='contents-container' class="container">
                <h1>Ur Cart</h1>                
                <table class="table table-condensed table-responsive table-hover">
                    <thead>
                        <tr>
                            <th>Product ID</th>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>SubTotal</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="total" value="${0}"/>
                        <c:forEach var="p" items="${list}">
                            <tr>
                                <td>${p.productID}</td>
                                <td>${p.productName}</td>
                                <td><sup>$</sup>${p.price}</td>
                                <td>${p.quantity}</td>
                                <td><sup>$</sup>${p.quantity * p.price}</td>
                                <td><a href="RemoveServlet?id=${p.productID}" class="btn btn-warning" title="Remove"><span class='glyphicon glyphicon-trash'></span></a></td>
                                <c:set var="total" value="${total + p.quantity * p.price}"/>
                            </tr>
                        </c:forEach>
                    </tbody>  
                    <tfoot>
                        <tr>
                            <td colspan="3"></td>                    
                            <td>Total</td>
                            <td><sup>$</sup>${total}</td>                   
                        </tr>
                    </tfoot>
                </table>
                <a href="ListServlet" class="btn btn-default"><span class='glyphicon glyphicon-shopping-cart'></span> Continue Shopping</a>
                <a href="OrderServlet" class="btn btn-info"><span class='glyphicon glyphicon-check'></span> Checkout </a>                
            </div>
            <!--end of contents-->
        </div>
    </body>
</html>
