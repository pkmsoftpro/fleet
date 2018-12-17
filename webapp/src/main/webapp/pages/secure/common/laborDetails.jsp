<%@taglib prefix="authz" uri="authz"%>
<div class="containerDiv" ng-init="activeAudit.serviceInformation.serviceDetail.laborDetails = activeAudit.serviceInformation.serviceDetail.laborDetails == null ? [] : activeAudit.serviceInformation.serviceDetail.laborDetails"
	ng-model="activeAudit.serviceInformation.serviceDetail.laborDetails" repeater>
	<input type="hidden" name="activeAudit.serviceInformation.serviceDetail.laborDetails" data-ng-model="activeAudit.serviceInformation.serviceDetail.laborDetails" />
	<div class="rowDivHeader">
		<div class="cellDivHeader wid125">
			<spring:message code="label.quote.laborJobCode" />
		</div>
		<div class="cellDivHeader wid125" >
			<spring:message code="label.quote.standardHours" />
		</div>
		<div class="cellDivHeader wid125" >
			<spring:message code="label.quote.jobDescription" />
		</div>
		<div class="cellDivHeader wid125">
			<spring:message code="label.quote.additionalLaborHours" />
		</div>
		<div class="cellDivHeader wid125">
			<spring:message code="label.quote.costPerHour" />
		</div>
		<div class="cellDivHeader wid125">
			<spring:message code="label.quote.extendedLaborPrice" />
		</div>
		<div class="cellDivHeader wid125">
			<spring:message code="label.quote.reasonForAdditionalLabor" />
		</div>
		<div class="cellDivHeader wid125">
			<a class="add-row" ng-click="listJobCodes(equipment.id,activeAudit.serviceInformation.causalPart.item.id)" ng-hide="isReadOnly()"></a>
		</div>
	</div>
	<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" ng-repeat="item in activeAudit.serviceInformation.serviceDetail.laborDetails">
		<div class="cellDiv wid125" >
			<div data-ng-model="item.completeCode" data-ng-bind="item.completeCode" tooltip="{{item.completeName}}" tooltip-placement="right" style="cursor: default">
				<input type="hidden" data-ng-model="item.completeName"  data-ng-bind="item.completeName" />
			</div>
		</div>
		<div class="cellDiv wid125">
			<div data-ng-model="item.hoursSpent" data-ng-bind="item.hoursSpent"></div>
		</div>
		<div class="cellDiv wid125" >
			<div data-ng-model="item.serviceProcedure.definedFor.definition.code" data-ng-bind="item.serviceProcedure.definedFor.definition.code"></div>
		</div>

		<div class="cellDiv wid125">
			<input class="cellInputStyle" TYPE="text" data-ng-model="item.additionalLaborHours" data-ng-readonly="isReadOnly()" is-number/>
		</div>
		<div class="cellDiv wid125" data-ng-init="item.costPerHour.currency = item.costPerHour.currency == null ? preferredCurrency : item.costPerHour.currency">
			 <input class="cellInputStyle" type="text" class="repeat" data-ng-model='item.costPerHour' ng-style="{width:'80px'}" money data-disable="true"/>
		</div>
		<div class="cellDiv wid125">
			<div>
                    &nbsp{{item.costPerHour.currency}}&nbsp{{((item.hoursSpent+item.additionalLaborHours) * item.costPerHour.amount)|number:2}}
         </div>
		</div>
		<div class="cellDiv wid125">
			<input class="cellInputStyle" TYPE="textarea" data-ng-model="item.reasonForAdditionalHours" data-ng-readonly="isReadOnly()" ng-required="(item.additionalLaborHours)>0"/>
		</div>
		
		<div class="cellDiv wid125">
			<a class="class" ng-click="deleteThis($index,'activeAudit.serviceInformation.serviceDetail.laborDetails')" ng-hide="isReadOnly()"><i class="icon-trash"></i> </a>
		</div>
	</div>
</div >
<div ng-show="invalidServiceRequest" class="red"><spring:message code="label.common.selectServiceRequest" /></div>
<div ng-show="invalidSerialNumber" class="red"><spring:message code="label.common.enterSerialNumber" /></div>
<div ng-show="invalidRepairEndDate" class="red"><spring:message code="label.common.enterRepairEndDate" /></div>
<div class="containerDiv" ng-init="activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails = activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails == null ? [] : activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails"
	ng-model="activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails" repeater>
	<input type="hidden" name="activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails" data-ng-model="activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails" />
	<div class="rowDivHeader">
		<div class="cellDivHeader wid135">
			<spring:message code="label.quote.standardServices" />
		</div>
		<div class="cellDivHeader wid115" >
			<spring:message code="label.quote.description" />
		</div>
		<div class="cellDivHeader wid115" >
			<spring:message code="label.quote.standardHours" />
		</div>
		<div ng-show="!isInternalUserOrOwningDealer" class="cellDivHeader wid115">
			<spring:message code="label.quote.flatFee" />
		</div>
		 <div  ng-show="isInternalUserOrOwningDealer" class="cellDivHeader wid115">
			<spring:message code="label.quote.flatFeeForDealer" />
		</div>
		<div ng-show="isInternalUserOrOwningDealer" class="cellDivHeader wid115">
			<spring:message code="label.quote.flatFeeForCustomer" />
		</div>
		 <%-- </authz:ifUserInRole> --%>
		<div class="cellDivHeader wid115">
			<spring:message code="label.quote.additionalLaborHours" />
		</div>
		<div class="cellDivHeader wid115">
			<spring:message code="label.quote.extendedLaborPrice" />
		</div>
		<div class="cellDivHeader wid115">
			<spring:message code="label.quote.reasonForAdditionalLabor" />
		</div>
		<div class="cellDivHeader wid115">
			<spring:message code="label.common.view" />
		</div>
		<div class="cellDivHeader wid60">
			<a class="add-row" ng-click="addInputRow('activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails','serviceCodeDefinition.code','serviceCodeDefinition.description','standardHours','dummyColumn','additionalLaborHours','reasonForAdditionalHours')" ng-hide="isReadOnly()"></a>
		</div>
	</div>
	<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" ng-repeat="item in activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails">
		<div class="cellDiv wid135 " >
			<input type="text"  data-ng-model="item.serviceCodeDefinition.code" data-ng-readonly="isReadOnly()"
                 typeahead-min-length='3' typeahead-on-select="setServiceCodeDefinition($item,$index)"
                 typeahead="serviceCodeDefinition.code as serviceCodeDefinition.code for serviceCodeDefinition in getStandardServiceCodes($viewValue)" required ng-change="clearStandardServices($index, item.serviceCodeDefinition.code)" />
		</div>
		<div class="cellDiv wid115">
			<div data-ng-model="item.serviceCodeDefinition.description" data-ng-bind="item.serviceCodeDefinition.description"></div>
		</div>
		
		<div class="cellDiv wid115">
		<div data-ng-model="item.standardHours" data-ng-bind="item.standardHours"></div>	
		</div>
		
		<div ng-show="isInternalUserOrOwningDealer || servicingDealer" class="cellDiv wid115" >
		 <INPUT TYPE="text" data-disable="true" ng-style="{width:'112px'}" data-ng-model="item.flatFeeForDealer"  money>
		</div>
		 <div ng-show="!servicingDealer" class="cellDiv wid115" >
		  <INPUT TYPE="text" data-disable="true" ng-style="{width:'112px'}" data-ng-model="item.flatFeeForCustomer"  money>
		 </div>
	
		<div class="cellDiv wid115">
		<input class="cellInputStyle" TYPE="text" data-ng-model="item.additionalLaborHours" data-ng-readonly="isReadOnly()" is-number />
		</div>
		<div ng-show="servicingDealer" class="cellDiv wid115">
		<div><INPUT TYPE="text" data-disable="true" ng-style="{width:'112px'}" data-ng-model="item.extendedPriceDealer"  money /></div>	
		</div>

		 <div ng-show="!servicingDealer" class="cellDiv wid115">
		<div><INPUT TYPE="text" data-disable="true" ng-style="{width:'112px'}" data-ng-model="item.extendedPriceCustomer"  money /></div>	
		</div>
		<div class="cellDiv wid115">
		<input class="cellInputStyle" TYPE="textarea" data-ng-model="item.reasonForAdditionalHours" data-ng-readonly="isReadOnly()" ng-required="(item.additionalLaborHours)>0"/>	
		</div>
		<div class="cellDiv wid115">
		 <a class="text-link"  href="" data-ng-click="showInclusions($index)"><spring:message code="label.common.viewInclusions" /> </a>	
		</div>
		<div class="cellDiv wid60">
			<a class="class" ng-click="deleteThis($index,'activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails')" ng-hide="isReadOnly()"><i class="icon-trash"></i> </a>
		</div>
	</div>
</div >

<div class="containerDiv" ng-init="activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail = activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail == null ? [] : activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail"
    ng-model="activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail" repeater>
    <input type="hidden" name="activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail" data-ng-model="activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail" />

    <div class="rowDivHeader">
        <div class="cellDivHeader wid400">
            <spring:message code="label.quote.overtimeLaborMultiplier" />
        </div>
        <div class="cellDivHeader wid200">
            <spring:message code="label.quote.overtimeLaborHours" />
        </div>
        <div class="cellDivHeader wid400">
            <spring:message code="label.quote.overtimeLaborReason" />
        </div>
    </div>
    <div class="cell-bottom-border" data-ng-repeat="item in laborMultipliers">
    <div ng-if="activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail.length==0">
        <div class="cellDiv wid400">
            <input class="cellInputStyle" TYPE="text" data-ng-model="item.laborMultiplierLabel" data-ng-readonly="true" />
        </div>
        <div class="cellDiv wid200">
            <input class="cellInputStyle" TYPE="text"
                data-ng-model="activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail[$index].overTimeLaborHours" is-number data-ng-readonly="true"/>
        </div>
        <div class="cellDiv wid400">
            <input class="cellInputStyle" TYPE="textarea"
                data-ng-model="activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail[$index].reasonForOverTimeLaborHours" 
                data-ng-readonly="true" ng-required="(activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail[$index].overTimeLaborHours) > 0"/>
        </div>
        </div>
        <span ng-if="activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail.length>0"> <span
            ng-repeat="laborMultiplier in activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail"> <span
                ng-if="laborMultiplier.overTimeLaborMultiplier==item.laborMultiplier"> <span class="cellDiv wid400"> <input class="cellInputStyle"
                        TYPE="text" data-ng-model="item.laborMultiplierLabel" data-ng-readonly="true" />
                </span> <span class="cellDiv wid200"> <input class="cellInputStyle" TYPE="text" data-ng-model="laborMultiplier.overTimeLaborHours" is-number
                        data-ng-readonly="true" />
                </span> <span class="cellDiv wid400"> <input class="cellInputStyle" TYPE="textarea" data-ng-model="laborMultiplier.reasonForOverTimeLaborHours"
                        data-ng-readonly="true" ng-required="(laborMultiplier.overTimeLaborHours) > 0" />
                </span>
            </span>
        </span>
        </span>

    </div>

</div>
<div popup="viewInclusions" close="closeInclusions()">
	<div class="modal-header">
		<center>
			<h6>
				<spring:message code="label.common.viewInclusions" />
			</h6>
		</center>
	</div>
	<div class="modal-body">
		<center>
			<div ng-show='showAssociatedInclussions'>
				<div class="fieldSpacerHeight" style="clear: both;"></div>
				<div class="floatL">
					<h6>
						<spring:message code="label.quote.OEMParts" />
					</h6>
				</div>
				<div class="fieldSpacerHeight" style="clear: both;"></div>
				<div class="containerDiv" style="width:450px!important;height:auto">
					<div class="rowDivHeader" style="width:450px !important;">
						<div class="cellDivHeader wid150">
							<spring:message code="label.common.partNumber" />
						</div>
						<div class="cellDivHeader wid150">
							<spring:message code="label.common.description" />
						</div>
						<div class="cellDivHeader wid150">
							<spring:message code="label.common.quantity" />
						</div>
					</div>

					<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" style="width:450px !important;"  ng-repeat="item in oemInclusions">
						<div class="cellDiv wid150">{{item.brandItem.itemNumber}}</div>
						<div class="cellDiv wid150">{{item.brandItem.item.description}}</div>
						<div class="cellDiv wid150">{{item.numberOfUnits}}</div>
					</div>
				</div>
					<div class="fieldSpacerHeight" style="clear: both;"></div>
					<div class="floatL">
						<h6 >
							<spring:message code="label.quote.nonOEMParts" />
						</h6>
					</div>
					<div class="fieldSpacerHeight" style="clear: both;"></div>
					<div class="containerDiv" style="width:400px !important;;height:auto">
						<div class="rowDivHeader" style="width:400px !important;">
							<div class="cellDivHeader wid100">
								<spring:message code="label.common.partNumber" />
							</div>
							<div class="cellDivHeader wid100">
								<spring:message code="label.common.description" />
							</div>
							<div class="cellDivHeader wid100">
								<spring:message code="label.common.quantity" />
							</div>
							<div class="cellDivHeader wid100">
								<spring:message code="label.quote.unitPrice" />
							</div>
						</div>

						<div data-ng-class-odd="'rowDivOdd'" style="width:400px !important;" data-ng-class-even="'rowDivEven'" ng-repeat="item in nonoemInclusions">
							<div class="cellDiv wid100">{{item.partNumber}}</div>
							<div class="cellDiv wid100">{{item.description}}</div>
							<div class="cellDiv wid100">{{item.numberOfUnits}}</div>
							<div class="cellDiv wid100">{{item.pricePerUnit.amount}} {{item.pricePerUnit.currency}}</div>
						</div>
					</div>
					
					<div class="fieldSpacerHeight" style="clear: both;"></div>
					 <div class="labelStyle">
					<spring:message code="label.quote.standardHours" />:  {{standardHours}}
					</div>
				</div>
		</center>
		<div class="fieldSpacerHeight" style="clear: both;"></div>
		<div class="fieldSpacerHeight" style="clear: both;"></div>
		<center>
			<button type="button" class="blue-btn" ng-click="closeInclusions()">
				<spring:message code="label.Common.close" />
			</button>
		</center>
	</div>
</div>


<div popup="showLaborTree" close="closePopup()">
		<div class="modal-header">
			<center>
				<h6>
					<spring:message code="label.quote.jobCode" />
				</h6>
			</center>
		</div>
		<div class="modal-body-jc">
			<center>
				<div ng-show='selectCausalPart1'>
					<spring:message code="label.quote.selectCausalPart" />
				</div>
				<div ng-show='selectSerialNumber1'>
					<spring:message code="label.quote.selectSerialNumber" />
				</div>
				<div ng-show='showJobCodeTree'>
					 <div ng-model="selected" multi-check-box>
						<ui-tree ng-model="jobCodes" load-fn="loadJobCodes" expand-to="hierarchy" selected-id="(activeAudit.serviceInformation.serviceDetail.laborDetails[index].serviceProcedure.id!=null)?activeAudit.serviceInformation.serviceDetail.laborDetails[index].serviceProcedure.id:'111'"
							attr-node-id="id"> </ui-tree>
					 </div>
				</div>
			</center>
			<div class="fieldSpacerHeight" style="clear: both;"></div>
			<div class="fieldSpacerHeight" style="clear: both;"></div>
			<center>
				<div ng-show='showJobCodeTree'>
					<button type="button" class="blue-btn" ng-click="addtoJobCodes()">
						<spring:message code="label.common.ok" />
					</button>
					<button type="button" class="blue-btn" ng-click="closePopup()">
						<spring:message code="label.Common.close" />
					</button>
				</div>
				<div ng-show='selectCausalPart1'>
					<button type="button" class="blue-btn" ng-click="closePopup()">
						<spring:message code="label.common.ok" />
					</button>
				</div>
				<div ng-show='selectSerialNumber1'>
					<button type="button" class="blue-btn" ng-click="closePopup()">
						<spring:message code="label.common.ok" />
					</button>
				</div>

			</center>
		</div>
	</div>