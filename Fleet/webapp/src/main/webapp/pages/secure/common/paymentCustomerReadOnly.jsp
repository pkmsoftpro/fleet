<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="details-sub-header">
	<span><spring:message code="label.quote.customerInvoiceDetails" /></span>
</div>
<table class="mar10">
	<tr>
		<td class="cellPaymentHeader wid250p"><spring:message code="label.payment.category" /></td>

		<td class="cellPaymentHeader wid150"><spring:message code="label.quote.partNumber" /></td>

		<td class="cellPaymentHeader wid150"><spring:message code="label.quote.quantity" /></td>

		<td class="cellPaymentHeader wid150"><spring:message code="label.payment.baseRate" /></td>

		<%-- <td class="cellPaymentHeader wid150"><spring:message code="label.quote.adjustedPrice" /></td> --%>
		
		<td class="cellPaymentHeader wid150"><spring:message code="label.payment.currentAmount" /></td>

		<%-- <td class="cellPaymentHeader wid150" data-ng-hide="isFlatRate"><spring:message code="label.payment.percentageApproved" /></td>

		<td class="cellPaymentHeader wid150" data-ng-show="isFlatRate"><spring:message code="label.payment.flatAmountApproved" /></td>	 --%>	
		
		<td class="cellPaymentHeader wid150"><spring:message code="label.payment.acceptedAmount" /></td>
	</tr>

	<tr data-ng-repeat="lineItemGroup in activeAudit.payment.lineItemGroups">

		<!-- OEM PARTS -->
		<td data-ng-if="lineItemGroup.name == 'OEM_PARTS'" colspan="6">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid250p left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell">
						<table class="tableSpacingBorder0">
							<tr data-ng-repeat="oemPART in activeAudit.serviceInformation.serviceDetail.oemPartsInstalled">
								<td class="cellPaymentCell wid150" title="{{oemPART.installedBrandItem.item.description}}"><span>{{oemPART.installedBrandItem.itemNumber}}</span></td>
								<td class="cellPaymentCell wid150" title="{{oemPART.numberOfUnits}}"><span>{{oemPART.numberOfUnits}}</span></td>
								<!-- <td class="cellPaymentCell wid150 textAlignRight" title="{{oemPART.pricePerUnit}}"><span>{{oemPART.pricePerUnit.currency}}
									{{oemPART.pricePerUnit.amount}}</span></td> -->
								<td class="wid150 textAlignRight" title="{{oemPART.basePricePerUnitCustomer}}"><span>{{oemPART.basePricePerUnitCustomer.currency}}
									{{oemPART.basePricePerUnitCustomer.amount}}</span></td>
							</tr>
                            <tr data-ng-show="activeAudit.serviceInformation.serviceDetail.oemPartsInstalled.length < 1">
                                <td colspan="3" class="wid458">--</td>
                            </tr>
						</table>
					</td>	
					<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>				
					<%-- <td class="cellPaymentCell wid150"><input class="wid55" type="text" data-ng-hide="isFlatRate" data-ng-model="lineItemGroup.percentageAcceptanceCustomer" data-ng-readonly="true" numbers-only /><input
						type="text" data-ng-show="isFlatRate" data-ng-model="lineItemGroup.acceptedFlatRateCust" ng-style="{width:'45px;text-align:right;'}" disable="true" money />
						<span data-ng-hide="isFlatRate"><spring:message code="label.equipmentdetails.percentage" /></span></td> --%>					
					<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.acceptedAmountCustomer.currency}} {{lineItemGroup.acceptedAmountCustomer.amount}}</span></td>
				</tr>
				
				
			</table>
		</td>

		<!-- NON OEM PARTS -->
		<td data-ng-if="lineItemGroup.name == 'NON_OEM_PARTS'" colspan="6">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid250p left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell">
						<table class="tableSpacingBorder0">
							<tr data-ng-repeat="nonOEMPART in activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled">
								<td class="cellPaymentCell wid150" title="{{nonOEMPART.description}}"><span>{{nonOEMPART.partNumber}}</span></td>
								<td class="cellPaymentCell wid150" title="{{nonOEMPART.numberOfUnits}}"><span>{{nonOEMPART.numberOfUnits}}</span></td>
								<!-- <td class="cellPaymentCell wid150 textAlignRight" title="{{nonOEMPART.pricePerUnit}}"><span>{{nonOEMPART.pricePerUnit.currency}}
									{{nonOEMPART.pricePerUnit.amount}}</span></td> -->
								<td class="wid150 textAlignRight" title="{{nonOEMPART.basePricePerUnitCustomer}}"><span>{{nonOEMPART.basePricePerUnitCustomer.currency}}
									{{nonOEMPART.basePricePerUnitCustomer.amount}}</span></td>
							</tr>
							<tr data-ng-show="activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled.length < 1">
							     <td colspan="3" class="wid458">--</td>
							</tr>
						</table>
				</td>
				<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
					<%-- <td class="cellPaymentCell wid150"><input class="wid55" type="text" data-ng-hide="isFlatRate"
						data-ng-model="lineItemGroup.percentageAcceptanceCustomer" numbers-only  data-ng-readonly="true" /><input type="text" data-ng-show="isFlatRate"
						data-ng-model="lineItemGroup.acceptedFlatRateCust" ng-style="{width:'45px;text-align:right;'}" disable="true" money />
						<span data-ng-hide="isFlatRate"><spring:message code="label.equipmentdetails.percentage" /></span></td>		 --%>			
				<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.acceptedAmountCustomer.currency}} {{lineItemGroup.acceptedAmountCustomer.amount}}</span></td>
				</tr>
			</table>
		</td>
		
			<!-- MISC LINE ITEMS-->
		<td data-ng-if="lineItemGroup.name == 'MISCELLANEOUS'" colspan="6">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid250p left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell">
						<table class="tableSpacingBorder0">
							<tr data-ng-repeat="miscItem in activeAudit.serviceInformation.serviceDetail.miscLineItems">
								<td class="cellPaymentCell wid150" title="{{miscItem.miscSubCostCodes.description}}"><span>{{miscItem.miscDescriptionForDisplay}}</span></td>
								<td class="cellPaymentCell wid150">--</td>
								<!-- <td class="cellPaymentCell wid150 textAlignRight" title="{{miscItem.miscPrice}}"><span>{{miscItem.miscPrice.currency}}
									{{miscItem.miscPrice.amount}}</span></td> -->
								<td class="wid150 textAlignRight" title="{{miscItem.baseMiscPriceCustomer}}"><span>{{miscItem.baseMiscPriceCustomer.currency}}
									{{miscItem.baseMiscPriceCustomer.amount}}</span></td>

							</tr>
							<tr data-ng-show="activeAudit.serviceInformation.serviceDetail.miscLineItems.length < 1">
							     <td colspan="3" class="wid458">--</td>
							</tr>
						</table>
				</td>
				<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
						<%-- <td class="cellPaymentCell wid150"><input class="wid55" type="text" data-ng-hide="isFlatRate" numbers-only  data-ng-model="lineItemGroup.percentageAcceptanceCustomer" data-ng-readonly="true"/><input
						type="text" data-ng-show="isFlatRate" data-ng-model="lineItemGroup.acceptedFlatRateCust" ng-style="{width:'45px;text-align:right;'}" disable="true" money />
						<span data-ng-hide="isFlatRate"><spring:message code="label.equipmentdetails.percentage" /></span></td>	 --%>			
				<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.acceptedAmountCustomer.currency}} {{lineItemGroup.acceptedAmountCustomer.amount}}</span></td>
				</tr>
			</table>
		</td>

		<!-- LABOR / TRAVEL AND TRANSPORTATION -->

		<td data-ng-if="lineItemGroup.name == 'LABOR' || lineItemGroup.name == 'TRAVEL' || lineItemGroup.name == 'DRAYAGE'" colspan="6">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid250p left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell">
						<table class="tableSpacingBorder0">
							<tr>
								<td class="cellPaymentCell wid150">--</td>
								<td class="cellPaymentCell wid150">--</td>
<!-- 								<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.rate.currency}} {{lineItemGroup.rate.amount}}</span></td> -->
								<td class="wid150 textAlignRight"
									title="{{lineItemGroup.modifierAmountForCustomer.currency}}.{{lineItemGroup.modifierAmountForCustomer.amount}}"><span>{{lineItemGroup.modifierAmountForCustomer.currency}}
									{{lineItemGroup.modifierAmountForCustomer.amount}}</span></td>
							</tr>
						</table>
					</td>
					
					<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
					<%-- <td class="cellPaymentCell wid150"><input class="wid55" type="text" data-ng-hide="isFlatRate"
						data-ng-model="lineItemGroup.percentageAcceptanceCustomer" data-ng-readonly="true" numbers-only /><input type="text" data-ng-show="isFlatRate"
						data-ng-model="lineItemGroup.acceptedFlatRateCust" ng-style="{width:'45px;text-align:right;'}" disable="true" money />
						<span data-ng-hide="isFlatRate"><spring:message code="label.equipmentdetails.percentage" /></span></td>	 --%>				
					<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.acceptedAmountCustomer.currency}} {{lineItemGroup.acceptedAmountCustomer.amount}}</span></td>

				</tr>
			</table>
		</td>
		
		<td data-ng-if="lineItemGroup.name == 'ADJUSTMENTS' || lineItemGroup.name == 'TAX'" colspan="6">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid250p left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell">
						<table class="tableSpacingBorder0">
							<tr>
								<td class="cellPaymentCell wid120">--</td>
								<td class="cellPaymentCell wid80">--</td>
								<td class="cellPaymentCell wid50 textAlignRight">--</td>
								<td class="cellPaymentCell wid100" >--</td>
								<td class="cellPaymentCell wid50 textAlignRight">--</td>
								<td class="wid50 textAlignRight">--</td>
							</tr>
						</table>
					</td>
					<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmountDealer.currency}} {{lineItemGroup.baseAmountDealer.amount}}</span></td>
				</tr>
			</table>
		</td>	

		<td data-ng-if="lineItemGroup.name == 'TOTAL_AMOUNT'" colspan="6">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid250p left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell">
						<table class="tableSpacingBorder0">
							<tr>
								<td class="cellPaymentCell wid150">--</td>
								<td class="cellPaymentCell wid150">--</td>
								<!-- <td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmount.currency}} {{lineItemGroup.baseAmount.amount}}</span></td> -->
								<td class="wid150 textAlignRight"
									title="{{lineItemGroup.modifierAmountForCustomer.currency}}.{{lineItemGroup.modifierAmountForCustomer.amount}}"><span>{{lineItemGroup.modifierAmountForCustomer.currency}}
									{{lineItemGroup.modifierAmountForCustomer.amount}}</span></td>
							</tr>
						</table>
					</td>
					<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
					<%-- <td class="cellPaymentCell wid150"><input class="wid55" type="text" data-ng-hide="isFlatRate"
						data-ng-model="lineItemGroup.percentageAcceptanceCustomer" data-ng-readonly="true" numbers-only  />
						<span data-ng-hide="isFlatRate"><spring:message code="label.equipmentdetails.percentage" /></span></td>	 --%>				
					<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.acceptedAmountCustomer.currency}} {{lineItemGroup.acceptedAmountCustomer.amount}}</span></td>

				</tr>
			</table>
		</td>


	</tr>
</table>