<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.HashMap"%>
<%@page import="model.CartItem"%>
<%
    int session_items = 0;
    int totalAmt = 0;
    int totalQty = 0;
    if (session.getAttribute("cart") != null) {
        HashMap<String, CartItem> sessionMap = (HashMap<String, CartItem>) session.getAttribute("cart");
        session_items = sessionMap.size();
        for (String key : sessionMap.keySet()) {
            totalQty += sessionMap.get(key).getQuantity();
            totalAmt += sessionMap.get(key).getQuantity() * sessionMap.get(key).getPrice();
        }
    }
%>
<!--menu-->
<nav id="nav_bar" class="navbar navbar-inverse navbar-fixed-top">
    <div class="container-fluid">                
        <div class="navbar-header">
            <!--icon for collapsed menu items-->
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#mainNavBar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <!--logo -->
            <a href="ListServlet" class="navbar-brand"><img class="img-responsive img-circle" src="resources/images/sites/eShop.png"/></a>
        </div>                
        <!--menu items -->
        <div class="collapse navbar-collapse" id="mainNavBar">
            <ul class="nav navbar-nav">                        
                <li><a href="ListServlet">Products</a></li>
                <li>
                    <a class="shopCart" href="ViewCartServlet" title="View Cart" style="position: relative;">                                
                        <% if (session_items > 0) { %><sub class='cart-overview'><%=session_items%></sub><% } %>
                        <% if (totalQty > 0) { %><span style="position: absolute; top:5px; left: 33px; color: #ffffff; font-weight: bold" class='cart-overview'><%=totalQty%></span><% } %>
                        <img src="resources/images/sites/checkout24.png" alt="Checkout" />
                        <sub class='cart-overview'><sup>$ </sup><%=totalAmt%></sub>	                   	
                    </a>
                </li>
                <li><a href="OrderServlet">Checkout</a></li>
            </ul>

            <!-- right align -->
            <ul class="nav navbar-nav navbar-right">                        
                <li>
                    <a href="SearchOrderServlet" title="Search Order"><img src="resources/images/sites/list24.png" alt="Order List" /></a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!--end of menu-->