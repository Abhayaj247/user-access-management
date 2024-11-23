<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>

<t:template>
    <jsp:attribute name="title">My Access Requests</jsp:attribute>
    <jsp:body>
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="card shadow-sm">
                        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
                            <h4 class="mb-0">
                                <i class="bi bi-list-check"></i> My Access Requests
                            </h4>
                            <a href="${pageContext.request.contextPath}/requests/create" class="btn btn-light">
                                <i class="bi bi-plus-circle"></i> New Request
                            </a>
                        </div>
                        <div class="card-body p-4">
                            <c:choose>
                                <c:when test="${empty requests}">
                                    <div class="text-center py-5">
                                        <i class="bi bi-inbox display-1 text-muted"></i>
                                        <p class="h5 text-muted mt-3">You haven't made any access requests yet.</p>
                                        <a href="${pageContext.request.contextPath}/requests/create" 
                                           class="btn btn-primary mt-3">
                                            <i class="bi bi-plus-circle"></i> Create Your First Request
                                        </a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="table-responsive">
                                        <table class="table table-hover align-middle">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>
                                                        <i class="bi bi-pc-display"></i> Software
                                                    </th>
                                                    <th>
                                                        <i class="bi bi-shield-lock"></i> Access Type
                                                    </th>
                                                    <th>
                                                        <i class="bi bi-chat-left-text"></i> Reason
                                                    </th>
                                                    <th>
                                                        <i class="bi bi-check-circle"></i> Status
                                                    </th>
                                                    <th>
                                                        <i class="bi bi-calendar"></i> Requested Date
                                                    </th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach items="${requests}" var="request">
                                                    <tr>
                                                        <td>
                                                            <strong>${request.softwareName}</strong>
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-info text-dark">
                                                                <i class="bi bi-key"></i> ${request.accessType}
                                                            </span>
                                                        </td>
                                                        <td>
                                                            <span class="text-muted">${request.reason}</span>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${request.status eq 'PENDING'}">
                                                                    <span class="badge bg-warning text-dark">
                                                                        <i class="bi bi-hourglass-split"></i> Pending
                                                                    </span>
                                                                </c:when>
                                                                <c:when test="${request.status eq 'APPROVED'}">
                                                                    <span class="badge bg-success">
                                                                        <i class="bi bi-check-circle"></i> Approved
                                                                    </span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-danger">
                                                                        <i class="bi bi-x-circle"></i> Rejected
                                                                    </span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <small class="text-muted">
                                                                <i class="bi bi-clock"></i> ${request.requestDate}
                                                            </small>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</t:template>
