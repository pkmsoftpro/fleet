<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<u:stylePicker fileName="ui-ext/actionResult/actionResult.css" />
<style type="text/css">
div#map {
	position: relative;
	width: 100%;
	height: 500px;
}
</style>
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
    <div popup="displayGoogleMap" close="closePopup()">
        <div class="modal-header">
             <spring:message code="label.quote.travelLocation" />
            <div class="floatR"> 
             <img src="../image/tabbClose.png" class="marT10" data-ng-click=closePopup() />
             </div>
        </div>
        
        <div class="modal-body">

            <div ng-show="invalidAddress" id="Error Message For Google Maps" class="twmsActionResults">
                <div class="twmsActionResultsSectionWrapper twmsActionResultsMessages ">
                    <h4 class="twmsActionResultActionHead">Message</h4>
                    <br clear="all" />
                    <s:text name="message.quote.travelLocation.invalid" />
                </div>
            </div>
            <div ng-init="travelLocation='test'" id="formatedAddress"></div>

            <div id="map">
                <div id="map_canvas" style="width: 100%; height: 100%"></div>
            </div>

        </div>
    </div>
</div>
