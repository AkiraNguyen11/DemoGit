<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/styles.css" rel="stylesheet">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="/index">Shop</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a class="nav-link" href="/product/list">Products</a></li>
                <li class="nav-item"><a class="nav-link" href="/cart/cartshow">Cart</a></li>
                <li class="nav-item"><a class="nav-link" href="/login">Account</a></li>
            </ul>
        </div>
    </nav>

    <!-- Checkout Section -->
    <section class="container py-5">
        <h2 class="text-center mb-4">Checkout</h2>
        <div class="row">
            <div class="col-md-6">
                <!-- Checkout Form -->
                <form action="/order/checkout" method="post">
                    <div class="form-group">
                        <label for="fullName">Full Name</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" value="${fullName}" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" class="form-control" id="email" name="email" value="${email}" required>
                    </div>
                    <div class="form-group">
                        <label for="address">Address</label>
                        <textarea class="form-control" id="address" name="address" required>${address}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="phoneNumber">Phone Number</label>
                        <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="${phoneNumber}" required>
                    </div>
                    <div class="form-group">
                        <label>Payment Method</label><br>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="cash" value="cash" checked>
                            <label class="form-check-label" for="cash">Cash</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="creditCard" value="credit_card">
                            <label class="form-check-label" for="creditCard">Credit Card</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="paymentMethod" id="paypal" value="paypal">
                            <label class="form-check-label" for="paypal">PayPal</label>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">Pay Now</button>
                </form>
            </div>
    <main role="main" class="container my-4">
        <h2>Shopping Cart</h2>
        <c:choose>
            <c:when test="${not empty cartItems}">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Product Name</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Total</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cartItems}">
                            <tr>
                                <td><img src="${item.product.imageURL}" alt="${item.product.name}" width="50" /></td>
                                <td>${item.product.name}</td>
                                <td>
                                    <input type="number" value="${item.quantity}" min="1" class="form-control quantity" data-product-id="${item.productId}" />
                                </td>
                                <td class="price">${item.price}</td>
                                <td class="item-total">${item.price * item.quantity}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart/remove-from-cart" method="post">
                                        <input type="hidden" name="productId" value="${item.productId}" />
                                        <button type="submit" class="btn btn-danger">Remove</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div class="d-flex justify-content-end">
                    <h4>Total: <span id="totalPrice">0</span></h4>
                </div>
                <div class="d-flex justify-content-end mt-3">
                    <form action="${pageContext.request.contextPath}/cart/checkout" method="post">
                        <button type="submit" class="btn btn-success">Checkout</button>
                    </form>
                </div>
            </c:when>
            <c:otherwise>
                <p>Your cart is empty.</p>
            </c:otherwise>
        </c:choose>
    </main>
        </div>
    </section>
</body>
</html>
