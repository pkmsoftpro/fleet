<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html id="ng-app" data-ng-app="priceConditionsApp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<script src="../scripts/angular/apps/pricingConditionApp.js"></script>
</head>
<u:body theme="fleet">
<div ng-init="customerPriceId='${customerPriceId}'"></div>
<div ng-init="isCustomer='${isCustomer}'"></div>
    <div data-ng-controller="priceConditionController">    
        <div class="accordion-header contentPane">
          <!-- accordion header -->
                <spring:message code="title.managePrice.CustomerPriceConfiguration" />
                <span class="expand-collapse collapse-icon"></span>
         </div>
	     <div class="overflow-hidden accordion-info">
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.ConditionType"/>:
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="priceCondition.conditionType.code" data-ng-readonly="true"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.make"/>:
			</div>
			<div style="float: left;">
				<input type="text" data-ng-model="priceCondition.make" data-ng-readonly="true"/>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.customerBillTo"/>:
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="priceCondition.customerBillto.customerNumber" data-ng-readonly="true"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.location"/>:
			</div>
			<div style="float: left;">
				<input type="text" data-ng-model="priceCondition.customerLocation.code" data-ng-readonly="true"/>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.salesAreaCode"/>:
			</div>
			<div class="floatL">
			    <input type="text" data-ng-model="priceCondition.customerBillto.salesAreaCode.displayName"  data-ng-readonly="true"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.materialCode"/>:
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="priceCondition.materialCode" data-ng-readonly="true"/>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.startDate"/>:
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="priceCondition.duration.fromDate" ui-date ui-date-format={{dateFormat}}  data-ng-disabled="true"/>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.endDate"/>:
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="priceCondition.duration.tillDate" ui-date ui-date-format={{dateFormat}} data-ng-disabled="true"/>
			</div>
			<div class="clear"></div>
		   <div class="labelStyle floatL">
				<spring:message code="title.managePrice.rate"/>:
			</div>
			<div class="floatL">
			    <span ng-if="priceCondition.conditionType.modifier==false">
				  <input type="text" name="priceCondition.rate" data-ng-model="priceCondition.rate" data-disable="true"  data-ng-style="{width:'180px'}" money/>
				</span>
				<span ng-if="priceCondition.conditionType.modifier==true">
				   <input type="text" data-ng-style="{width:'195px'}"  data-ng-model="priceCondition.modifier" data-ng-readonly="true"/><b>%</b>
				</span>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.status"/>:
			</div>
			<div class="floatL" ng-if="priceCondition.status==true">
			      <input type="text"  name="priceCondition.status" value="ACTIVE" data-ng-readonly="true"/>
			</div>
			<div class="floatL" ng-if="priceCondition.status==false">
			   <input type="text" name="priceCondition.status" value="INACTIVE" data-ng-readonly="true"/>
			</div>      
			<div class="clear"></div>
			 <div ng-show="showMiscView">
			 <div class="labelStyle floatL">
				<spring:message code="title.managePrice.model"/>:
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="priceCondition.model.name" data-ng-readonly="true"/>
			</div>
			 <div class="labelStyle floatL">
				<spring:message code="title.managePrice.competitorModel"/>:
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="priceCondition.competitorBrandModel.competitorModelName" data-ng-readonly="true"/>
			</div>
			</div>
		     <div class="clear"></div>
			 <div class="labelStyle floatL">
				<spring:message code="label.commom.callType"/>:
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="priceCondition.callType.name" data-ng-readonly="true"/>
			</div>
			<div ng-show="showMiscView">
			  <div class="labelStyle floatL">
				<spring:message code="title.managePrice.subCostCode"/>:
			  </div>
			  <div class="floatL">
			    <input type="text"  data-ng-model="priceCondition.subCodeItem.miscSubcostcodeRef.code" data-ng-readonly="true" />
			  </div>
			</div>
			<div ng-show="showPartView">
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.subCostCode"/>:
			</div>
			<div class="floatL">
			    <input type="text"  data-ng-model="priceCondition.subCodeItem.subCostCode" data-ng-readonly="true"/>
			</div>
			</div>
			<div ng-hide="viewPriceModifier==true || priceCondition.materialCode =='DRAYAGE'">
			 <div class="labelStyle floatL">
				<spring:message code="title.managePrice.uom"/>:
			</div>
			 <div class="floatL">
			    <input type="text" data-ng-model="priceCondition.uom" data-ng-readonly="true"/>
			</div>
			</div>			
			</div>					
      </div>
</u:body>
</html>