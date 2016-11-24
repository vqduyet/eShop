<%-- 
    Document   : orderConfirmation
    Created on : Nov 24, 2016, 1:22:42 PM
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
        <title>Order Confirmation</title>
    </head>
    <body>
        <div class="container-fluid">
            <!--header-->
            <c:import url="header.jsp"/>
            <!--end of header-->
            <!--contents-->
            <% if (session.getAttribute("orderStatus") != null) {
                    if ((Boolean) session.getAttribute("orderStatus")) {
            %>
            <div id='contents-container' class="container table-responsive col-md-8 col-md-offset-2">
                <div class="text-center">
                    <h1 >YOUR ORDER HAS BEEN RECEIVED</h1>
                    <hr/>
                    <p class="lead">THANK YOU FOR YOUR PURCHASE!<br/>
                        Your order # is: <kbd><c:out value="${infoList[0]}"/></kbd>
                    </p>
                    <p>Your order has been sent to our sales representatives for processing with details as follows:<p>
                </div>

                <ul>
                    <li>
                        <h3>Order Information</h3>
                        <ul>
                            <li>Customer Name: <c:out value="${infoList[1]}"/></li>
                            <li>Order Date: <c:out value="${infoList[2]}"/></li>
                            <li>Total: <c:out value="${infoList[3]}"/></li>					
                        </ul>
                    </li>
                    <li>
                        <h3>Items in Order</h3>
                        <table class="table table-condensed">
                            <thead>
                                <tr>
                                    <th>Product ID</th>
                                    <th>Product Name</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>SubTotal</th>
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
                    </li>
                </ul>
                <% //cancel session and restart a new one %>
                <div class="text-center">
                    <p>You can re-check your order info with above Order No. in <a href="SearchOrderServlet" class="btn btn-info btn-sm" role="button">Search Order</a><p>
                        <a href="ListServlet" class="btn btn-default" role="button"><span class="glyphicon glyphicon-shopping-cart"></span> Continue Shopping</a>
                </div>
            </div>
            <!--end of contents-->
            <%        
                session.invalidate();
                    } }
                else {
                    response.sendRedirect("page404.jsp");
                }
            %>
        </div>
    </body>
</html>
