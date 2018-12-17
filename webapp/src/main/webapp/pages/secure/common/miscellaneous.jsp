<div data-ng-repeat="costCategory in applicableCostCategoriesList">
	<div data-ng-if="costCategory.categoryGroup=='MAJOR COST CATEGORY'">		
         <div data-ng-if="costCategory.code=='MISCELLANEOUS' && activeAudit.serviceInformation.serviceDetail.miscLineItems.length>0">
           <div class="details-sub-header">
              <span><spring:message code="label.common.miscellaneous" /> </span>
            </div>
            <div ng-repeat="miscLineItem in activeAudit.serviceInformation.serviceDetail.miscLineItems">
                <div class="labelStyle floatL">{{miscLineItem.miscDescriptionForDisplay}}</div>
                <input type='hidden' data-ng-bind="miscLineItem.miscPrice.currency=miscLineItem.miscPrice.currency==null?preferredCurrency:miscLineItem.miscPrice.currency" />
                <div class="floatL">
                    <input type="text" data-ng-model="miscLineItem.miscPrice" data-disable="isReadOnly()" ng-style="{width:'184px'}" money />
                </div>
                <div class="fieldSpacerWidth floatL">&nbsp;</div>
            </div>
        </div>       
	</div>
</div>
 <div data-ng-show="isTaxSectionVisible" class="details-sub-header">
    		<span><spring:message code="label.quote.taxes" /> </span>
</div>
<div data-ng-repeat="costCategory in applicableCostCategoriesList">
	<div data-ng-if="costCategory.categoryGroup=='TAXES' || costCategory.categoryGroup=='CANADIAN TAXES'">
		
		<div data-ng-if="costCategory.code=='US_TAXES'">
       		<div class="labelStyle floatL">
				<spring:message code="label.quote.USTaxes" />
			</div>
			<input type='hidden'
				data-ng-bind="activeAudit.serviceInformation.serviceDetail.usTaxes.currency = activeAudit.serviceInformation.serviceDetail.usTaxes.currency==null ? preferredCurrency : activeAudit.serviceInformation.serviceDetail.usTaxes.currency" />
			<div class="floatL">
				<input type="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.usTaxes" data-disable="isReadOnly()" ng-style="{width:'184px'}" money />
			</div>
			<div class="fieldSpacerWidth floatL">&nbsp;</div>
		</div>

		<div data-ng-if="costCategory.code=='HST'">
			<div class="labelStyle floatL">
				<spring:message code="label.quote.HST" />
			</div>
			<input type='hidden'
				data-ng-bind="activeAudit.serviceInformation.serviceDetail.hst.currency = activeAudit.serviceInformation.serviceDetail.hst.currency==null ? preferredCurrency : activeAudit.serviceInformation.serviceDetail.hst.currency" />
			<div class="floatL">
				<input type="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.hst" data-disable="isReadOnly()" ng-style="{width:'184px'}" money />
			</div>
			<div class="fieldSpacerWidth floatL">&nbsp;</div>
		</div>
		<div data-ng-if="costCategory.code=='PST'">
			<div class="labelStyle floatL">
				<spring:message code="label.quote.PST" />
			</div>
			<input type='hidden'
				data-ng-bind="activeAudit.serviceInformation.serviceDetail.pst.currency = activeAudit.serviceInformation.serviceDetail.pst.currency==null ? preferredCurrency : activeAudit.serviceInformation.serviceDetail.pst.currency" />
			<div class="floatL">
				<input type="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.pst" data-disable="isReadOnly()" ng-style="{width:'184px'}" money />
			</div>
			<div class="fieldSpacerWidth floatL">&nbsp;</div>
		</div>
		<div data-ng-if="costCategory.code=='GST'">
			<div class="labelStyle floatL">
				<spring:message code="label.quote.GST" />
			</div>
			<input type='hidden'
				data-ng-bind="activeAudit.serviceInformation.serviceDetail.gst.currency = activeAudit.serviceInformation.serviceDetail.gst.currency==null ? preferredCurrency : activeAudit.serviceInformation.serviceDetail.gst.currency" />
			<div class="floatL">
				<input type="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.gst" data-disable="isReadOnly()" ng-style="{width:'184px'}" money />
			</div>
			<div class="fieldSpacerWidth floatL">&nbsp;</div>
		</div>
		<div data-ng-if="costCategory.code=='QST'">
			<div class="labelStyle floatL">
				<spring:message code="label.quote.QST" />
			</div>
			<input type='hidden'
				data-ng-bind="activeAudit.serviceInformation.serviceDetail.qst.currency = activeAudit.serviceInformation.serviceDetail.qst.currency==null ? preferredCurrency : activeAudit.serviceInformation.serviceDetail.qst.currency" />
			<div class="floatL">
				<input type="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.qst" data-disable="isReadOnly()" ng-style="{width:'184px'}" money />
			</div>
			<div class="fieldSpacerWidth floatL">&nbsp;</div>
		</div>
	</div>
</div>
<div class="clear"></div>     