<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>

<c:choose>
    <c:when test="${empty sessionScope.user}">
        <c:redirect url="${pageContext.request.contextPath}/login"/>
    </c:when>
    <c:otherwise>
        <c:choose>
            <c:when test="${fn:toUpperCase(sessionScope.user.role) eq 'ADMIN' || fn:toUpperCase(sessionScope.user.role) eq 'MANAGER'}">
                <c:redirect url="${pageContext.request.contextPath}/requests/pending"/>
            </c:when>
            <c:otherwise>
                <c:redirect url="${pageContext.request.contextPath}/requests/my"/>
            </c:otherwise>
        </c:choose>
    </c:otherwise>
</c:choose>
