<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="/index">Shop</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse"
            data-target="#navbarNav" aria-controls="navbarNav"
            aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/product/list">Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/cart/cartshow">Cart</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown"
                        role="button" data-toggle="dropdown" aria-haspopup="true"
                        aria-expanded="false">Order</a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="/order/list">My Orders</a>
                    </div>
                </li>
                <li class="nav-item dropdown">
                    <c:choose>
                        <c:when test="${not empty loggedInUser}">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown2"
                                role="button" data-toggle="dropdown" aria-haspopup="true"
                                aria-expanded="false"> Xin chào ${loggedInUser} </a>
                            <div class="dropdown-menu" aria-labelledby="navbarDropdown2">
                                <a class="dropdown-item" href="/edit-profile">Edit</a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="/logout">Đăng xuất</a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <a class="nav-link" href="/account">Account</a>
                        </c:otherwise>
                    </c:choose>
                </li>
            </ul>
        </div>
    </nav>

    <!-- My Orders Section -->
    <section class="container py-5">
        <h2 class="text-center mb-4">My Orders</h2>
        <div class="row justify-content-center">
            <div class="col-md-8">
                <!-- Order List -->
                <ul class="list-group">
                    <!-- Iterate over orders -->
                    <c:forEach var="order" items="${orders}">
                        <li class="list-group-item">
                            <div class="row">
                                <div class="col-sm-6">
                                    <h5>Order #${order.orderId}</h5>
                                    <!-- Format timestamp to display date -->
                                    <p>Date: ${order.orderDate.toLocalDateTime().toLocalDate()}</p>
                                    <p>Total: $${order.totalPrice}</p>
                                </div>
                                <div class="col-sm-6 text-right">
                                    <form action="/order/cancel" method="post">
                                        <input type="hidden" name="orderId" value="${order.orderId}">
                                        <button type="submit" class="btn btn-danger">Remove</button>
                                    </form>
                                    <!-- Change the href to link to order details page -->
                                </div>
                            </div>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </div>
    </section>
</body>
</html>
