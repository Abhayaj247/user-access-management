<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="t" %>
<jsp:useBean id="requests" scope="request" type="java.util.List"/>

<t:template>
    <jsp:attribute name="title">Pending Requests</jsp:attribute>
    <jsp:body>
        <div class="container">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h4 class="mb-0">
                        <i class="bi bi-clock-history"></i> Pending Access Requests
                    </h4>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${empty requests}">
                            <div class="text-center py-4">
                                <i class="bi bi-inbox text-muted" style="font-size: 3rem;"></i>
                                <p class="text-muted mt-2">No pending requests found.</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table class="table table-striped table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th><i class="bi bi-person"></i> Employee</th>
                                            <th><i class="bi bi-pc-display"></i> Software</th>
                                            <th><i class="bi bi-shield-lock"></i> Access Type</th>
                                            <th><i class="bi bi-chat-left-text"></i> Reason</th>
                                            <th><i class="bi bi-calendar"></i> Request Date</th>
                                            <th><i class="bi bi-gear"></i> Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${requests}" var="request">
                                            <tr>
                                                <td>${request.username}</td>
                                                <td>${request.softwareName}</td>
                                                <td>
                                                    <span class="badge bg-info">
                                                        ${request.accessType}
                                                    </span>
                                                </td>
                                                <td>${request.reason}</td>
                                                <td>${request.requestDate}</td>
                                                <td>
                                                    <div class="btn-group" role="group">
                                                        <form action="${pageContext.request.contextPath}/requests/approve" method="post" class="me-1">
                                                            <input type="hidden" name="requestId" value="${request.id}">
                                                            <button type="submit" class="btn btn-success btn-sm">
                                                                <i class="bi bi-check-lg"></i> Approve
                                                            </button>
                                                        </form>
                                                        <form action="${pageContext.request.contextPath}/requests/reject" method="post">
                                                            <input type="hidden" name="requestId" value="${request.id}">
                                                            <button type="submit" class="btn btn-danger btn-sm">
                                                                <i class="bi bi-x-lg"></i> Reject
                                                            </button>
                                                        </form>
                                                    </div>
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
    </jsp:body>
</t:template>
