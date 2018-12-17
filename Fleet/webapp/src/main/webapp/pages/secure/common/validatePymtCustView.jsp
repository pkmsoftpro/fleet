<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

		<div class="details-sub-header">
			<span><spring:message code="label.quote.customerInvoiceDetails" /></span>
		</div>
	
<!-- Customer Invoice -->
<table class="mar10">
	<tr>
		<td class="cellPaymentHeader wid200"><spring:message code="label.payment.category" /></td>

		<td class="cellPaymentHeader wid200"><spring:message code="label.quote.partNumber" /></td>

		<td class="cellPaymentHeader wid200"><spring:message code="label.quote.quantity" /></td>

		<td class="cellPaymentHeader wid200"><spring:message code="label.payment.baseRate" /></td>

		<td class="cellPaymentHeader wid200"><spring:message code="label.payment.customerInvoice" /></td>        
	</tr>

	<tr data-ng-repeat="lineItemGroup in activeAudit.payment.lineItemGroups">

		<!-- OEM PARTS -->
		<td data-ng-if="lineItemGroup.name == 'OEM_PARTS'" colspan="6">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid200 left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell wid613">
						<table>
							<tr data-ng-repeat="oemPART in activeAudit.serviceInformation.serviceDetail.oemPartsInstalled">
								<td class="cellPaymentCell wid200" title="{{oemPART.installedBrandItem.item.description}}"><span>{{oemPART.installedBrandItem.itemNumber}}</span></td>
								<td class="cellPaymentCell wid200" title="{{oemPART.numberOfUnits}}"><span>{{oemPART.numberOfUnits}}</span></td>
								<td class="cellPaymentCell wid200 textAlignRight" title="{{oemPART.basePricePerUnitCustomer}}"><span>{{oemPART.basePricePerUnitCustomer.currency}}
									{{oemPART.basePricePerUnitCustomer.amount}}</span></td>
							</tr>
							<tr data-ng-show="activeAudit.serviceInformation.serviceDetail.oemPartsInstalled.length < 1">
							     <td colspan="3" class="wid458">--</td>
							</tr>
						</table>
					</td>
					<td class="cellPaymentCell wid200 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
				</tr>
			</table>
		</td>

		<!-- NON OEM PARTS -->
		<td data-ng-if="lineItemGroup.name == 'NON_OEM_PARTS'" colspan="6">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid200 left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell wid613">
						<table class="tableSpacingBorder0">
							<tr data-ng-repeat="nonOEMPART in activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled">
								<td class="cellPaymentCell wid200" title="{{nonOEMPART.description}}"><span>{{nonOEMPART.partNumber}}</span></td>
								<td class="cellPaymentCell wid200" title="{{nonOEMPART.numberOfUnits}}"><span>{{nonOEMPART.numberOfUnits}}</span></td>
								<td class="cellPaymentCell wid200 textAlignRight" title="{{nonOEMPART.basePricePerUnitCustomer}}"><span>{{nonOEMPART.basePricePerUnitCustomer.currency}}
									{{nonOEMPART.basePricePerUnitCustomer.amount}}</span></td>
							</tr>							
							<tr data-ng-show="activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled.length < 1">
							<td colspan="3" class="wid458">--</td>
							</tr>
						</table>
					</td>
					<td class="cellPaymentCell wid200 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
				</tr>
			</table>
		</td>

		<!-- MISC LINE ITEMS-->
		<td data-ng-if="lineItemGroup.name == 'MISCELLANEOUS'" colspan="6">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid200 left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell wid613">
						<table class="tableSpacingBorder0">
							<tr data-ng-repeat="miscItem in activeAudit.serviceInformation.serviceDetail.miscLineItems">
								<td class="cellPaymentCell wid200" title="{{miscItem.miscSubCostCodes.description}}"><span>{{miscItem.miscDescriptionForDisplay}}</span></td>
								<td class="cellPaymentCell wid200">--</td>
								<td class="cellPaymentCell wid200 textAlignRight" title="{{miscItem.baseMiscPriceCustomer}}"><span>{{miscItem.baseMiscPriceCustomer.currency}}
									{{miscItem.baseMiscPriceCustomer.amount}}</span></td>
							</tr>
							<tr data-ng-show="activeAudit.serviceInformation.serviceDetail.miscLineItems.length < 1">
								<td colspan="3" class="textAlignRight">--</td>
							</tr>
						</table>
					</td>
					<td class="cellPaymentCell wid200 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
				</tr>
			</table>
		</td>

		<!-- LABOR / TRAVEL AND TRANSPORTATION -->

		<td data-ng-if="lineItemGroup.name == 'LABOR' || lineItemGroup.name == 'TRAVEL' || lineItemGroup.name == 'DRAYAGE'" colspan="6">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid200 left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell wid613">
						<table class="tableSpacingBorder0">
							<tr>
								<td class="cellPaymentCell wid200">--</td>
								<td class="cellPaymentCell wid200">--</td>
								<td class="cellPaymentCell wid200 textAlignRight"><span>{{lineItemGroup.modifierAmountForCustomer.currency}} {{lineItemGroup.modifierAmountForCustomer.amount}}</span></td>
							</tr>
						</table>
					</td>
					<td class="cellPaymentCell wid200 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
				</tr>
			</table>
		</td>

		<td data-ng-if="lineItemGroup.name == 'TOTAL_AMOUNT'" colspan="6">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid200 left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell wid613">
						<table class="tableSpacingBorder0">
							<tr>
								<td class="cellPaymentCell wid200">--</td>
								<td class="cellPaymentCell wid200">--</td>
								<!-- <td class="cellPaymentCell wid200 textAlignRight"><span>{{lineItemGroup.baseAmount.currency}} {{lineItemGroup.baseAmount.amount}}</span></td> -->
                                <td class="cellPaymentCell wid200 textAlignRight"><span>--</span></td>
							</tr>
						</table>
					</td>
					<td class="cellPaymentCell wid200 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
				</tr>
			</table>
		</td>
	</tr>
</table>