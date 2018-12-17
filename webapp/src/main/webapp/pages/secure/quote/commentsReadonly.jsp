<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
 <div ng-show="servicingDealer">
        <div class="accordion-header contentPane">
            <spring:message code="title.common.comments" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
        <div ng-show="activeAudit.auditBy == 'DEALER USER'">
    	<div class="labelStyle floatL">
    		<spring:message code="label.quote.notesForNMHG" />:
    	</div>
    	<div class="floatL">
    		<textarea max-length
    			data-ng-model="activeAudit.notesForNMHG"
    			rows="4" cols="500" class="wid500" ng-readonly="true"></textarea>
    	</div>
    
    	<div class="clear"></div>
    
    	<div class="labelStyle floatL">
    		<spring:message code="label.quote.notesForCustomer" />:
    	</div>
    	<div class="floatL">
    		<textarea max-length
    			data-ng-model="activeAudit.notesForCustomer"
    			rows="4" cols="500" class="wid500" ng-readonly="true"></textarea>
    	</div>
     </div> 
    	<div class="clear"></div>
        
        <div class="labelStyle floatL">
            <spring:message code="label.quote.notesForDealer" />:
        </div>
        <div class="floatL">
            <textarea max-length rows="4" cols="500" class="wid500" data-ng-model="activeAudit.notesForDealer" ng-readonly="true"></textarea>
        </div>
    	</div>
	<div class="clear"></div>
	
</div>

<div ng-show="isCustomerUser">
        <div class="accordion-header contentPane">
            <spring:message code="title.common.comments" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
        <div class="clear"></div>
        
        <div class="labelStyle floatL">
            <spring:message code="label.quote.notesForCustomer" />:
        </div>
        <div class="floatL">
            <textarea max-length value=""
                data-ng-model="activeAudit.notesForCustomer"
                rows="4" cols="500" class="wid500" ng-readonly="true"></textarea>
        </div>
        <div class="clear"></div>
        <div ng-show="activeAudit.auditBy=='CUSTOMER'">
    	<div class="labelStyle floatL">
    		<spring:message code="label.quote.notesForDealer" />:
    	</div>
    	<div class="floatL">
    		<textarea max-length rows="4" cols="500" class="wid500" data-ng-model="activeAudit.notesForDealer" id="customerNotes1"  ng-readonly="true"></textarea>
    	</div>
    	
    	<div class="clear"></div>
    	
    	<div class="labelStyle floatL">
    		<spring:message code="label.quote.notesForNMHG" />:
    	</div>
    	<div class="floatL">
    		<textarea max-length
    			data-ng-model="activeAudit.notesForNMHG"
    			rows="4" cols="500" class="wid500" id="customerNotes2" ng-readonly="true"></textarea>
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
            <textarea max-length rows="4" cols="500" class="wid500" data-ng-model="activeAudit.internalComments" ng-readonly="true"></textarea>
        </div>
        
        <div class="clear"></div>
        
        <div class="labelStyle floatL">
            <spring:message code="label.quote.notesForDealer" />:
        </div>
        <div class="floatL">
            <textarea max-length rows="4" cols="500" class="wid500" data-ng-model="activeAudit.notesForDealer" ng-readonly="true"></textarea>
        </div>
        
        <div class="clear"></div>
        
        <div class="labelStyle floatL">
            <spring:message code="label.quote.notesForCustomer" />:
        </div>
        <div class="floatL">
            <textarea max-length value=""
                data-ng-model="activeAudit.notesForCustomer"
                rows="4" cols="500" class="wid500" ng-readonly="true"></textarea>
        </div>
         <div class="clear"></div>
         <div class="labelStyle floatL">
    		<spring:message code="label.quote.notesForNMHG" />:
    	</div>
    	<div class="floatL">
    		<textarea max-length
    			data-ng-model="activeAudit.notesForNMHG"
    			rows="4" cols="500" class="wid500" ng-readonly="true"></textarea>
    	</div>
       </div> 
</div>
</div> 


