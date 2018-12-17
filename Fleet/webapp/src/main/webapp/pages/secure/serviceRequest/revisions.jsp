
<div data-ng-if="serviceRequest.serviceRequestAudits!='' ">
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.revisions" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
        <div ng-if="selectedId==false" class="mar10-marT0">
            <div class="gridStyle custom-grid-row" data-ng-grid="gridForServiceRequestAudits" data-ng-dblclick="serviceRequestAudit(selectedItems)"></div>
        </div>
        <div ng-if="selectedId==true" class="mar10-marT0">
            <div class="gridStyle custom-grid-row" data-ng-grid="gridForServiceRequestAudits"></div>
        </div>
        <div class="clear"></div>
    </div>
</div>