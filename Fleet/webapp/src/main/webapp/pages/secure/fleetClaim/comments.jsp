<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
<div ng-show="servicingDealer">
        <div class="accordion-header contentPane">
            <spring:message code="title.common.comments" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
    	<div class="labelStyle floatL">
    		<spring:message code="label.quote.notesForNMHG" />:
    	</div>
    	<div class="floatL">
    		<textarea max-length
    			data-ng-model="activeAudit.notesForNMHG"
    			rows="4" cols="500" class="wid500"></textarea>
    	</div>
    
    	<div class="clear"></div>
    
    	<div class="labelStyle floatL">
    	   <spring:message code="label.quote.notesForCustomer" />:
    		<!-- <spring:message code="label.common.publicComments" />: -->
    	</div>
    	<div class="floatL">
    		<textarea max-length
    			data-ng-model="activeAudit.notesForCustomer"
    			rows="4" cols="500" class="wid500"></textarea>
    	</div>
    	<div class="clear"></div>
    	<div ng-show="folderName=='Claims Workbench'">
	    	<div class="labelStyle floatL">
	            <spring:message code="label.quote.notesForDealer" />:
	        </div>
	        <div class="floatL">
	            <textarea max-length rows="4" data-ng-readonly="true" cols="500" class="wid500" data-ng-model="activeAudit.notesForDealer" ></textarea>
	        </div>
	        
	     </div>
    	
   </div>
	
</div>

 
<div ng-show="isInternalUserOrOwningDealer">
        <div class="accordion-header contentPane">
            <spring:message code="title.common.comments" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
         <div class="labelStyle floatL">
            <spring:message code="label.common.internalComments" />:
        </div>
        <div class="floatL">
            <textarea max-length rows="4" cols="500" class="wid500" data-ng-model="activeAudit.internalComment" ng-required="task.takenTransition=='Request FSS Advice' || task.takenTransition=='Transfer'"></textarea>
        </div>
        
        <div class="clear"></div>
        
        <div class="labelStyle floatL">
            <spring:message code="label.quote.notesForDealer" />:
        </div>
        <div class="floatL">
            <textarea max-length rows="4" cols="500" class="wid500" data-ng-model="activeAudit.notesForDealer" ng-required="task.takenTransition=='Request Dealer Information'"></textarea>
        </div>
        
        <div class="clear"></div>
        
        <div class="labelStyle floatL">
           <!--  <spring:message code="label.common.publicComments" />: -->
           <spring:message code="label.quote.notesForCustomer" />:
        </div>
        <div class="floatL">
            <textarea max-length value=""
                data-ng-model="activeAudit.notesForCustomer"
                rows="4" cols="500" class="wid500" ></textarea>
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
	<div ng-show="isCustomerUser">
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
	    
		</div>
	</div> 
</div>

