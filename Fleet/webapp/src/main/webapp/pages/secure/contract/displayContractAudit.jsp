<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html data-ng-app="createContract">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<u:stylePicker fileName="contract/contract.css" />
<style type="text/css">
.gridStyle {
	border: 1px solid rgb(212, 212, 212);
	width: 1000px;
	height: 200px;
}
</style>
</head>

<u:body theme="fleet">
    <input type="hidden" id='contractId' value='${contractId}' />
    <input type="hidden" id='selectedAuditId' value="${selectedAuditId}">
    <div ng-init="isDealerOwned=${isDealerOwned}"></div>
    <form data-ng-controller="ContractController" name="form" novalidate>
        <div alert-msg></div>
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="title.common.general" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
            <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.contractCode" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contractAudit.forContract.code" data-ng-readonly="true">
                </div>
                <div class="fieldSpacerWidth floatL"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.contractType" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contract.type" data-ng-readonly="true">
                </div>
            </div>
            <div class="clear"></div>
            <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.contractStartDate" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contractAudit.availability.fromDate" datepicker-popup="{{dateFormat}}"
                        data-ng-readonly="true">
                </div>
                <div class="fieldSpacerWidth floatL"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.contractEndDate" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contractAudit.availability.tillDate" datepicker-popup="{{dateFormat}}"
                        data-ng-readonly="true">
                </div>
            </div>
            <div class="clear"></div>
            <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.contractStatus" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contractAudit.status" data-ng-readonly="true">
                </div>
                    <div class="fieldSpacerWidth floatL"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.common.servicingDealer" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contractAudit.servicingDealer.name" data-ng-readonly="true">
                </div>
            </div>
            <div class="clear"></div>
            <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.customerName" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contract.activeContractAudit.forCustomer.name" data-ng-readonly="true">
                </div>
            </div>
            <div class="clear"></div>
            <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.customerShipTo" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contract.activeContractAudit.shipTo.code" data-ng-readonly="true">
                </div>
                <div class="fieldSpacerWidth floatL"></div>

              <div ng-if="isDealerOwned">
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.customerBillTo" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="customerBillTo" data-ng-readonly="true">
                </div>
              </div>
            </div>
            <div class="clear"></div>
               <div>
                <div class="labelStyle ti0 floatL">
                    <spring:message code="label.common.currency" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contract.activeContractAudit.forCustomer.preferredCurrency" data-ng-readonly="true">
                </div>
                <div class="fieldSpacerWidth floatL"></div>
                  <div ng-if="!isDealerOwned">
                <div class="labelStyle floatL">
                    <spring:message code="label.contract.primary" />
                </div>
                <div class="floatL">
                <span ng-if="contractAudit.primary==true">
                 <spring:message code="label.common.yes" />
                </span>
                <span ng-if="contractAudit.primary==false">
                 <spring:message code="label.common.no" />
                </span>
            </div>
            </div>
            <div class="clear"></div>
            <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.alertWindow" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contractAudit.alertWindowFromExpiryDate" data-ng-readonly="true">
                </div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.alertWindow.days" />
                </div>
            </div>
            <div class="clear"></div>
            <div ng-if='isDealerOwned'>
            <div>
                <div class="labelStyle ti0 floatL">
                    <spring:message code="label.invoice.minHours" />
                </div>
                <div class="floatL">
                    <input TYPE="text" data-ng-model="contractAudit.forContract.minHours" class="wid120" data-ng-readonly="true"/>
                </div>
            </div>
            <div>
             <div class="clear"></div>
            <div class="labelStyle floatL">
                    <spring:message code="label.invoice.isLocationLevelInvoiceRequired" />
                </div>
                <INPUT type="checkbox" data-ng-model="contractAudit.forContract.isLocationLevelInvoice" ng-disabled="true">
            </div>
            </div>
        </div>
        <div class="clear"></div>
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="label.newContract.machinesCovered" />
            <span class="expand-collapse collapse-icon"></span>
        </div>

        <div class="overflow-hidden accordion-info">
            <div class="gridStyle marL25 history-table" data-ng-grid="gridForMachines"></div>
        </div>
        <div class="clear"></div>
        <!-- <div class="clear"></div> -->
        <%-- <div title-pane content-pane-title="<spring:message code="label.newContract.dealerPaymentExceptions"/>" collapse="false"></div>
		<%@include file="dealerPaymentExceptions.jsp"%>
		<%@include file="dealerPaymentOverrides.jsp"%> --%>
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="label.newContract.costCategories" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
            <%@include file="readableCostCategories.jsp"%>
        </div>
        <div class="clear"></div>
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="label.newContract.travelMatrix" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
            <%@include file="travelMatrixReadonly.jsp"%>
        </div>
        <div class="clear"></div>
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="label.newContract.taxInformation" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
            <!-- Repeat Table Test Widget -->
         <%@include file="taxDetailsReadonly.jsp"%>
        </div>
        <div class="clear"></div>

        <div class="accordion-header contentPane">
            <spring:message code="title.common.attachment" />
            <span class="expand-collapse collapse-icon"></span>
        </div>

        <div class="overflow-hidden accordion-info">
            <div class="clear"></div>
            <div class="labelStyle floatL">
                <spring:message code="label.common.Attachment" />
                :
            </div>
            <div class="floatL">
                <button type="button" class="blue-btn" data-ng-click="uploadDocuments()">
                    <spring:message code="label.common.Attach" />
                </button>
            </div>

            <div class="clear"></div>
            <div class="radioClear"></div>
            <div>
                <%@include file="attachedDocumentsReadonly.jsp"%>
            </div>
            <div class="clear"></div>
        </div>

        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="label.newContract.commentsHeader" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
            <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.comments" />
                </div>
                <div class="floatL">
                    <textarea name="comments" max-length data-ng-model="contractAudit.comments" class="wid500" data-ng-readonly="true"></textarea>
                </div>
            </div>
        </div>
        <div class="clear"></div>
        <div>
            <button  type="button" class="blue-btn btn-primary marL455" data-ng-click="cancel()"
                onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                <spring:message code="label.Common.cancel" />
            </button>
        </div>
    </form>
</u:body>
<script src="../scripts/vendor/angularjs/es5-shim.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-file-upload.min.js"></script>
<script src="../scripts/contract/contractApp.js"></script>
</html>