<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
<body>
    <c:choose>
        <c:when test="${result=='updated'}">
            <div style="background-color: #dff0d8; text-align: center; width: 750px; margin-left: 250px;">
                <div align="center" style="color: green; font-size: 110%; font-weight: bold;"><spring:message code="message.serviceRequest.etaUpdatedSuccess" /></div>
            </div>
        </c:when>
        <c:when test="${result=='notUpdated'}">
            <div style="background-color: #dff0d8; text-align: center; width: 750px; margin-left: 250px;">
                <div align="center" style="color: green; font-size: 110%; font-weight: bold;"><spring:message code="message.serviceRequest.etaUpdatedAlready" /></div>
            </div>
        </c:when>
        <c:otherwise>
            <div style="background-color: #FAFAD2; text-align: center; width: 750px; margin-left: 250px;">
                <div align="center" style="color: red; font-size: 110%; font-weight: bold;"><spring:message code="message.serviceRequest.notAuthorizedOnEta" /></div>
            </div>
        </c:otherwise>
    </c:choose>
</body>
</html>
