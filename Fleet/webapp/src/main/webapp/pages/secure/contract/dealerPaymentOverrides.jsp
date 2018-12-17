<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="labelStyle">
	<spring:message code="label.updateContract.overrides.dealerPayment" />
</div>
<div class="labelStyle floatL marL30">
	<spring:message code="label.updateContract.exception.laborPayment" />
</div>
<br>
<div class="containerDiv wid800" ng-init="contract.applDlrPymtOverrides.laborPaymentExceptions = contract.applDlrPymtOverrides.laborPaymentExceptions == null ? [] : contract.applDlrPymtOverrides.laborPaymentExceptions" ng-model="contract.applDlrPymtOverrides.laborPaymentExceptions"
	repeater>
	<input type="hidden" name="contract.applDlrPymtOverrides.laborPaymentExceptions" data-ng-model="contract.applDlrPymtOverrides.laborPaymentExceptions">
	<div class="rowDivHeader wid1200 ">
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.startDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.endDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.description" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.dealer" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.laborHours" />
		</div>
		<div class="cellDivHeader wid200">
			<a class="buttonlink"
				data-ng-click="addInputRow('contract.applDlrPymtOverrides.laborPaymentExceptions','forDuration.fromDate,forDuration.tillDate,description,dealer.name,laborHours')">Add
				Row</a>
		</div>
	</div>
	<!-- Repeat Template Section -->
	<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" class="wid1200 " ng-repeat="item in contract.applDlrPymtOverrides.laborPaymentExceptions">
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.fromDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.tillDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.description' />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" url="listServiceProviders" name="item.dealer" data-ng-model="item.dealer"
				fbs-typeahead />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.laborHours' />
		</div>

		<div class="cellDiv wid200">
			<a class="class" ng-click="deleteThis($index,'contract.applDlrPymtOverrides.laborPaymentExceptions')"><i class="icon-trash"></i> </a>
		</div>
	</div>
</div>
<br>
<div class="labelStyle floatL marL30 wid350">
	<spring:message code="label.updateContract.exception.servicePayment" />
</div>
<br>
<div class="containerDiv wid800" ng-init="contract.applDlrPymtOverrides.serviceCodeExceptions = contract.applDlrPymtOverrides.serviceCodeExceptions == null ? [] : contract.applDlrPymtOverrides.serviceCodeExceptions" ng-model="contract.applDlrPymtOverrides.serviceCodeExceptions"
	repeater>
	<input type="hidden" name="contract.applDlrPymtOverrides.serviceCodeExceptions" data-ng-model="contract.applDlrPymtOverrides.serviceCodeExceptions">
	<div class="rowDivHeader wid1200 ">
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.startDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.endDate" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.description" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.dealer" />
		</div>
		<div class="cellDivHeader wid200">
			<spring:message code="label.updateContract.exception.duration" />
		</div>
		<div class="cellDivHeader wid200">
			<a class="buttonlink"
				data-ng-click="addInputRow('contract.applDlrPymtOverrides.serviceCodeExceptions','forDuration.fromDate,forDuration.tillDate,description,dealer.name,duration')">Add
				Row</a>
		</div>
	</div>
	<!-- Repeat Template Section -->
	<div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" class="wid1200 " ng-repeat="item in contract.applDlrPymtOverrides.serviceCodeExceptions">
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.fromDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.forDuration.tillDate' datepicker-popup={{dateFormat}} />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.description' />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" url="listServiceProviders" name="item.dealer" data-ng-model="item.dealer"
				fbs-typeahead />
		</div>
		<div class="cellDiv wid200">
			<input class="wid160 marTB2 repeat" type="text" data-ng-model='item.duration' />
		</div>

		<div class="cellDiv wid200">
			<a class="class" ng-click="deleteThis($index,'contract.applDlrPymtOverrides.serviceCodeExceptions')"><i class="icon-trash"></i> </a>
		</div>
	</div>
</div>
<br>