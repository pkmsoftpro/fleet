<!DOCTYPE html>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="authz" uri="authz"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html id="ng-app" data-ng-app="inclusivescapp">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<script src="../scripts/angular/apps/inclusiveServiceCodeApp.js"></script>
<script type="text/javascript"	src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<u:stylePicker fileName="serviceCodes/serviceCodes.css" />
</head>

<u:body theme="fleet">
	<form data-ng-controller="InclusiveSCController" name="form" novalidate>
		<div alert-msg></div>
		<div class="accordion-header contentPane">
			<!-- accordion header -->
			<spring:message code="label.fleetadmin.inclusiveservicecodes" />
			<span class="expand-collapse collapse-icon"></span>
		</div>
		<div class="overflow-hidden accordion-info">
		  <div>
			<div class="labelStyle floatL">
				<spring:message code="label.inclusiveservicecode.parentccode" />:
				<span class="red">*</span>
			</div>
			<div class="floatL">
				  <input type="text"  data-ng-model="serviceCodeDefinition.code" typeahead-min-length='3' typeahead-on-select="setServiceCodeDefinition($item)" name="serviceCodeDefinition"
                    ng-change="validate()"  typeahead="serviceCodeDefinition.code as serviceCodeDefinition.code for serviceCodeDefinition in getServiceCodes($viewValue)" required/>
			</div>
			<div class="clear"></div>
           </div>
			<div ng-show="loading">
			    <div class="labelStyle floatL">
					<spring:message code="label.serviceCode.description" />:
				</div>
				<div class="floatL">
					<input type="text" ng-model="serviceCodeDefinition.description" data-ng-readonly="true" required/>
				</div>
				<div class="clear"></div>
				<div class="labelStyle floatL">
					<spring:message code="label.serviceCode.category" />:
				</div>
				<div class="floatL">
					<input type="text" ng-model="serviceCodeDefinition.category" data-ng-readonly="true" />
				</div>
				<div class="fieldSpacerWidth floatL">&nbsp;</div>
				<div class="details-sub-header"><span><spring:message code="label.inclusiveCodes.child"/></span></div>
				<div class="containerDiv  marL25 wid1000" ng-model="serviceCodeDefinition.childCodes" repeater="serviceCodeDefinition.childCodes" repeatAttrs="">
				 	<input type="hidden" name="serviceCodeDefinition.childCodes" data-ng-model="serviceCodeDefinition.childCodes"/>
				   	<!-- Header Section -->
					<div class="rowDivHeader">
						<div class="cellDivHeader wid300">
							<spring:message code="label.serviceCode.code" />
						</div>
						<div class="cellDivHeader wid300">
							<spring:message code="label.serviceCode.description" />
						</div>
						<div class="cellDivHeader wid300">
							<spring:message code="label.serviceCode.category" />
						</div>
						<div class="cellDivHeader wid100">
							<a class="add-row"
								ng-click="addInputRow('serviceCodeDefinition.childCodes','code,description,category')"></a>
						</div>
					</div>
					<!-- Repeat Template Section -->
					<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" ng-repeat="sc in serviceCodeDefinition.childCodes"  ng-form='subform' class="wid1000" >
					  <div class="cellDiv wid300">
				   		  <input type="text"  data-ng-model="sc.code" typeahead-min-length='3' typeahead-on-select="setChildServiceCode(this,$index,$item)" name="code" ng-required="true"
                           typeahead="serviceCodeDefinition.code as serviceCodeDefinition.code for serviceCodeDefinition in getServiceCodes($viewValue)" ng-change="validateChildCode(this,$index)"/>
						</div>
						<div class="cellDiv wid300">
							<div ng-bind='sc.description' required></div>
						</div>
						<div class="cellDiv wid300">
							<div ng-bind='sc.category' required></div>
						</div>
						<div class="cellDiv wid100">
							<a class="cellDiv wid100"
								ng-click="deleteThis($index,'serviceCodeDefinition.childCodes')"><i
								class="icon-trash"></i> </a>
						</div>
					</div>
					
				</div>
			</div>
			</div>
			<!-- Buttons -->
			<div class="clear"></div>
			<div class="fieldSpacerWidth floatL">&nbsp;</div>
			<div style="padding-left: 400px;">
			   <authz:ifPermitted resource="manageServiceCodes">
				<button type="button" class="blue-btn btn-primary" data-ng-click="saveInclusiveCode()" ng-disabled='form.$invalid'>
					<spring:message code="label.Common.save" />
				</button>
			    </authz:ifPermitted>
			    <button type="button" class="blue-btn btn-primary" onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
					<spring:message code="label.Common.cancel" />
				</button>
				<!-- ENDButtons -->
			</div>
		
	</form>
</u:body>
</html>