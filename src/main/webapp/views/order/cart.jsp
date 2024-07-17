<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/resources/css/styles.css' />" rel="stylesheet">
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

    <!-- Main content -->
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

        <!-- Shipping Information Form -->
        <div class="mt-5">
            <h3>Shipping Information</h3>
           
            <form action="${pageContext.request.contextPath}/cart/orders" method="post">
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" required>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="address">Address</label>
                    <textarea class="form-control" id="address" name="address" required></textarea>
                </div>
                <div class="form-group">
                    <label for="phoneNumber">Phone Number</label>
                    <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" required>
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
                <!-- Hidden input field to pass total price -->
                <input type="hidden" name="totalPrice" id="totalPriceHidden" />
                <button type="submit" class="btn btn-primary">Place Order</button>
            </form>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-light py-4 text-center">
        <div class="container">
            <p>&copy; 2024 E-commerce Website. All rights reserved.</p>
        </div>
    </footer>

    <!-- JavaScript -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            function updateTotalPrice() {
                let total = 0;
                $('tbody tr').each(function() {
                    const quantity = parseInt($(this).find('.quantity').val());
                    const price = parseFloat($(this).find('.price').text());
                    const itemTotal = quantity * price;
                    $(this).find('.item-total').text(itemTotal.toFixed(2));
                    total += itemTotal;
                });
                $('#totalPrice').text(total.toFixed(2));
                // Update hidden input field with total price
                $('#totalPriceHidden').val(total.toFixed(2));
            }

            updateTotalPrice();

            $('.quantity').on('change', function() {
                const productId = $(this).data('product-id');
                const quantity = $(this).val();

                $.ajax({
                    url: '${pageContext.request.contextPath}/cart/update-quantity',
                    method: 'POST',
                    data: {
                        productId: productId,
                        quantity: quantity
                    },
                    success: function(response) {
                        updateTotalPrice();
                    },
                    error: function(error) {
                        alert('Error updating quantity');
                    }
                });
            });
        });
    </script>
</body>
</html>
            