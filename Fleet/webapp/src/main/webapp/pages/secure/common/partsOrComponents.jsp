<%@taglib prefix="authz" uri="authz"%>
    <div class="details-sub-header"><span><spring:message code="label.common.quote.oemPartsInstalled"/></span>
     <c:if test="${folderName == null  or folderName=='Quotes Drafted' or folderName=='Draft Claims' or folderName=='Dealer Owned Draft Claims'}">
       &nbsp;&nbsp;&nbsp;&nbsp; <span  class="warningFont" ><spring:message code="title.common.note.partsAndComponents" />   </span>
</c:if>
    </div>
<div class="containerDiv"
    ng-init="activeAudit.serviceInformation.serviceDetail.oemPartsInstalled = activeAudit.serviceInformation.serviceDetail.oemPartsInstalled == null ? [] : activeAudit.serviceInformation.serviceDetail.oemPartsInstalled"
    ng-model="activeAudit.serviceInformation.serviceDetail.oemPartsInstalled" repeater>
    <input type="hidden" name="activeAudit.serviceInformation.serviceDetail.oemPartsInstalled"
        data-ng-model="activeAudit.serviceInformation.serviceDetail.oemPartsInstalled" />
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
        <div class="cellDivHeader wid96">
            <a class="add-row" ng-hide="isReadOnly()"
                ng-click="addInputRow('activeAudit.serviceInformation.serviceDetail.oemPartsInstalled','installedPartSerialNumber','installedBrandItem.id','basePricePerUnitDealer','extendedPricePerUnit')"></a>
        </div>
    </div>
    <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'"
        ng-repeat="item in activeAudit.serviceInformation.serviceDetail.oemPartsInstalled | orderBy: 'id'">
        <div class="cellDiv wid200">
            <input TYPE="text" data-ng-model="item.installedPartSerialNumber"  data-ng-readonly="isReadOnly()"/>
        </div>
        <div class="cellDiv wid200" data-ng-init="URL=module=='quote'?'listPartNumbers?id=':'listPartNumbersForClaim?brand='">
            <input TYPE="text" url="{{URL}}{{moduleId}}" data-ng-readonly="isReadOnly()"
               data-ng-model="item.installedBrandItem.itemNumber" fbs-typeahead  ng-change="installedItemDescription($index,item.installedBrandItem.itemNumber)" required />
        </div>
        <div class="cellDiv wid200">
            <div data-ng-model="item.installedBrandItem.item.description" data-ng-bind="item.installedBrandItem.item.description"></div>
        </div>
        <div class="cellDiv wid100">
            <input type="text"  class="repeat" data-ng-readonly="isReadOnly()" data-ng-model='item.numberOfUnits' numbers-only required/>
        </div>
         <div class="cellDiv wid100"
            ng-init="item.basePricePerUnitDealer.currency = item.basePricePerUnitDealer.currency == null ? preferredCurrency : item.basePricePerUnitDealer.currency">
            <input class="cellInputStyle" type="text" class="repeat" data-ng-model='item.basePricePerUnitDealer' disable="true" ng-style="{width:'50px'}"
                money />
        </div>
         <div class="cellDiv wid106"
            ng-init="item.extendedPricePerUnit.currency = item.extendedPricePerUnit.currency == null ? preferredCurrency : item.extendedPricePerUnit.currency">
            <input class="cellInputStyle" type="text" class="repeat" data-ng-model='item.extendedPricePerUnit' disable="true" ng-style="{width:'50px'}"
                money />
        </div>
        <div class="cellDiv wid96">
            <a class="class"  ng-click="deleteThis($index,'activeAudit.serviceInformation.serviceDetail.oemPartsInstalled')" ng-hide="isReadOnly()"><i class="icon-trash"></i>
            </a>
        </div>
    </div>
</div>

    <div class="details-sub-header"><span><spring:message code="label.common.quote.oemPartsReplaced"/></span></div>
<div class="containerDiv"
    ng-init="activeAudit.serviceInformation.serviceDetail.oemPartsReplaced = activeAudit.serviceInformation.serviceDetail.oemPartsReplaced == null ? [] : activeAudit.serviceInformation.serviceDetail.oemPartsReplaced"
    ng-model="activeAudit.serviceInformation.serviceDetail.oemPartsReplaced" repeater>
    <input type="hidden" name="activeAudit.serviceInformation.serviceDetail.oemPartsReplaced"
        data-ng-model="activeAudit.serviceInformation.serviceDetail.oemPartsReplaced" />
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
        <div class="cellDivHeader wid100">
             <a class="add-row" ng-hide="isReadOnly()"
                 ng-click="addInputRow('activeAudit.serviceInformation.serviceDetail.oemPartsReplaced','replacedPartSerialNumber','replacedBrandItem.id','removedBrandItem.description','numberOfUnits')"></a>
        </div>
    </div>
    <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'"
        ng-repeat="item in activeAudit.serviceInformation.serviceDetail.oemPartsReplaced | orderBy: 'id'">
        <div class="cellDiv wid225">
            <input TYPE="text" data-ng-model="item.replacedPartSerialNumber" data-ng-readonly="isReadOnly()"/>
        </div>
        <div class="cellDiv wid261" data-ng-init="URL=module=='quote'?'listPartNumbers?id=':'listPartNumbersForClaim?brand='">
            <input TYPE="text" url="{{URL}}{{moduleId}}" data-ng-readonly="isReadOnly()"
                data-ng-model="item.replacedBrandItem.itemNumber" fbs-typeahead ng-change="itemDescription($index,item.replacedBrandItem.itemNumber)" required />
        </div>
        <div class="cellDiv wid261">
            <div data-ng-model="item.removedBrandItem.item.description"
                data-ng-bind="item.replacedBrandItem.item.description"></div>
        </div>
        <div class="cellDiv wid150">
            <input type="text"  class="repeat" data-ng-readonly="isReadOnly()" data-ng-model='item.numberOfUnits' numbers-only required/>
        </div>
        <div class="cellDiv wid100">
            <a class="class"  ng-click="deleteThis($index,'activeAudit.serviceInformation.serviceDetail.oemPartsReplaced')" ng-hide="isReadOnly()"><i class="icon-trash"></i>
            </a>
        </div>
    </div >
</div> 

		<div class="details-sub-header">
			<span><spring:message code="label.common.quote.non-oemParts" />
			</span>
		</div>
		<div class="containerDiv" ng-init="activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled = activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled == null ? [] : activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled"
			ng-model="activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled" repeater>
			<input type="hidden" name="activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled" data-ng-model="activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled">
			<!-- Header Section -->
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
				<div class="cellDivHeader wid102">
					<a class="add-row" ng-hide="isReadOnly()" ng-click="addInputRow('activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled', 'partNumber', 'description', 'numberOfUnits', 'basePricePerUnitDealer', 'extendedPricePerUnit', 'invoice')"></a>
				</div>
			</div>
			
			<!-- Repeat Template Section -->
			<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" ng-repeat="item in activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled | orderBy: 'id'">
			
				<div class="cellDiv wid150">
					<input class="cellInputStyle" type="text" class="repeat" data-ng-readonly="isReadOnly()" data-ng-model='item.partNumber' required />
				</div>
				<div class="cellDiv wid150">
					<input class="cellInputStyle" type="text" class="repeat" data-ng-readonly="isReadOnly()" data-ng-model='item.description' required />
				</div>
				<div class="cellDiv wid150">
					<input class="cellInputStyle" type="text" class="repeat" data-ng-readonly="isReadOnly()" data-ng-model='item.numberOfUnits' numbers-only required />
				</div>
				
				<div ng-if="isReadOnly()==true" class="cellDiv wid150" data-ng-init="item.pricePerUnit.currency = item.pricePerUnit.currency == null ? preferredCurrency : item.pricePerUnit.currency">
					<input class="cellInputStyle" type="text" class="repeat" data-ng-model='item.pricePerUnit' ng-style="{width:'80px'}" money disable="true"/>
				</div>
				<div ng-if="isReadOnly()==false" class="cellDiv wid150" data-ng-init="item.pricePerUnit.currency = item.pricePerUnit.currency == null ? preferredCurrency : item.pricePerUnit.currency">
					<input class="cellInputStyle" type="text" class="repeat" data-ng-model='item.pricePerUnit' ng-style="{width:'80px'}" money disable="item.isPriceFetchAmount"/>
				</div>
				<div class="cellDiv wid150">
					<div ng-show='item.pricePerUnit.amount * item.numberOfUnits'>&nbsp{{item.pricePerUnit.currency}}&nbsp{{calculateNonOemExtendedPrice(item.pricePerUnit.amount,item.numberOfUnits)|number:2}}</div>
				</div>
				<div class="cellDiv wid150">
				    <a class="text-link" ng-hide="item.invoice != null || isReadOnly()" data-ng-disabled="isReadOnly()" href="" data-ng-click="uploadInvoice(item)"><spring:message code="label.quote.attachInvoice" /> </a>
				    <a class="text-link" ng-show="item.invoice != null" href="download?id={{item.invoice.id}}">{{item.invoice.fileName}} </a>
				    <a class="class" ng-show="item.invoice != null && !isReadOnly()" ng-click="item.invoice = null"><i class="icon-trash"></i> </a>
				</div>
				<div class="cellDiv wid102">
					<a class="class" ng-click="deleteThis($index,'activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled')" ng-hide="isReadOnly()"><i class="icon-trash"></i> </a>
				</div>
			</div>

		</div>