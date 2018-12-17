
<div data-ng-repeat="costCategory in applicableCostCategoriesList">
	<div data-ng-if="costCategory.categoryGroup=='MAJOR COST CATEGORY'">
		<!-- <div data-ng-if="costCategory.code=='DRAYAGE'">
			<div class="labelStyle floatL">
				<spring:message code="label.quote.transportation" />
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.transportation" data-disable="true" ng-style="{width:'184px'}" money />
			</div>
			<div class="fieldSpacerWidth floatL">&nbsp;</div>
		</div>
		<div class="clear"></div>  -->
		<div data-ng-if="costCategory.code=='MISCELLANEOUS' && activeAudit.serviceInformation.serviceDetail.miscLineItems.length>0">
        
<div class="details-sub-header">
    <span><spring:message code="label.common.miscellaneous" /> </span>
</div>
			<div ng-repeat="miscLineItem in activeAudit.serviceInformation.serviceDetail.miscLineItems">
				<div class="labelStyle floatL">{{miscLineItem.miscDescriptionForDisplay}}</div>
				<div class="floatL">
					<input type="text" data-ng-model="miscLineItem.miscPrice" data-disable="true" ng-style="{width:'184px'}" money />
				</div>
				<div class="fieldSpacerWidth floatL">&nbsp;</div>
			</div>
		</div>
	</div>
</div>
<!-- <div class="clear"></div> -->
<div class="details-sub-header">
	<span><spring:message code="label.quote.taxes" /> </span>
</div>
<div data-ng-repeat="costCategory in applicableCostCategoriesList">
	<div data-ng-if="costCategory.categoryGroup=='TAXES' || costCategory.categoryGroup=='CANADIAN TAXES'">
		<div data-ng-if="costCategory.code=='US_TAXES'">
			<div class="labelStyle floatL">
				<spring:message code="label.quote.USTaxes" />
			</div>
				<div class="floatL">
				<input type="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.usTaxes" data-disable="true" ng-style="{width:'184px'}" money />
			</div>
			<div class="fieldSpacerWidth floatL">&nbsp;</div>
		</div>

		<div data-ng-if="costCategory.code=='HST'">
			<div class="labelStyle floatL">
				<spring:message code="label.quote.HST" />
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.hst" data-disable="true" ng-style="{width:'184px'}" money />
			</div>
			<div class="fieldSpacerWidth floatL">&nbsp;</div>
		</div>
		<div data-ng-if="costCategory.code=='PST'">
			<div class="labelStyle floatL">
				<spring:message code="label.quote.PST" />
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.pst" data-disable="true" ng-style="{width:'184px'}" money />
			</div>
			<div class="fieldSpacerWidth floatL">&nbsp;</div>
		</div>
		<div data-ng-if="costCategory.code=='GST'">
			<div class="labelStyle floatL">
				<spring:message code="label.quote.GST" />
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.gst" data-disable="true" ng-style="{width:'184px'}" money />
			</div>
			<div class="fieldSpacerWidth floatL">&nbsp;</div>
		</div>
		<div data-ng-if="costCategory.code=='QST'">
			<div class="labelStyle floatL">
				<spring:message code="label.quote.QST" />
			</div>
			<div class="floatL">
				<input type="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.qst" data-disable="true" ng-style="{width:'184px'}" money />
			</div>
			<div class="fieldSpacerWidth floatL">&nbsp;</div>
		</div>
	</div>
</div>