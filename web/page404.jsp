<%-- 
    Document   : page404
    Created on : Nov 24, 2016, 3:18:27 PM
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
        <title>Not found</title>
    </head>
    <body>
        <div class="container-fluid">
            <!--header-->
            <c:import url="header.jsp"/>
            <!--end of header-->
            <!--contents-->
            <div id='contents-container' class="container col-md-8 col-md-offset-2">
                <br/>
                <a href="ListServlet"><img style="width:100%" class="img-responsive img-rounded" src="resources/images/sites/page404-lg.png" alt="Page 404"/></a>
            </div>
            <!--end of contents-->            
        </div>
    </body>
</html>
