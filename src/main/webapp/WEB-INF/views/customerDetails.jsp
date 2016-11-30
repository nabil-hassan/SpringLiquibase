<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<html>

<head>
    <%@ include file="include/header.jsp"%>
    <spring:url value="/customerForm/submit" var="form_submit_url"/>
    <title>Spring MVC Basic Form w/ backing object</title>
</head>

<body>
    <h2>Spring MVC Customer Form</h2>
    <p>This section illustrates a very basic form which passes data to and form server as a backing object.</p>
    <a href="${pageContext.request.contextPath}">home</a>
    <hr/>

    <div id="responsePanel" class="responsePanel">
        <p>${responseMsg}</p>
    </div>

    <div id="errorPanel" class="errorPanel">
        <p>${errorMsg}</p>
    </div>

    <div id="formPanel">
        <form:form action="${form_submit_url}" modelAttribute="customer" method="POST">
            <fieldset>
                <legend>Login</legend>
                <br/>
                <span>
                    <form:hidden path="id" id="id"/>
                </span>
                <span>
                    <label for="forename">Forename</label>
                    <form:input path="forename" type="text" id="forename" placeholder="enter forename"/>
                    <form:errors path="forename"/>
                </span>
                <br/><br/>
                <span>
                        <label for="surname">Surname</label>
                        <form:input path="surname" type="text" id="surname" placeholder="enter surname"/>
                        <form:errors path="surname"/>
                    </span>
                <br/><br/>
                <span>
                        <label for="age">Age</label>
                        <form:input path="age" type="number" id="age" placeholder="enter age"/>
                        <form:errors path="age"/>
                    </span>
                <br/><br/>
                        <form:button id="submit">Submit</form:button>
                    </span>
            </fieldset>
        </form:form>
    </div>

</body>