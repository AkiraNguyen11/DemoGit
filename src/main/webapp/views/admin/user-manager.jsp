<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>User Management</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
</head>
<body>
	<div class="container">
		<h1 class="mt-4">User Management</h1>
		<div class="row">
			<div class="col-md-8">
				<c:if test="${not empty users}">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>ID</th>
								<th>Username</th>
								<th>Full Name</th>
								<th>Email</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${users}" var="user">
								<tr>
									<td>${user.id}</td>
									<td>${user.username}</td>
									<td>${user.fullName}</td>
									<td>${user.email}</td>
									<td><a href="/user-manager/edit/${user.id}"
										class="btn btn-sm btn-warning">Edit</a> <a
										href="/user-manager/delete/${user.id}"
										class="btn btn-sm btn-danger"
										onclick="return confirm('Are you sure you want to delete this user?')">Delete</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:if>
				<c:if test="${empty users}">
					<p>No users found.</p>
				</c:if>
			</div>
			<div class="col-md-4">
				<h3 id="formTitle">Add New User</h3>
				<form id="userForm" action="/user-manager/create" method="post">
					<input type="hidden" id="userId" name="id"
						value="${empty item ? '' : item.id}" />
					<div class="form-group">
						<label for="username">Username:</label> <input type="text"
							class="form-control" id="username" name="username"
							value="${empty item ? '' : item.username}" required>
					</div>
					<div class="form-group">
						<label for="password">Password:</label> <input type="password"
							class="form-control" id="password" name="password"
							value="${empty item ? '' : item.password}" required>
					</div>
					<div class="form-group">
						<label for="fullName">Full Name:</label> <input type="text"
							class="form-control" id="fullName" name="fullName"
							value="${empty item ? '' : item.fullName}" required>
					</div>
					<div class="form-group">
						<label for="email">Email:</label> <input type="email"
							class="form-control" id="email" name="email"
							value="${empty item ? '' : item.email}" required>
					</div>
					<div class="form-group">
						<label for="address">Address:</label> <input type="text"
							class="form-control" id="address" name="address"
							value="${empty item ? '' : item.address}" required>
					</div>
					<div class="form-group">
						<label for="phoneNumber">Phone Number:</label> <input type="text"
							class="form-control" id="phoneNumber" name="phoneNumber"
							value="${empty item ? '' : item.phoneNumber}" required>
					</div>


					<button type="submit" id="submitBtn" class="btn btn-primary">Add</button>
					<button type="reset" class="btn btn-secondary"
						onclick="loadUserForm('add')">Add New User</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
