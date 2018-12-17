<%@taglib prefix="authz" uri="authz"%>
    <div class="details-sub-header"><span><spring:message code="label.common.quote.oemPartsInstalled"/></span></div>
<div class="containerDiv">
    <div class="rowDivHeader">
        <div class="cellDivHeader wid200">
            <spring:message code="label.common.partSerialNumber" />
        </div>
        <div class="cellDivHeader wid200">
            <spring:message code="label.common.partNumber" />
        </div>
        <div class="cellDivHeader wid200">
            <spring:message code="label.common.description" />
        </div>
        <div class="cellDivHeader wid100">
            <spring:message code="label.common.quantity" />
        </div>
         <div class="cellDivHeader wid100">
            <spring:message code="label.quote.unitPrice" />
        </div>
         <div class="cellDivHeader wid106">
            <spring:message code="label.quote.extendedPrice" />
        </div>
    </div>
    <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'"
        ng-repeat="item in activeAudit.serviceInformation.serviceDetail.oemPartsInstalled | orderBy: 'id'">
        <div class="cellDiv wid200">
            <input TYPE="text" data-ng-readonly="true" data-ng-model="item.installedPartSerialNumber"  />
        </div>
        <div class="cellDiv wid200">
            <input TYPE="text" 
               data-ng-readonly="true"  data-ng-model="item.installedBrandItem.itemNumber" />
        </div>
        <div class="cellDiv wid200">
            <div >{{item.installedBrandItem.item.description}}</div>
        </div>
        <div class="cellDiv wid100">
            <input type="text" data-ng-readonly="true"   class="repeat" data-ng-model='item.numberOfUnits' numbers-only required/>
        </div>
         <div class="cellDiv wid100">
            <input class="cellInputStyle" type="text" class="repeat" data-ng-model='item.basePricePerUnitDealer' ng-readonly="true" ng-style="{width:'50px'}"
               data-disable="true"  money />
        </div>
         <div class="cellDiv wid106">
            <input class="cellInputStyle" data-ng-readonly="true"  type="text" class="repeat" data-ng-model='item.extendedPricePerUnit' disable="true" ng-style="{width:'50px'}"
                money />
        </div>
    </div>
</div>

    <div class="details-sub-header"><span><spring:message code="label.common.quote.oemPartsReplaced"/></span></div>
<div class="containerDiv">
    <div class="rowDivHeader">
        <div class="cellDivHeader wid225">
            <spring:message code="label.common.partSerialNumber" />
        </div>
        <div class="cellDivHeader wid261">
            <spring:message code="label.common.partNumber" />
        </div>
        <div class="cellDivHeader wid261">
             <spring:message code="label.common.description" />
        </div>
        <div class="cellDivHeader wid150">
             <spring:message code="label.common.quantity" />
        </div>
    </div>
    <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'"
        ng-repeat="item in activeAudit.serviceInformation.serviceDetail.oemPartsReplaced | orderBy: 'id'">
        <div class="cellDiv wid225">
            <input TYPE="text" data-ng-model="item.replacedPartSerialNumber" data-ng-readonly="true" />
        </div>
        <div class="cellDiv wid261">
            <input TYPE="text" data-ng-model="item.replacedBrandItem.itemNumber" data-ng-readonly="true" />
        </div>
        <div class="cellDiv wid261">
            <div data-ng-model="item.removedBrandItem.item.description"
                data-ng-bind="item.replacedBrandItem.item.description"></div>
        </div>
        <div class="cellDiv wid150">
            <input type="text"  class="repeat" data-ng-readonly="true"  data-ng-model='item.numberOfUnits' numbers-only required/>
        </div>
    </div >
</div> 
		<div class="details-sub-header">
			<span><spring:message code="label.common.quote.non-oemParts" />
			</span>
		</div>
		<div class="containerDiv">
			<div class="rowDivHeader">
				<div class="cellDivHeader wid150">
					<spring:message code="label.common.partNumber" />
				</div>
				<div class="cellDivHeader wid150">
					<spring:message code="label.common.description" />
				</div>
				<div class="cellDivHeader wid150">
					<spring:message code="label.common.quantity" />
				</div>
				<div class="cellDivHeader wid150">
					<spring:message code="label.quote.unitPrice" />
				</div>
				<div class="cellDivHeader wid150">
					<spring:message code="label.quote.extendedPrice" />
				</div>
				<div class="cellDivHeader wid150">
					<spring:message code="label.quote.attachInvoice" />
				</div>
			</div>

			<!-- Repeat Template Section -->
			<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" ng-repeat="item in activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled | orderBy: 'id'">
				<div class="cellDiv wid150">
					<input class="cellInputStyle" data-ng-readonly="true"  type="text" class="repeat" data-ng-model='item.partNumber' required />
				</div>
				<div class="cellDiv wid150">
					<input class="cellInputStyle" type="text" data-ng-readonly="true"  class="repeat" data-ng-model='item.description' required />
				</div>
				<div class="cellDiv wid150">
					<input class="cellInputStyle" type="text" data-ng-readonly="true"  class="repeat" data-ng-model='item.numberOfUnits' numbers-only required />
				</div>
				<div class="cellDiv wid150" >
					<input class="cellInputStyle" type="text" data-disable="true"  class="repeat" data-ng-model='item.pricePerUnit' ng-style="{width:'80px'}" money />

				</div>
				<div class="cellDiv wid150">
					<div ng-show='item.pricePerUnit.amount * item.numberOfUnits'>&nbsp{{item.pricePerUnit.currency}}&nbsp{{calculateNonOemExtendedPrice(item.pricePerUnit.amount,item.numberOfUnits)|number:2}}</div>
				</div>
				<div class="cellDiv wid150">
				    <a class="text-link" ng-show="item.invoice != null" href="download?id={{item.invoice.id}}">{{item.invoice.fileName}} </a>
				</div>
			</div>

		</div>
	