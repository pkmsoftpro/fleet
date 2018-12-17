<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="clear"></div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.revisions" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info" style="padding: 10.5px !important">
<span data-ng-if="fleetClaim.id!=null && activeAudit.fleetClaimState!='DRAFT'">
        <c:if test="${folderName!='Draft Claims'}">
            <div ng-show="audits!='' ">
                <div ng-if="selectedId==false">
                    <div class="gridStyle" data-ng-grid="gridForFleetClaimAudits" data-ng-dblclick="fleetClaimAudit(selectedItems)"></div>
                </div>
                <div ng-if="selectedId==true">
                    <div class="gridStyle" data-ng-grid="gridForFleetClaimAudits"></div>
                </div>
            </div>
        </c:if>
 </span>
</div>
<div class="clear"></div>