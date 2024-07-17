<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Product List</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="<c:url value='/resources/css/styles.css' />" rel="stylesheet">
<style>
table {
    width: 100%;
    border-collapse: collapse;
}

table, th, td {
    border: 1px solid black;
}

th, td {
    padding: 10px;
    text-align: left;
}

th {
    background-color: #f2f2f2;
}

.card-img-top {
    width: 100%;
    height: 200px; /* hoặc một kích thước phù hợp với bạn */
    object-fit: cover;
}
</style>
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

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav id="sidebar"
                class="col-md-3 col-lg-2 d-md-block bg-light sidebar">
                <div class="sidebar-sticky">
                    <h5 class="sidebar-heading">Categories</h5>
                    <form action="/product/list" method="get">
                        <div class="form-group">
                            <select class="form-control" name="category">
                                <option value="">All Categories</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id}"
                                        ${selectedCategory == category.id ? 'selected' : ''}>${category.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <input class="form-control" type="search" name="keywords"
                                placeholder="Search" aria-label="Search"
                                value="${param.keywords}">
                        </div>
                        <hr>
                        <h5 class="sidebar-heading">Price Filter</h5>
                        <div class="form-group">
                            <label for="minPrice">Min Price:</label> <input
                                class="form-control" type="number" name="min" id="minPrice"
                                value="${param.min}">
                        </div>
                        <div class="form-group">
                            <label for="maxPrice">Max Price:</label> <input
                                class="form-control" type="number" name="max" id="maxPrice"
                                value="${param.max}">
                        </div>
                        <button type="submit" class="btn btn-primary btn-block">Filter</button>
                    </form>
                </div>
            </nav>

            <!-- Main content -->
            <main role="main" class="col-md-9 col-lg-10
    ml-sm-auto px-4">
                <h2 class="text-center my-4">Product List</h2>
                <div class="row">
                    <c:if test="${not empty page.content}">
                        <c:forEach var="product" items="${page.content}"
                            varStatus="status">
                            <div class="col-md-3 mb-4">
                                <div class="card h-100">
                                    <img src="${product.imageURL}" class="card-img-top"
                                        alt="${product.name}">
                                    <div class="card-body">
                                        <h5 class="card-title">${product.name}</h5>
                                        <p class="card-text">${product.description}</p>
                                        <p class="card-text">Price: ${product.price}</p>
                                        <a href="/product_detail/${product.id}"
                                            class="btn btn-primary">View Details</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty page.content}">
                        <div class="col-12">
                            <p class="text-center">No products found.</p>
                        </div>
                    </c:if>
                </div>

                <!-- Pagination -->
                <nav aria-label="Page navigation">
                    <ul class="pagination justify-content-center">
                        <c:forEach begin="0" end="${page.totalPages - 1}" var="i">
                            <li
                                class="page-item <c:if test='${page.number == i}'>active</c:if>">
                                <a class="page-link"
                                    href="/product/list?keywords=${param.keywords}&p=${i}&min=${param.min}&max=${param.max}&category=${selectedCategory}">${i + 1}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </nav>
           
        </main>
    </div>
</div>

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
           