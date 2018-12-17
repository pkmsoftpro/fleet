<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<s:head theme="fleet" />
		<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
		<link rel='stylesheet prefetch' href='http://netdna.bootstrapcdn.com/font-awesome/4.0.0/css/font-awesome.min.css'>
	</head>
	<u:body theme="fleet">
		<div class="accordion-header contentPane">
	         <spring:message code="accordionLabel.programGuideSummary.dealer"/>
	         <span class="expand-collapse collapse-icon"></span>
	    </div>
		<div class="overflow-hidden accordion-info">
			<table>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.serviceCode.dealerName"/>  
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.dealer.name}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="columnTitle.inventory.customerName"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.customer.name}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="column.customer.number"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.customer.customerNumber}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.key.contacts"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.keyContacts}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.labour.rates"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.labourRates}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.parts.pricing"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.partsPricing}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.fleetClaim.travel"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.travel}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.quote.requirement"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.quoteRequirement}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.purchase.order.requirement"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.purchaseOrderRequirement}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.serviceRequest.quickSearch"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.serviceRequest}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.service.expectations"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.serviceExpectations}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.tires.and.wheels"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.tiresAndWheels}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.claim.submission.instructions"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.claimSubmissionInstructions}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.loaner.process"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.loanerProvision}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.billing.allowances"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.billingAllowances}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.program.exclusions"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.programExclusions}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="title.common.specialInstructions"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.specialInstructions}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.pm.services"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${dealerProgramGuideSummary.periodicMaintenanceServices}<br><br>
					</td>
				<tr>
			</table>
			<div class="clear"></div>
		</div>	
	</u:body>
</html>
