<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<div data-ng-if="activeAudit.payment.creditMemos.length > 0">
	<div class="clear"></div>
	<div class="accordion-header contentPane">
		<span><spring:message code="title.fleetClaim.creditMemo"/></span>
		<span class="expand-collapse collapse-icon"></span>
	</div>

	<div class="overflow-hidden accordion-info">
		<div data-ng-if="isInternalUserOrOwningDealer==true || isCustomerUser!=true">
			<div data-ng-if="activeAudit.payment.creditMemos.length > 1">
				<div class="details-sub-header">
					<span> Credit Memo History </span>
				</div>
				<table style="width: 90%;padding-left: 20px;">
					<thead>
						<tr>
							<td class="cellPaymentHeader wid150">Credit Memo Number</td>
							<td class="cellPaymentHeader wid150">Credit Memo Date</td>
							<td class="cellPaymentHeader wid100">Tax</td>
							<td class="cellPaymentHeader wid100"> Approved Amount</td>
							<td class="cellPaymentHeader wid100">C/D</td>
						</tr>
					</thead>
					<tbody data-ng-repeat="creditMemo in activeAudit.payment.creditMemos">
						<tr data-ng-if="creditMemo.responseType=='DEALER_RESPONSE_INFO'">
							<td class="cellPaymentCell wid150">{{creditMemo.creditMemoNumber}}</td>
							<td class="cellPaymentCell wid150">{{creditMemo.creditMemoDate}}</td>
							<td class="cellPaymentCell wid150 textAlignRight">{{creditMemo.dealerTaxAmount.currency}} {{creditMemo.dealerTaxAmount.amount}}</td>
							<td class="cellPaymentCell wid150 textAlignRight">{{creditMemo.dealerTotalAmount.currency}} {{creditMemo.dealerTotalAmount.amount}}</td>
							<td class="cellPaymentCell wid150"> CREDIT </td>
						</tr>
						<tr data-ng-if="creditMemo.responseType=='SUPPLEMENTAL_RESPONSE_INFO'  && creditMemo.suppBillingParty=='DEALER'">
							<td class="cellPaymentCell wid150">{{creditMemo.suppBillingDoc}}</td>
							<td class="cellPaymentCell wid150">{{creditMemo.suppBillingDocDate}}</td>
							<td class="cellPaymentCell wid150 textAlignRight">{{creditMemo.suppTaxAmount.currency}} {{creditMemo.suppTaxAmount.amount}}</td>
							<td class="cellPaymentCell wid150 textAlignRight">{{creditMemo.suppTotalAmount.currency}} {{creditMemo.suppTotalAmount.amount}}</td>
							<td class="cellPaymentCell wid150"> {{creditMemo.suppBillingType}} </td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div data-ng-if="isInternalUserOrOwningDealer==true || isCustomerUser == true">
			<div class="details-sub-header">
				<span> Invoice History </span>
			</div>
			<table style="width: 90%;padding-left: 20px;">
				<thead>
					<tr>
						<td class="cellPaymentHeader wid150"> Invoice Number </td>
						<td class="cellPaymentHeader wid150"> Invoice Date </td>
						<td class="cellPaymentHeader wid100"> Tax </td>
						<td class="cellPaymentHeader wid100"> Approved Amount </td>
						<td class="cellPaymentHeader wid100"> C/D </td>
					</tr>
				</thead>
				<tbody data-ng-repeat="creditMemo in activeAudit.payment.creditMemos">
					<tr data-ng-if="creditMemo.responseType=='INITIAL_RESPONSE_INFO' && isInternalUserOrOwningDealer==true">
						<td class="cellPaymentCell wid150"> {{creditMemo.debitMemoNumber}} </td>
						<td class="cellPaymentCell wid150"> {{creditMemo.debitMemoDate}} </td>
						<td class="cellPaymentCell wid150"> </td>
						<td class="cellPaymentCell wid150"> </td>
						<td class="cellPaymentCell wid150"> </td>
					</tr>
					<tr data-ng-if="creditMemo.responseType=='INVOICING_RESPONSE_INFO'">
						<td class="cellPaymentCell wid150">{{creditMemo.customerInvoiceNumber}}</td>
						<td class="cellPaymentCell wid150">{{creditMemo.customerInvoiceDate}}</td>
						<td class="cellPaymentCell wid150 textAlignRight">{{creditMemo.customerInvoiceTaxAmount.currency}} {{creditMemo.customerInvoiceTaxAmount.amount}}</td>
						<td class="cellPaymentCell wid150 textAlignRight">{{creditMemo.customerInvoiceTotalAmount.currency}} {{creditMemo.customerInvoiceTotalAmount.amount}}</td>
						<td class="cellPaymentCell wid150"> DEBIT </td>
					</tr>
					<tr data-ng-if="creditMemo.responseType=='SUPPLEMENTAL_RESPONSE_INFO' && creditMemo.suppBillingParty=='CUSTOMER'">
						<td class="cellPaymentCell wid150">{{creditMemo.suppBillingDoc}}</td>
						<td class="cellPaymentCell wid150">{{creditMemo.suppBillingDocDate}}</td>
						<td class="cellPaymentCell wid150 textAlignRight">{{creditMemo.suppTaxAmount.currency}} {{creditMemo.suppTaxAmount.amount}}</td>
						<td class="cellPaymentCell wid150 textAlignRight">{{creditMemo.suppTotalAmount.currency}} {{creditMemo.suppTotalAmount.amount}}</td>
						<td class="cellPaymentCell wid150 "> {{creditMemo.suppBillingType}} </td>
					</tr>
				</tbody>
			</table>
		</div>
	
	</div>
</div>

