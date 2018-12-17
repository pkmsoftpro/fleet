
<div class="centered marB10">
<c:if test="${folderName=='Quotes Drafted'}">
<button type="button" class="blue-btn btn-primary" data-ng-click="validateQuote('Submit Quote')" ng-disabled='form.$invalid'>
            <spring:message code="label.Common.validate"/></button>
<button type="button" class="blue-btn btn-primary" data-ng-click="save()" >
            <spring:message code="label.Common.save"/></button>
<button type="button" class="blue-btn btn-primary" data-ng-click="deleteDraftQuote()">
            <spring:message code="label.common.delete"/></button>
</c:if>
<c:if test="${folderName=='Quotes Submitted'}">
<button type="button" class="blue-btn btn-primary" data-ng-click="quoteSummary()" ng-disabled='form.$invalid'>
<spring:message code="label.Common.quoteSummary"/></button>	
<button type="button" class="blue-btn btn-primary"  data-ng-click="revertQuote('Quote Reverted')" ng-disabled='form.$invalid'>
            <spring:message code="label.Common.revert"/></button>		
</c:if>
<c:if test="${folderName=='Quotes Accepted'}">
<button type="button" class="blue-btn btn-primary" data-ng-click="quoteSummary()" ng-disabled='form.$invalid'>
<spring:message code="label.Common.quoteSummary"/></button>
</c:if>
<c:if test="${folderName=='Quotes Rejected'}">
<button type="button" class="blue-btn btn-primary"  data-ng-click="validateQuote('Quote Resubmitted by Dealer')" ng-disabled='form.$invalid'>
  <spring:message code="label.Common.resubmitted"/></button>	
</c:if>
<c:if test="${folderName=='Quotes Received For Revision from Owner'}">
<button type="button" class="blue-btn btn-primary"  data-ng-click="validateQuote('Resubmit quote')" ng-disabled='form.$invalid'>
  <spring:message code="label.Common.submit"/></button>	
</c:if>
<c:if test="${folderName=='Quotes Reverted'}">
<button type="button" class="blue-btn btn-primary"  data-ng-click="validateQuote('Dealer Quote ReSubmit')" ng-disabled='form.$invalid'>
  <spring:message code="label.Common.submit"/></button>	
</c:if>
<c:if test="${folderName=='Quotes Expired'}">
<button type="button" class="blue-btn btn-primary" data-ng-click="quoteSummary()" ng-disabled='form.$invalid'>
<spring:message code="label.Common.quoteSummary"/></button>
</c:if>
<button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
<spring:message code="label.Common.cancel"/></button>	
</div>