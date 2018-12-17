<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="authz" uri="authz"%>
<div ng-show="servicingDealer">
    <div popup="isDealerCreateServiceRequest" close="closeDealerWarningMessage()">
        <div class="modal-header">
            <center>
                <spring:message code="label.common.warning" />
            </center>
        </div>
        <div class="modal-body">
            <center>
                    <spring:message code="label.serviceRequest.isDealerCreateServiceRequest" />
            </center>
            <div class="clear"></div>
            <center>
                <button type="button" class="blue-btn" ng-click="closeDealerWarningMessage()" data-focus-me>
                    <spring:message code="label.serviceRequest.underWarranty.ok" />
                </button>
            </center>
        </div>
    </div>
</div>

    
     <div popup="showContractWarningMessage" close="closeContractWarningMessage()">
        <div class="modal-header">
            <center>
                <spring:message code="label.common.warning" />
            </center>
        </div>
        <div class="modal-body">
            <center>
                <div ng-show="isCustomerUser">
                    <spring:message code="label.serviceRequest.contractMessage.forCustomer" />
                </div>
               <div ng-hide="isCustomerUser">
                    <spring:message code="label.serviceRequest.contractMessage.forNMHGAndDealer" />
                </div>
            </center>
            <div class="clear"></div>
            <center>
                <button type="button" class="blue-btn" ng-click="closeContractWarningMessage()" data-focus-me>
                    <spring:message code="label.serviceRequest.underWarranty.ok" />
                </button>
            </center>
        </div>
    </div>
        <div popup="addCustomerComments" close="close()">
        <div class="modal-header">
            <center>
                <h6>
                    <spring:message code="label.serviceRequest.additionalDetails" />
                </h6>
            </center>
        </div>
        <div class="modal-body">
            <center>
                <div ng-show='selectSerialNumber'>
                    <spring:message code="label.serviceRequest.cusotmerComments" />
                </div>

                <div ng-show='showcustomernotes'>
                    <div data-ng-repeat="addcustomernote in customernotes">
                        <div class="floatL" data-ng-class-odd="'odd'" data-ng-class-even="'even'">
                            <input class="floatL" type="checkbox" data-ng-model="addcustomernote.checked" />&nbsp {{ addcustomernote.data }}
                        </div>
                        <div class="clear"></div>
                    </div>
                </div>
            </center>
            <div class="clear"></div>
            <div class="clear"></div>
            <center>
                <div ng-show='showcustomernotes'>
                    <button type="button" class="blue-btn" ng-click="addtoNotes()">
                        <spring:message code="label.serviceRequest.underWarranty.ok" />
                    </button>
                </div>
                <div ng-show='selectSerialNumber'>
                    <button type="button" class="blue-btn" ng-click="close()">
                        <spring:message code="label.serviceRequest.underWarranty.ok" />
                    </button>
                </div>

            </center>
        </div>
    </div>
     <div popup="showWarrantyWarningMessage" close="closeWarrantyWarningMessage()">
        <div class="modal-header">
            <%-- <h4>
			<spring:message code="label.serviceRequest.underWarranty.title" />
			</h4> --%>
        </div>
        <div class="modal-body">
            <div style="text-align: center;">
                <spring:message code="label.serviceRequest.underWarranty.notification" />
            </div>
            <div class="clear"></div>
            <div style="text-align: center;">
            <button type="button" class="blue-btn" data-ng-click="closeWarrantyWarningMessage()" data-focus-me>
                <spring:message code="label.serviceRequest.underWarranty.ok" />
            </button>
            </div>
        </div>
    </div>