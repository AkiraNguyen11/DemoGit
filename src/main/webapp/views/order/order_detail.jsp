<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <!-- Navbar -->
    <!-- Navbar code here -->

    <!-- Order Details Section -->
    <section class="container py-5">
        <h2 class="text-center mb-4">Order Details</h2>
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        Order #${order.orderId}
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Order Details</h5>
                        <p class="card-text">Date: ${order.orderDate.toLocalDateTime().toLocalDate()}</p>
                        <p class="card-text">Total: $${order.totalPrice}</p>
                        <!-- Table of ordered items -->
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Product</th>
                                    <th scope="col">Price</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Iterate over order items -->
                                <c:forEach var="item" items="${orderItems}">
                                    <tr>
                                        <td>${item.productName}</td>
                                        <td>$${item.price}</td>
                                        <td>${item.quantity}</td>
                                        <td>$${item.total}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <!-- Button Back -->
                        <div class="text-center">
                            <a href="/order/list" class="btn btn-primary">Back</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>
