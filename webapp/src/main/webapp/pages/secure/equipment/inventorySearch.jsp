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
<script src="../scripts/equipment/equipmentApp.js"></script>
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css">
<script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
<link rel="stylesheet" type="text/css" href="../css/search_pages.css" />
</head>
<u:body theme="fleet">
  <%@include file="i18N_equipment_javascript_vars.jsp"%>
    <form data-ng-controller="equipmentSearchController" name="form" novalidate style="border: 1px #b5bcc7 solid;padding: 1px">
        <table border="0" cellspacing="0" cellpadding="0" class="grid wid-100p">
        <tbody>
        <tr>
        <td>
		<div id="section_header" class="section_header commomPrint marB10">
                    <spring:message code="search.manage.inventory.ManageInventory"/>
		</div>
		</td>
		</tr>
		<tr>
		<td>
			<div class="labelStyle" style="float: left;">
				<spring:message code="search.manage.inventory.serialnumber"/> :
			</div>		
			<div  class="inputStyle">
				<input  type="text" id="serialNumber"  name="fleetInventoryitem.serialNumber" data-ng-model="fleetInventoryitem.serialNumber"  
				ng-change="setFleetInventoryId(fleetInventoryitem.serialNumber)"
				url="getInventories" fbs-typeahead/>
			</div>
                    <div ng-show='fleetInventoryitem.serialNumber' class="floatL">
                        <img id="serialNumberAlert" src="../image/ui-ext/validation/alerts.gif" class="marT10" class="visibility-hidden"
                            tooltip="<spring:message code='label.common.serialNumber.invalid'/>" />
                    </div>
		</td>
		</tr>
		<tr>	
		<td>
			<div class="labelStyle" style="float: left;">
				<spring:message code="search.manage.inventory.assetnumber"/> :
		    </div>		
			<div class="inputStyle">
				<input type="text" id="assetNumber" name="assetNumber" data-ng-model="fleetInventoryitem.assetNumber"   
				ng-change="setFleetInventoryAssetNumber(fleetInventoryitem.assetNumber)" url="listInventoryItemsByAssetNumber" fbs-typeahead  />
			</div>
			<div ng-show='form.assetNumber.$error.invalid' class="floatL">
                        <img id="assetNumberAlert" src="../image/ui-ext/validation/alerts.gif" class="marT10" 
                            tooltip="<spring:message code='label.common.assetNumber.invalid'/>" /> 
           </div>
		</td>	
		</tr>
		</tbody>
		</table>	
		<!-- Buttons -->
            <div style="padding: 0 0 5px 220px;">
            <button type="button"  class="blue-btn" data-ng-click="reset()"><spring:message code="search.manage.inventory.reset" /></button>
			<button type="button"  class="blue-btn" data-ng-click="searchFleetInventory()"><spring:message code="search.manage.inventory.searchButton" /></button>
		   </div>
	   
    </form>
 </u:body>
</html>