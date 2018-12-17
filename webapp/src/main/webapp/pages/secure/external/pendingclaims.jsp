<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
	<head>
		<s:head theme="twms"/>
		<title><s:text name="Pending Payment"/></title>
		<u:stylePicker fileName="base.css"/>
    	<u:stylePicker fileName="yui/reset.css" common="true"/>
    	<u:stylePicker fileName="layout.css" common="true"/>
	    <script type="text/javascript">
	        dojo.require("dijit.layout.LayoutContainer");
	        dojo.require("dojox.layout.ContentPane");
	        dojo.require("dijit.layout.BorderContainer");
	    </script>
	</head>
	<u:body >
		<br/>
		<div style="text-align: center;">
			<h2>
				<spring:message code="title.viewClaim.manualyClickNote"/> 
			</h2>
		</div>
		<br/>
		
		
		<%-- <c:forEach items="${pendingClaims}" var="claim">
			<div style="margin-left: 5px;">
				<c:choose>
					<c:when test="${claim.activeFleetClaimAudit.payment.activeCreditMemo == null}">
						<a href="paymentAcknowledge?responseIndex=1&id=<c:out value="${claim.id}"/>">
							<spring:message code="label.commom.claimNumber"/> : <c:out value="${claim.fleetClaimNumber}" />
						</a>
					</c:when>
					<c:when test="${claim.activeFleetClaimAudit.payment.activeCreditMemo.responseType == 'INITIAL_RESPONSE_INFO'}">
						<a href="paymentAcknowledge?responseIndex=2&id=<c:out value="${claim.id}"/>">
							<spring:message code="label.commom.claimNumber"/> : <c:out value="${claim.fleetClaimNumber}" />
						</a>
					</c:when>
					<c:when test="${claim.activeFleetClaimAudit.payment.activeCreditMemo.responseType == 'INVOICING_RESPONSE_INFO'}">
						<a href="paymentAcknowledge?responseIndex=3&id=<c:out value="${claim.id}"/>">
							<spring:message code="label.commom.claimNumber"/> : <c:out value="${claim.fleetClaimNumber}" />
						</a>
					</c:when>
					<c:otherwise>
						<a href="paymentAcknowledge?responseIndex=3&id=<c:out value="${claim.id}"/>">
							<spring:message code="label.commom.claimNumber"/> : <c:out value="${claim.fleetClaimNumber}" />
						</a>
					</c:otherwise>
				</c:choose>
			</div>
		</c:forEach> --%>
	</u:body>
</html>	