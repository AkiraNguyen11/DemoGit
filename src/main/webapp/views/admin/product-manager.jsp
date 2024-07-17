<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Product Management</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"/>
    <style>
        .product-image {
            max-width: 100px;
            max-height: 100px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="mt-4">Product Management</h1>

    <!-- Add Product Form -->
    <div class="row">
        <div class="col-md-6">
            <h3>Add Product</h3>
            <form id="productForm" action="/product-manager/save" method="post">
                <div class="form-group">
                    <label for="id">ID:</label>
                    <input type="text" class="form-control" id="id" name="id" readonly>
                </div>
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" class="form-control" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <input type="text" class="form-control" id="description" name="description">
                </div>
                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" class="form-control" id="price" name="price" required>
                </div>
                <div class="form-group">
                    <label for="stockQuantity">Stock Quantity:</label>
                    <input type="number" class="form-control" id="stockQuantity" name="stockQuantity" required>
                </div>
                <div class="form-group">
                    <label for="category">Category ID:</label>
                    <input type="number" class="form-control" id="category" name="category" required>
                </div>
                <div class="form-group">
                    <label for="imageURL">Image URL:</label>
                    <input type="text" class="form-control" id="imageURL" name="imageURL">
                </div>
                <button type="button" class="btn btn-primary" onclick="submitForm('/product-manager/update')">Update</button>
                <button type="submit" class="btn btn-primary">Add Product</button>
            </form>
        </div>
    </div>

    <!-- List of Products -->
    <div class="row mt-4">
        <div class="col-md-12">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Stock Quantity</th>
                    <th>Category ID</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${products}" var="product">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.name}</td>
                        <td>${product.description}</td>
                        <td>${product.price}</td>
                        <td>${product.stockQuantity}</td>
                        <td>${product.category.id}</td>
                        <td>
                            <img src="${product.imageURL}" alt="Product Image" class="product-image">
                        </td>
                        <td>
                            <button class="btn btn-sm btn-warning" onclick="editProduct(${product.id},'${product.name}','${product.description}',${product.price},${product.stockQuantity},${product.category.id},'${product.imageURL}')">Edit</button>
                            <a href="/product-manager/delete/${product.id}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this product?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <c:if test="${empty products}">
                <p>No products found.</p>
            </c:if>
        </div>
    </div>

</div>
<script>
    function editProduct(id, name, description, price, stockQuantity, categoryId, imageURL) {
        document.getElementById('id').value = id;
        document.getElementById('name').value = name;
        document.getElementById('description').value = description;
        document.getElementById('price').value = price;
        document.getElementById('stockQuantity').value = stockQuantity;
        document.getElementById('category').value = categoryId;
        document.getElementById('imageURL').value = imageURL;
    }

    function submitForm(action) {
        const form = document.getElementById('productForm');
        form.action = action;
        form.submit();
    }
</script>
</body>
</html>
