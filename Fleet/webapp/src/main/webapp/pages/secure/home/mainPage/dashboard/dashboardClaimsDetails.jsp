<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
</head>
<u:body theme="fleet">
        <div class="accordion-header contentPane">
          <!-- accordion header -->
                 <c:if test="${dashboardClaimdetails.outstanding ==true}">
                  <spring:message code="columnTitle.claimsListing.outstandingDetails" />
                </c:if>
                <c:if test="${dashboardClaimdetails.claimage==true}">
                  <spring:message code="columnTitle.claimsListing.claimageDetails" />
                </c:if>
                <c:if test="${dashboardClaimdetails.requiringInfo==true}">
                  <spring:message code="columnTitle.claimsListing.requiringInfoDetails" />
                </c:if>
                <c:if test="${dashboardClaimdetails.processedClaim==true}">
                  <spring:message code="columnTitle.claimsListing.processedClaimDetails" />
                </c:if>
                <c:if test="${dashboardClaimdetails.adjustedclaim==true}">
                  <spring:message code="columnTitle.claimsListing.adjustedClaimDetails" />
                </c:if>
                <span class="expand-collapse collapse-icon"></span>
         </div>
	     <div class="overflow-hidden accordion-info">
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.slmsClaimNumber"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.slmsClaimNumber}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.slmsSRNumber"/>
			</div>
			<div style="float: left;">
				<input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.slmsSRNumber}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.dealerW0Number"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.dealerW0Number}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.dealerClaimNumber"/>
			</div>
			<div style="float: left;">
				<input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.dealerClaimNumber}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.dealerInvoiceNumber"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.dealerInvoiceNumber}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.creditMemoNumber"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.creditMemoNumber}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.serialNumber"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.serialNumber}" readonly="readonly"/>
			</div>
		   <div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.servicingBranch"/>
			</div>
			<div class="floatL">
			  	  <input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.servicingBranch}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.customerBillTo"/>
			</div>
			<div class="floatL" ng-if="priceCondition.status==true">
			      <input type="text"  name="dashboardClaimdetails" value="${dashboardClaimdetails.customerBillTo}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.customerName"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.customerName}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			 <div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.callType"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.callType}" readonly="readonly"/>
			</div>
			 <div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.claimStatus"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.claimStatus}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			  <div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.quoteNumber"/>
			  </div>
			  <div class="floatL">
			    <input type="text"  name="dashboardClaimdetails" value="${dashboardClaimdetails.quoteNumber}" readonly="readonly" />
			  </div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.totalRequestedAmount"/>
			</div>
			<div class="floatL">
			    <input type="text"  name="dashboardClaimdetails" value="${dashboardClaimdetails.totalRequestedAmount}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			 <div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.totalApprovedAmount"/>
			</div>
			 <div class="floatL">
			    <input type="text"name="dashboardClaimdetails" value="${dashboardClaimdetails.totalApprovedAmount}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.workPerformed"/>
			</div>
			 <div class="floatL">
			    <input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.workPerformed}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			 <div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.requestedLabor"/>
			</div>
			 <div class="floatL">
			    <input type="text"name="dashboardClaimdetails" value="${dashboardClaimdetails.requestedLabor}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.requestedParts"/>
			</div>
			 <div class="floatL">
			    <input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.requestedParts}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			 <div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.requestedTravel"/>
			</div>
			 <div class="floatL">
			    <input type="text"name="dashboardClaimdetails" value="${dashboardClaimdetails.requestedTravel}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.requestedDrayage"/>
			</div>
			 <div class="floatL">
			    <input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.requestedDrayage}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			 <div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.requestedMisc"/>
			</div>
			 <div class="floatL">
			    <input type="text"name="dashboardClaimdetails" value="${dashboardClaimdetails.requestedMisc}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.approvedLabor"/>
			</div>
			 <div class="floatL">
			    <input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.approvedLabor}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			 <div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.approvedParts"/>
			</div>
			 <div class="floatL">
			    <input type="text"name="dashboardClaimdetails" value="${dashboardClaimdetails.approvedParts}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.approvedTravel"/>
			</div>
			 <div class="floatL">
			    <input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.approvedTravel}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			 <div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.approvedDrayage"/>
			</div>
			 <div class="floatL">
			    <input type="text"name="dashboardClaimdetails" value="${dashboardClaimdetails.approvedDrayage}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.claimsListing.approvedMisc"/>
			</div>
			 <div class="floatL">
			    <input type="text" name="dashboardClaimdetails" value="${dashboardClaimdetails.approvedMisc}" readonly="readonly"/>
			</div>
			</div>
			<div style="padding-left: 400px;">
		    	<button type="button" class="blue-btn btn-primary" onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                    <spring:message code="label.Common.cancel"/>
                </button>
            </div>
</u:body>
</html>