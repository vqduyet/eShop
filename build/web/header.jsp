<%-- 
    Document   : header
    Created on : Nov 24, 2016, 9:25:56 AM
    Author     : Duyet
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">        
    </head>
    <body>
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
                            <a href="ViewCartServlet" title="View Cart">                                
                                <img src="resources/images/sites/checkout24.png" alt="Checkout" />                    	
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
    </body>
</html>
