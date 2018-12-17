<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="authz" uri="authz"%>

<div alert-msg></div>
<div class="accordion-header contentPane marT10">
    <!-- accordion header -->
    <spring:message code="title.common.customerDetails" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">

    <div ng-if="customerId!=''">
        <div ng-repeat="billTo in customer.customerBillTos">
             <div ng-if='!isDealerOwned'>
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.customerBillTo" />
                {{$index+1}}:
            </div>
            </div>
             <div ng-if='isDealerOwned'>
             <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.customerBillTo" />
            </div>
             </div>
            <div class="floatL">
                <INPUT TYPE="text" data-ng-readonly="customer!=''" data-ng-model="billTo.customerNumber" />
            </div>
            <span data-ng-if="billTo.primary==true">
                <div class="customerLabelStyle floatL">
                    <spring:message code="label.customer.status" />
                    :
                </div>
                <div ng-if='!isDealerOwned'>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="billTo.status" />
                </div>
                </div>
                <div ng-if='isDealerOwned'>
                    <div class="floatL">
                        <select id="status" data-ng-model="billTo.status" name="status" ng-options="c for c in status"
                            class="dropdown-normal" required>
                        </select>
                    </div>
                </div>
                <authz:ifUserInRole roles="admin">
	                 <div  class="floatR" > 
		    				<img src="../image/pgmSummary.png" class="marR10" data-ng-click="printCustomerPGS()" tooltip="<spring:message code='label.common.pgs'/>" tooltip-placement="left"/>
					 </div> 
				</authz:ifUserInRole>
            </span>
        </div>
    </div>

   <div class="clear"></div>
   
   <div ng-show="!isDealerOwned">
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.customerName" />
            :
               <span class="red">*</span>
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="customer.name" data-ng-required='true'>
        </div>
    </div>

    <div class="clear"></div>

    <div>
        <div ng-if="!isDealerOwned">
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.accountType" />
            : <span class="red">*</span>
        </div>
        <div class="floatL">
            <select id="accountType" data-ng-model="customer.accountType" name="accountType" ng-options="c for c in accountTypeList" class="dropdown-normal"
                required>
                  <option value="">-- Select --</option>         
            </select>
        </div>
        </div>
        <div ng-if="isDealerOwned">
         <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.customerName" />
            :<span class="red">*</span>
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="(customerId!='')" data-ng-model="customer.name" data-ng-required='true'>
        </div>
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.accountManager" />
            : <span class="red">*</span>
        </div>
        <div class="floatL">
            <div class="floatL">
                <input type="text" id='contractContact' url="getContractContacts" name="contractContact"
                    data-ng-model="customer.contractContact.completeNameAndLogin" fbs-typeahead required />
            </div>
            <div ng-show='form.contractContact.$error.invalid' class="floatL hgt30 wid20">
                <img id="customerContactAlert" src="/webapp/image/ui-ext/validation/alerts.gif" class="marT9 hide"
                    tooltip="<spring:message code='label.common.contractContact.invalid'/>" />
            </div>
        </div>
    </div>


    <div class="details-sub-header">
        <span><spring:message code="label.customer.billingAddress" />
        </span>
    </div>

    <div class="clear"></div>

    <div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.city" />
            :
               <span class="red">*</span>
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customer.address.city" data-ng-required='isMandatory()'/>
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.country" />
            :<span class="red">*</span>
        </div>
        <div class="floatL">
            <div>
                 <select id="billingCountry" data-ng-model="customer.address.country" ng-options="c for c in countries"  data-ng-required='isMandatory()'></select>
            </div>
        </div>
    </div>

    <div class="clear"></div>

    <div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.postalCode" />
            :
               <span class="red">*</span>
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customer.address.zipCode" data-ng-required='isMandatory()'>
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.state" />
            :<span class="red">*</span>
        </div>
        <div class="floatL">
            <div>
                 <select id="billingState" data-ng-model="customer.address.state" data-ng-options="c for c in billingStates"  data-ng-required='isMandatory()'></select>
            </div>
        </div>

        <div class="clear"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.addressLine1" />
            :
            <span class="red">*</span>
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customer.address.addressLine1" data-ng-required='isMandatory()'>
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.addressLine2" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customer.address.addressLine2">
        </div>

        <div class="clear"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.zipExt" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customer.address.zipcodeExtension">
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.phone" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customer.address.phone">
        </div>

        <div class="clear"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.phoneExt" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customer.address.phoneExt">
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.fax" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customer.address.fax" >
        </div>

        <div class="clear"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.faxExt" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customer.address.deliveryPointCode">
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.email" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customer.address.email" >
        </div>
        <div class="fieldSpacerWidth floatL"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.currency" />
            :<span class="red">*</span>
        </div>
        <div class="floatL">
          <div>
                <select id="preferredCurrency" data-ng-model="customer.preferredCurrency" ng-options="ic for ic in invoicingCurrenciesList"
                    data-ng-disabled="isDealerOwned==false" data-ng-required="true"></select>
            </div>
             </div>
    </div>
    <!-- End -->

    <div class="clear"></div>
    <div class="details-sub-header">
        <span><spring:message code="label.customer.physicalAddress" />
        </span>
    </div>
    <div class="clear"></div>

    <div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.city" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customer.physicalAddress.city" data-ng-required='true'/>
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.country" />
            :
            <span  ng-if='isMandatory()'>
            <span class="red">*</span>
            </span >
        </div>
        <div class="floatL">
             <div>
                <select id="physicalAddressCountry" data-ng-model="customer.physicalAddress.country" ng-options="c for c in countries" data-ng-disabled="isDealerOwned==false" data-ng-required='true'></select>
            </div>
        </div>
    </div>

    <div class="clear"></div>

    <div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.postalCode" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customer.physicalAddress.zipCode" data-ng-required='true'>
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.state" />
            :
            <span  ng-if='isMandatory()'>
            <span class="red">*</span>
            </span >
        </div>
        <div class="floatL">
             <div>
                <select id="billingState" data-ng-model="customer.physicalAddress.state" data-ng-options="c for c in states" data-ng-disabled="isDealerOwned==false" data-ng-required='true'></select>
            </div>
        </div>

        <div class="clear"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.addressLine1" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customer.physicalAddress.addressLine1" data-ng-required='true'>
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.addressLine2" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customer.physicalAddress.addressLine2">
        </div>

        <div class="clear"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.zipExt" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customer.physicalAddress.zipcodeExtension">
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.phone" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customer.physicalAddress.phone">
        </div>

        <div class="clear"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.phoneExt" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customer.physicalAddress.phoneExt">
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.fax" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customer.physicalAddress.fax">
        </div>

        <div class="clear"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.faxExt" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customer.physicalAddress.deliveryPointCode">
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.email" />
            :
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customer.physicalAddress.email">
        </div>
    </div>
    <!-- End -->


   
     <div class="clear"></div>
    <div ng-if="!isDealerOwned">
        <div class="details-sub-header">
            <span><spring:message code="title.common.associatedFleetPersonnel" /> </span>
        </div>
    </div>
    <div ng-if="isDealerOwned">
        <div class="details-sub-header">
            <span><spring:message code="title.common.dealerOwnedFleetPersonnel" /> </span>
        </div>
    </div>
    <div class="clear"></div>


        <div>
            <div ng-if="!isDealerOwned">
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.primaryFleetServiceSpecialist" />
                <span class="red">*</span>
            </div>
            </div>
             <div ng-if="isDealerOwned">
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.primaryFleetServiceWriter" />
                <span class="red">*</span>
            </div>
            </div>
            <div class="floatL">
                <select id="primaryFss" data-ng-model="customer.primaryFss.id"
                    ng-options="primaryfss.id as primaryfss.completeNameAndLogin for primaryfss in fleetServiceSpecialistList" required>
                	<option value="">
                   		<spring:message code="label.serviceRequest.select" />
               		</option>
                </select>
            </div>
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.fleetCoordinator" />
            </div>
            <div class="floatL">
                <select id="fleetCoordinator" data-ng-model="customer.fleetCoordinator.id"
                    ng-options="fleetCoordinator.id as fleetCoordinator.completeNameAndLogin for fleetCoordinator in fleetServiceSpecialistList">
                    <option value="">
                   		<spring:message code="label.serviceRequest.select" />
               		</option>
                </select>
            </div>
        </div>

        <div class="clear"></div>

        <div>
         	<div ng-if="!isDealerOwned">
	            <div class="customerLabelStyle floatL">
	                <spring:message code="label.customer.secondaryFleetServiceSpecialist" />
	            </div>
            </div>
            <div ng-if="isDealerOwned">
	            <div class="customerLabelStyle floatL">
	                <spring:message code="label.customer.secondaryFleetServiceWriter" />
	            </div>
            </div>
            <div class="floatL">
                <select id="secondaryFss" data-ng-model="customer.secondaryFss.id"
                    ng-options="secondaryfss.id as secondaryfss.completeNameAndLogin for secondaryfss in fleetServiceSpecialistList">
                    <option value="">
                   		<spring:message code="label.serviceRequest.select" />
               		</option>
                </select>
            </div>
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.fleetServiceManager" />
                <span class="red">*</span>
            </div>
            <div class="floatL">
                <select id="fleetServiceManager" data-ng-model="customer.fleetServiceManager.id"
                    ng-options="fleetServiceManager.id as fleetServiceManager.completeNameAndLogin for fleetServiceManager in fleetServiceSpecialistList"
                    data-ng-required="true">
                    <option value="">
                   		<spring:message code="label.serviceRequest.select" />
               		</option>
                </select>
            </div>

            <div class="clear"></div>

           <div ng-if="!isDealerOwned">
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.tertiaryFleetServiceSpecialist" />
            </div>
            </div>
             <div ng-if="isDealerOwned">
             <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.tertiaryFleetServiceWriter" />
            </div>
             </div>
            <div class="floatL">
                <select id="tertiaryFss" data-ng-model="customer.tertiaryFss.id"
                    ng-options="tertiaryfss.id as tertiaryfss.completeNameAndLogin for tertiaryfss in fleetServiceSpecialistList">
                    <option value="">
                   		<spring:message code="label.serviceRequest.select" />
               		</option>
                </select>
            </div>
            <!-- Operational Manager  -->
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.operationalManager" />
                <span class="red">*</span>
            </div>
            <div class="floatL">
                <select id="operationsManager" data-ng-model="customer.operationsManager.id"
                    ng-options="operationsManager.id as operationsManager.completeNameAndLogin for operationsManager in fleetServiceSpecialistList" 
                    data-ng-required="true">
                    <option value="">
                   		<spring:message code="label.serviceRequest.select" />
               		</option>
                </select>
            </div>
        </div>

        <!-- End -->
        <!-- Quote - LOA -->

        <div class="clear"></div>
        <div class="details-sub-header">
            <span><spring:message code="title.common.quoteLOA" />
            </span>
        </div>
        <div class="clear"></div>
        <div>
            <div class="customerLabelStyle floatL">
                <input type="hidden" ng-init="nmhgLoaScheme.name = 'NMHG-LOA-SCHEME-NAME'" ng-model="nmhgLoaScheme.name" />
                <div class="clear"></div>
                <input type="hidden" ng-init="nmhgLoaScheme.code = 'NMHG-LOA-SCHEME-CODE'" ng-model="nmhgLoaScheme.code" />
                <div class="clear"></div>
                <div ng-init="nmhgLoaScheme.loaLevels = customer.nmhgLoaScheme.loaLevels == null ? [] : customer.nmhgLoaScheme.loaLevels"
                    ng-model="nmhgLoaScheme.loaLevels" repeater>
                    <input type="hidden" ng-model="nmhgLoaScheme.loaLevels">
                    <div ng-repeat="loaLevel in nmhgLoaScheme.loaLevels">
                        <input type="hidden" ng-model="loaLevel.name"> <input type="hidden" ng-model="loaLevel.loaLevel">
                    </div>
                </div>
            </div>

            <div class="clear"></div>

            <div>
                <div class="customerLabelStyle floatL">
                    <spring:message code="label.customer.fleetServiceSpecialist" />
                </div>
                <div class="floatL">
                    <input type='hidden' data-ng-bind="fssMoney.currency=customer.preferredCurrency" /> <input ng-style="{width:'182px'}"
                        data-ng-model="fssMoney" name="fssMoney" money />
                </div>
                <div ng-show='form.fssMoney.$error.require' style="color: red;">
                    &nbsp;
                    <spring:message code="label.common.error.required" />
                </div>
            </div>

            <div class="clear"></div>

            <div>
                <div class="customerLabelStyle floatL">
                    <spring:message code="label.customer.fleetServiceManager" />
                </div>
                <input type='hidden' data-ng-bind="fsmMoney.currency=customer.preferredCurrency" />
                <div class="floatL">
                    <input ng-style="{width:'182px'}" data-ng-model="fsmMoney" name="fsmMoney" money />
                </div>
                <div ng-show='form.fsmMoney.$error.greater && (!form.fsmMoney.$error.require)' style="color: red;">
                    &nbsp;
                    <spring:message code="label.common.error.greaterThan" arguments="{{fssMoney.amount}}" />
                </div>
                <div ng-show='form.fsmMoney.$error.require' style="color: red;">
                    &nbsp;
                    <spring:message code="label.common.error.required" />
                </div>
            </div>

            <div class="clear"></div>

            <div>
                <div class="customerLabelStyle floatL">
                    <spring:message code="label.customer.operationalManager" />
                </div>
                <input type='hidden' data-ng-bind="omMoney.currency=customer.preferredCurrency" />
                <div class="floatL">
                    <input ng-style="{width:'182px'}" data-ng-model="omMoney" name="omMoney" money />
                </div>
                <div ng-show='form.omMoney.$error.greater' style="color: red;">
                    &nbsp;
                    <spring:message code="label.common.error.greaterThan" arguments="{{fsmMoney.amount}}" />
                </div>
            </div>
        </div>
        
        <!-- CLAIM - LOA -->
        <div class="clear"></div>
        <div class="details-sub-header">
            <span><spring:message code="title.common.claimLOA" />
            </span>
        </div>
        <div class="clear"></div>
        <div>
            <div class="customerLabelStyle floatL">
                <input type="hidden" ng-init="claimLoaScheme = customer.claimLoaScheme == null? {} :customer.claimLoaScheme"> <input
                    type="hidden" ng-init="claimLoaScheme.name = 'CLAIM-LOA-SCHEME-NAME'" ng-model="claimLoaScheme.name" />
                <div class="clear"></div>
                <input type="hidden" ng-init="claimLoaScheme.code = 'CLAIM-LOA-SCHEME-CODE'" ng-model="claimLoaScheme.code" />
                <div ng-init="claimLoaScheme.loaLevels = customer.claimLoaScheme.loaLevels == null ? [] : claimLoaScheme.loaLevels"
                    ng-model="claimLoaScheme.loaLevels" repeater>
                    <input type="hidden" ng-model="claimLoaScheme.loaLevels">
                    <div ng-repeat="loaLevel in claimLoaScheme.loaLevels">
                        <input type="hidden" ng-model="loaLevel.name"> <input type="hidden" ng-model="loaLevel.loaLevel">
                    </div>
                </div>
            </div>
            <div class="clear"></div>
            <div>
                <div class="customerLabelStyle floatL">
                	<spring:message code="label.customer.claimProcessor"/>
                    <span ng-if="isDealerOwned">
                    <span class="red">*</span>
                    </span>
                </div>
                <div class="floatL">
                    <select id="claimLOAUserLevelOne" data-ng-model="claimLOAUserLevelOne.id"
                        ng-options="claimLOAUserLevelOne.id as claimLOAUserLevelOne.completeNameAndLogin for claimLOAUserLevelOne in claimLOAUsersList" data-ng-required="isDealerOwned">
                        <option value="">
                    		<spring:message code="label.serviceRequest.select" />
                		</option>
                    </select>
                </div>
                <div class="floatL" style="margin-left: 25px;">
                    <input type='hidden' data-ng-bind="claimLOALevelOneMoney.currency=customer.preferredCurrency" />
                    <input ng-style="{width:'182px'}" data-ng-model="claimLOALevelOneMoney" money data-ng-required='{{isDealerOwned}}'/>
                </div>
            </div>

            <div class="clear"></div>
            <div>
                <div class="customerLabelStyle floatL">
                	<spring:message code="label.customer.claimProcessor"/>
                </div>
                <div class="floatL">
                    <select id="claimLOAUserLevelTwo" data-ng-model="claimLOAUserLevelTwo.id"
                        ng-options="claimLOAUserLevelTwo.id as claimLOAUserLevelTwo.completeNameAndLogin for claimLOAUserLevelTwo in filterClaimLoaLevelOneUser()">
                        <option value="">
                    		<spring:message code="label.serviceRequest.select" />
                		</option>
                    </select>
                </div>
                <div class="floatL" style="margin-left: 25px;">
                    <input type='hidden' data-ng-bind="claimLOALevelTwoMoney.currency=customer.preferredCurrency" /> 
                    <input type="text" ng-style="{width:'182px'}" data-ng-model="claimLOALevelTwoMoney" name="claimLOALevelTwoMoney" money />
                </div>
                <div ng-show='form.claimLOALevelTwoMoney.$error.greater' style="color: red;">
                    &nbsp;
                    <spring:message code="label.common.error.greaterThan" arguments="{{claimLOALevelOneMoney.amount}}" />
                </div>
            </div>
            <div class="clear"></div>
            <div>
                <div class="customerLabelStyle floatL">
                	<spring:message code="label.customer.claimProcessor" />
                </div>
                <div class="floatL">
                    <select id="claimLOAUserLevelThree" data-ng-model="claimLOAUserLevelThree.id"
                        ng-options="claimLOAUserLevelThree.id as claimLOAUserLevelThree.completeNameAndLogin for claimLOAUserLevelThree in filterClaimLoaLevelOneTwoUser()">
                        <option value="">
                    		<spring:message code="label.serviceRequest.select" />
                		</option>
                    </select>
                </div>
                <div class="floatL" style="margin-left: 25px;">
                    <input type='hidden' data-ng-bind="claimLOALevelThreeMoney.currency=customer.preferredCurrency" /> <input ng-style="{width:'182px'}"
                        data-ng-model="claimLOALevelThreeMoney" name="claimLOALevelThreeMoney" money />
                </div>
                <div ng-show='form.claimLOALevelThreeMoney.$error.greater' style="color: red;">
                    &nbsp;
                    <spring:message code="label.common.error.greaterThan" arguments="{{claimLOALevelTwoMoney.amount}}" />
                </div>
            </div>
            
            <div class="clear"></div>
            <div>
            	<div class="customerLabelStyle floatL">
            		<spring:message code="label.customer.fleetServiceSpecialist" />
				</div>
            	<div class="floatL">
            		<select id="claimLOAUserLevelFour" data-ng-model="claimLOAUserLevelFour.id"
                        ng-options="claimLOAUserLevelFour.id as claimLOAUserLevelFour.completeNameAndLogin for claimLOAUserLevelFour in filterClaimLoaLevelOneTwoThreeUser()">
                        <option value="">
                    		<spring:message code="label.serviceRequest.select" />
                		</option>
                    </select>
            	</div>
            	<div class="floatL" style="margin-left: 25px;">
                    <input type='hidden' data-ng-bind="claimLOALevelFourMoney.currency=customer.preferredCurrency" /> <input ng-style="{width:'182px'}"
                        data-ng-model="claimLOALevelFourMoney" name="claimLOALevelFourMoney" money />
                </div>
                <div ng-show='form.claimLOALevelFourMoney.$error.greater' style="color: red;">
                    &nbsp;
                    <spring:message code="label.common.error.greaterThan" arguments="{{claimLOALevelThreeMoney.amount}}" />
                </div>
            </div>
            
            <div class="clear"></div>
            <div>
            	<div class="customerLabelStyle floatL">
            		<spring:message code="label.customer.accountsManager"/>
            	</div>
            	<div class="floatL">
            		<select id="claimLOAUserLevelFive" data-ng-model="claimLOAUserLevelFive.id"
                        ng-options="claimLOAUserLevelFive.id as claimLOAUserLevelFive.completeNameAndLogin for claimLOAUserLevelFive in filterClaimLoaLevelOneTwoThreeFourUser()">
                        <option value="">
                    		<spring:message code="label.serviceRequest.select" />
                		</option>
                    </select>
            	</div>
            	<div class="floatL" style="margin-left: 25px;">
                    <input type='hidden' data-ng-bind="claimLOALevelFiveMoney.currency=customer.preferredCurrency" /> <input ng-style="{width:'182px'}"
                        data-ng-model="claimLOALevelFiveMoney" name="claimLOALevelFiveMoney" money />
                </div>
                <div ng-show='form.claimLOALevelFiveMoney.$error.greater' style="color: red;">
                    &nbsp;
                    <spring:message code="label.common.error.greaterThan" arguments="{{claimLOALevelFourMoney.amount}}" />
                </div>
            </div>
        </div>
        <!-- END OF CLAIM LOA -->
        
        
        <!-- Customer - LOA -->

        <div class="clear"></div>
        <div class="details-sub-header">
            <span><spring:message code="title.common.customerLOA" />
            </span>
        </div>
        <div class="clear"></div>
        <div>
            <div class="customerLabelStyle floatL">
                <input type="hidden" ng-init="customerLoaScheme = customer.customerLoaScheme == null? {} :customer.customerLoaScheme"> <input
                    type="hidden" ng-init="customerLoaScheme.name = 'CUST-LOA-SCHEME-NAME'" ng-model="customerLoaScheme.name" />
                <div class="clear"></div>
                <input type="hidden" ng-init="customerLoaScheme.code = 'CUST-LOA-SCHEME-CODE'" ng-model="customerLoaScheme.code" />
                <div ng-init="customerLoaScheme.loaLevels = customer.customerLoaScheme.loaLevels == null ? [] : customerLoaScheme.loaLevels"
                    ng-model="customerLoaScheme.loaLevels" repeater>
                    <input type="hidden" ng-model="customerLoaScheme.loaLevels">
                    <div ng-repeat="loaLevel in customerLoaScheme.loaLevels">
                        <input type="hidden" ng-model="loaLevel.name"> <input type="hidden" ng-model="loaLevel.loaLevel">
                    </div>
                </div>
            </div>
            <div class="clear"></div>
            <div>
                <div class="customerLabelStyle floatL">Level-1:</div>
                <div class="floatL">
                    <select id="customerLOAUserLevelOne" data-ng-model="customerLOAUserLevelOne.id"
                        ng-options="customerLOAUserLevelOne.id as customerLOAUserLevelOne.completeNameAndLogin for customerLOAUserLevelOne in customerLOAUsersList">
                        <option value="">
                    		<spring:message code="label.serviceRequest.select" />
                		</option>
                    </select>
                </div>
                <div class="floatL" style="margin-left: 25px;">
                    <input type='hidden' data-ng-bind="customerLOALevelOneMoney.currency=customer.preferredCurrency" /> <input ng-style="{width:'182px'}"
                        data-ng-model="customerLOALevelOneMoney" money />
                </div>
            </div>

            <div class="clear"></div>
            <div>
                <div class="customerLabelStyle floatL">Level-2:</div>
                <div class="floatL">
                    <select id="customerLOAUserLevelTwo" data-ng-model="customerLOAUserLevelTwo.id"
                        ng-options="customerLOAUserLevelTwo.id as customerLOAUserLevelTwo.completeNameAndLogin for customerLOAUserLevelTwo in filterCustomerLoaLevelOneUser()">
                        <option value="">
                    		<spring:message code="label.serviceRequest.select" />
                		</option>
                    </select>
                </div>
                <div class="floatL" style="margin-left: 25px;">
                    <input type='hidden' data-ng-bind="customerLOALevelTwoMoney.currency=customer.preferredCurrency" /> <input type="text"
                        ng-style="{width:'182px'}" data-ng-model="customerLOALevelTwoMoney" name="customerLOALevelTwoMoney" money />
                </div>
                <div ng-show='form.customerLOALevelTwoMoney.$error.greater' style="color: red;">
                    &nbsp;
                    <spring:message code="label.common.error.greaterThan" arguments="{{customerLOALevelOneMoney.amount}}" />
                </div>
            </div>

            <div class="clear"></div>
            <div>
                <div class="customerLabelStyle floatL">Level-3:</div>
                <div class="floatL">
                    <select id="customerLOAUserLevelThree" data-ng-model="customerLOAUserLevelThree.id"
                        ng-options="customerLOAUserLevelThree.id as customerLOAUserLevelThree.completeNameAndLogin for customerLOAUserLevelThree in filterCustomerLoaLevelOneTwoUser()">
                        <option value="">
                    		<spring:message code="label.serviceRequest.select" />
                		</option>
                    </select>
                </div>
                <div class="floatL" style="margin-left: 25px;">
                    <input type='hidden' data-ng-bind="customerLOALevelThreeMoney.currency=customer.preferredCurrency" /> <input ng-style="{width:'182px'}"
                        data-ng-model="customerLOALevelThreeMoney" name="customerLOALevelThreeMoney" money />
                </div>
                <div ng-show='form.customerLOALevelThreeMoney.$error.greater' style="color: red;">
                    &nbsp;
                    <spring:message code="label.common.error.greaterThan" arguments="{{customerLOALevelTwoMoney.amount}}" />
                </div>
            </div>
        </div>
   
    <!--     END  -->

    <div class="clear"></div>
    
    <div class="details-sub-header">
        <span><spring:message code="title.common.quoteClaimBehaviour" />
        </span>
    </div>
    <div class="clear"></div>

    <div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.daysToExpire" />
            :
        </div>
        <div class="marR109 floatL">
            <INPUT TYPE="number" data-ng-model="customer.daysToExpire" numbers-only />
        </div>
        <div class="fieldSpacerWidth floatL"></div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.claimVsQuoteAmount" />
            :
        </div>
        <div class="floatL">
            <INPUT type="number" data-ng-model="customer.claimVsQuoteAmt" numbers-only />
            <spring:message code="label.common.percentage" />
        </div>
    </div>

    <div class="clear"></div>

    <div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.daystToPreinvoiceApproval" />
            :
        </div>
        <div class="marR109 floatL">
            <INPUT type="number" data-ng-model="customer.daysToPreinvoiceApproval" numbers-only />
        </div>
        <div class="fieldSpacerWidth floatL"></div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.quoteVsClaimAmount" />
            :
        </div>
        <div class="floatL">
            <INPUT type="number" data-ng-model="customer.quoteVsClaimAmt" numbers-only />
            <spring:message code="label.common.percentage" />
        </div>

    </div>

    <div class="clear"></div>

    <div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.isAuditEnabled" />
            :
        </div>
        <div class="fieldSpacerWidth floatL"></div>
        <div class="yesOrNoRadioStyle floatL">
            <spring:message code="label.common.yes" />
            <input type="radio" id="auditEnabled" data-ng-model="customer.auditEnabled" ng-value="true" ng-boolean-radio />
            <spring:message code="label.common.no" />
            <input type="radio" id="auditNotEnabled" data-ng-model="customer.auditEnabled" ng-value="false" ng-boolean-radio ng-change="disableValues()" />
        </div>
        <div data-ng-show="customer.auditEnabled">
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.auditFrequency" />
                :
            </div>
            <div class="marR109 floatL">
                <INPUT type="number" data-ng-model="customer.auditFrequency" data-ng-required="customer.auditEnabled" numbers-only />
            </div>
        </div>
    </div>

    <div class="clear"></div>

    <%--     <div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.auditGroup" />:
        </div>
       <div class="floatL">
            <select data-ng-model="customer.auditGroup">
                <option value="">-- Select --</option>
            </select>
        </div>
    </div> --%>
    <!-- End -->

    <div class="clear"></div>
    <div class="details-sub-header">
        <span><spring:message code="title.common.accountBehaviour" />
        </span>
    </div>
    <div class="clear"></div>

    <div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.isDayTimeEmergency" />
            :
        </div>
        <div class="fieldSpacerWidth floatL"></div>
        <div class="yesOrNoRadioStyle floatL">
            <spring:message code="label.common.yes" />
            <input type="radio" id="dayTimeEmergencyEnabled" data-ng-model="customer.dayTimeEmergency" ng-value="true" ng-boolean-radio
                data-ng-init="customer.dayTimeEmergency=false" ng-click="showEmergencyMessage=true" />
            <spring:message code="label.common.no" />
            <input type="radio" id="dayTimeEmergencyNotEnabled" data-ng-model="customer.dayTimeEmergency" ng-value="false" ng-boolean-radio
                data-ng-init="customer.dayTimeEmergency=false" />
        </div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.isTelemetryEnabled" />
            :
        </div>
        <div class="fieldSpacerWidth floatL"></div>
        <div class="yesOrNoRadioStyle floatL">
            <spring:message code="label.common.yes" />
            <input type="radio" id="telemetryEnabled" data-ng-model="customer.telemetryEnabled" ng-value="true" ng-boolean-radio />
            <spring:message code="label.common.no" />
            <input type="radio" id="telemetryNotEnabled" data-ng-model="customer.telemetryEnabled" ng-value="false" ng-boolean-radio />
        </div>
    </div>

    <div class="clear"></div>

    <div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.isServiceChannelEnabled" />
            :
        </div>
        <div class="fieldSpacerWidth floatL"></div>
        <div class="yesOrNoRadioStyle floatL">
            <spring:message code="label.common.yes" />
            <input type="radio" id="serviceChannelEnabled" data-ng-model="customer.serviceChannelEnabled" ng-value="true" ng-boolean-radio />
            <spring:message code="label.common.no" />
            <input type="radio" id="serviceChannelNotEnabled" data-ng-model="customer.serviceChannelEnabled" ng-value="false" ng-boolean-radio />
        </div>
         <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.isNeedDifferentDealerEnabled" />
            :
        </div>
        <div class="fieldSpacerWidth floatL"></div>
        <div class="yesOrNoRadioStyle floatL">
            <spring:message code="label.common.yes" />
            <input type="radio" id="needDifferentDealerEnabled" data-ng-model="customer.needDifferentDealerEnabled" ng-value="true" ng-boolean-radio />
            <spring:message code="label.common.no" />
            <input type="radio" id="needDifferentDealerEnabled" data-ng-model="customer.needDifferentDealerEnabled" ng-value="false" ng-boolean-radio />
        </div>
    </div>

    <div class="clear"></div>

    <div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.fiscalStartDate" />
            :
        </div>
        <div class="floatL">
            <select id="startDate" data-ng-model="customer.fiscalStartDate" name="startDate" ng-options="c for c in monthsList">
            </select>
        </div>
        <div class="fieldSpacerWidth floatL"></div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customer.fiscalEndDate" />
            :
        </div>
        <div class="floatL">
            <input type="text" data-ng-model="customer.fiscalEndDate" readonly />
            <!--  <select id="endDate" data-ng-model="customer.fiscalEndDate" name="endDate" ng-options="c for c in monthsList">
         </select> -->
        </div>

        <div class="clear"></div>

        <div>
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.script" />
                :
            </div>
            <div class="floatL">
                <textarea data-ng-model="customer.scriptForCallCenter" rows="4" cols="400" class="wid400" max-length></textarea>
            </div>
            <div class="fieldSpacerWidth floatL"></div>
            <div class="customerLabelStyle floatL"></div>
            <div class="floatL"></div>
        </div>

        <div class="clear"></div>
        <div class="details-sub-header">
            <span><spring:message code="title.common.overTimeMultipliers" />
            </span>
        </div>
        <div class="clear"></div>

        <div>
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.nightAndSaturdayMultiplier" />
                : <span class="red">*</span>
            </div>
            <div class="marR109 floatL">
                <INPUT type="number" data-ng-model="customer.nightSatMultiplier" numbers-only required />
                <spring:message code="label.common.percentage" />
            </div>
        </div>

        <div class="clear"></div>

        <div>
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.sundayMultiplier" />
                : <span class="red">*</span>
            </div>
            <div class="marR109 floatL">
                <INPUT type="number" data-ng-model="customer.sundayMultiplier" numbers-only required />
                <spring:message code="label.common.percentage" />
            </div>

        </div>

        <div class="clear"></div>

        <div>
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.holidayMultiplier" />
                : <span class="red">*</span>
            </div>
            <div class="marR109 floatL">
                <INPUT type="number" data-ng-model="customer.holidayMultiplier" numbers-only required />
                <spring:message code="label.common.percentage" />
            </div>

        </div>
    </div>

    <div popup="showEmergencyMessage" close="closeEmergencyMessage()">
        <div class="modal-header">
            <center>
                <h6>
                    <spring:message code="label.customerManangement.daytimeEmergency" />
                </h6>
            </center>
        </div>
        <div class="modal-body">
            <center>
                <spring:message code="label.customerManangement.daytimeEmergencyMsg" />
            </center>
            <div class="clear"></div>
            <div class="clear"></div>
            <center>
                <button type="button" class="blue-btn" ng-click="closeEmergencyMessage()">
                    <spring:message code="label.common.ok" />
                </button>
            </center>
        </div>
    </div>

</div>
<div ng-if="isDealerOwned">
	<div class="accordion-header contentPane">
		<!-- accordion header -->
		<spring:message code="title.common.invoicing" />
		<span class="expand-collapse collapse-icon"></span>
	</div>
	<div class="overflow-hidden accordion-info">
		<div>
			<div class="customerLabelStyle floatL">
				<spring:message code="label.customer.dueDays" />
				:<span class="red">*</span>
			</div>
			<div class="floatL">
				<INPUT TYPE="text" data-ng-model="customer.dueDays" data-ng-required='true'>
			</div>

			<div class="fieldSpacerWidth floatL"></div>
			<div class="customerLabelStyle floatL">
				<spring:message code="label.customer.invoicingInterval" />
				:<span class="red">*</span>
			</div>
			<div class="marR109 floatL">
				<select name="customer.invoicingInterval"
					data-ng-model="customer.invoicingInterval"
					ng-options="ii for ii in listInvoicingInterval" data-ng-required='true'>
					<option value="">-SELECT-</option>
				</select>
			</div>

		</div>
		<div class="clear"></div>
		<div>
			<div class="customerLabelStyle floatL">
				<spring:message code="label.customer.invoicingCurrency" />
				:<span class="red">*</span>
			</div>
			<div class="marR109 floatL">
				<select name="customer.invoicingCurrency"
					data-ng-model="customer.invoicingCurrency"
					ng-options="icl for icl in invoicingCurrenciesList" data-ng-required='true'>
					<option value="">-SELECT-</option>
				</select>
			</div>

		</div>
		<div class="clear"></div>
		<div>
			<div class="customerLabelStyle floatL">
				<spring:message code="label.customer.doNotTaxCustomer" />
				: <input type="checkbox" class="action-radio"
					ng-model="customer.taxFlag">
			</div>
		</div>
	</div>
</div>
<!-- End -->