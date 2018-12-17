<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
<div ng-if="servicingDealer">
        <div class="accordion-header contentPane">
            <spring:message code="title.common.comments" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
        <div ng-if="selectedId==true">
                <div class="labelStyle floatL">
                    <spring:message code="label.quote.notesForDealer" />:
                </div>
                <div class="floatL">
                    <textarea max-length rows="4" cols="500" class="wid500" data-ng-model="activeAudit.notesForDealer" data-ng-readonly="true"></textarea>
                </div>
                <div class="clear"></div>
        </div>
        
    	<div class="labelStyle floatL">
    		<spring:message code="label.quote.notesForNMHG" />:<span data-ng-show="(fleetClaim.displayStatus=='Denied And Closed' && selectedId==false && searchfleetClaim==true)" class="red">*</span>
    	</div>
    	<div class="floatL">
    		<textarea id='notesForNMHG' max-length
    			data-ng-model="activeAudit.notesForNMHG"
    			rows="4" cols="500" class="wid500" data-ng-disabled="!(fleetClaim.displayStatus=='Denied And Closed' && selectedId==false && searchfleetClaim==true)" data-ng-required="(fleetClaim.displayStatus=='Denied And Closed' && selectedId==false && searchfleetClaim==true)"></textarea>
    	</div>
    
    	<div class="clear"></div>
    
    	
    	<div class="labelStyle floatL">
    	   <spring:message code="label.quote.notesForCustomer" />:
    	</div>
            <div ng-if="activeAudit.updatedBy.userType=='INTERNAL'">
                <div class="floatL">
                    <textarea max-length data-ng-model="data" rows="4" cols="500" class="wid500" data-ng-readonly="true"></textarea>
                </div>
            </div>
            <div ng-if="activeAudit.updatedBy.userType!='INTERNAL'">
                <div class="floatL">
                    <textarea max-length data-ng-model="activeAudit.notesForCustomer" rows="4" cols="500" class="wid500" data-ng-readonly="true"></textarea>
                </div>
            </div>
        </div>
	<div class="clear"></div>
	
</div>

 

	<div ng-if="isInternalUserOrOwningDealer||isFleetProcesor">
        <div class="accordion-header contentPane">
            <spring:message code="title.common.comments" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
        
        <div class="labelStyle floatL">
            <spring:message code="label.common.internalComments" />:<span data-ng-show="(fleetClaim.displayStatus=='Denied And Closed' && selectedId==false && searchfleetClaim==true)" class="red">*</span>
            
        </div>
        <div class="floatL">
            <textarea max-length rows="4" cols="500" class="wid500" data-ng-model="activeAudit.internalComment" data-ng-disabled="!(fleetClaim.displayStatus=='Denied And Closed' && selectedId==false && searchfleetClaim==true)" data-ng-required="(fleetClaim.displayStatus=='Denied And Closed' && selectedId==false && searchfleetClaim==true)"></textarea>
        </div>
        
        <div class="clear"></div>
        
        <div class="labelStyle floatL">
            <spring:message code="label.quote.notesForDealer" />:
        </div>
        <div class="floatL">
            <textarea max-length rows="4" cols="500" class="wid500" data-ng-model="activeAudit.notesForDealer" data-ng-readonly="true"></textarea>
        </div>
        
        <div class="clear"></div>
        
        <div ng-if="selectedId==true">
                <div class="labelStyle floatL">
                    <spring:message code="label.quote.notesForNMHG" />:
                </div>
                <div class="floatL">
                    <textarea id='notesForNMHG' max-length data-ng-model="activeAudit.notesForNMHG" rows="4" cols="500" class="wid500" data-ng-readonly="true"></textarea>
                </div>
                <div class="clear"></div>
        </div>
        
        <div class="labelStyle floatL">
         	<spring:message code="label.quote.notesForCustomer" />:
         </div>
        <div class="floatL">
            <textarea max-length value=""
                data-ng-model="activeAudit.notesForCustomer"
                rows="4" cols="500" class="wid500" data-ng-readonly="true"></textarea>
        </div>
         <div class="clear"></div>
          <div ng-if="activeAudit.customerRejectionReason !=null && activeAudit.customerRejectionReason.length !=0">
		         <div class="labelStyle floatL">
		    		<spring:message code="title.common.claimDisputeReasonComments" />:
		    	</div>
		    	<div class="floatL">${activeAudit.customerRejectionReason}
		    		<div ng-repeat="reason in activeAudit.customerRejectionReason">
		    			{{reason.description}}
		    		</div>
		    		
		    	</div>
	    	</div>
	    	<div class="clear"></div>
	    	<div  ng-if="activeAudit.customerDisputeComments!=null">
	        <div class="labelStyle floatL">
	           <spring:message code="label.claim.customerDisputeComments" />
	        </div>
	        <div class="floatL">
	            <textarea max-length value=""
	                data-ng-model="activeAudit.customerDisputeComments"
	                rows="4" cols="500" class="wid500" data-ng-readonly="true" ></textarea>
	        </div>
            </div>
       </div> 
       </div>
       <div ng-if="isCustomerUser">
        <div class="accordion-header contentPane">
            <spring:message code="title.common.comments" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
         <div class="overflow-hidden accordion-info">
       		<div ng-if="activeAudit.customerRejectionReason !=null && activeAudit.customerRejectionReason.length !=0">
		         <div class="labelStyle floatL">
		    		<spring:message code="title.common.claimDisputeReasonComments" />:
		    	</div>
		    	<div class="floatL">${activeAudit.customerRejectionReason}
		    		<div ng-repeat="reason in activeAudit.customerRejectionReason">
		    			{{reason.description}}
		    		</div>
		    		
		    	</div>
	    	</div>
	    	<div class="clear"></div>
	        <div class="labelStyle floatL">
	           <spring:message code="label.claim.customerDisputeComments" />
	        </div>
	        <div class="floatL">
	            <textarea max-length value=""
	                data-ng-model="activeAudit.customerDisputeComments"
	                rows="4" cols="500" class="wid500" data-ng-readonly="true" ></textarea>
	        </div>
            <div class="clear"></div>
            <div ng-if="selectedId==true">
                <div class="labelStyle floatL">
                   <spring:message code="label.quote.notesForCustomer" />:
               </div>
               <div class="floatL">
                  <textarea max-length data-ng-model="activeAudit.notesForCustomer" rows="4" cols="500" class="wid500" data-ng-readonly="true"></textarea>
               </div>
            </div>
       </div>
 </div>
</div> 


