<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-commerce Website</title>
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
                <li class="nav-item">
                    <a class="nav-link" href="/products">Products</a>
                </li>
                <c:if test="${sessionScope.isAdmin}">
                    <li class="nav-item">
                        <a class="nav-link" href="admin/user-manager">UserMana</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/product-manager">ProductMana</a>
                    </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link" href="/cart/cartshow">Cart</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/login">Account</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/logout">Logout</a>
                </li>
            </ul>
        </div>
    </nav>
    
    <!-- Hero Section -->
    <header class="jumbotron text-center">
        <h1 class="display-4">Welcome to Our Shop</h1>
        <p class="lead">Find the best products here</p>
        <a href="/products" class="btn btn-primary btn-lg">Shop Now</a>
    </header>


    <!-- Top 10 Discounted Products -->
    <section class="container py-5">
        <h2 class="text-center mb-4">Top 10 Discounted Products</h2>
        <div class="row">
            <c:forEach items="${getTop10DiscountedProducts}" var="product">
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <img src="${product.imageURL}" class="card-img-top" alt="Product Image">
                        <div class="card-body">
                            <h5 class="card-title">${product.productName}</h5>
                            <p class="card-text">${product.description}</p>
                            <p class="card-text">Price: ${product.price}</p>
                            <a href="/product/${product.productId}" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </section>
    
    <!-- Footer -->
    <footer class="bg-light py-4 text-center">
        <div class="container">
            <p>&copy; 2024 E-commerce Website. All rights reserved.</p>
        </div>
    </footer>
    
    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
