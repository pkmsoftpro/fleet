<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html id="ng-app" data-ng-app="equipmentApp">
<u:stylePicker fileName="quote/quote.css" />
<u:stylePicker fileName="quote/tableFormat.css" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<script type="text/javascript"
	src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<script src="../scripts/equipment/equipmentApp.js"></script>
<link rel="stylesheet" type="text/css" href="../css/search_pages.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
</head>
<u:body theme="fleet">
    <div alert-msg></div>
	<%@include file="i18N_equipment_javascript_vars.jsp"%>
	<form data-ng-controller="equipmentTransferController" name="form" novalidate
		style="border: 0px #b5bcc7 solid; padding: 0px;padding-bottom:5px">

		<div class="accordion-header contentPane">	<!-- accordion header -->
		<spring:message code="search.manage.inventory.TransferCustomerUnits"/>
		<span class="expand-collapse collapse-icon"></span>
	</div>
	<div class="overflow-hidden accordion-info">
		
      <div class="clear"></div>
 	<div>
		<div class="containerDiv"  style="width: 990px;"
			ng-init="equipmentTransferUnitBean.fleetInventoryItems = equipmentTransferUnitBean.fleetInventoryItems == null ? [] : equipmentTransferUnitBean.fleetInventoryItems"
			 data-ng-model="equipmentTransferUnitBean.fleetInventoryItems" repeater>
				<input type="hidden" name="equipmentTransferUnitBean.fleetInventoryItems" data-ng-model="equipmentTransferUnitBean.fleetInventoryItems"/>
				<div class="rowDivHeader">
					<div class="cellDivHeader wid150">
						<spring:message code="label.tranferUnit.truckSerialNo" />
					</div>
					 <div class="cellDivHeader wid150">
						<spring:message code="label.tranferUnit.series" />
					</div>
					<div class="cellDivHeader wid150">
						<spring:message code="label.tranferUnit.model" />
					</div>
					<div class="cellDivHeader wid150">
						<spring:message code="label.tranferUnit.shipTo" />
					</div>
					<div class="cellDivHeader wid150">
						<spring:message code="label.tranferUnit.itemCondition" />
					</div>
					<div class="cellDivHeader wid150">
						<spring:message code="label.tranferUnit.buildDate" />
					</div> 
					<div class="cellDivHeader wid102">
						<a class="add-row" ng-click="addInputRow('equipmentTransferUnitBean.fleetInventoryItems','serialNumber,fleetInventoryItem.inventoryItem.ofType.subSeriesCode,fleetInventoryItem.model.groupCode,fleetInventoryItem.equipmentCondition')"></a>
					</div>
				</div>
				<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" ng-repeat="fleetInventoryItem in equipmentTransferUnitBean.fleetInventoryItems">
					<div class="cellDiv wid150">
						<input type="text" data-ng-model="fleetInventoryItem.serialNumber"
							url="listInventoryItemsForTransfer" fbs-typeahead ng-change="getSerialnoDetails($index,fleetInventoryItem.serialNumber)" required />
					</div>
					<div class="cellDiv wid150">
						<input type="text"  data-ng-model="fleetInventoryItem.product.groupCode" readonly=true />
					</div>

					<div class="cellDiv wid150">
						<input type="text"
							data-ng-model="fleetInventoryItem.model.groupCode"
							readonly=true />
					</div>

					<div class="cellDiv wid150">
						<input type="text"  data-ng-model="fleetInventoryItem.activeFleetInventoryAudit.shipTo.code"
							
							readonly=true />
					</div>
					<div class="cellDiv wid150">
						<input type="text" name="fleetInventoryItem.equipmentCondition" data-ng-model="fleetInventoryItem.equipmentCondition"
							readonly=true />
					</div>
					
					<div class="cellDiv wid150">
						<input type="text" data-ng-model="fleetInventoryItem.installDate"
							readonly=true />
					</div>
					<div class="cellDiv wid102">
						<a class="class"
							ng-click="deleteThis($index,'equipmentTransferUnitBean.fleetInventoryItems')"><i
							class="icon-trash"></i> </a>
					</div> 
				</div>
			</div>
		</div>
</div>		
	<div class="accordion-header contentPane">	<!-- accordion header -->
		<spring:message code="label.tranferUnit.searchLocation"/>
		<span class="expand-collapse collapse-icon"></span>
	</div>
	<div class="overflow-hidden accordion-info">
			 <div class="clear"></div>
                <div class="labelStyle floatL">
                    <table>
                        <tr>
							<td class="floatL" ng-show="isCustomerNumber"><spring:message code="columnTitle.quote.customerNumber"/> </td>
                            <td class="floatL" ng-hide="isCustomerNumber"><spring:message code="label.common.customerName"/> </td>
							<td class="floatL">
                              <%-- <a class="text-link" href="#"
								ng-click="toggleCustomerNumber()" ng-hide="isCustomerNumber">
										<spring:message code="label.tranferUnit.showCustomerNumber" /> 
							  </a> --%>
							  <a class="text-link" href="#" ng-click="toggleCustomerNumber()"
								ng-show="isCustomerNumber"><spring:message code="label.tranferUnit.showCustomerName" />
							  </a>
							</td>
                        </tr>                        
                    </table>
                </div>
                   <div class="floatL">
                    <input type="text"  url="listOfFleetCustomers" id="customerNumber"  ng-show="isCustomerNumber"
                         fbs-typeahead ng-change="getCustomerLocationsByName(equipmentTransferUnitBean.fleetCustomer.customerNumber)" data-ng-model="equipmentTransferUnitBean.fleetCustomer.customerNumber" required />
									
                    <input type="text"  url="listCustomersBelongsToAnOrganization" id="customerName" ng-hide="isCustomerNumber"
                         fbs-typeahead  ng-change="getCustomerLocationsByName(equipmentTransferUnitBean.fleetCustomer.name)" data-ng-model="equipmentTransferUnitBean.fleetCustomer.name" required />
                   </div>
               
                <div class="clear"></div>
                <div class="fieldSpacerHeight" style="height:8px;"></div>
				<div>	
					  <div class="labelStyle floatL" style="padding-left:6px">
								<spring:message code="title.managePrice.locationCode"/>
					   </div>
		              <div class="floatL marR20">
						<select data-ng-model="equipmentTransferUnitBean.customerLocation"  ng-options="ct.locationsMapkey as ct.locationsMapkey for ct in locations" required>
					 	<option value=""><spring:message code="label.common.select" /></option>
					 	</select>
					</div>
                	 </div>
			   <div class="overflow-hidden clearAll">
			   <div class="" style="margin-left:206px">
			 
					<button type="button" class="blue-btn btn-primary"
						data-ng-click="performTransfer()" ng-disabled='form.$invalid'>
						<spring:message code="label.tranferUnit.button.performTransfer" />
					</button>
			 </div>
			 </div>
		</div>		
	</form>
</u:body>
</html>