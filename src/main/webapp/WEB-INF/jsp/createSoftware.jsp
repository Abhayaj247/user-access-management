<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:template>
    <jsp:attribute name="title">Add Software</jsp:attribute>
    <jsp:body>
        <div class="container mt-4">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="card shadow">
                        <div class="card-header bg-primary text-white">
                            <h4 class="mb-0"><i class="bi bi-plus-circle"></i> Add New Software</h4>
                        </div>
                        <div class="card-body">
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger" role="alert">
                                    <i class="bi bi-exclamation-triangle"></i> ${error}
                                </div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/software/create" method="post" class="needs-validation" novalidate>
                                <div class="mb-3">
                                    <label for="name" class="form-label">Software Name</label>
                                    <input type="text" class="form-control" id="name" name="name" required>
                                    <div class="invalid-feedback">
                                        Please provide a software name.
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label for="description" class="form-label">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="3" required></textarea>
                                    <div class="invalid-feedback">
                                        Please provide a description.
                                    </div>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label d-block">Access Levels</label>
                                    <div class="border rounded p-3">
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="accessLevels" value="Read" id="readAccess" checked>
                                            <label class="form-check-label" for="readAccess">
                                                <i class="bi bi-eye"></i> Read
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="accessLevels" value="Write" id="writeAccess">
                                            <label class="form-check-label" for="writeAccess">
                                                <i class="bi bi-pencil"></i> Write
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="checkbox" name="accessLevels" value="Admin" id="adminAccess">
                                            <label class="form-check-label" for="adminAccess">
                                                <i class="bi bi-shield-lock"></i> Admin
                                            </label>
                                        </div>
                                    </div>
                                    <div class="form-text">Select at least one access level.</div>
                                </div>
                                
                                <div class="d-flex justify-content-between">
                                    <a href="${pageContext.request.contextPath}/software/list" class="btn btn-secondary">
                                        <i class="bi bi-arrow-left"></i> Back to List
                                    </a>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="bi bi-save"></i> Add Software
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
                        
                        // Check if at least one access level is selected
                        var accessLevels = form.querySelectorAll('input[name="accessLevels"]:checked')
                        if (accessLevels.length === 0) {
                            event.preventDefault()
                            event.stopPropagation()
                            alert('Please select at least one access level')
                        }
                        
                        form.classList.add('was-validated')
                    }, false)
                })
            })()
        </script>
    </jsp:body>
</t:template>
