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
 <div ng-init="dealerPriceId='${dealerPriceId}'"></div>
 <div ng-init="priceCondition.type='DEALER'"></div>
    <form data-ng-controller="priceConditionController" name="form" novalidate>
        <div alert ng-repeat="alert in alerts" type="alert.type">{{alert.msg}}</div>
         <div class="accordion-header contentPane">
          <!-- accordion header -->
          <c:if test="${isDealer}"> 
                <spring:message code="accordionLabel.managePrices.dealerPricingConditions"/>:
          </c:if>
          <c:if test="${!isDealer}">
          		<spring:message code="accordionLabel.managePrices.customerPricingConditions"/>:
          </c:if>
                <span class="expand-collapse collapse-icon"></span>
         </div>
	     <div class="overflow-hidden accordion-info">
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.ConditionType"/>:
				<span class="red">*</span>
			</div>
			<div class="floatL">
			<select  data-ng-model="priceCondition.conditionType.id"  ng-options="ct.id as ct.code for ct in listOfConditionType" ng-change="setPriceType(priceCondition.conditionType.id)" required>
				  <option value="">-SELECT-</option>
				</select>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.make"/>:
			</div>
			<div class="floatL">
			    <select  data-ng-model="priceCondition.make" ng-options="ct for ct in listMake">
			     <option value="">ALL</option>
			     </select>
			</div>
			<div class="clear"></div>
			 <div class="labelStyle floatL">
				<spring:message code="title.managePrice.customerBillTo"/>:
				<span class="red">*</span>
			</div>
			<div class="floatL">
		          <input  type="text"  url="listOfCustomerBillTos" data-ng-model="priceCondition.customerBillto.customerNumber" fbs-typeahead ng-change="getCustomerLocation(priceCondition.customerBillto.customerNumber)"
		            data-ng-required="true"/>	
			</div>
			 <div class="labelStyle floatL">
				<spring:message code="title.managePrice.location"/>:
			</div>
			<div class="floatL">
				<select data-ng-model="priceCondition.customerLocation.id"  ng-options="ct.id as ct.code for ct in locations">
				 <option value="">ALL</option>
				 </select>
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
				<span class="red">*</span>
			</div>
			<div class="floatL">
			    <select name="priceCondition.materialCode" data-ng-model="priceCondition.materialCode"  ng-options="mc for mc in listMaterialCode" ng-change="lstViewChange(priceCondition.materialCode)" required>
			     <option value="">-SELECT-</option>
			    </select>
			</div>
			<div class="clear"></div>		
			<c:choose>
				<c:when test="${isInternalUser}">
			
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.dealer"/>:
				<span class="red">*</span>
			</div>		
			<div class="floatL">
			   <input  type="text"  url="listServiceProviders" data-ng-model="priceCondition.dealer.name" fbs-typeahead ng-change="getDealer(priceCondition.dealer.name)" required/>
			</div>
				</c:when>
			
				<c:otherwise>
			<div class="floatL">			 
			 	<c:if test="${isDealer}">
			 	<div class="labelStyle floatL">
					<spring:message code="title.managePrice.dealer"/>:
					<span class="red">*</span>
				</div>
			   		<input  type="text"  url="listServiceProviders" data-ng-model="priceCondition.dealer.name" fbs-typeahead ng-change="getDealer(priceCondition.dealer.name)" required />
				</c:if>
				<%-- <c:if test="${!isDealer}">
				<div class="labelStyle floatL">
					<spring:message code="label.attachment.customer"/>
					<span class="red">*</span>
				</div>
                	<input type="text" class="textInput" data-ng-readonly="true" data-ng-model="customerProgramGuideSummary.customer.name" />
           		</c:if> --%>
			</div>
				</c:otherwise>
			</c:choose>
			<div class="labelStyle floatL">
				<spring:message code="label.commom.callType"/>:
			</div>
			<div class="floatL" ng-init="priceCondition.callType=priceCondition.callType==null? listCallTypes[0]:priceCondition.callType">
			    <select  data-ng-model="priceCondition.callType.id"  ng-options="callType.listOfValues.id as callType.listOfValues.name for callType in listCallTypes">
			     <option value="">ALL</option>
			    </select>
			</div>
			<div class="clear"></div>
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.startDate"/>:
				<span class="red">*</span>
			</div>
			<div class="floatL">
			     <input  type="text" data-ng-model='priceCondition.duration.fromDate'  data-datepicker-popup="{{dateFormat}}"  required/>
			
			</div>
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.endDate"/>:
				<span class="red">*</span>
			</div>
			<div class="floatL">
			  <input type="text" data-ng-model='priceCondition.duration.tillDate'  datepicker-popup="{{dateFormat}}" min="priceCondition.duration.fromDate" required/>
			</div>
		   <div class="clear"></div>
		    <div class="labelStyle floatL">
				<spring:message code="title.managePrice.rate"/>:
				<span class="red">*</span>
			</div>
			<div class="floatL">
				<span ng-if="viewPriceModifier==true">
				   <input type="text" is-number data-ng-style="{width:'195px'}" data-ng-model="priceCondition.modifier" ng-required="viewPriceModifier"/><b>%</b>
				</span>
				<span ng-if="viewPriceModifier==false">
				    <div data-ng-init="priceCondition.rate.currency = priceCondition.fleetCustomer.preferredCurrency == null?'USD': priceCondition.fleetCustomer.preferredCurrency">
				    <input type="text"  data-ng-model="priceCondition.rate"  data-ng-style="{width:'180px'}" ng-required="!viewPriceModifier" money/>
				    </div>
				</span>
			</div>
			<div class="labelStyle floatL">
				<spring:message code="title.managePrice.status"/>:
				<span class="red">*</span>
			</div>
			<div class="floatL" ng-init="priceCondition.status=priceCondition.status.length==0?priceCondition.status:true">
			      <select name="priceCondition.status" data-ng-model="priceCondition.status" 
			         ng-options="status.value as status.name for status in  [{value: true, name: 'ACTIVE'}, {value: false, name: 'INACTIVE'}]" required>
                 </select>
     		</div>
			<div class="clear"></div>
			<div ng-show="showMiscView">
			  <div class="labelStyle floatL">
				<spring:message code="title.managePrice.model"/>:
			  </div>
			  <div class="floatL">
			    <input  type="text" fbs-typeahead  data-ng-model='priceCondition.model.name' url="listModels" ng-change="getModel(priceCondition.model.name)"/>
			  </div>
			   <div class="labelStyle floatL">
				<spring:message code="title.managePrice.competitorModel"/>:
			  </div>
			   <div class="floatL">
			    <input type="text"  data-ng-model="priceCondition.competitorBrandModel.competitorModelName" typeahead-min-length='3' typeahead-on-select="setCompetitorModel($item)"
                           typeahead="competitorBrandModel.competitorModelName as competitorBrandModel.competitorModelName for competitorBrandModel in getCompetitorModel($viewValue)"/>
			  </div>
			  <div class="clear"></div>
			  <div class="labelStyle floatL">
				<spring:message code="title.managePrice.subCostCode"/>:
			  </div>
			  <div class="floatL">
			    <select data-ng-model="priceCondition.subCodeItem.miscSubcostcodeRef.id" ng-options="msc.id as msc.code for msc in miscSubCodesList">
			     <option value="">ALL</option>
			    </select>
			  </div>
			</div>  
			<div ng-show="showPartView">
			 <div class="labelStyle floatL">
				<spring:message code="title.managePrice.subCostCode"/>:
			 </div>
			 <div class="floatL">
			    <input type="text"  data-ng-model="priceCondition.subCodeItem.subCostCode"/>
			 </div>
			 </div>
			<div ng-hide="viewPriceModifier==true || priceCondition.materialCode =='DRAYAGE'">
			 <div class="labelStyle floatL">
				<spring:message code="title.managePrice.uom"/>:
				<span class="red">*</span>
			</div>
			<div class="floatL">
			    <select data-ng-model="priceCondition.uom" ng-options="uom for uom in listUOM" data-ng-disabled="true"></select>
			</div>
			</div>
      </div>
        <div style="padding-left: 400px;" ng-show="!successPage">
		 
		 	<c:if test="${isDealer}"> 
				<button type="button" class="blue-btn btn-primary"
					data-ng-click="savePrice()" ng-disabled='form.$invalid'>
					<spring:message code="label.Common.save" />
				</button>
			 </c:if>
			<c:if test="${!isDealer}">
				<button type="button" class="blue-btn btn-primary"
					data-ng-click="saveCustomerPrice()" ng-disabled='form.$invalid'>
					<spring:message code="label.Common.save" />
				</button>
			</c:if>
			<%-- </authz:ifPermitted> --%>
			<button type="button" class="blue-btn btn-primary" data-ng-click="cancel()"
                    onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                    <spring:message code="label.Common.cancel" />
                </button>
       </div>
</form>
</u:body>
</html>
