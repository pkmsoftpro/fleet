<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="labelStyle">
	<spring:message code="label.updateContract.exception.dealerPayment" />
</div>
<div class="labelStyle floatL marL30">
	<spring:message code="label.updateContract.exception.oemPartPayment" />
</div>
<br>
<div class="containerDiv wid800" ng-init="contract.applDlrPymtExcptns.oemPartExceptions = contract.applDlrPymtExcptns.oemPartExceptions == null ? [] : contract.applDlrPymtExcptns.oemPartExceptions" ng-model="contract.applDlrPymtExcptns.oemPartExceptions" repeater>
	<input type="hidden" name="contract.applDlrPymtExcptns.oemPartExceptions" data-ng-model="contract.applDlrPymtExcptns.oemPartExceptions">
	<div class="rowDivHeader wid1000 ">
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.startDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.endDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.dealer" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.modifier" />
		</div>
		<!-- <div class="cellDivHeader wid300">Set Price</div> -->
		<div class="cellDivHeader wid200">
			<a class="add-row"
				data-ng-click="addInputRow('contract.applDlrPymtExcptns.oemPartExceptions','forDuration.fromDate,forDuration.tillDate,dealer.name,modifierPercentage')"></a>
		</div>
	</div>
	<!-- Repeat Template Section -->
	<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" class="wid1000 " ng-repeat="item in contract.applDlrPymtExcptns.oemPartExceptions">
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.fromDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.tillDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<!-- <input class="wid160 marTB2 repeat" type="text" data-ng-model='item.dealer.name' /> -->
			<input class="wid160 marTB2 repeat" type="text" url="listServiceProviders" name="item.dealer" data-ng-model="item.dealer"
				fbs-typeahead />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.modifierPercentage' />
		</div>
		<div class="cellDiv wid200">
			<a class="class" ng-click="deleteThis($index,'contract.applDlrPymtExcptns.oemPartExceptions')"><i class="icon-trash"></i> </a>
		</div>
	</div>
</div>
<div class="labelStyle floatL marL30">
	<spring:message code="label.updateContract.exception.nonOemPartPayment" />
</div>
<br>
<div class="containerDiv wid800" ng-init="contract.applDlrPymtExcptns.nonOEMPartExceptions = contract.applDlrPymtExcptns.nonOEMPartExceptions == null ? [] : contract.applDlrPymtExcptns.nonOEMPartExceptions" ng-model="contract.applDlrPymtExcptns.nonOEMPartExceptions" repeater>
	<input type="hidden" name="contract.applDlrPymtExcptns.nonOEMPartExceptions" data-ng-model="contract.applDlrPymtExcptns.nonOEMPartExceptions">
	<div class="rowDivHeader wid1000 ">
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.startDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.endDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.dealer" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.modifier" />
		</div>
		<!-- <div class="cellDivHeader wid300">Set Price</div> -->
		<div class="cellDivHeader wid200">
			<a class="add-row"
				data-ng-click="addInputRow('contract.applDlrPymtExcptns.nonOEMPartExceptions','forDuration.fromDate,forDuration.tillDate,dealer.name,modifierPercentage')"></a>
		</div>
	</div>
	<!-- Repeat Template Section -->
	<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" class="wid1000 " ng-repeat="item in contract.applDlrPymtExcptns.nonOEMPartExceptions">
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.fromDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.tillDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<!-- <input class="wid160 marTB2 repeat" type="text" data-ng-model='item.dealer.name' /> -->
			<input class="wid160 marTB2 repeat" type="text" url="listServiceProviders" name="item.dealer" data-ng-model="item.dealer"
				fbs-typeahead />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.modifierPercentage' />
		</div>
		<div class="cellDiv wid200">
			<a class="class" ng-click="deleteThis($index,'contract.applDlrPymtExcptns.nonOEMPartExceptions')"><i class="icon-trash"></i> </a>
		</div>
	</div>
</div>
<br>
<div class="labelStyle floatL marL30">
	<spring:message code="label.updateContract.exception.laborRate" />
</div>
<br>
<div class="containerDiv wid800" ng-init="contract.applDlrPymtExcptns.laborRateExceptions = contract.applDlrPymtExcptns.laborRateExceptions == null ? [] : contract.applDlrPymtExcptns.laborRateExceptions" ng-model="contract.applDlrPymtExcptns.laborRateExceptions" repeater>
	<input type="hidden" name="contract.applDlrPymtExcptns.laborRateExceptions" data-ng-model="contract.applDlrPymtExcptns.laborRateExceptions">
	<div class="rowDivHeader wid1000 ">
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.startDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.endDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.dealer" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.modifier" />
		</div>
		<!-- <div class="cellDivHeader wid300">Set Price</div> -->
		<div class="cellDivHeader wid200">
			<a class="add-row"
				data-ng-click="addInputRow('contract.applDlrPymtExcptns.laborRateExceptions','forDuration.fromDate,forDuration.tillDate,dealer.name,modifierPercentage')"></a>
		</div>
	</div>
	<!-- Repeat Template Section -->
	<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" class="wid1000 " ng-repeat="item in contract.applDlrPymtExcptns.laborRateExceptions">
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.fromDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.tillDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<!-- <input class="wid160 marTB2 repeat" type="text" data-ng-model='item.dealer.name' /> -->
			<input class="wid160 marTB2 repeat" type="text" url="listServiceProviders" name="item.dealer" data-ng-model="item.dealer"
				fbs-typeahead />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.modifierPercentage' />
		</div>
		<div class="cellDiv wid200">
			<a class="class" ng-click="deleteThis($index,'contract.applDlrPymtExcptns.laborRateExceptions')"><i class="icon-trash"></i> </a>
		</div>
	</div>
</div>
<br>
<div class="labelStyle floatL marL30">
	<spring:message code="label.updateContract.exception.travelRate" />
</div>
<br>
<div class="containerDiv wid800" ng-init="contract.applDlrPymtExcptns.travelRateExceptions = contract.applDlrPymtExcptns.travelRateExceptions == null ? [] : contract.applDlrPymtExcptns.travelRateExceptions" ng-model="contract.applDlrPymtExcptns.travelRateExceptions" repeater>
	<input type="hidden" name="contract.applDlrPymtExcptns.travelRateExceptions" data-ng-model="contract.applDlrPymtExcptns.travelRateExceptions">
	<div class="rowDivHeader wid1000 ">
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.startDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.endDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.dealer" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.modifier" />
		</div>
		<!-- <div class="cellDivHeader wid300">Set Price</div> -->
		<div class="cellDivHeader wid200">
			<a class="add-row"
				data-ng-click="addInputRow('contract.applDlrPymtExcptns.travelRateExceptions','forDuration.fromDate,forDuration.tillDate,dealer.name,modifierPercentage')"></a>
		</div>
	</div>
	<!-- Repeat Template Section -->
	<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" class="wid1000 " ng-repeat="item in contract.applDlrPymtExcptns.travelRateExceptions">
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.fromDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.tillDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<!-- <input class="wid160 marTB2 repeat" type="text" data-ng-model='item.dealer.name' /> -->
			<input class="wid160 marTB2 repeat" type="text" url="listServiceProviders" name="item.dealer" data-ng-model="item.dealer"
				fbs-typeahead />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.modifierPercentage' />
		</div>
		<div class="cellDiv wid200">
			<a class="class" ng-click="deleteThis($index,'contract.applDlrPymtExcptns.travelRateExceptions')"><i class="icon-trash"></i> </a>
		</div>
	</div>
</div>
<br>
<div class="labelStyle floatL marL30">
	<spring:message code="label.updateContract.exception.drayage" />
</div>
<br>
<div class="containerDiv wid800" ng-init="contract.applDlrPymtExcptns.drayageExceptions = contract.applDlrPymtExcptns.drayageExceptions == null ? [] : contract.applDlrPymtExcptns.drayageExceptions" ng-model="contract.applDlrPymtExcptns.drayageExceptions" repeater>
	<input type="hidden" name="contract.applDlrPymtExcptns.drayageExceptions" data-ng-model="contract.applDlrPymtExcptns.drayageExceptions">
	<div class="rowDivHeader wid1000 ">
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.startDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.endDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.dealer" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.modifier" />
		</div>
		<!-- <div class="cellDivHeader wid300">Set Price</div> -->
		<div class="cellDivHeader wid200">
			<a class="add-row"
				data-ng-click="addInputRow('contract.applDlrPymtExcptns.drayageExceptions','forDuration.fromDate,forDuration.tillDate,dealer.name,modifierPercentage')"></a>
		</div>
	</div>
	<!-- Repeat Template Section -->
	<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" class="wid1000 " ng-repeat="item in contract.applDlrPymtExcptns.drayageExceptions">
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.fromDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.tillDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<!-- <input class="wid160 marTB2 repeat" type="text" data-ng-model='item.dealer.name' /> -->
			<input class="wid160 marTB2 repeat" type="text" url="listServiceProviders" name="item.dealer" data-ng-model="item.dealer"
				fbs-typeahead />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.modifierPercentage' />
		</div>
		<div class="cellDiv wid200">
			<a class="class" ng-click="deleteThis($index,'contract.applDlrPymtExcptns.drayageExceptions')"><i class="icon-trash"></i> </a>
		</div>
	</div>
</div>
<br>
<div class="labelStyle floatL marL30">
	<spring:message code="label.updateContract.exception.miscellaneous" />
</div>
<br>
<div class="containerDiv wid800" ng-init="contract.applDlrPymtExcptns.miscellaneousExceptions = contract.applDlrPymtExcptns.miscellaneousExceptions == null ? [] : contract.applDlrPymtExcptns.miscellaneousExceptions" ng-model="contract.applDlrPymtExcptns.miscellaneousExceptions"
	repeater>
	<input type="hidden" name="contract.applDlrPymtExcptns.miscellaneousExceptions" data-ng-model="contract.applDlrPymtExcptns.miscellaneousExceptions">
	<div class="rowDivHeader wid1000 ">
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.startDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.endDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.dealer" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.modifier" />
		</div>
		<!-- <div class="cellDivHeader wid300">Set Price</div> -->
		<div class="cellDivHeader wid200">
			<a class="add-row"
				data-ng-click="addInputRow('contract.applDlrPymtExcptns.miscellaneousExceptions','forDuration.fromDate,forDuration.tillDate,dealer.name,modifierPercentage')"></a>
		</div>
	</div>
	<!-- Repeat Template Section -->
	<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" class="wid1000 " ng-repeat="item in contract.applDlrPymtExcptns.miscellaneousExceptions">
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.fromDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.tillDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<!-- <input class="wid160 marTB2 repeat" type="text" data-ng-model='item.dealer.name' /> -->
			<input class="wid160 marTB2 repeat" type="text" url="listServiceProviders" name="item.dealer" data-ng-model="item.dealer"
				fbs-typeahead />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.modifierPercentage' />
		</div>
		<div class="cellDiv wid200">
			<a class="class" ng-click="deleteThis($index,'contract.applDlrPymtExcptns.miscellaneousExceptions')"><i class="icon-trash"></i> </a>
		</div>
	</div>
</div>
