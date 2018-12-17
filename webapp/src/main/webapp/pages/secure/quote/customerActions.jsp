<c:if test="${folderName=='Quotes Received'}">
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.actions" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
        <div class="actionslabelStyle">
    				<span><spring:message code="label.common.quote.PONumber" /></span>
                	<INPUT TYPE="text" maxlength="{{quote.serviceRequest.customerLocation.purchaseOrderLength}}" 
            	 	data-ng-model="quote.serviceRequest.activeServiceRequestAudit.customerPoNumber" id="customerPoNumber" 
            	 	ng-blur="validatePONumber(quote.serviceRequest.activeServiceRequestAudit.customerPoNumber,quote.serviceRequest.customerLocation.id,quote.serviceRequest.customerLocation.poRegularExpression,quote.serviceRequest.customerLocation.duplicatePoNumberAllowed)"
            	 	ng-required="quote.serviceRequest.customerLocation.purchaseOrderRequired">
            	 	<div class="fieldSpacerWidth floatR" style="margin-right: 570px;">
            	  		<div ng-if="PONumberDuplicate">
                    	 	<div ng-show='PONumberDuplicate' class="floatL">
                        		<img id="serialNumberAlert" src="../image/ui-ext/validation/alerts.gif" class="marT10" class="visibility-hidden"
                            	tooltip="<spring:message code='label.serviceRequest.PONumber.invalid'/>" />
                    		</div>
                    	</div>
                    	<div ng-if="PONumberExits">
                    	   <div ng-show='PONumberExits' class="floatL">
                        	<img id="serialNumberAlert" src="../image/ui-ext/validation/alerts.gif" class="marT10" class="visibility-hidden"
                           		tooltip="<spring:message code='label.serviceRequest.PONumber.duplicate'/>" />
                    	  </div>
                 		</div> 
					</div>
		  	<div data-ng-if="isApproveTransfer">
            	<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Approved and Transfer" ng-disabled="isApproved">
                <spring:message code="label.common.quote.customerApproveAndTransfer" />
            </div>
			
			<div data-ng-if="isApprove">
				<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Approved">
            	<spring:message code="label.common.quote.accept" />
			</div>
			
			<div data-ng-if="!isApprove && !isApproveTransfer">
				<span style="color: red;"><spring:message code="label.common.error.loaSetUp" /></span>
			</div>
			
			<div>
				<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Denied">
            <spring:message code="label.common.quote.deny" />
			</div>
			<div>
				 <input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="RequestRevision">
            <spring:message code="label.common.quote.requestRevision" />
			</div>
        </div>
   
    <div class="hgt50"></div>
    <div class="centered marB10">
            <button type="button" class="blue-btn btn-primary" data-ng-click="validateQuote()" ng-disabled='form.$invalid ||PONumberDuplicate==true||PONumberExits'>
                <spring:message code="label.Common.validate" />
            </button>
            <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()"
                onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                <spring:message code="label.Common.cancel" />
            </button>
    </div></div>
</c:if>
<c:if test="${(folderName=='Quotes Accepted') || (folderName=='Quotes Rejected')|| (folderName=='Quotes Sent For Revision')}">
    <div class="centered marB10">
            <button type="button" class="blue-btn btn-primary" data-ng-click="quoteSummary()" ng-disabled='form.$invalid'>
                <spring:message code="label.Common.quoteSummary" />
            </button>
            <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()"
                onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                <spring:message code="label.Common.cancel" />
            </button>
    </div>
</c:if>
 