<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags" %>

<t:template>
    <jsp:attribute name="title">Software List</jsp:attribute>
    <jsp:body>
        <div class="container mt-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2><i class="bi bi-list-ul"></i> Software List</h2>
                <c:if test="${pageContext.request.isUserInRole('Admin')}">
                    <a href="${pageContext.request.contextPath}/software/create" class="btn btn-primary">
                        <i class="bi bi-plus-circle"></i> Add New Software
                    </a>
                </c:if>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    <i class="bi bi-exclamation-triangle"></i> ${error}
                </div>
            </c:if>

            <c:choose>
                <c:when test="${empty softwareList}">
                    <div class="alert alert-info" role="alert">
                        <i class="bi bi-info-circle"></i> No software found.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Access Levels</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="software" items="${softwareList}">
                                    <tr>
                                        <td>${software.name}</td>
                                        <td>${software.description}</td>
                                        <td>
                                            <c:forEach var="level" items="${software.accessLevels}" varStatus="status">
                                                <span class="badge bg-primary">${level}</span>
                                                <c:if test="${not status.last}">&nbsp;</c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </jsp:body>
</t:template>
