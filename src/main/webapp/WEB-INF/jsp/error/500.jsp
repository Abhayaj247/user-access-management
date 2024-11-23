<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../base.jsp">
    <jsp:param name="title" value="Server Error"/>
    <jsp:body>
        <div class="row justify-content-center">
            <div class="col-md-6 text-center">
                <div class="card">
                    <div class="card-body">
                        <h1 class="display-1">500</h1>
                        <h4 class="mb-4">Internal Server Error</h4>
                        <p class="text-muted">An unexpected error occurred. Please try again later.</p>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</jsp:include>
