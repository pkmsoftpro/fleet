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
    <div class="containerDiv"
        ng-init="contractAudit.applicableTravelMatrix = contractAudit.applicableTravelMatrix == null ? [] : contractAudit.applicableTravelMatrix"
        ng-model="contractAudit.applicableTravelMatrix" repeater>
        <input type="hidden" name="contractAudit.applicableTravelMatrix" data-ng-model="contractAudit.applicableTravelMatrix" />
        <table border="1" cellspacing="0" cellpadding="0" class="accordion-table">
            <tr class="tableHeader">
                <th class="labelStyle"><spring:message code="label.updateContract.travelMatrix.tripType" /></th>
                <th class="labelStyle"><spring:message code="label.updateContract.travelMatrix.miles" /></th>
                <th class="labelStyle"><spring:message code="label.updateContract.travelMatrix.currency" /></th>
                <th class="labelStyle"><spring:message code="label.updateContract.travelMatrix.hours" /></th>
            </tr>

            <tr class="tableData" ng-repeat="item in contractAudit.applicableTravelMatrix">
                <td><input style="margin-bottom: 2px; margin-top: 2px; width: 100px" type="text" class="repeat" data-ng-readonly="true"
                    data-ng-model='item.trip'></input>
                </td>
                <td><input style="margin-bottom: 2px; margin-top: 2px; width: 100px" type="text" class="repeat" data-ng-model='item.milesPerTrip' data-ng-readonly="true"></input>
                </td>
                <td>
                    <div class="cellDiv" style="width: 226px;"
                        data-ng-init="item.travelFlatAmount.currency = item.travelFlatAmount.currency == null ? 'USD' : item.travelFlatAmount.currency">
                        <INPUT style="margin-bottom: 2px; margin-top: 2px; width: 100px" TYPE="text" ng-style="{width:'182px'}" data-disable="true" 
                            data-ng-model="item.travelFlatAmount" money>
                    </div></td>

                <td><INPUT style="margin-bottom: 2px; margin-top: 2px; width: 100px" TYPE="text" ng-readonly="true" ng-model="item.hour"></td>
            </tr>
        </table>
    </div>
</div>