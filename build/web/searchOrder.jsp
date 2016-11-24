<%-- 
    Document   : searchOrder
    Created on : Nov 24, 2016, 3:18:13 PM
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
        <title>Search Order</title>
    </head>
    <body>
        <div class="container-fluid">
            <!--header-->
            <c:import url="header.jsp"/>
            <!--end of header-->
            <!--contents-->
            <div id='contents-container' class="container">                
                <!--search area-->	
                <div class='container col-md-3 table-responsive' style="margin-right: 20px; min-height: 100%;">
                    <h3 class='text-center'>SEARCH BY ORDER #</h3>
                    <hr/>
                    <form class="form" action="SearchOrderServlet" method="post" id='searchForm'>
                        <div class="form-group">
                            <label for="orderID">Order Number</label>
                            <input type="text"
                                   id="orderID"
                                   name="orderID"
                                   placeholder="Please enter your order number"
                                   class="form-control"                                                      
                                   />                
                        </div>			
                        <input type="submit" value="Search" id="btnSearch" class="btn btn-default pull-right"/>
                    </form>
                </div>
                <!--end of search area-->
                <!--result area-->
                <%              
                    
                    if(request.getAttribute("match") != null) { 
                        if((Boolean)request.getAttribute("match")) { 
                %>
                <div class="col-md-8 container table-responsive">
                    <c:forEach var="info" items="${infoList}">
                        <h2>Order No: <kbd>${info[0]}<kbd></h2>
		<hr/>
		<ul>
                    <li>
                        <h3>Order Information</h3>
                        <ul>
                            <li>Customer Name: ${info[3]}</li>
                            <li>Order Date: ${info[1]}</li>
                            <li>Total: <sup>$</sup>${info[2]}</li>	
                        </ul>
                    </li>
                    </c:forEach>                    
                    <li>
                        <h3>Items in Order</h3>
                        <table class="table table-condensed">
                            <thead>
                                <tr>
                                    <th>Product ID</th>
                                    <th>Product Name</th>
                                    <th>Price</th>
                                    <th>Quantity</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="details" items="${detailsList}">
                                    <tr>
                                        <td>${details[0]}</td>
                                        <td>${details[1]}</td>
                                        <td><sup>$</sup>${details[2]}</td>
                                        <td>${details[3]}</td>
                                        <td><sup>$</sup>${details[4]}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>				
                    </li>
		</ul>
                </div>
                <% 
                    } else if(!(Boolean)request.getAttribute("match")) {
                %>
                <div class="col-md-8 container table-responsive">
                    <h3>No results.</h3>
                </div>
                <% } } %>
                <!--end of result area-->
            </div>
            <!--end of contents-->
        </div>
    </body>
</html>
