<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="details-sub-header">
	<span><spring:message code="label.quote.customerInvoiceDetails" /></span>
</div>
<%-- <div class="text-link" ng-click="toggleFlatRate()" data-ng-show="isFlatRate">
	<spring:message code="label.quote.percentage" />
</div>
<div class="text-link" ng-click="toggleFlatRate()" data-ng-hide="isFlatRate">
	<spring:message code="label.quote.flatAmount" />
</div> --%>
<table class="mar10">
	<tr>
		<td class="cellPaymentHeader wid205"><spring:message code="label.payment.category" /></td>

		<td class="cellPaymentHeader wid120"><spring:message code="label.quote.partNumber" /></td>

		<td class="cellPaymentHeader wid80"><spring:message code="label.quote.quantity" /></td>

		<td class="cellPaymentHeader wid100"><spring:message code="label.payment.baseRate" /></td>

		<td class="cellPaymentHeader wid100"><spring:message code="label.quote.conditionType" /></td>

		<td class="cellPaymentHeader wid100"><spring:message code="label.quote.conditionTypeValue" /></td>

		<td class="cellPaymentHeader wid100"><spring:message code="label.quote.adjustedPrice" /></td>
		
		<td class="cellPaymentHeader wid150"><spring:message code="label.payment.currentAmount" /></td>
		<!-- 
		<td class="cellPaymentHeader wid150" data-ng-hide="isFlatRate"><spring:message code="label.payment.percentageApproved" /></td>

		<td class="cellPaymentHeader wid150" data-ng-show="isFlatRate"><spring:message code="label.payment.flatAmountApproved" /></td>	
		 -->	
		
	<%-- 	<td class="cellPaymentHeader wid100"><spring:message code="label.payment.acceptedAmount" /></td> --%>
	</tr>

	<tr data-ng-repeat="lineItemGroup in activeAudit.payment.lineItemGroups">

		<!-- OEM PARTS -->
		<td data-ng-if="lineItemGroup.name == 'OEM_PARTS'" colspan="10">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid205 left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell wid600">
						<table class="tableSpacingBorder0">
							<tr data-ng-repeat="oemPART in activeAudit.serviceInformation.serviceDetail.oemPartsInstalled">
								<td class="cellPaymentCell wid120" title="{{oemPART.installedBrandItem.item.description}}"><span>{{oemPART.installedBrandItem.itemNumber}}</span></td>
								<td class="cellPaymentCell wid80" title="{{oemPART.numberOfUnits}}"><span>{{oemPART.numberOfUnits}}</span></td>
								<td class="cellPaymentCell wid100 textAlignRight" title="{{oemPART.basePricePerUnitDealer}}"><span>{{oemPART.basePricePerUnitDealer.currency}}
									{{oemPART.basePricePerUnitDealer.amount}}</span></td>

								<td class="cellPaymentCell wid100" title="{{oemPART.conditionTypeCustomer}}"><span>{{oemPART.conditionTypeCustomer}}</span></td>
								<td class="cellPaymentCell wid100 textAlignRight" title="{{oemPART.conditionTypeValueCustomer}}"><span>{{oemPART.conditionTypeValueCustomer}}</span></td>

								<td class="wid100 textAlignRight" title="{{oemPART.basePricePerUnitCustomer}}"><span>{{oemPART.basePricePerUnitCustomer.currency}}
									{{oemPART.basePricePerUnitCustomer.amount}}</span></td>

							</tr>
						</table>
					</td>	
					<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>				
					<%-- <td class="cellPaymentCell wid150"><input class="wid55" type="text" data-ng-hide="isFlatRate" data-ng-model="lineItemGroup.percentageAcceptanceCustomer" data-ng-readonly="isReadOnly() || !isCustPaymentAdjustmentEnabled" numbers-only /><input
						type="text" data-ng-show="isFlatRate" data-ng-model="lineItemGroup.acceptedFlatRateCust" ng-style="{width:'45px;text-align:right;'}" disable="isReadOnly() || !isCustPaymentAdjustmentEnabled" money />
						<span data-ng-hide="isFlatRate"><spring:message code="label.equipmentdetails.percentage" /></span></td>			
					<td class="cellPaymentCell wid100 textAlignRight"><span>{{lineItemGroup.acceptedAmountCustomer.currency}} {{lineItemGroup.acceptedAmountCustomer.amount}}</span></td> --%>		
				</tr>
				
				<tr data-ng-show="activeAudit.serviceInformation.serviceDetail.oemPartsInstalled.length < 1">
							<td colspan="6" class="wid600">--</td>
							</tr>
			</table>
		</td>

		<!-- NON OEM PARTS -->
		<td data-ng-if="lineItemGroup.name == 'NON_OEM_PARTS'" colspan="10">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid205 left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell wid600">
						<table class="tableSpacingBorder0">
							<tr data-ng-repeat="nonOEMPART in activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled">
								<td class="cellPaymentCell wid120" title="{{nonOEMPART.description}}"><span>{{nonOEMPART.partNumber}}</span></td>
								<td class="cellPaymentCell wid80" title="{{nonOEMPART.numberOfUnits}}"><span>{{nonOEMPART.numberOfUnits}}</span></td>
								<td class="cellPaymentCell wid100 textAlignRight" title="{{nonOEMPART.basePricePerUnitDealer}}"><span>{{nonOEMPART.basePricePerUnitDealer.currency}}
									{{nonOEMPART.basePricePerUnitDealer.amount}}</span></td>


								<td class="cellPaymentCell wid100" title="{{nonOEMPART.conditionTypeCustomer}}"><span>{{nonOEMPART.conditionTypeCustomer}}</span></td>
								<td class="cellPaymentCell wid100 textAlignRight" title="{{nonOEMPART.conditionTypeValueCustomer}}"><span>{{nonOEMPART.conditionTypeValueCustomer}}</span></td>
								<td class="wid100 textAlignRight" title="{{nonOEMPART.basePricePerUnitCustomer}}"><span>{{nonOEMPART.basePricePerUnitCustomer.currency}}
									{{nonOEMPART.basePricePerUnitCustomer.amount}}</span></td>
							</tr>
							<tr data-ng-show="activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled.length < 1">
							<td colspan="6" class="wid600">--</td>
							</tr>
						</table>
				</td>
				<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
					<%-- <td class="cellPaymentCell wid150"><input class="wid55" type="text" data-ng-hide="isFlatRate"
						data-ng-model="lineItemGroup.percentageAcceptanceCustomer" numbers-only  data-ng-readonly="isReadOnly() || !isCustPaymentAdjustmentEnabled" /><input type="text" data-ng-show="isFlatRate"
						data-ng-model="lineItemGroup.acceptedFlatRateCust" ng-style="{width:'45px;text-align:right;'}" disable="isReadOnly() || !isCustPaymentAdjustmentEnabled" money />
						<span data-ng-hide="isFlatRate"><spring:message code="label.equipmentdetails.percentage" /></span></td>	 			
				<td class="cellPaymentCell wid100 textAlignRight"><span>{{lineItemGroup.acceptedAmountCustomer.currency}} {{lineItemGroup.acceptedAmountCustomer.amount}}</span></td>--%>	
				</tr>
			</table>
		</td>
		
			<!-- MISC LINE ITEMS-->
		<td data-ng-if="lineItemGroup.name == 'MISCELLANEOUS'" colspan="10">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid205 left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell wid600">
						<table class="tableSpacingBorder0">
							<tr data-ng-repeat="miscItem in activeAudit.serviceInformation.serviceDetail.miscLineItems">
								<td class="cellPaymentCell wid120" title="{{miscItem.miscSubCostCodes.description}}"><span>{{miscItem.miscDescriptionForDisplay}}</span></td>
								<td class="cellPaymentCell wid80">--</td>
								<td class="cellPaymentCell wid100 textAlignRight" title="{{miscItem.baseMiscPriceDealer}}"><span>{{miscItem.baseMiscPriceDealer.currency}}
									{{miscItem.baseMiscPriceDealer.amount}}</span></td>


								<td class="cellPaymentCell wid100" title="{{miscItem.conditionTypeCustomer}}"><span>{{miscItem.conditionTypeCustomer}}</span></td>
								<td class="cellPaymentCell wid100 textAlignRight" title="{{miscItem.conditionTypeValueCustomer}}"><span>{{miscItem.conditionTypeValueCustomer}}</span></td>
								<td class="wid100 textAlignRight" title="{{miscItem.baseMiscPriceCustomer}}"><span>{{miscItem.baseMiscPriceCustomer.currency}}
									{{miscItem.baseMiscPriceCustomer.amount}}</span></td>

							</tr>
							<tr data-ng-show="activeAudit.serviceInformation.serviceDetail.miscLineItems.length < 1">
							<td colspan="6" class="wid600">--</td>
							</tr>
						</table>
				</td>
				<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
						<%-- <td class="cellPaymentCell wid150"><input class="wid55" type="text" data-ng-hide="isFlatRate" numbers-only  data-ng-model="lineItemGroup.percentageAcceptanceCustomer" data-ng-readonly="isReadOnly() || !isCustPaymentAdjustmentEnabled"/><input
						type="text" data-ng-show="isFlatRate" data-ng-model="lineItemGroup.acceptedFlatRateCust" ng-style="{width:'45px;text-align:right;'}" disable="isReadOnly() || !isCustPaymentAdjustmentEnabled" money />
						<span data-ng-hide="isFlatRate"><spring:message code="label.equipmentdetails.percentage" /></span></td>	 		
				<td class="cellPaymentCell wid100 textAlignRight"><span>{{lineItemGroup.acceptedAmountCustomer.currency}} {{lineItemGroup.acceptedAmountCustomer.amount}}</span></td>--%>	
				</tr>
			</table>
		</td>

		<!-- LABOR / TRAVEL AND TRANSPORTATION -->

		<td data-ng-if="lineItemGroup.name == 'LABOR' || lineItemGroup.name == 'TRAVEL' || lineItemGroup.name == 'DRAYAGE'" colspan="10">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid205 left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell wid600">
						<table class="tableSpacingBorder0">
							<tr>
								<td class="cellPaymentCell wid120">--</td>
								<td class="cellPaymentCell wid80">--</td>
								<td class="cellPaymentCell wid100 textAlignRight"><span>{{lineItemGroup.modifierAmountForDealer.currency}} {{lineItemGroup.modifierAmountForDealer.amount}}</span></td>
								<td class="cellPaymentCell wid100" title="{{lineItemGroup.conditionTypeCustomer.code}}"><span>{{lineItemGroup.conditionTypeCustomer.code}}</span></td>
								<td class="cellPaymentCell wid100 textAlignRight" title="{{lineItemGroup.conditionTypeValueCustomer}}"><span>{{lineItemGroup.conditionTypeValueCustomer}}</span></td>
								<td class="wid100 textAlignRight"
									title="{{lineItemGroup.modifierAmountForCustomer.currency}}.{{lineItemGroup.modifierAmountForCustomer.amount}}"><span>{{lineItemGroup.modifierAmountForCustomer.currency}}
									{{lineItemGroup.modifierAmountForCustomer.amount}}</span></td>
							</tr>
						</table>
					</td>
					
					<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
					<%-- <td class="cellPaymentCell wid150"><input class="wid55" type="text" data-ng-hide="isFlatRate"
						data-ng-model="lineItemGroup.percentageAcceptanceCustomer" data-ng-readonly="isReadOnly() || !isCustPaymentAdjustmentEnabled" numbers-only /><input type="text" data-ng-show="isFlatRate"
						data-ng-model="lineItemGroup.acceptedFlatRateCust" ng-style="{width:'45px;text-align:right;'}" disable="isReadOnly() || !isCustPaymentAdjustmentEnabled" money />
						<span data-ng-hide="isFlatRate"><spring:message code="label.equipmentdetails.percentage" /></span></td>	 			
					<td class="cellPaymentCell wid100 textAlignRight"><span>{{lineItemGroup.acceptedAmountCustomer.currency}} {{lineItemGroup.acceptedAmountCustomer.amount}}</span></td>--%>	

				</tr>
			</table>
		</td>

		<td data-ng-if="lineItemGroup.name == 'ADJUSTMENTS' || lineItemGroup.name == 'TAX'" colspan="10">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid205 left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell wid600">
						<table class="tableSpacingBorder0">
							<tr>
								<td class="cellPaymentCell wid120">--</td>
								<td class="cellPaymentCell wid80">--</td>
								<td class="cellPaymentCell wid100 textAlignRight">--</td>
								<td class="cellPaymentCell wid100" >--</td>
								<td class="cellPaymentCell wid100 textAlignRight" >--</td>
								<td class="wid100 textAlignRight" >--</td>
							</tr>
						</table>
					</td>
					<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
				</tr>
			</table>
		</td>
		
		<td data-ng-if="lineItemGroup.name == 'TOTAL_AMOUNT'" colspan="10">
			<table class="tableSpacingBorder0 cellPaymentTable">
				<tr>
					<td class="cellPaymentCell wid205 left"><span>{{lineItemGroup.displayName}}</span></td>
					<td class="cellPaymentCell wid600">
						<table class="tableSpacingBorder0">
							<tr>
								<td class="cellPaymentCell wid120">--</td>
								<td class="cellPaymentCell wid80">--</td>
								<td class="cellPaymentCell wid100 textAlignRight"><span>{{lineItemGroup.modifierAmountForDealer.currency}} {{lineItemGroup.modifierAmountForDealer.amount}}</span></td>
								<td class="cellPaymentCell wid100" title="{{lineItemGroup.conditionTypeCustomer.code}}"><span>{{lineItemGroup.conditionTypeCustomer.code}}</span></td>
								<td class="cellPaymentCell wid100 textAlignRight" title="{{lineItemGroup.conditionTypeValueCustomer}}"><span>{{lineItemGroup.conditionTypeValueCustomer}}</span></td>
								<td class="wid100 textAlignRight"
									title="{{lineItemGroup.modifierAmountForCustomer.currency}}.{{lineItemGroup.baseAmountDealer.amount}}"><span>{{lineItemGroup.baseAmountDealer.currency}}
									{{lineItemGroup.baseAmountDealer.amount}}</span></td>
							</tr>
						</table>
					</td>
					<td class="cellPaymentCell wid150 textAlignRight"><span>{{lineItemGroup.baseAmountCustomer.currency}} {{lineItemGroup.baseAmountCustomer.amount}}</span></td>
					<%-- <td class="cellPaymentCell wid150"><input class="wid55" type="text" data-ng-hide="isFlatRate"
						data-ng-model="lineItemGroup.percentageAcceptanceCustomer" data-ng-readonly="isReadOnly() || !isCustPaymentAdjustmentEnabled" numbers-only  />
						<span data-ng-hide="isFlatRate"><spring:message code="label.equipmentdetails.percentage" /></span></td>	 			
					<td class="cellPaymentCell wid100 textAlignRight"><span>{{lineItemGroup.acceptedAmountCustomer.currency}} {{lineItemGroup.acceptedAmountCustomer.amount}}</span></td>--%>	

				</tr>
			</table>
		</td>


	</tr>
</table>