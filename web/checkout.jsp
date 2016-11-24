<%-- 
    Document   : checkout
    Created on : Nov 24, 2016, 10:25:57 AM
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
        <title>Checkout</title>
    </head>
    <body>
        <div class="container-fluid">
            <!--header-->
            <c:import url="header.jsp"/>
            <!--end of header-->
            <!--contents-->
            <div id='contents-container' class="container">
                <h1>CHECKOUT</h1>
                <% if(session.getAttribute("cart") != null) { %>
                <div class="table-responsive col-md-8" style="margin-right: 20px;">
                    <h3>Items in Order</h3>
                    <hr/>
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
                                <td>Sum</td>
                                <td><sup>$</sup>${total}</td>                   
                            </tr>
                        </tfoot>
                    </table>
                    <a href="ListServlet" class="btn btn-default"><span class='glyphicon glyphicon-shopping-cart'></span> Continue Shopping</a>
                    <a href="ViewCartServlet" class="btn btn-info"><span class='glyphicon glyphicon-eye-open'></span> View Cart</a>
                </div>
                <!--client's info-->
                <div class="table-responsive col-md-3">
                    <h3>Order Info</h3>
                    <hr/>
                    <form class="form" action="OrderServlet" method="post" id='orderForm'>
                        <div class="form-group">
                            <label for="cusName">Customer Name</label>
                            <input type="text"
                                   id="cusName"
                                   name="cusName"
                                   class="form-control"
                                   required=""
                                   placeholder="Please enter your name"                                   
                                   />                
                        </div>
                        <div class="form-group">
                            <label for="orderDate">Order Date</label>
                            <input type="text"                                   
                                   id="orderDate"
                                   name="orderDate"
                                   class="form-control"
                                   readonly=""
                                   value="${date}"
                                   />                
                        </div>
                        <div class="form-group">
                            <label for="total">Total</label>
                            <input type="text"
                                   id="total"
                                   name="total"
                                   class="form-control"
                                   readonly=""
                                   value="${total}"
                                   />                
                        </div>                        
                        <input type="submit" value="Order" id="btnOrder" class="btn btn-success pull-right"/>
                    </form>
                </div>
                <% } else { %>
                <div>
                    <h3>There is no item in Ur Cart.</h3>          
                    <a href="ListServlet" class="btn btn-default"><span class='glyphicon glyphicon-shopping-cart'></span> Continue Shopping</a>                    
                </div>
                <% } %>
                <!--end of client's info-->      
            </div>
            <!--end of contents-->
        </div>
                
<script>
$(document).ready(function() {
	/*submit order form*/
	$("#btnOrder").click(function(e) {
		if(!validateOrderForm()){
			e.preventDefault();			
		}
		else {
			$("#orderForm").submit();
		}
	});
	/*validate order form*/
	function validateOrderForm(){
		var errCount = 0;	
		var nameReg = /^[a-zA-Z][a-zA-Z ]+$/;

		var names = $('#cusName').val().trim();		    

		var inputVal = new Array(names);

		var inputMessage = new Array("name");

		$('.error').hide();

		if(inputVal[0] === ""){
			$('#cusName').after('<div class="error alert-danger"> Please enter your ' + inputMessage[0] + '</div>');
			errCount++;
		} 
		else if(!nameReg.test(names)){
			$('#cusName').after('<div class="error alert-danger"> Letters only</div>');
			errCount++;
		}		
		
		if(errCount===0) return true;
		else return false;		
	}	
});
</script>                

    </body>
</html>
