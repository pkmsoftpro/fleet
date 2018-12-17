<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html id="ng-app" data-ng-app="createFleetClaim">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<u:stylePicker fileName="quote/quote.css" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css">
<script src="../scripts/fleetClaim/invoiceApp.js"></script>
</head>
<u:body theme="fleet">
	<%@include file="i18N_invoice_javascript_vars.jsp"%>
	<form data-ng-controller="InvoiceController"  name="form" novalidate id="invoiceForm">
	<div ng-show="invoiceForm==true">
	<div class="clear"></div>
	<div class="accordion-header contentPane">
    <spring:message code="label.invoice.generateInvoice" />
    <span class="expand-collapse collapse-icon"></span>
	</div>
	<div class="overflow-hidden accordion-info">
			<div class="labelStyle floatL">
					<spring:message code="label.invoice.customerName" />
					<span class="red">*</span>
			</div>
			<div class="floatL">
					<INPUT TYPE="text" id='customer.name' data-ng-model="customer.name"  name='customer.name'  typeahead-min-length='3' typeahead-on-select="setCustomer($item)"  typeahead="customer.name as customer.name for customer in findCustomersWhoseNameStartingWith($viewValue)" required  />
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
					<spring:message code="label.invoice.invoiceType" />
					<span class="red">*</span>
			</div>
			<div class="floatL">
					<select name="invoiceType" data-ng-model="invoiceType" required ng:change="populateDuration()">
					<option ng:repeat="(key,value) in invoiceTypes" value="{{key}}" required >{{value}}</option>
					</select>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
					<spring:message code="label.invoice.duration" />
					<span class="red">*</span>
			</div>
			<div class="floatL">
					<INPUT TYPE="text"  id='duration' data-ng-model="duration.displayDuration"  name='duration' required data-ng-readonly="true"  />
					<span class="red" data-ng-show="duration.errors[0]">{{duration.errors[0]}}</span>
			</div>
			<div class="clear"></div>
			<div class="centered marB10">
                <button type="button" class="blue-btn btn-primary" data-ng-click="generateInvoice()" ng-disabled='form.$invalid'>
                    <spring:message code="label.Common.submit" />
                </button>
            <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
                <spring:message code="label.Common.cancel" />
            </button>
            </div>
	</div>
	<div class="clear"></div>
	</div>
	<div ng-show="successForm==true">
	 <jsp:include page="../common/success.jsp"></jsp:include>
	</div>
	</form>	
</u:body>
</html>