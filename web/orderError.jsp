<%-- 
    Document   : orderError
    Created on : Nov 24, 2016, 1:22:53 PM
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
        <title>Order Error</title>
    </head>
    <body>
        <div class="container-fluid">
            <!--header-->
            <c:import url="header.jsp"/>
            <!--end of header-->
            <!--contents-->
            <% if (session.getAttribute("orderStatus") != null) {
                    if (!(Boolean) session.getAttribute("orderStatus")) {
            %>
            <div id='contents-container' class="container col-md-7 col-md-offset-2">                
                <div class='well'>
                    <h1>OOPS! YOUR ORDER FAILED!</h1>
                </div>
            </div>
            <!--end of contents-->
            <%        }
                } else {
                    response.sendRedirect("page404.jsp");
                }
            %>
        </div>
    </body>
</html>
