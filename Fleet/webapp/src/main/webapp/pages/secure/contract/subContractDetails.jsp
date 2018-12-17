<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@include file="../admin/servicecode/i18N_servicecode_javascript_vars.jsp"%>
<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.subContract.subContractDetails" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div class="labelStyle floatL">
        <spring:message code="label.subContract.subContractCode" />
        :
    </div>
    <div class="floatL">
        <input type="text" data-ng-readonly="true" data-ng-model="subContract.subContractCode" />
    </div>
    <div class="clear"></div>

    <div class="labelStyle floatL">
        <spring:message code="label.subContract.startDate" />
        :
    </div>
    <div class="floatL" style="width: 220px; height: 20px">
        <input type="text" data-ng-readonly="true" data-ng-model="subContract.contract.activeContractAudit.availability.fromDate" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.subContract.endDate" />
        :
    </div>
    <div class="floatL"></div>
    <div>
        <input type="text" data-ng-readonly="true" data-ng-model="subContract.contract.activeContractAudit.availability.tillDate" />
    </div>
    <div class="clear"></div>

    <div class="labelStyle floatL">
        <spring:message code="label.subContract.customerName" />
        :
    </div>
    <div class="floatL">
        <input type="text" data-ng-readonly="true" data-ng-model="subContract.contract.activeContractAudit.forCustomer.name" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.subContract.servicingDealer" />
        :
    </div>
    <div class="floatL"></div>
    <div>
        <input type="text" data-ng-readonly="true" data-ng-model="subContract.contract.activeContractAudit.servicingDealer.name" />
    </div>
    <div class="clear"></div>

    <div class="labelStyle floatL">
        <spring:message code="label.subContract.customerLocation" />
        :
    </div>
    <div class="floatL">
        <input type="text" data-ng-readonly="true" data-ng-model="subContract.contract.activeContractAudit.shipTo.locationsMapkey" />
    </div>
    <div class="clear"></div>

    <div class="labelStyle floatL">
        <spring:message code="label.common.city" />
        :
    </div>
    <div class="floatL">
        <input type="text" data-ng-readonly="true" data-ng-model="subContract.contract.activeContractAudit.forCustomer.address.city" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.common.state" />
        :
    </div>
    <div class="floatL"></div>
    <div>
        <input type="text" data-ng-readonly="true" data-ng-model="subContract.contract.activeContractAudit.forCustomer.address.state" />
    </div>

    <div class="clear"></div>
    <div class="labelStyle floatL">
        <spring:message code="label.common.zip" />
        :
    </div>
    <div class="floatL">
        <input type="text" data-ng-readonly="true" data-ng-model="subContract.contract.activeContractAudit.forCustomer.address.zipCode" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="clear"></div>

    <div class="labelStyle floatL">
        <spring:message code="label.common.threshold" />
        :
    </div>
    <div class="floatL" data-ng-init="subContract.contract.activeContractAudit.shipTo.calculatedDealerThreshold.currency = subContract.contract.activeContractAudit.shipTo.calculatedDealerThreshold.currency == null ? subContract.contract.activeContractAudit.shipTo.preferredCurrency : subContract.contract.activeContractAudit.shipTo.calculatedDealerThreshold.currency">
        <input type="text" disable="true" data-ng-model="subContract.contract.activeContractAudit.shipTo.calculatedDealerThreshold" money />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
</div>
<div class="clear"></div>

<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.common.MachinesCovered" />
    : <span class="expand-collapse collapse-icon"></span>
</div>

<div class="overflow-hidden accordion-info">
    <div class="containerDiv">
        <div class="rowDivHeader">
            <div class="cellDivHeader wid100">
                <spring:message code="columnTitle.contract.serialNumber" />
            </div>
            <div class="cellDivHeader wid150" >
                <spring:message code="columnTitle.contract.model" />
            </div>
              <div class="cellDivHeader wid96" >
                <spring:message code="columnTitle.contract.Status" />
            </div>
            <div class="cellDivHeader wid100">
                <spring:message code="columnTitle.contract.manufacturer" />
            </div>
            <div class="cellDivHeader wid120">
                <spring:message code="title.equipmentdetails.maintenanceType" />
            </div>
            <div class="cellDivHeader wid100">
                <spring:message code="columnTitle.subContract.pMMaintenanceRate" />
            </div>
             <div class="cellDivHeader wid100">
                <spring:message code="columnTitle.subContract.fullMaintenanceRate" />
            </div>
            <div class="cellDivHeader wid127">
                <spring:message code="label.common.labourRate" />
            </div>
            <div class="cellDivHeader wid100">
                <spring:message code="columnTitle.subContract.percentOfLabor" />
            </div>
        </div>
        <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" data-ng-repeat="item in activeSubContractInventories"
            data-ng-show="item.status=='ACTIVE'">
            <div class="cellDiv wid100 " >
                <div>{{item.fleetInventoryItem.serialNumber}}</div>
            </div>
             <div class="cellDiv wid150">
                <!-- <div>{{item.fleetInventoryItem.modelName}}</div> -->
                <div class="model" tooltip="{{item.fleetInventoryItem.modelName}}" tooltip-placement="right">{{item.fleetInventoryItem.modelName}}</div>               
            </div>
            <div class="cellDiv wid96">
                <div>{{item.status}}</div>
            </div>
              <div class="cellDiv wid100" >
                <div>{{item.fleetInventoryItem.brandType}}</div>
            </div>
            <div class="cellDiv wid120">
                <div>{{item.fleetInventoryItem.maintenanceType}}</div>
            </div>
            <authz:ifUserInRole roles="fleetCoordinator,dealerOwnedCoordinator">
                <c:choose>
                    <c:when test="${folderName=='Contracts Unpublished'||folderName=='Contracts Denied'}">
                        <div  ng-if="isFleetCoordinatorOrDealerOwnedCoordinator==true" class="cellDiv wid100"
                            data-ng-init="item.fleetInventoryItem.pmMaintenanceRate.currency = item.fleetInventoryItem.pmMaintenanceRate.currency == null ? item.fleetInventoryItem.preferredCurrency : item.fleetInventoryItem.pmMaintenanceRate.currency">
                            <INPUT class="cellInputStyle" type="text" class="repeat" data-ng-model="item.fleetInventoryItem.pmMaintenanceRate" money
                                data-ng-style="{width:'50px'}" />
                        </div>
                        <div ng-if="isFleetCoordinatorOrDealerOwnedCoordinator==true" class="cellDiv wid100"
                            data-ng-init="item.fleetInventoryItem.fullMaintenanceRate.currency = item.fleetInventoryItem.fullMaintenanceRate.currency == null ? item.fleetInventoryItem.preferredCurrency : item.fleetInventoryItem.fullMaintenanceRate.currency">
                            <INPUT class="cellInputStyle" type="text" class="repeat" data-ng-model="item.fleetInventoryItem.fullMaintenanceRate" money
                                ng-style="{width:'100px'}" />
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="cellDiv wid100" ng-if="isFleetCoordinatorOrDealerOwnedCoordinator==true"
                            data-ng-init="item.fleetInventoryItem.pmMaintenanceRate.currency = item.fleetInventoryItem.pmMaintenanceRate.currency == null ? item.fleetInventoryItem.preferredCurrency : item.fleetInventoryItem.pmMaintenanceRate.currency">
                            <INPUT class="cellInputStyle" type="text" class="repeat" data-ng-model="item.fleetInventoryItem.pmMaintenanceRate" money
                                data-ng-style="{width:'50px'}" disable="true" />
                        </div>
                        <div class="cellDiv wid100" ng-if="isFleetCoordinatorOrDealerOwnedCoordinator==true"
                            data-ng-init="item.fleetInventoryItem.fullMaintenanceRate.currency = item.fleetInventoryItem.fullMaintenanceRate.currency == null ? item.fleetInventoryItem.preferredCurrency : item.fleetInventoryItem.fullMaintenanceRate.currency">
                            <INPUT class="cellInputStyle" type="text" class="repeat" data-ng-model="item.fleetInventoryItem.fullMaintenanceRate" money
                                ng-style="{width:'100px'}" disable="true" />
                        </div>
                    </c:otherwise>
                </c:choose>
            </authz:ifUserInRole>
            <authz:ifUserInRole roles="dealerSubContractApprover">
                <div class="cellDiv wid100" ng-if="isServicingDealer==true"
                    data-ng-init="item.fleetInventoryItem.pmMaintenanceRate.currency = item.fleetInventoryItem.pmMaintenanceRate.currency == null ? item.fleetInventoryItem.preferredCurrency : item.fleetInventoryItem.pmMaintenanceRate.currency">
                    <INPUT class="cellInputStyle" type="text" class="repeat" data-ng-model="item.fleetInventoryItem.pmMaintenanceRate" money
                        data-ng-style="{width:'50px'}" disable="true" />
                </div>
                <div class="cellDiv wid100" ng-if="isServicingDealer==true"
                    data-ng-init="item.fleetInventoryItem.fullMaintenanceRate.currency = item.fleetInventoryItem.fullMaintenanceRate.currency == null ? item.fleetInventoryItem.preferredCurrency : item.fleetInventoryItem.fullMaintenanceRate.currency">
                    <INPUT class="cellInputStyle" type="text" class="repeat" data-ng-model="item.fleetInventoryItem.fullMaintenanceRate" money
                        ng-style="{width:'100px'}" disable="true" />
                </div>
            </authz:ifUserInRole>

                 <div class="cellDiv wid127"  data-ng-init="item.laborRate.currency = item.laborRate.currency == null ? item.fleetInventoryItem.preferredCurrency : item.laborRate.currency">
                    <INPUT class="cellInputStyle" type="text" class="repeat" data-ng-model="item.laborRate" money
                        ng-style="{width:'127px'}" disable="true" />
                </div>
            <div class="cellDiv wid100">
                <div style="width:95%!important">
                    <INPUT style="margin-bottom: 2px; margin-top: 2px; width: 100px" TYPE="text" ng-readonly="true" ng-model="ngModel">%
                </div>
            </div>
        </div>
    </div>
</div>
<div class="clear"></div>

<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.subContract.AdditionalInfo" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div class="labelStyle floatL">
        <spring:message code="label.subContract.authorizeTravel" />
        :
    </div>
    <div class="floatL" data-ng-init="subContract.authorizeTravel.currency = subContract.authorizeTravel.currency == null ? subContract.contract.activeContractAudit.shipTo.preferredCurrency : subContract.authorizeTravel.currency">
        <input type="text" disable="true" data-ng-model="subContract.authorizeTravel" money/>
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="labelStyle floatL">
        <spring:message code="label.subContract.percentOfListParts" />
        :
    </div>
    <div class="floatL"></div>
    <authz:ifUserInRole roles="fleetCoordinator,dealerOwnedCoordinator">
        <c:choose>
            <c:when test="${folderName=='Contracts Unpublished'||folderName=='Contracts Denied'}">
                <div ng-if="isFleetCoordinatorOrDealerOwnedCoordinator==true">
                    <input type="text" data-ng-model="subContract.percentOfListParts" />%
                </div>
            </c:when>
            <c:otherwise>
                <div ng-if="isFleetCoordinatorOrDealerOwnedCoordinator==true">
                    <input type="text" data-ng-readonly="true" data-ng-model="subContract.percentOfListParts" />%
                </div>
            </c:otherwise>
        </c:choose>
    </authz:ifUserInRole>
    <authz:ifUserInRole roles="dealerSubContractApprover">
        <div ng-if="isServicingDealer==true">
            <input type="text" data-ng-readonly="true" data-ng-model="subContract.percentOfListParts" />%
        </div>
    </authz:ifUserInRole>
</div>
<div class="clear"></div>

<authz:ifUserInRole roles="fleetCoordinator,dealerOwnedCoordinator">
    <c:if test="${folderName=='Contracts Unpublished'||folderName=='Contracts Denied'}">
        <div class="accordion-header contentPane" ng-if="isFleetCoordinatorOrDealerOwnedCoordinator==true">
            <!-- accordion header -->
            <spring:message code="title.common.comments" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info" ng-if="isFleetCoordinatorOrDealerOwnedCoordinator==true">
            <div class="labelStyle floatL">
                <spring:message code="title.common.comments" />
                :
            </div>
            <div class="floatL">
                <textarea max-length name="serviceCall.comments" data-ng-model="subContract.activeSubContractAudit.comments" rows="4" cols="450" class="wid500"
                    data-ng-required="true"></textarea>
            </div>
        </div>
        <div class="clear"></div>
    </c:if>
</authz:ifUserInRole>

<authz:ifUserInRole roles="dealerSubContractApprover">
    <c:if test="${folderName=='Contracts Pending Approval'}">
        <div class="accordion-header contentPane" ng-if="isServicingDealer==true">
            <!-- accordion header -->
            <spring:message code="title.common.comments" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info" ng-if="isServicingDealer==true">
            <div class="labelStyle floatL">
                <spring:message code="title.common.comments" />
                :
            </div>
            <div class="floatL">
                <textarea max-length name="serviceCall.comments" data-ng-model="subContract.activeSubContractAudit.comments" rows="4" cols="450" class="wid500"
                    data-ng-required="takenAction=='deny'"></textarea>
            </div>
        </div>
        <div class="clear"></div>
    </c:if>
</authz:ifUserInRole>

<div ng-show="audits!='' ">
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="label.newContract.history" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
        <div class="gridStyle marL25 history-table" data-ng-grid="gridForSubContractAuditHistory"></div>
    </div>
</div>

<authz:ifUserInRole roles="dealerSubContractApprover">
    <c:if test="${folderName=='Contracts Pending Approval'}">
        <div class="accordion-header contentPane" data-ng-show="isServicingDealer==true">
            <!-- accordion header -->
            <spring:message code="title.common.actions" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info" data-ng-show="isServicingDealer==true">
            <div class="padL10">
                <input type="radio" class="action-radio" data-ng-model="takenAction" value="accept" data-ng-required="required" />
                <spring:message code="label.common.accept" />
            </div>
            <div class="padL10">
                <input type="radio" class="action-radio" ng-model="takenAction" value="deny" data-ng-required="required" />
                <spring:message code="label.common.deny" />
            </div>
            <div class="centered marB10">
                <button type="button" class="blue-btn btn-primary" data-ng-click="submit()" data-ng-disabled="form.$invalid || submitForm">
                    <spring:message code="label.common.submit" />
                </button>
                <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
                    <spring:message code="label.Common.cancel" />
                </button>
            </div>
        </div>
    </c:if>
</authz:ifUserInRole>

<authz:ifUserInRole roles="fleetCoordinator,dealerOwnedCoordinator">
    <div class="overflow-hidden marT10">
        <div class="centered marB10" data-ng-show="isFleetCoordinatorOrDealerOwnedCoordinator">
            <c:if test="${folderName=='Contracts Unpublished'}">
                <button type="button" class="blue-btn" data-ng-click="save()" ng-disabled='form.$invalid || submitForm'>
                    <spring:message code="label.Common.save" />
                </button>
                <button type="button" class="blue-btn" data-ng-click="submit()" ng-disabled='form.$invalid || submitForm'>
                    <spring:message code="button.subContract.publish" />
                </button>
                <button type="button" class="blue-btn" data-ng-click="cancel()">
                    <spring:message code="label.Common.cancel" />
                </button>
            </c:if>
            <c:if test="${folderName=='Contracts Denied'}">
                <button type="button" class="blue-btn" data-ng-click="submit()" ng-disabled='form.$invalid || submitForm'>
                    <spring:message code="button.subContract.publish" />
                </button>
                <button type="button" class="blue-btn" data-ng-click="cancel()">
                    <spring:message code="label.Common.cancel" />
                </button>
            </c:if>
        </div>
</authz:ifUserInRole>
</div>