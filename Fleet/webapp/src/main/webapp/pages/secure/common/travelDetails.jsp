<div class="accordion-header contentPane">
    <spring:message code="title.common.travelDetails" />
    <span class="expand-collapse collapse-icon"></span>
</div>

<div class="overflow-hidden accordion-info">
    <div ng-init="activeAudit.serviceInformation.serviceDetail.travelDetails.travelHours=0">
        <div data-ng-repeat="costCategory in applicableCostCategoriesList">
            <div data-ng-if="costCategory.categoryGroup=='MAJOR COST CATEGORY'">
                <div data-ng-if="costCategory.code=='TRAVEL'">
                    <div class="labelStyle floatL">
                        <spring:message code="label.quote.travelLocation" />
                    </div>
                    <div class="floatL">
                        <INPUT TYPE="text" id="travelLocation" data-ng-readonly="true" data-ng-model="serviceDealerAddress" is-number> <span id="onee"
                            tabindex="0" class="dis-inblock" style="vertical-align: top;"><img id="googleMap" class="clickable"
                            src="../css/theme/official/dojo/official/images/googleMapViewer.png" data-ng-click="openMap()" /> </span>
                    </div>

                    <div class="labelStyle floatL padL11">
                        <spring:message code="label.quote.numberOfTrips" />
                    </div>
                    <div class="floatL">
                        <select style="margin-bottom: 2px; margin-top: 2px; width: 140px" data-ng-disabled="isReadOnly()"
                            data-ng-model="activeAudit.serviceInformation.serviceDetail.travelDetails.numberOfTrips" 
                            ng-options="t for t in noOfTrips">
                            <option value="">
                                <spring:message code="label.serviceRequest.select" />
                            </option>
                        </select>
                    </div>
                    <div class="clear"></div>
                    <div class="labelStyle floatL">
                        <spring:message code="label.quote.travelHours" />
                    </div>
                    <div class="floatL">
                        <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="activeAudit.serviceInformation.serviceDetail.travelDetails.travelHours">
                    </div>
                    <div class="labelStyle floatL">
                        <spring:message code="label.quote.travelDistance" />
                    </div>
                    <div class="floatL">
                        <INPUT TYPE="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.travelDetails.milesPerTrip" data-ng-readonly="true">
                    </div>
                    <div class="labelStyle floatL" data-ng-show="activeAudit.serviceInformation.serviceDetail.travelDetails.numberOfTrips > 0">
                        <spring:message code="label.quote.additionalTravelHours" />
                    </div>
                    <div class="floatL" data-ng-show="activeAudit.serviceInformation.serviceDetail.travelDetails.numberOfTrips > 0">
                        <INPUT TYPE="text" id="additionalTravelHours" data-ng-readonly="isReadOnly()"
                            data-ng-model="activeAudit.serviceInformation.serviceDetail.travelDetails.addtionalHours" is-number>
                    </div>
                    <div class="labelStyle floatL" data-ng-show="activeAudit.serviceInformation.serviceDetail.travelDetails.numberOfTrips > 0">
                        <spring:message code="label.quote.reasonforAdditionalTravel" />
                    </div>

                    <div class="floatL" data-ng-show="activeAudit.serviceInformation.serviceDetail.travelDetails.numberOfTrips > 0">
                        <textarea name="additionalTravel" data-ng-readonly="isReadOnly()"
                            data-ng-model="activeAudit.serviceInformation.serviceDetail.travelDetails.reasonForAdditionalHours" rows="4" cols="50" max-length
                            data-ng-required="isRequired()"></textarea>
                    </div>
                    <div class="clear"></div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="../common/googleMap.jsp" />
</div>
