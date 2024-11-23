<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="../base.jsp">
    <jsp:param name="title" value="Page Not Found"/>
    <jsp:body>
        <div class="row justify-content-center">
            <div class="col-md-6 text-center">
                <div class="card">
                    <div class="card-body">
                        <h1 class="display-1">404</h1>
                        <h4 class="mb-4">Page Not Found</h4>
                        <p class="text-muted">The page you are looking for does not exist or has been moved.</p>
                        <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Go Home</a>
                    </div>
                </div>
            </div>
        </div>
    </jsp:body>
</jsp:include>
