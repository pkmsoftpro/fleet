<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div alert-msg></div>
<div class="accordion-header contentPane marT10">
    <spring:message code="title.common.dealershipdetail" />
    <span class="expand-collapse collapse-icon"></span>
</div>
																											<!-- GENERAL DETAILS SECTION  -->
<div class="overflow-hidden accordion-info">	
	<div>
		<div class="labelStyle floatL">
	        <spring:message code="label.dealerShip.dealerNumber" /> : <span class="red">*</span>
	    </div>
	    <div class="floatL">
	    	<input type="text" data-ng-model="dealerShip.serviceProviderNumber" data-ng-required="true"/>
	    </div>
	    
		<div class="labelStyle floatL">
	        <spring:message code="label.dealerShip.name" /> : <span class="red">*</span>
	    </div>
	    <div class="floatL">
	        <input type="text" data-ng-model="dealerShip.name" data-ng-required="true"/>
	    </div>
	    
		<div class="labelStyle floatL">
	        <spring:message code="label.dealerShip.preferredCurrency" /> : <span class="red">*</span>
	    </div>
	    <div class="floatL">
	        <select id="preferredCurrency" data-ng-model="dealerShip.preferredCurrency" data-ng-options="currency for currency in masterdata.currencies" data-ng-required='true'>
	        </select>
	    </div>
	    
		<div class="labelStyle floatL">
	        <spring:message code="label.dealerShip.contactPersonName" /> : 
	    </div>
	    <div class="floatL">
	        <input type="text" data-ng-model="dealerShip.address.contactPersonName" />
	    </div>
	</div>																				
																											<!-- ADDRESS DETAILS SECTION -->
	<div class="details-sub-header">
        <span>
        	<spring:message code="label.customer.physicalAddress" />
        </span>
    </div>

	<div>
	    <div class="labelStyle floatL">
	    	<spring:message code="label.common.city" /> : <span class="red">*</span>
	    </div>
		<div class="floatL">
			<input type="text" data-ng-model="dealerShip.address.city" data-ng-required='true'> 
		</div>    
		
		<div class="labelStyle floatL">
	    	<spring:message code="label.common.country" /> : <span class="red">*</span>
	    </div>
		<div class="floatL">
			<select id="countryId" data-ng-model="dealerShip.address.country" data-ng-options="country for country in masterdata.countries" data-ng-required='true'></select>
		</div>
	
		<div class="labelStyle floatL">
	        <spring:message code="label.common.postal/ZipCode" /> : <span class="red">*</span>
	    </div>
	     <div class="floatL">
	         <input type="text" data-ng-model="dealerShip.address.zipCode" data-ng-required="true">
	     </div>
	        	
		<div class="labelStyle floatL">
	    	<spring:message code="label.common.state" /> : <span class="red">*</span>
	    </div>
		<div class="floatL">
			<select data-ng-model="dealerShip.address.state" data-ng-options="state for state in masterdata.states" data-ng-required='true'></select>
		</div>
		
		<div class="labelStyle floatL">
	            <spring:message code="label.common.addressLine1" /> : <span class="red">*</span>
	    </div>
	    <div class="floatL">
	        <input type="text" data-ng-model="dealerShip.address.addressLine1" data-ng-required='true'>
	    </div>
	    
	    <div class="labelStyle floatL">
	        <spring:message code="label.common.addressLine2" />:
	    </div>
	    <div class="floatL">
	        <input type="text" data-ng-model="dealerShip.address.addressLine2">
	    </div>
	
	    <div class="labelStyle floatL">
	       <spring:message code="label.common.zipExt" />:
	   </div>
	   <div class="floatL">
	       <input type="text" data-ng-model="dealerShip.address.zipcodeExtension">
	   </div>
	   
	   <div class="labelStyle floatL">
	       <spring:message code="label.common.phone" /> :
	   </div>
	   <div class="floatL">
	       <input type="text" data-ng-model="dealerShip.address.phone">
	   </div>
	
		<div class="labelStyle floatL">
			<spring:message code="label.common.phoneExt" />:
		</div>
		<div class="floatL">
		    <input type="text" data-ng-model="dealerShip.address.phoneExt">
		</div>
		
		<div class="labelStyle floatL">
		    <spring:message code="label.common.fax" /> :
		</div>
		<div class="floatL">
		    <input type="text" data-ng-model="dealerShip.address.fax">
		</div>
	
		<div class="labelStyle floatL">
		    <spring:message code="label.common.faxExt" /> :
		</div>
		<div class="floatL">
		    <input type="text" data-ng-model="dealerShip.address.faxExt">
		</div>
		
		<div class="labelStyle floatL">
	    	<spring:message code="label.common.email" />:
	    </div>
	    <div class="floatL">
	        <input type="text" data-ng-model="dealerShip.address.email">
	    </div>
	</div>    

</div>

<div class="heigthBu clear"></div>
<div class="heigthBu clear"></div>
<div class="heigthBu clear"></div>
<div class="heigthBu clear"></div>
																															<!-- BUTTON SECTION  -->
<div class="text-center">
	<div data-ng-show="{{dealerShip.id==null}}">
        <button type="button" class="blue-btn btn-primary" data-ng-click="saveDealer()" data-ng-disabled='form.$invalid'>
            <spring:message code="label.common.save" />
        </button>
        
        <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
             <spring:message code="label.Common.cancel" />
         </button>
	</div>        
</div>

