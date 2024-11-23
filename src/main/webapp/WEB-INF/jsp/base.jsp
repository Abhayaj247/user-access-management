<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>${param.title} - User Access Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            padding-top: 60px;
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #0d6efd;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .navbar-brand {
            font-weight: 600;
            letter-spacing: 0.5px;
        }
        .nav-link {
            font-weight: 500;
            padding: 0.5rem 1rem !important;
            transition: all 0.2s ease-in-out;
        }
        .nav-link:hover {
            background-color: rgba(255,255,255,0.1);
            border-radius: 4px;
        }
        .card {
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border: none;
            border-radius: 8px;
        }
        .card-header {
            border-bottom: none;
            background-color: transparent;
            padding: 1.5rem;
        }
        .card-body {
            padding: 1.5rem;
        }
        .btn {
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 6px;
        }
        .alert {
            border: none;
            border-radius: 8px;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="bi bi-shield-lock"></i> UAMS
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <c:if test="${not empty sessionScope.user}">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/requests/my">
                                <i class="bi bi-list-check"></i> My Requests
                            </a>
                        </li>
                        <c:if test="${sessionScope.user.role eq 'EMPLOYEE' or sessionScope.user.role eq 'MANAGER' or sessionScope.user.role eq 'ADMIN'}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/requests/create">
                                    <i class="bi bi-plus-circle"></i> Request Access
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.user.role eq 'MANAGER' or sessionScope.user.role eq 'ADMIN'}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/requests/pending">
                                    <i class="bi bi-clock-history"></i> Pending Requests
                                </a>
                            </li>
                        </c:if>
                        <c:if test="${sessionScope.user.role eq 'ADMIN'}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/software/create">
                                    <i class="bi bi-pc-display"></i> Add Software
                                </a>
                            </li>
                        </c:if>
                    </c:if>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <li class="nav-item">
                                <span class="nav-link">
                                    <i class="bi bi-person-circle"></i> ${sessionScope.user.username}
                                    <span class="badge bg-light text-dark ms-1">${sessionScope.user.role}</span>
                                </span>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                                    <i class="bi bi-box-arrow-right"></i> Logout
                                </a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="bi bi-box-arrow-in-right"></i> Login
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/signup">
                                    <i class="bi bi-person-plus"></i> Sign Up
                                </a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <c:if test="${not empty error}">
            <div class="alert alert-danger d-flex align-items-center" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>
                <div>${error}</div>
            </div>
        </c:if>
        <jsp:doBody/>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
