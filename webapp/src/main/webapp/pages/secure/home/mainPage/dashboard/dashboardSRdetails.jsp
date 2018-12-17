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
                 <c:if test='${dashboardSRdetails.missedPM ==true}'>
                  <spring:message code="columnTitle.SRListing.missedPMDetails" />
                </c:if>
                 <c:if test='${dashboardSRdetails.missedPM==false}'>
                   <spring:message code="columnTitle.SRListing.serviceResponseDetails" />
                </c:if>
                <span class="expand-collapse collapse-icon"></span>
         </div>
	     <div class="overflow-hidden accordion-info">
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.shipTo"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardSRdetails" value="${dashboardSRdetails.locationShipTo}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.customerName"/>
			</div>
			<div style="float: left;">
				<input type="text" name="dashboardSRdetails" value="${dashboardSRdetails.customerName}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.servicingBranch"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardSRdetails" value="${dashboardSRdetails.servicingBranch}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.serialNumber"/>
			</div>
			<div style="float: left;">
				<input type="text" name="dashboardSRdetails" value="${dashboardSRdetails.serialNumber}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.serviceRequestedDate"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardSRdetails" value="${dashboardSRdetails.serviceRequestedDate}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.startRepairDate"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardSRdetails" value="${dashboardSRdetails.startRepairDate}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.externalCallType"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardSRdetails" value="${dashboardSRdetails.externalCallType}" readonly="readonly"/>
			</div>
		   <div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.customerPONumber"/>
			</div>
			<div class="floatL">
			  	  <input type="text" name="dashboardSRdetails" value="${dashboardSRdetails.customerPONumber}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.daysToRespond"/>
			</div>
			<div class="floatL" ng-if="priceCondition.status==true">
			      <input type="text"  name="dashboardSRdetails" value="${dashboardSRdetails.daysToRespond}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.dealerWONumber"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardSRdetails" value="${dashboardSRdetails.dealerWONumber}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			 <div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.dealerClaimNumber"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardSRdetails" value="${dashboardSRdetails.dealerClaimNumber}" readonly="readonly"/>
			</div>
			 <div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.customerLocationPhNo"/>
			</div>
			<div class="floatL">
				<input type="text" name="dashboardSRdetails" value="${dashboardSRdetails.customerLocationPhNo}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			  <div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.customerLocationContact"/>
			  </div>
			  <div class="floatL">
			    <input type="text"  name="dashboardSRdetails" value="${dashboardSRdetails.customerLocationContact}" readonly="readonly" />
			  </div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.lastPMDate"/>
			</div>
			<div class="floatL">
			    <input type="text"  name="dashboardSRdetails" value="${dashboardSRdetails.lastPMDate}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			 <div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.nextPMDate"/>
			</div>
			 <div class="floatL">
			    <input type="text"name="dashboardSRdetails" value="${dashboardSRdetails.nextPMDate}" readonly="readonly"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="columnTitle.SRListing.serviceRequestStatus"/>
			</div>
			 <div class="floatL">
			    <input type="text" name="dashboardSRdetails" value="${dashboardSRdetails.serviceRequestStatus}" readonly="readonly"/>
			</div>
			<div class="clear"></div>
			</div>
			<div style="padding-left: 400px;">
		    	<button type="button" class="blue-btn btn-primary" onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                    <spring:message code="label.Common.cancel"/>
                </button>
            </div>
</u:body>
</html>