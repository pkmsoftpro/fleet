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
	        <spring:message code="label.dealerShip.dealerNumber" /> : 
	    </div>
	    <div class="floatL">
	        <input type="text" data-ng-model="dealerShip.serviceProviderNumber" data-ng-required="true" data-ng-readonly="true"/>
	    </div>
	    
		<div class="labelStyle floatL">
	        <spring:message code="label.dealerShip.name" /> : 
	    </div>
	    <div class="floatL">
	        <input type="text" data-ng-model="dealerShip.name" data-ng-required="true" data-ng-readonly="true"/>
	    </div>
	    
		<div class="labelStyle floatL">
	        <spring:message code="label.dealerShip.preferredCurrency" /> : 
	    </div>
	    <div class="floatL">
	        <select id="preferredCurrency" data-ng-model="dealerShip.preferredCurrency" data-ng-options="currency for currency in masterdata.currencies" data-ng-required='true' data-ng-readonly="true">
	        </select>
	    </div>
	    
		<div class="labelStyle floatL">
	        <spring:message code="label.dealerShip.contactPersonName" /> : 
	    </div>
	    <div class="floatL">
	        <input type="text" data-ng-model="dealerShip.address.contactPersonName" data-ng-readonly="true"/>
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
	    	<spring:message code="label.common.city" /> : 
	    </div>
		<div class="floatL">
			<input type="text" data-ng-model="dealerShip.address.city" data-ng-required='true' data-ng-readonly="true" /> 
		</div>    
		
		<div class="labelStyle floatL">
	    	<spring:message code="label.common.country" /> : 
	    </div>
		<div class="floatL">
			<select id="countryId" data-ng-model="dealerShip.address.country" data-ng-options="country for country in masterdata.countries" data-ng-required='true' data-ng-readonly="true"></select>
		</div>
	
		<div class="labelStyle floatL">
	        <spring:message code="label.common.postal/ZipCode" /> : 
	    </div>
	     <div class="floatL">
	         <input type="text" data-ng-model="dealerShip.address.zipCode" data-ng-required="true" data-ng-readonly="true"/>
	     </div>
	        	
		<div class="labelStyle floatL">
	    	<spring:message code="label.common.state" /> : 
	    </div>
		<div class="floatL">
			<select data-ng-model="dealerShip.address.state" data-ng-options="state for state in masterdata.states" data-ng-required='true' data-ng-readonly="true"></select>
		</div>
		
		<div class="labelStyle floatL">
	            <spring:message code="label.common.addressLine1" /> : 
	    </div>
	    <div class="floatL">
	        <input type="text" data-ng-model="dealerShip.address.addressLine1" data-ng-required='true' data-ng-readonly="true" />
	    </div>
	    
	    <div class="labelStyle floatL">
	        <spring:message code="label.common.addressLine2" />:
	    </div>
	    <div class="floatL">
	        <input type="text" data-ng-model="dealerShip.address.addressLine2" data-ng-readonly="true"/>
	    </div>
	
	    <div class="labelStyle floatL">
	       <spring:message code="label.common.zipExt" />:
	   </div>
	   <div class="floatL">
	       <input type="text" data-ng-model="dealerShip.address.zipcodeExtension" data-ng-readonly="true" />
	   </div>
	   
	   <div class="labelStyle floatL">
	       <spring:message code="label.common.phone" /> :
	   </div>
	   <div class="floatL">
	       <input type="text" data-ng-model="dealerShip.address.phone" data-ng-readonly="true" />
	   </div>
	
		<div class="labelStyle floatL">
			<spring:message code="label.common.phoneExt" />:
		</div>
		<div class="floatL">
		    <input type="text" data-ng-model="dealerShip.address.phoneExt" data-ng-readonly="true" />
		</div>
		
		<div class="labelStyle floatL">
		    <spring:message code="label.common.fax" /> :
		</div>
		<div class="floatL">
		    <input type="text" data-ng-model="dealerShip.address.fax" data-ng-readonly="true" />
		</div>
	
		<div class="labelStyle floatL">
		    <spring:message code="label.common.faxExt" /> :
		</div>
		<div class="floatL">
		    <input type="text" data-ng-model="dealerShip.address.faxExt" data-ng-readonly="true" />
		</div>
		
		<div class="labelStyle floatL">
	    	<spring:message code="label.common.email" />:
	    </div>
	    <div class="floatL">
	        <input type="text" data-ng-model="dealerShip.address.email" data-ng-readonly="true"/>
	    </div>
	</div>    

</div>

<div class="heigthBu clear"></div>
<div class="heigthBu clear"></div>
<div class="heigthBu clear"></div>
<div class="heigthBu clear"></div>
																															<!-- BUTTON SECTION  -->
<div class="text-center">
	<button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
       <spring:message code="label.Common.close" />
     </button>
</div>

