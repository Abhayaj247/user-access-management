<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:template>
    <jsp:attribute name="title">Login</jsp:attribute>
    <jsp:body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white">
                            <h4 class="mb-0">
                                <i class="bi bi-shield-lock"></i> Login to UAMS
                            </h4>
                        </div>
                        <div class="card-body p-4">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger d-flex align-items-center" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <div>${error}</div>
                                </div>
                            </c:if>
                            <form action="${pageContext.request.contextPath}/login" method="post" class="needs-validation" novalidate>
                                <div class="mb-3">
                                    <label for="username" class="form-label">
                                        <i class="bi bi-person"></i> Username
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-person-fill"></i>
                                        </span>
                                        <input type="text" class="form-control" id="username" name="username" 
                                               placeholder="Enter your username" required>
                                        <div class="invalid-feedback">
                                            Please enter your username.
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
                                               placeholder="Enter your password" required>
                                        <div class="invalid-feedback">
                                            Please enter your password.
                                        </div>
                                    </div>
                                </div>
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        <i class="bi bi-box-arrow-in-right"></i> Login
                                    </button>
                                </div>
                                <div class="text-center mt-3">
                                    <span class="text-muted">Don't have an account?</span>
                                    <a href="${pageContext.request.contextPath}/signup" class="ms-2">
                                        <i class="bi bi-person-plus"></i> Sign Up
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