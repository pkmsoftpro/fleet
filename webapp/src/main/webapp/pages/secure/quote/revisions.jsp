<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="clear"></div>
<div class="accordion-header contentPane">
    <spring:message code="title.common.revisions" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info" style="padding:10.5px!important">
<span data-ng-if="quote.id!=null && quote.activeQuoteAudit.quoteState!='DRAFT'" class="clear">    
        <c:if test="${folderName!='Quotes Drafted'}">
            <div ng-show="audits!='' ">
                <div ng-if="selectedId==false">
                    <div class="gridStyle" data-ng-grid="gridForQuoteAudits" data-ng-dblclick="quoteAudit(selectedItems)"></div>
                </div>
                <div ng-if="selectedId==true">
                    <div class="gridStyle" data-ng-grid="gridForQuoteAudits"></div>
                </div>
            </div>
          <div class="clear"></div>
    </c:if>
</span>
</div>