<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:template>
    <jsp:attribute name="title">Request Access</jsp:attribute>
    <jsp:body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white">
                            <h4 class="mb-0">
                                <i class="bi bi-plus-circle"></i> Request Software Access
                            </h4>
                        </div>
                        <div class="card-body p-4">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger d-flex align-items-center" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                    <div>${error}</div>
                                </div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/requests/create" method="post" class="needs-validation" novalidate>
                                <div class="mb-4">
                                    <label for="softwareId" class="form-label">
                                        <i class="bi bi-pc-display"></i> Software
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-list"></i>
                                        </span>
                                        <select class="form-select" id="softwareId" name="softwareId" required>
                                            <option value="">Select Software</option>
                                            <c:forEach items="${softwareList}" var="software">
                                                <option value="${software.id}">${software.name}</option>
                                            </c:forEach>
                                        </select>
                                        <div class="invalid-feedback">
                                            Please select a software.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="accessType" class="form-label">
                                        <i class="bi bi-shield-lock"></i> Access Type
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-key"></i>
                                        </span>
                                        <select class="form-select" id="accessType" name="accessType" required>
                                            <option value="">Select Access Type</option>
                                            <option value="Read">
                                                <i class="bi bi-eye"></i> Read
                                            </option>
                                            <option value="Write">
                                                <i class="bi bi-pencil"></i> Write
                                            </option>
                                            <option value="Admin">
                                                <i class="bi bi-gear"></i> Admin
                                            </option>
                                        </select>
                                        <div class="invalid-feedback">
                                            Please select an access type.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="reason" class="form-label">
                                        <i class="bi bi-chat-left-text"></i> Reason for Request
                                    </label>
                                    <div class="input-group">
                                        <span class="input-group-text">
                                            <i class="bi bi-justify"></i>
                                        </span>
                                        <textarea class="form-control" id="reason" name="reason" 
                                                  rows="4" required 
                                                  placeholder="Please explain why you need access to this software..."></textarea>
                                        <div class="invalid-feedback">
                                            Please provide a reason for your request.
                                        </div>
                                    </div>
                                    <div class="form-text text-muted">
                                        Provide a clear explanation of why you need access to this software.
                                    </div>
                                </div>
                                
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary btn-lg">
                                        <i class="bi bi-send"></i> Submit Request
                                    </button>
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
