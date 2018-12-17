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
	         <spring:message code="accordionLabel.programGuideSummary.customer"/>
	         <span class="expand-collapse collapse-icon"></span>
	    </div>
		<div class="overflow-hidden accordion-info">
			<table>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="columnTitle.inventory.customerName"/>  
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.customer.name}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="column.customer.number"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.customer.customerNumber}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.primary.program.type"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.primaryProgramType}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.representative.contacts"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.representativeContacts}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.billing.intervals"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.billingIntervals}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.dispute.process"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.disputeProcess}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.alternate.service.providers"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.alternateServiceProviders}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.service.request.process"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.serviceRequestProcess}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.po.requirement"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.purchaseOrderRequirement}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.response.time"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.responseTime}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.after.hours.process"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.afterHoursProcess}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.threshold"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.quoteThreshold}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.loaner.process"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.loanerProcess}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.reporting"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.reporting}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.travel.stipulations"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.travelStipulations}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.billing.allowances"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.billingAllowances}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.notes.and.exclusions"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.notesAndExclusions}<br><br>
					</td>
				</tr>
				<tr>
					<td class="labelStyle align-top">
						<spring:message code="label.common.pm.intervals"/> 
					</td>
					<td class="labelStyle align-top">:</td>
					<td class="align-top floatL">
						${customerProgramGuideSummary.periodicMaintenanceInterval}<br><br>
					</td>
				<tr>
			</table>
			<div class="clear"></div>
		</div>	
	</u:body>
</html>
