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
                                <td>                                    
                                    <input class='input-sm form-control center-block' id="qty-${p.productID}" type="number" value="${p.quantity}" name="modQty" min="1" disabled style='width:30%;'/>
                                </td>
                                <td><sup>$</sup><span id="sub-${p.productID}">${p.quantity * p.price}</span></td>
                                <td>
                                    <div class="btn-group">
                                        <button class="btn btn-default btnEdit" data-button="${p.productID}" data-id="btnEdit-${p.productID}"  title="Edit"><span class="glyphicon glyphicon-edit"></span></button>
                                        <button class="btn btn-success btnUpdate btn-hide" data-button="${p.productID}" data-id="btnUpdate-${p.productID}" title="Update"><span class="glyphicon glyphicon-check"></span></button>
                                        <a href="RemoveServlet?id=${p.productID}" class="btn btn-warning" role="button" title="Remove"><span class="glyphicon glyphicon-trash"></span></a>
					</div>
                                </td>
                                <c:set var="total" value="${total + p.quantity * p.price}"/>
                            </tr>
                        </c:forEach>
                    </tbody>  
                    <tfoot>
                        <tr>
                            <td colspan="3"></td>                    
                            <td>Total</td>
                            <td><sup>$</sup><span id='total_price'>${total}</span></td>                   
                        </tr>
                    </tfoot>
                </table>
                <a href="ListServlet" class="btn btn-default"><span class='glyphicon glyphicon-shopping-cart'></span> Continue Shopping</a>
                <a href="OrderServlet" class="btn btn-info"><span class='glyphicon glyphicon-check'></span> Checkout </a>                
            </div>
            <!--end of contents-->            
        </div>
                        
                        
<script>
$(document).ready(function() {	
	/*toggle Edit button*/
	$('.btnEdit').click(function(){
		var $button = $(this);
		var buttonNumber = $button.data('button');

		$button.addClass('btn-hide');
		$('#qty-'+buttonNumber).prop("disabled", false );
		$('.btnUpdate[data-button="'+buttonNumber+'"]').removeClass('btn-hide');
		});
	/*toggle Update button and submit ajax*/
	$('.btnUpdate').click(function(e){
		var $button = $(this);
		var buttonNumber = $button.data('button');
		var quantity = $('#qty-'+buttonNumber).val();
		if(quantity == "" || !(Math.floor(quantity) == quantity && $.isNumeric(quantity)) || quantity <= 0 ) {
			alert('Quantity must be positive integer number!\nPlease re-enter.');
                        $('#qty-'+buttonNumber).focus();
			e.preventDefault();
		}
		else {
			$button.addClass('btn-hide');
			$('#qty-'+buttonNumber).prop("disabled", true );			
			$('.btnEdit[data-button="'+buttonNumber+'"]').removeClass('btn-hide');
			
			$.ajax({
				url: "EditQtyServlet",
				type: "POST",
				dataType : 'json',
				data : {
					code : buttonNumber,
					quantity : quantity
				},				
				success: function(data, status){
					$("#total_price").html(data[0]);
					$('#sub-'+buttonNumber).html(data[1]);					
				},
				error: function() {alert("Problem in sending reply!")}
			});
		}
	});
});
</script>                        

    </body>
</html>
