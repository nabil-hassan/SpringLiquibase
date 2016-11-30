<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <%@ include file="include/header.jsp"%>
    <title>Customer List</title>
    <spring:url value="/customerForm" var="form_url"/>
</head>

<body>
    <h1>Spring MVC Customer List</h1>
    <p>This section illustrates how to bind a list of entities.</p>
    <a href="${pageContext.request.contextPath}">home</a>
    <hr/>

    <div id ="resultsPanel">
        <c:choose>
            <c:when test="${(empty customers) || (customers.size() == 0)}">
                <p>No customers exist in the system</p>
            </c:when>

            <c:otherwise>
                <p>Here are the customers</p>
                <table>
                    <tr>
                        <th>Id</th>
                        <th>Forename</th>
                        <th>Surname</th>
                        <th>Age</th>
                    </tr>
                    <c:forEach items="${customers}" var="customer">
                        <tr>
                            <td><a href="${form_url}?customerId=${customer.id}">${customer.id}</a></td>
                            <td>${customer.forename}</td>
                            <td>${customer.surname}</td>
                            <td>${customer.age}</td>
                        </tr>
                    </c:forEach>
                </table>
            </c:otherwise>
        </c:choose>
    </div>
</body>

</html>
