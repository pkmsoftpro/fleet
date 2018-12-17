
<div class="containerDiv"/>
	<div class="rowDivHeader">
		<div class="cellDivHeader wid150">
			<spring:message code="label.quote.laborJobCode" />
		</div>
		<div class="cellDivHeader wid150" >
			<spring:message code="label.quote.standardHours" />
		</div>
		<div class="cellDivHeader wid150" >
			<spring:message code="label.quote.jobDescription" />
		</div>
		<div class="cellDivHeader wid150">
			<spring:message code="label.quote.additionalLaborHours" />
		</div>
		<div class="cellDivHeader wid150">
			<spring:message code="label.quote.costPerHour" />
		</div>
		<div class="cellDivHeader wid150">
			<spring:message code="label.quote.extendedLaborPrice" />
		</div>
		<div class="cellDivHeader wid100">
			<spring:message code="label.quote.reasonForAdditionalLabor" />
		</div>
	</div>
	<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" ng-repeat="item in activeAudit.serviceInformation.serviceDetail.laborDetails">
		<div class="cellDiv wid150" >
			<div data-ng-model="item.completeCode"  data-ng-bind="item.completeCode" tooltip="{{item.completeName}}" tooltip-placement="right" style="cursor: default">
				<input type="hidden" data-ng-model="item.completeName"  data-ng-bind="item.completeName" />
			</div>
		</div>
		<div class="cellDiv wid150">
			<div data-ng-model="item.hoursSpent" data-ng-bind="item.hoursSpent"></div>
		</div>
		<div class="cellDiv wid150" >
			<div data-ng-model="item.serviceProcedure.definedFor.definition.code" data-ng-bind="item.serviceProcedure.definedFor.definition.code" ></div>
		</div>

		<div class="cellDiv wid150">
			<input class="cellInputStyle" TYPE="text" data-ng-model="item.additionalLaborHours" data-ng-readonly="true"/>
		</div>
		<div class="cellDiv wid150">
			 <input class="cellInputStyle" type="text" class="repeat" data-ng-model='item.costPerHour' ng-style="{width:'80px'}" money data-disable="true"/>
		</div>
		<div class="cellDiv wid150">
			<div  ng-show='(item.hoursSpent +item.additionalLaborHours) * item.costPerHour.amount'>
                    &nbsp{{item.costPerHour.currency}}&nbsp{{(item.hoursSpent +item.additionalLaborHours) * item.costPerHour.amount |number:2}}
         </div>
		</div>
		
		<div class="cellDiv wid100">
			<input class="cellInputStyle" TYPE="textarea" data-ng-model="item.reasonForAdditionalHours" data-ng-readonly="true"/>
		</div>
	</div>
</div >


<div class="containerDiv" >
	<div class="rowDivHeader">
		<div class="cellDivHeader wid150">
			<spring:message code="label.quote.standardServices" />
		</div>
		<div class="cellDivHeader wid150" >
			<spring:message code="label.quote.description" />
		</div>
		<div class="cellDivHeader wid150" >
			<spring:message code="label.quote.standardHours" />
		</div>
		 <div ng-if="isInternalUserOrOwningDealer || servicingDealer"  class="cellDivHeader wid150">
			<spring:message code="label.quote.flatFeeForDealer" />
		</div>
		<div ng-if="!servicingDealer"  class="cellDivHeader wid150">
			<spring:message code="label.quote.flatFeeForCustomer" />
		</div>

		<div class="cellDivHeader wid150">
			<spring:message code="label.quote.additionalLaborHours" />
		</div>
		<div class="cellDivHeader wid150">
			<spring:message code="label.quote.extendedLaborPrice" />
		</div>
		<div class="cellDivHeader wid100">
			<spring:message code="label.quote.reasonForAdditionalLabor" />
		</div>
		<div class="cellDivHeader wid115">
			<spring:message code="label.common.view" />
		</div>
	</div>
	<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" ng-repeat="item in activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails">
		<div class="cellDiv wid150 " >
			<input type="text"  data-ng-model="item.serviceCodeDefinition.code" data-ng-readonly="isReadOnly()"/>
		</div>
		<div class="cellDiv wid150">
			{{item.serviceCodeDefinition.description}}
		</div>
		
		<div class="cellDiv wid150">
		<div data-ng-model="item.standardHours" data-ng-bind="item.standardHours"></div>	
		</div>
		

		<div ng-if="isInternalUserOrOwningDealer || servicingDealer" class="cellDiv wid150" >
		 <INPUT TYPE="text" data-disable="true" ng-style="{width:'112px'}" data-ng-model="item.flatFeeForDealer"  money>
		</div>


		 <div ng-if="!servicingDealer" class="cellDiv wid150" >
		  <INPUT TYPE="text" data-disable="true" ng-style="{width:'112px'}" data-ng-model="item.flatFeeForCustomer"  money>
		 </div>

	
		<div class="cellDiv wid150">
		<input class="cellInputStyle" TYPE="text" data-ng-model="item.additionalLaborHours" data-ng-readonly="true" numbers-only />
		</div>

		<div ng-show="servicingDealer" class="cellDiv wid150">
		<div><INPUT TYPE="text" data-disable="true" ng-style="{width:'112px'}" data-ng-model="item.extendedPriceDealer"  money /></div>	
		</div>


		 <div ng-show="!servicingDealer" class="cellDiv wid150">
		<div><INPUT TYPE="text" data-disable="true" ng-style="{width:'112px'}" data-ng-model="item.extendedPriceCustomer"  money /></div>	
		</div>

		<div class="cellDiv wid100">
		<input class="cellInputStyle" TYPE="textarea" data-ng-model="item.reasonForAdditionalHours" data-ng-readonly="true" ng-required="item.additionalLaborHours"/>	
		</div>
		<div class="cellDiv wid115">
		 <a class="text-link"  href="" data-ng-click="showInclusions($index)"><spring:message code="label.common.viewInclusions" /> </a>	
		</div>
	</div>
</div >


<div class="containerDiv" >
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
            <input class="cellInputStyle" TYPE="text" data-ng-model="item.laborMultiplierLabel" readonly="readonly" />
        </div>
        <div class="cellDiv wid200">
            <input class="cellInputStyle" TYPE="text"
                data-ng-model="activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail[$index].overTimeLaborHours" numbers-only data-ng-readonly="true"/>
        </div>
        <div class="cellDiv wid400">
            <input class="cellInputStyle" TYPE="textarea"
                data-ng-model="activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail[$index].reasonForOverTimeLaborHours" 
                data-ng-readonly="true"/>
        </div>
        </div>
        <span ng-if="activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail.length>0"> <span
            ng-repeat="laborMultiplier in activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail"> <span
                ng-if="laborMultiplier.overTimeLaborMultiplier==item.laborMultiplier"> <span class="cellDiv wid400"> <input class="cellInputStyle"
                        TYPE="text" data-ng-model="item.laborMultiplierLabel" readonly="readonly" />
                </span> <span class="cellDiv wid200"> <input class="cellInputStyle" TYPE="text" data-ng-model="laborMultiplier.overTimeLaborHours" numbers-only
                        data-ng-readonly="true" />
                </span> <span class="cellDiv wid400"> <input class="cellInputStyle" TYPE="textarea" data-ng-model="laborMultiplier.reasonForOverTimeLaborHours"
                        data-ng-readonly="true" />
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
				<div class="containerDiv" style="width:450px !important;">
					<div class="rowDivHeader" style="width:450px !important;">
						<div class="cellDivHeader wid100">
							<spring:message code="label.common.partNumber" />
						</div>
						<div class="cellDivHeader wid100">
							<spring:message code="label.common.description" />
						</div>
						<div class="cellDivHeader wid100">
							<spring:message code="label.common.quantity" />
						</div>
					</div>

					<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" style="width:450px !important;"  ng-repeat="item in oemInclusions">
						<div class="cellDiv wid100">{{item.brandItem.itemNumber}}</div>
						<div class="cellDiv wid100">{{item.brandItem.item.description}}</div>
						<div class="cellDiv wid100">{{item.numberOfUnits}}</div>
					</div>
				</div>
					<div class="fieldSpacerHeight" style="clear: both;"></div>
					<div class="floatL">
						<h6 >
							<spring:message code="label.quote.nonOEMParts" />
						</h6>
					</div>
					<div class="fieldSpacerHeight" style="clear: both;"></div>
					<div class="containerDiv" style="width:450px !important;">
						<div class="rowDivHeader" style="width:450px !important;">
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

						<div data-ng-class-odd="'rowDivOdd'" style="width:450px !important;" data-ng-class-even="'rowDivEven'" ng-repeat="item in nonoemInclusions">
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
