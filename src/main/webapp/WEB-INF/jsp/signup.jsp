<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:template>
    <jsp:attribute name="title">Sign Up</jsp:attribute>
    <jsp:body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white">
                            <h4 class="mb-0">
                                <i class="bi bi-person-plus"></i> Sign Up
                            </h4>
                        </div>
                        <div class="card-body p-4">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger d-flex align-items-center" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <div>${error}</div>
                                </div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/signup" method="post" class="needs-validation" novalidate>
                                <div class="mb-3">
                                    <label for="username" class="form-label">
                                        <i class="bi bi-person"></i> Username
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-person-fill"></i>
                                        </span>
                                        <input type="text" class="form-control" id="username" name="username" 
                                               placeholder="Choose a username" required>
                                        <div class="invalid-feedback">
                                            Please choose a username.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="email" class="form-label">
                                        <i class="bi bi-envelope"></i> Email
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-envelope-fill"></i>
                                        </span>
                                        <input type="email" class="form-control" id="email" name="email" 
                                               placeholder="Enter your email" required>
                                        <div class="invalid-feedback">
                                            Please enter a valid email address.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="password" class="form-label">
                                        <i class="bi bi-key"></i> Password
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-key-fill"></i>
                                        </span>
                                        <input type="password" class="form-control" id="password" name="password" 
                                               placeholder="Create a password" required 
                                               pattern=".{6,}" title="Password must be at least 6 characters">
                                        <div class="invalid-feedback">
                                            Password must be at least 6 characters long.
                                        </div>
                                    </div>
                                    <div class="form-text text-muted">
                                        Password must be at least 6 characters long.
                                    </div>
                                </div>
                                
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        <i class="bi bi-person-plus"></i> Create Account
                                    </button>
                                </div>
                                
                                <div class="text-center mt-3">
                                    <span class="text-muted">Already have an account?</span>
                                    <a href="${pageContext.request.contextPath}/login" class="ms-2">
                                        <i class="bi bi-box-arrow-in-right"></i> Login
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            // Form validation
            (function () {
                'use strict'
                var forms = document.querySelectorAll('.needs-validation')
                Array.prototype.slice.call(forms).forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        form.classList.add('was-validated')
                    }, false)
                })
            })()
        </script>
    </jsp:body>
</t:template>