<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<spring:eval expression="@fleetProperties.getProperty('googleMapsAPI.businessKey.enabled')" var="businessAPIKeyEnabled" />
<c:choose>
	<c:when test="${businessAPIKeyEnabled}">
		<script type="text/javascript"
		src="https://maps.googleapis.com/maps/api/js?client=<spring:eval expression="@fleetProperties.getProperty('googleMapsAPI.business.clientId')" />&sensor=false"></script>
	</c:when>
	<c:otherwise>
		<script type="text/javascript"src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
	</c:otherwise>
</c:choose>

<div>
    <div class="labelStyle floatL">
        <spring:message code="label.common.dealerName" /><span ng-show="task.takenTransition=='Assign' || task.takenTransition=='reAssign'" class="red">*</span>
    </div>
    <div class="floatL">
             <input type="text" url="listServiceProviders" id="dealerName" name="dealerName" ng-required="task.takenTransition=='Assign' || task.takenTransition=='reAssign'"
                        data-ng-model="serviceRequest.forDealer.name" ng-change="getDealerLocations(serviceRequest.forDealer.name)" fbs-typeahead />
                      
                  
    </div>
                <div class="fieldSpacerWidth floatL hgt30">
                    <div ng-show='form.dealerName.$error.invalid' class="floatL">
                        <img src="../image/ui-ext/validation/alerts.gif" class="marT10" tooltip="<spring:message code='label.common.serialNumber.invalid'/>" />
                    </div>
                </div>
               
    <div class="labelStyle floatL">
        <spring:message code="label.serviceRequest.dealerLocation" />:
    </div>
    <div>
        <select data-ng-model="location" ng-options="location for location in listOfLocation" class="dropdown-normal" ng-change="calculateDistances(location)">
            <option value=""><spring:message code="label.serviceRequest.select" /></option>
        </select>
    </div>

    <div class="fieldSpacerHeight clear"></div>
    <div class="labelStyle floatL">
        <spring:message code="label.serviceRequest.distance" />:
    </div>
    <div class="floatL">
        <input type="text" data-ng-model='distanceValue' data-ng-readonly="true" />
    </div>
</div>