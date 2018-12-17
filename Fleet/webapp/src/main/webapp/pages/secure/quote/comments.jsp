<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div>
 <div ng-show="servicingDealer">
    <c:if test="${(folderName!='Quotes Submitted')
                &&(folderName!='Quotes Accepted')
                &&(folderName!='Quotes Expired')
                &&(folderName!='Quotes Accepted Internal')
                &&(folderName!='Quotes Accepted Dealer Owned')
                &&(folderName!='Quotes Expired Internal')
                &&(folderName!='Quotes Expired Dealer Owned')}">
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
	    	</div>
	    	<div class="floatL">
	    		<textarea max-length
	    			data-ng-model="activeAudit.notesForCustomer"
	    			rows="4" cols="500" class="wid500"></textarea>
	    	</div>
	    	
	    	<div class="clear"></div>
	    	
	    	<div class="labelStyle floatL">
	    		<spring:message code="label.quote.notesForDealer" />:
	    	</div>
	    	<div class="floatL">
	    		<textarea max-length data-ng-readonly="true"
	    			data-ng-model="activeAudit.notesForDealer"
	    			rows="4" cols="500" class="wid500"></textarea>
	    	</div>
	    	
    	</div>
    </c:if>
	<div class="clear"></div>
	
</div>

<div ng-show="isCustomerUser">
    <c:if test="${(folderName!='Quotes Accepted')
                &&(folderName!='Quotes Sent For Revision')
                &&(folderName!='Quotes Reverted')
                &&(folderName!='Quotes Rejected')
                &&(folderName!='Quotes Expired')
                &&(folderName!='Quotes Accepted Internal')
                &&(folderName!='Quotes Accepted Dealer Owned')
                &&(folderName!='Quotes Reverted Dealer Owned')
                &&(folderName!='Quotes Reverted Internal')
                &&(folderName!='Quotes Rejected Internal')
                &&(folderName!='Quotes Rejected Dealer Owned')
                &&(folderName!='Quotes Expired Internal')
                &&(folderName!='Quotes Expired Dealer Owned')}">
        <div class="accordion-header contentPane">
            <spring:message code="title.common.comments" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
    	<div class="labelStyle floatL">
    		<spring:message code="label.quote.notesForDealer" />:
    	</div>
    	<div class="floatL">
    		<textarea max-length rows="4" cols="500" class="wid500" data-ng-model="activeAudit.notesForDealer"  ng-required="task.takenTransition=='Denied'"  id="customerNotes1" ></textarea>
    	</div>
    	
    	<div class="clear"></div>
    	
    	<div class="labelStyle floatL">
    		<spring:message code="label.quote.notesForNMHG" />:
    	</div>
    	<div class="floatL">
    		<textarea max-length
    			data-ng-model="activeAudit.notesForNMHG"
    			rows="4" cols="500" class="wid500" id="customerNotes2"></textarea>
    	</div>
    	</div>
    </c:if>
</div>
<div ng-show="isInternalUserOrOwningDealer">
    <c:if test="${(folderName!='Quotes Accepted')
                &&(folderName!='Quotes Sent For Revision')
                &&(folderName!='Quotes Reverted')
                &&(folderName!='Quotes Rejected')
                &&(folderName!='Quotes Expired')
                &&(folderName!='Quotes Accepted Internal')
                &&(folderName!='Quotes Accepted Dealer Owned')
                &&(folderName!='Quotes Reverted Dealer Owned')
                &&(folderName!='Quotes Reverted Internal')
                &&(folderName!='Quotes Rejected Internal')
                &&(folderName!='Quotes Rejected Dealer Owned')
                &&(folderName!='Quotes Expired Internal')
                &&(folderName!='Quotes Expired Dealer Owned')}">
        <div class="accordion-header contentPane">
            <spring:message code="title.common.comments" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
        <div class="labelStyle floatL">
            <spring:message code="label.common.internalComments" />:
        </div>
        <div class="floatL">
            <textarea max-length rows="4" cols="500" class="wid500" data-ng-model="activeAudit.internalComments" ng-required="task.takenTransition=='Transfer'"></textarea>
        </div>
        
        <div class="clear"></div>
        
        <div class="labelStyle floatL">
            <spring:message code="label.quote.notesForDealer" />:
        </div>
        <div class="floatL">
            <textarea max-length rows="4" cols="500" class="wid500" data-ng-model="activeAudit.notesForDealer" ng-required="task.takenTransition=='Service Specialist Denied' || task.takenTransition=='Quote Denied By Specialist' || task.takenTransition=='Service Specialist Sent For RequestRevision'"></textarea>
        </div>
        
        <div class="clear"></div>
        
        <div class="labelStyle floatL">
            <spring:message code="label.quote.notesForCustomer" />:
        </div>
        <div class="floatL">
            <textarea max-length value=""
                data-ng-model="activeAudit.notesForCustomer"
                rows="4" cols="500" class="wid500"></textarea>
        </div>
         <div class="clear"></div>
       </div> 
    </c:if>
</div>
</div> 


