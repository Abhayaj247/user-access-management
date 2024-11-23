<%@ tag description="Base template" pageEncoding="UTF-8" %>
<%@ attribute name="title" required="true" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <title>${title} - User Access Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            padding-top: 60px;
            background-color: #f8f9fa;
        }
        .navbar {
            background-color: #343a40;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .card {
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            border: none;
            border-radius: 8px;
        }
        .card-header {
            border-top-left-radius: 8px !important;
            border-top-right-radius: 8px !important;
        }
        .table {
            margin-bottom: 0;
        }
        .table th {
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
        }
        .badge {
            padding: 0.5em 0.75em;
            font-weight: 500;
        }
        .btn {
            padding: 0.5rem 1rem;
            font-weight: 500;
        }
        .btn-light {
            background: rgba(255,255,255,0.9);
        }
        .btn-light:hover {
            background: #ffffff;
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
                                <a class="nav-link" href="${pageContext.request.contextPath}/software/list">
                                    <i class="bi bi-list-ul"></i> Software List
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/software/create">
                                    <i class="bi bi-plus-square"></i> Add Software
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
                                    <span class="badge bg-light text-dark">${sessionScope.user.role}</span>
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

    <jsp:doBody/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
