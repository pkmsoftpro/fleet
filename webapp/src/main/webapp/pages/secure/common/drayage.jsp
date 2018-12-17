<div class="accordion-header contentPane">
    <spring:message code="label.quote.transportation" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div data-ng-repeat="costCategory in applicableCostCategoriesList">
        <div data-ng-if="costCategory.categoryGroup=='MAJOR COST CATEGORY'">
            <div data-ng-if="costCategory.code=='DRAYAGE'">
                <div class="details-sub-header">
                    <span><spring:message code="label.quote.transportation" /> </span>
                </div>
                <div class="labelStyle floatL">
                    <spring:message code="label.quote.transportation" />
                </div>
                <input type='hidden'
                    data-ng-bind="activeAudit.serviceInformation.serviceDetail.transportation.currency = activeAudit.serviceInformation.serviceDetail.transportation.currency==null ? preferredCurrency : activeAudit.serviceInformation.serviceDetail.transportation.currency" />
                <div class="floatL">
                    <input type="text" data-ng-model="activeAudit.serviceInformation.serviceDetail.transportation" data-disable="isReadOnly()"
                        ng-style="{width:'184px'}" money />
                </div>
                <div class="fieldSpacerWidth floatL">&nbsp;</div>
            </div>

        </div>
    </div>
</div>