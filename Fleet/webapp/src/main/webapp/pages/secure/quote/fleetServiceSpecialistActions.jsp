<c:if test="${folderName=='Quotes Received'}">
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.actions" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
       <div class="actionslabelStyle">
            <div data-ng-show="isApproveTransfer">
	             <div>
	            	<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Approved and Transfer" ng-disabled="isApproved">
	                <spring:message code="label.common.quote.nmhgapprovedAndTransfer" />
	            </div>
	            <div>
	            	<input type="radio" class="action-radio"  data-ng-model="task.takenTransition" required="required" value="ApproveAndTransferOnBehalfOfCustomer">
	                <spring:message code="label.common.quote.nmhgapprovedAndTransferBehalfOfCustomer" />
	           </div>
	           	           <div>
	            	<input type="radio" class="action-radio"  data-ng-model="task.takenTransition" required="required" value="ApproveAndTransferWithoutCustomerBilling">
	                <spring:message code="label.common.quote.nmhgapprovedAndTransferWithoutCustomerBilling" />
	           </div>
            </div>
            <div data-ng-show="isApprove">
	           <div>
	            	<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Approved">
	                <spring:message code="label.common.quote.submitToCustomer" />
	            </div>
	            <div>
	            	<input type="radio" class="action-radio"  data-ng-model="task.takenTransition" required="required" value="ApproveOnBehalfOfCustomer">
	                <spring:message code="label.common.quote.approveOnBehalfOfCustomer" />
	           </div>
	           <div>
	            	<input type="radio" class="action-radio"  data-ng-model="task.takenTransition" required="required" value="ApproveWithoutCustomerBilling">
	                <spring:message code="label.common.quote.approveWithoutCustomerBilling" />
	           </div>
            </div>
           
            <div data-ng-show="!isApprove && !isApproveTransfer">
            	<div data-ng-if="!isApprovedAlready">
					<span style="color: red;"><spring:message code="label.common.error.loaSetUp" /></span>            	
            	</div>
            	<div data-ng-if="isApprovedAlready">
            		<div style="color: red;"><spring:message code="label.common.error.loaApproved" /></div>
            	</div>
			</div>
           <div>
           		<input type="radio" class="action-radio"  data-ng-model="task.takenTransition" required="required" value="Service Specialist Sent For RequestRevision">
                <spring:message code="label.common.quote.requestRevision" />
           </div>
           <div>
           		<input type="radio" class="action-radio"  data-ng-model="task.takenTransition" required="required" value="Service Specialist Denied">
                <spring:message code="label.common.quote.deny" />
           </div>
           <div class="actionQuote">
           <span>
            	<input type="radio" class="action-radio"  data-ng-model="task.takenTransition" required="required" value="Transfer">
                <spring:message code="label.common.quote.transfer" />
				</span>
                <select data-ng-model="task.transferTo"
                    data-ng-options="name for name in task.listInternalUsers" ng-required="task.takenTransition=='Transfer'" ng-disabled="task.takenTransition!='Transfer'">
                    <option value=""><spring:message code="label.serviceRequest.select" /></option>
                </select>
                 <div ng-if="task.takenTransition!='Transfer'">
	                {{task.transferTo=""}}
				</div>
            </div>        
            <div class="actionQuote">
            	<span>
            		<input type="checkbox" class="action-radio" 
        		ng-model="quote.activeQuoteAudit.recommendationFlag" >
        		<spring:message code="label.common.quote.fleetRecomendation" />
            	</span>
        		
        		<select data-ng-show="quote.activeQuoteAudit.recommendationFlag==true" data-ng-model="quote.activeQuoteAudit.fleetRecommendation.id"
                    data-ng-options="fr.id as fr.name for fr in fleetRecommendations" ng-required="quote.activeQuoteAudit.recommendationFlag">
                    <option value=""><spring:message code="label.serviceRequest.select" /></option>
                </select>
                 <div ng-if="quote.activeQuoteAudit.recommendationFlag==false">
                    {{quote.activeQuoteAudit.recommendationComments=""}}
                    {{quote.activeQuoteAudit.fleetRecommendation=null}}
                </div> 
   			<div ng-if="quote.activeQuoteAudit.recommendationFlag==true">
				<div class="actionQuote">
					<span>
						<spring:message code="label.common.quote.recommendation" />
            			<span class="red">*</span>
					</span>
            		
                <textarea max-length
						data-ng-model="quote.activeQuoteAudit.recommendationComments"
						rows="4" cols="500" class="wid400" ng-required="quote.activeQuoteAudit.recommendationFlag"></textarea>
                </div>
			</div><br/>
		</div>
       </div>
    <div class="hgt50"></div>
    <div class="centered marB10">
            <button type="button" class="blue-btn btn-primary" data-ng-click="validateQuote()" ng-disabled='form.$invalid'>
                <spring:message code="label.Common.validate" />
            </button>
            <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()" >
                <spring:message code="label.Common.cancel" />
            </button>
    </div>
  </div>
</c:if>
<c:if test="${folderName=='Quotes Accepted Internal' || folderName=='Quotes Accepted Dealer Owned' || folderName=='Quotes Rejected Internal' || folderName=='Quotes Rejected Dealer Owned'}">
    <div class="hgt50"></div>
    <div class="centered marB10">
            <button type="button" class="blue-btn btn-primary" data-ng-click="quoteSummary()" ng-disabled='form.$invalid'>
                <spring:message code="label.Common.quoteSummary" />
            </button>
            <button ng-show="!isClaimAssociated" type="button" class="blue-btn btn-primary" data-ng-click="reopenQuote('Quote Reopen by ServiceSpecialist')" ng-disabled='form.$invalid'>
                <spring:message code="label.common.reopen" />
            </button>
            <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
                <spring:message code="label.Common.cancel" />
            </button>
    </div>
</c:if>
<c:if test="${folderName=='Quotes Accepted' || folderName=='Quotes Rejected' }">
 <div class="hgt50"></div>
    <div class="centered marB10">
            <button type="button" class="blue-btn btn-primary" data-ng-click="quoteSummary()" ng-disabled='form.$invalid'>
                <spring:message code="label.Common.quoteSummary" />
            </button>
            <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
                <spring:message code="label.Common.cancel" />
            </button>
    </div>
</c:if>

<c:if test="${folderName=='Quotes Received For Revision from Customer'}">
    <div class="accordion-header contentPane">
        <spring:message code="title.common.actions" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
       <div class="actionslabelStyle">
         <div data-ng-show="isApproveTransfer">
	             <div>
	            	<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Approved and Transfer" ng-disabled="isApproved">
	                <spring:message code="label.common.quote.nmhgapprovedAndTransfer" />
	            </div>
	            <div>
	            	<input type="radio" class="action-radio"  data-ng-model="task.takenTransition" required="required" value="ApproveAndTransferOnBehalfOfCustomer">
	                <spring:message code="label.common.quote.nmhgapprovedAndTransferBehalfOfCustomer" />
	           </div>
	           	           <div>
	            	<input type="radio" class="action-radio"  data-ng-model="task.takenTransition" required="required" value="ApproveAndTransferWithoutCustomerBilling">
	                <spring:message code="label.common.quote.nmhgapprovedAndTransferWithoutCustomerBilling" />
	           </div>
            </div>
            <div data-ng-show="isApprove">
	           <div>
	            	<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Approved">
	                <spring:message code="label.common.quote.submitToCustomer" />
	            </div>
	            <div>
	            	<input type="radio" class="action-radio"  data-ng-model="task.takenTransition" required="required" value="ApproveOnBehalfOfCustomer">
	                <spring:message code="label.common.quote.approveOnBehalfOfCustomer" />
	           </div>
	           <div>
	            	<input type="radio" class="action-radio"  data-ng-model="task.takenTransition" required="required" value="ApproveWithoutCustomerBilling">
	                <spring:message code="label.common.quote.approveWithoutCustomerBilling" />
	           </div>
            </div>
           
            <div data-ng-show="!isApprove && !isApproveTransfer">
				<span style="color: red;"><spring:message code="label.common.error.loaSetUp" /></span>
			</div>
            <div><input type="radio" class="action-radio" required="required" data-ng-model="task.takenTransition"
                    value="sent for dealer revision">
                <spring:message code="label.common.quote.requestRevision" />
                </div>
            <div><input type="radio" class="action-radio" required="required" data-ng-model="task.takenTransition"
                    value="Quote Denied By Specialist">
                <spring:message code="label.common.quote.deny" />
                </div>
            <div class="actionQuote">
           <span>
            <input type="radio" class="action-radio" required="required" data-ng-model="task.takenTransition"
                    value="Quote Transfer to Internal">
                <spring:message code="label.common.quote.transfer" />
           </span>
                <select  data-ng-model="task.transferTo"
                    ng-options="name for name in task.listInternalUsers" ng-required="task.takenTransition=='Quote Transfer to Internal'">
                    <option value=""><spring:message code="label.serviceRequest.select" /></option>
                </select>
                 <div ng-if="task.takenTransition!='Quote Transfer to Internal'">
	                {{task.transferTo=""}}
				</div>
                 </div>
                  <div class="actionQuote">
            	<span>
            		<input type="checkbox" class="action-radio" 
        		ng-model="quote.activeQuoteAudit.recommendationFlag" >
        		<spring:message code="label.common.quote.fleetRecomendation" />
            	</span>
        		
        		<select  data-ng-show="quote.activeQuoteAudit.recommendationFlag==true" data-ng-model="quote.activeQuoteAudit.fleetRecommendation.id"
                    data-ng-options="fr.id as fr.name for fr in fleetRecommendations" ng-required="quote.activeQuoteAudit.recommendationFlag">
                    <option value=""><spring:message code="label.serviceRequest.select" /></option>
                </select>
                <div ng-if="quote.activeQuoteAudit.recommendationFlag==false">
                    {{quote.activeQuoteAudit.recommendationComments=""}}
                    {{quote.activeQuoteAudit.fleetRecommendation=null}}
                </div>
   			<div ng-if="quote.activeQuoteAudit.recommendationFlag==true">
				<div class="actionQuote">
					<span>
						<spring:message code="label.common.quote.recommendation" />
            			<span class="red">*</span>
					</span>
            		
                <textarea max-length
						data-ng-model="quote.activeQuoteAudit.recommendationComments"
						rows="4" cols="500" class="wid400" ng-required="quote.activeQuoteAudit.recommendationFlag"></textarea>
                </div>
			</div><br/>
		</div>
        </div>
   
    <div class="hgt50"></div>
    <div class="centered marB10">
            <button type="button" class="blue-btn btn-primary" data-ng-click="validateQuote()" ng-disabled='form.$invalid'>
                <spring:message code="label.Common.validate" />
            </button>
            <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()" >
                <spring:message code="label.Common.cancel" />
            </button>
    </div>
   </div>
</c:if>
<div ng-show="isInternalUserOrOwningDealer">  
<c:if test="${(folderName=='Quotes Sent For Revision') || (folderName=='Quotes Reverted') || (folderName=='Quotes Reverted Internal') || (folderName=='Quotes Reverted Dealer Owned')}">
    <div class="centered marB10">
            <button type="button" class="blue-btn btn-primary" data-ng-click="quoteSummary()" ng-disabled='form.$invalid'>
                <spring:message code="label.Common.quoteSummary" />
            </button>
            <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
                <spring:message code="label.Common.cancel" />
            </button>
    </div>
</c:if>
</div>