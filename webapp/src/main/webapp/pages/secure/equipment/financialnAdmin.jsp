

<div sub-section content-pane-title="<spring:message code="title.common.miscellaneous"/>" collapse="false"></div>

<div>
    <div class="labelStyle" style="float: left;">
        <spring:message code="label.quote.freight" />
    </div>
    <div style="float: left;"
        data-ng-init="quote.activeQuoteAudit.serviceInformation.serviceDetail.freight.currency=quote.activeQuoteAudit.serviceInformation.serviceDetail.freight.currency==null?'${currency}' : quote.activeQuoteAudit.serviceInformation.serviceDetail.freight.currency">
        <input type="text" data-ng-model="quote.activeQuoteAudit.serviceInformation.serviceDetail.freight" data-disable="false" ng-style="{width:'206px'}" money />
    </div>

    <div class="fieldSpacerWidth" style="float: left;">&nbsp;</div>
    <div class="labelStyle" style="float: left;">
        <spring:message code="label.quote.laborOutside" />
    </div>
    <div style="float: left;"
        data-ng-init="quote.activeQuoteAudit.serviceInformation.serviceDetail.laborOutside.currency=quote.activeQuoteAudit.serviceInformation.serviceDetail.laborOutside.currency==null?'${currency}' : quote.activeQuoteAudit.serviceInformation.serviceDetail.laborOutside.currency">
        <input type="text" data-ng-model="quote.activeQuoteAudit.serviceInformation.serviceDetail.laborOutside" data-disable="false" ng-style="{width:'206px'}"
            money />
    </div>
</div>

<div class="fieldSpacerHeight" style="clear: both;"></div>

<div>
    <div class="labelStyle" style="float: left;">
        <spring:message code="label.quote.environmentalFee" />
    </div>
    <div style="float: left;"
        data-ng-init="quote.activeQuoteAudit.serviceInformation.serviceDetail.environmentalFee.currency=quote.activeQuoteAudit.serviceInformation.serviceDetail.environmentalFee.currency==null?'${currency}' : quote.activeQuoteAudit.serviceInformation.serviceDetail.environmentalFee.currency">
        <input type="text" data-ng-model="quote.activeQuoteAudit.serviceInformation.serviceDetail.environmentalFee" data-disable="false"
            ng-style="{width:'206px'}" money />
    </div>
    <div class="fieldSpacerWidth" style="float: left;">&nbsp;</div>
    <div class="labelStyle" style="float: left;">
        <spring:message code="label.quote.miscSourcingTravel" />
    </div>
    <div style="float: left;"
        data-ng-init="quote.activeQuoteAudit.serviceInformation.serviceDetail.miscSourcingTravel.currency=quote.activeQuoteAudit.serviceInformation.serviceDetail.miscSourcingTravel.currency==null?'${currency}' : quote.activeQuoteAudit.serviceInformation.serviceDetail.miscSourcingTravel.currency">
        <input type="text" data-ng-model="quote.activeQuoteAudit.serviceInformation.serviceDetail.miscSourcingTravel" data-disable="false"
            ng-style="{width:'206px'}" money />
    </div>
</div>
<div class="fieldSpacerHeight" style="clear: both;"></div>

<div>
    <div class="labelStyle" style="float: left;">
        <spring:message code="label.quote.rental" />
    </div>
    <div style="float: left;"
        data-ng-init="quote.activeQuoteAudit.serviceInformation.serviceDetail.rental.currency=quote.activeQuoteAudit.serviceInformation.serviceDetail.rental.currency==null?'${currency}' : quote.activeQuoteAudit.serviceInformation.serviceDetail.rental.currency">
        <input type="text" data-ng-model="quote.activeQuoteAudit.serviceInformation.serviceDetail.rental" data-disable="false" ng-style="{width:'206px'}" money />
    </div>
    <div class="fieldSpacerWidth" style="float: left;">&nbsp;</div>
    <div class="labelStyle" style="float: left;">
        <spring:message code="label.quote.other" />
    </div>
    <div style="float: left;"
        data-ng-init="quote.activeQuoteAudit.serviceInformation.serviceDetail.other.currency=quote.activeQuoteAudit.serviceInformation.serviceDetail.other.currency==null?'${currency}' : quote.activeQuoteAudit.serviceInformation.serviceDetail.other.currency">
        <input type="text" data-ng-model="quote.activeQuoteAudit.serviceInformation.serviceDetail.other" data-disable="false" ng-style="{width:'206px'}" money />
    </div>
</div>
<div class="fieldSpacerHeight" style="clear: both;"></div>

<div>
    <div class="labelStyle" style="float: left;">
        <spring:message code="label.quote.drayage" />
    </div>
    <div style="float: left;"
        data-ng-init="quote.activeQuoteAudit.serviceInformation.serviceDetail.drayage.currency=quote.activeQuoteAudit.serviceInformation.serviceDetail.drayage.currency==null?'${currency}' : quote.activeQuoteAudit.serviceInformation.serviceDetail.drayage.currency">
        <input type="text" data-ng-model="quote.activeQuoteAudit.serviceInformation.serviceDetail.drayage" data-disable="false" ng-style="{width:'206px'}" money />
    </div>
</div>
<div class="fieldSpacerHeight" style="clear: both;"></div>


<div sub-section content-pane-title="<spring:message code="label.quote.taxes"/>" collapse="false"></div>

<div>
    <div class="labelStyle" style="float: left;">
        <spring:message code="label.quote.USTaxes" />
    </div>
    <div style="float: left;"
        data-ng-init="quote.activeQuoteAudit.serviceInformation.serviceDetail.usTaxes.currency=quote.activeQuoteAudit.serviceInformation.serviceDetail.usTaxes.currency==null?'${currency}' : quote.activeQuoteAudit.serviceInformation.serviceDetail.usTaxes.currency">
        <input type="text" data-ng-model="quote.activeQuoteAudit.serviceInformation.serviceDetail.usTaxes" data-disable="false" ng-style="{width:'206px'}" money />
    </div>
    <div class="fieldSpacerWidth" style="float: left;">&nbsp;</div>
    <div class="labelStyle" style="float: left;">
        <spring:message code="label.quote.HST" />
    </div>
    <div style="float: left;"
        data-ng-init="quote.activeQuoteAudit.serviceInformation.serviceDetail.hst.currency=quote.activeQuoteAudit.serviceInformation.serviceDetail.hst.currency==null?'${currency}' : quote.activeQuoteAudit.serviceInformation.serviceDetail.hst.currency">
        <input type="text" data-ng-model="quote.activeQuoteAudit.serviceInformation.serviceDetail.hst" data-disable="false" ng-style="{width:'206px'}" money />
    </div>
</div>

<div class="fieldSpacerHeight" style="clear: both;"></div>

<div>
    <div class="labelStyle" style="float: left;">
        <spring:message code="label.quote.PST" />
    </div>
    <div style="float: left;"
        data-ng-init="quote.activeQuoteAudit.serviceInformation.serviceDetail.pst.currency=quote.activeQuoteAudit.serviceInformation.serviceDetail.pst.currency==null?'${currency}' : quote.activeQuoteAudit.serviceInformation.serviceDetail.pst.currency">
        <input type="text" data-ng-model="quote.activeQuoteAudit.serviceInformation.serviceDetail.pst" data-disable="false" ng-style="{width:'206px'}" money />
    </div>
    <div class="fieldSpacerWidth" style="float: left;">&nbsp;</div>
    <div class="labelStyle" style="float: left;">
        <spring:message code="label.quote.GST" />
    </div>
    <div style="float: left;"
        data-ng-init="quote.activeQuoteAudit.serviceInformation.serviceDetail.gst.currency=quote.activeQuoteAudit.serviceInformation.serviceDetail.gst.currency==null?'${currency}' : quote.activeQuoteAudit.serviceInformation.serviceDetail.gst.currency">
        <input type="text" data-ng-model="quote.activeQuoteAudit.serviceInformation.serviceDetail.gst" data-disable="false" ng-style="{width:'206px'}" money />
    </div>
</div>

<div class="fieldSpacerHeight" style="clear: both;"></div>

<div>
    <div class="labelStyle" style="float: left;">
        <spring:message code="label.quote.QST" />
    </div>
    <div style="float: left;"
        data-ng-init="quote.activeQuoteAudit.serviceInformation.serviceDetail.qst.currency=quote.activeQuoteAudit.serviceInformation.serviceDetail.qst.currency==null?'${currency}' : quote.activeQuoteAudit.serviceInformation.serviceDetail.qst.currency ">
        <input type="text" data-ng-model="quote.activeQuoteAudit.serviceInformation.serviceDetail.qst" data-disable="false" ng-style="{width:'206px'}" money />
    </div>
</div>



