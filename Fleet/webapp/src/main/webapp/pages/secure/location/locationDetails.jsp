
<div ng-repeat= "billTo in customerLocation.customer.customerBillTos">
              <div ng-if='!isDealerOwned'>
            <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.customerBillTo" />
                {{$index+1}}:
            </div>
            </div>
             <div ng-if='isDealerOwned'>
             <div class="customerLabelStyle floatL">
                <spring:message code="label.customer.customerBillTo" />
            </div>
             </div>
           <div class="floatL">
                <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="billTo.customerNumber" />
            </div>
</div>
<div class="fieldSpacerWidth floatL">&nbsp;</div>

<div class="clear"></div>

<div class="customerLabelStyle floatL">
    <spring:message code="label.customer.customerName" />
    :
</div>
<div class="floatL">
    <input type="text" data-ng-readonly="true" data-ng-model="customerLocation.customerName">
</div>

<div class="fieldSpacerWidth floatL">&nbsp;</div>
<div class="customerLabelStyle floatL">
    <spring:message code="label.customer.status" />
    :
</div>

<div class="floatL">
    <input type="text" data-ng-readonly="true" data-ng-model="customerLocation.displayStatus">
</div>

<div class="clear"></div>

<div class="customerLabelStyle floatL">
    <spring:message code="search.customerLocation.shipTo" />
    :
</div>
<div class="floatL">
    <input type="text" data-ng-readonly="true" data-ng-model="customerLocation.code">
</div>
<div class="fieldSpacerWidth floatL">&nbsp;</div>

<div class="customerLabelStyle floatL">
    <spring:message code="search.customerLocation.locationName" />
    :
</div>
<div class="floatL">
    <input type="text" data-ng-readonly="true" data-ng-model="customerLocation.name">
</div>

<div class="clear"></div>

<div class="sectionSpacerHeight clear"></div>
<!-- <div>
    <span class="subSection"><spring:message code="label.customer.physicalAddress" /> </span> <span class="subSection" style="margin-left: 340px"><spring:message
            code="label.customer.billingAddress" /> </span>
</div> -->
    <div class="details-sub-header"><span><spring:message code="label.customer.billingAddress"/></span></div>
<div class="sectionSpacerHeight clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.common.city" /> : 
        <span  ng-if='isMandatory()'>
    		 <span class="red">*</span>
     	</span >
    </div>
    <div class="floatL">
        <input type="text" data-ng-model="customerLocation.address.city" data-ng-required='isMandatory()'>
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>

    <div class="customerLabelStyle floatL">
        <spring:message code="label.common.country" />
        :
         <span  ng-if='isMandatory()'>
         <span class="red">*</span>
         </span >
    </div>
    <div class="floatL">
        <!-- <input type="text" data-ng-model="customerLocation.address.country"> -->
        <select id="country" data-ng-model="customerLocation.address.country" ng-options="c for c in countries" data-ng-required='isMandatory()'>
        </select>
    </div>
</div>

<div class="clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.common.postal/ZipCode" /> :
        <span  ng-if='isMandatory()'>
    		 <span class="red">*</span>
     	</span >
    </div>
    <div class="floatL">
        <input type="text" data-ng-model="customerLocation.address.zipCode" data-ng-required='isMandatory()'>
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>

    <div class="customerLabelStyle floatL">
        <spring:message code="label.common.state" />
        :
     <span  ng-if='isMandatory()'>
    	 <span class="red">*</span>
     </span >
    </div>
    <div class="floatL">
        <!-- <input type="text" data-ng-model="customerLocation.address.state"> -->
        <select id="state" data-ng-model="customerLocation.address.state" ng-options="c for c in states" data-ng-required='isMandatory()'>
        </select>
    </div>
</div>
<div class="clear"></div>
<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.common.addressLine1" /> :
        <span  ng-if='isMandatory()'>
    		 <span class="red">*</span>
     	</span > 
    </div>
    <div class="floatL">
        <input type="text" data-ng-model="customerLocation.address.addressLine1" data-ng-required='isMandatory()'>
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.common.addressLine2" />
        :
    </div>
    <div class="floatL">
        <input type="text" data-ng-model="customerLocation.address.addressLine2">
    </div>
    <div class="clear"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.zipExt" />:
        </div>
       <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customerLocation.address.zipcodeExtension">
        </div>
        <div class="fieldSpacerWidth floatL">&nbsp;</div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.phone" />:
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customerLocation.address.phone">
        </div>
       
    <div class="clear"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.phoneExt" />:
        </div>
       <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customerLocation.address.phoneExt">
        </div>
        <div class="fieldSpacerWidth floatL">&nbsp;</div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.fax" />:
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customerLocation.address.fax">
        </div>
        
     <div class="clear"></div>

        <%-- <div class="customerLabelStyle floatL">
            <spring:message code="label.common.faxExt" />:
        </div>
       <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customerLocation.address.faxExt">
        </div> 
        <div class="fieldSpacerWidth floatL">&nbsp;</div>--%> 
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.email" />:
        </div>
       <div class="floatL">
            <INPUT TYPE="text" data-ng-model="customerLocation.address.email">
        </div>
</div>

<div class="clear"></div>
    <div class="details-sub-header"><span><spring:message code="label.customer.physicalAddress"/></span></div>
<div class="clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.common.city" />
        : <span class="red">*</span>
    </div>
    <div class="floatL">
        <input type="text" data-ng-readonly="isReadOnly()" data-ng-model="customerLocation.physicalAddress.city" data-ng-required="!isReadOnly()" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.common.country" />
        : <span class="red">*</span>
    </div>
    <div class="floatL">
        <div data-ng-show="isReadOnly()">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customerLocation.physicalAddress.country">
        </div>
        <div data-ng-hide="isReadOnly()">
            <select id="locationBillingCountry" data-ng-model="customerLocation.physicalAddress.country" ng-options="c for c in countries"
                data-ng-readonly="isReadOnly()" data-ng-required="!isReadOnly()">
            </select>
        </div>
    </div>
</div>

<div class="clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.common.postal/ZipCode" />
        : <span class="red">*</span>
    </div>
    <div class="floatL">
        <input type="text" data-ng-readonly="isReadOnly()" data-ng-model="customerLocation.physicalAddress.zipCode" data-ng-required="!isReadOnly()" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.common.state" />
        : <span class="red">*</span>
    </div>
    <div class="floatL">
        <div data-ng-show="isReadOnly()">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customerLocation.physicalAddress.state">
        </div>
        <div data-ng-hide="isReadOnly()">
            <select id="locationBillingState" data-ng-model="customerLocation.physicalAddress.state" ng-options="c for c in billingStates"  data-ng-required="!isReadOnly()">
            </select>
        </div>
    </div>
</div>

<div class="clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.common.addressLine1" />
        : <span class="red">*</span>
    </div>
    <div class="floatL">
        <input type="text" data-ng-readonly="isReadOnly()" data-ng-model="customerLocation.physicalAddress.addressLine1" data-ng-required="!isReadOnly()"/>
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.common.addressLine2" />
        :
    </div>
    <div class="floatL">
        <input type="text" data-ng-readonly="isReadOnly()" data-ng-model="customerLocation.physicalAddress.addressLine2">
    </div>
    <div class="clear"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.zipExt" />:
        </div>
       <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customerLocation.physicalAddress.zipcodeExtension">
        </div>
        <div class="fieldSpacerWidth floatL">&nbsp;</div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.phone" />:
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customerLocation.physicalAddress.phone">
        </div>
       
    <div class="clear"></div>

        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.phoneExt" />:
        </div>
       <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customerLocation.physicalAddress.phoneExt">
        </div>
        <div class="fieldSpacerWidth floatL">&nbsp;</div>
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.fax" />:
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customerLocation.physicalAddress.fax">
        </div>
        
     <div class="clear"></div>

        <%-- <div class="customerLabelStyle floatL">
            <spring:message code="label.common.faxExt" />:
        </div>
       <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customerLocation.physicalAddress.faxExt">
        </div> 
        <div class="fieldSpacerWidth floatL">&nbsp;</div>--%> 
        <div class="customerLabelStyle floatL">
            <spring:message code="label.common.email" />:
        </div>
       <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="isReadOnly()" data-ng-model="customerLocation.physicalAddress.email">
        </div>
</div>


<div class="sectionSpacerHeight clear"></div>
    <div class="details-sub-header"><span><spring:message code="title.common.quoteClaimBehaviour"/></span></div>
<div class="sectionSpacerHeight clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.quoteThresholdAmount" />
        :
    </div>
    <div class="floatL">
        <INPUT TYPE="text" data-ng-model="customerLocation.quoteThreshold" money/>
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.dealerQuoteVariance" />
        : <span ng-if="customerLocation.varianceInPercentage==false"> {{customerLocation.preferredCurrency}}
        </span>
        <div class="floatL">
            <spring:message code="label.customerLocation.inPercentage" />
            <spring:message code="label.common.yes" />
            <input type="radio" data-ng-model="customerLocation.varianceInPercentage" data-ng-value="true" ng-boolean-radio />
            <spring:message code="label.common.no" />
            <input type="radio" data-ng-model="customerLocation.varianceInPercentage" data-ng-value="false" ng-boolean-radio  />
        </div>
    </div>
    <div class="floatL">
        <INPUT TYPE="text" data-ng-model="customerLocation.dealerQuoteVariance" ng-change="calculateDealerThresholdAmount()" is-number>
        <span
            ng-if="customerLocation.varianceInPercentage==true"> <spring:message code="label.common.percentage" />
        </span>
    </div>
</div>

<div class="clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.calculatedDealerThresholdAmount" />
        :
        {{customerLocation.preferredCurrency}}
    </div>
    <div class="floatL" ng-show="customerLocation.varianceInPercentage==true">
        <INPUT TYPE="text" data-ng-value="customerLocation.quoteThreshold.amount - ((customerLocation.quoteThreshold.amount * (-customerLocation.dealerQuoteVariance)) / 100)|number:2" data-ng-readonly="true" />
    </div> 
    
    <div class="floatL" ng-show="customerLocation.varianceInPercentage==false">
        <INPUT TYPE="text" data-ng-value="customerLocation.quoteThreshold.amount - (-customerLocation.dealerQuoteVariance)|number:2" data-ng-readonly="true" />
    </div>
    <div class="fieldSpacerWidth">&nbsp;</div>
</div>

<div class="sectionSpacerHeight clear"></div>

    <div class="details-sub-header"><span><spring:message code="title.common.serviceRequestBehaviour"/></span></div>
<div class="sectionSpacerHeight clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.dealerCreateServiceRequest" />
    </div>
    <div class="floatL">
        <spring:message code="label.common.yes" />
        <input type="radio" data-ng-model="customerLocation.createServiceRequest" data-ng-value="true">
        <spring:message code="label.common.no" />
        <input type="radio" data-ng-model="customerLocation.createServiceRequest" data-ng-value="false">
    </div>

    <div class="radiobuttonSpacing floatL wid160">&nbsp;</div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.serviceCall" />
        <span ng-if="customerLocation.periodicServiceCall==true"><span class="red">*</span></span>
    </div>
    <div class="floatL">
        <spring:message code="label.common.yes" />
        <input type="radio" data-ng-model="customerLocation.periodicServiceCall" data-ng-value="true" ng-boolean-radio />
        <spring:message code="label.common.no" />
        <input type="radio" data-ng-model="customerLocation.periodicServiceCall" data-ng-value="false" ng-change="specifyingValues()" ng-boolean-radio />
        <span ng-if="customerLocation.periodicServiceCall==true"><INPUT class="cellInputStyle" TYPE="text"
            data-ng-model="customerLocation.numberOfDays" tooltip="<spring:message code="toolTip.periodicServiceCall" />" tooltip-placement="right"
            tooltip-animation="false"  data-ng-required="customerLocation.periodicServiceCall==true" numbers-only/>
        </span>
    </div>
</div>

<div class="sectionSpacerHeight clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.ETA-On-ServiceRequest" />
    </div>
    <div class="floatL">
        <input type="checkbox" ng-model="customerLocation.etaOnServiceRequest">
    </div>
    <div class="radiobuttonSpacing floatL wid212">&nbsp;</div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.Self-Diagnosis" />
    </div>
    <div class="floatL">
        <spring:message code="label.common.yes" />
        <input type="radio" data-ng-model="customerLocation.selfDiagonosisEnabled" data-ng-value="true" ng-boolean-radio />
        <spring:message code="label.common.no" />
        <input type="radio" data-ng-model="customerLocation.selfDiagonosisEnabled" data-ng-value="false" ng-boolean-radio />
    </div>
</div> 

<div class="sectionSpacerHeight clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.Self-DiagnosisMandatory" />
    </div>      
    <div class="floatL">
        <spring:message code="label.common.yes" />
        <input type="radio" data-ng-model="customerLocation.selfDiagnosisMandatory" data-ng-value="true" ng-boolean-radio ng-disabled="!customerLocation.selfDiagonosisEnabled" />
        <spring:message code="label.common.no" />
        <input type="radio" data-ng-model="customerLocation.selfDiagnosisMandatory" data-ng-value="false" ng-boolean-radio ng-disabled="!customerLocation.selfDiagonosisEnabled"/>
    </div>
</div>

<div class="sectionSpacerHeight clear"></div>
<div class="sectionSpacerHeight clear"></div>
    <div class="details-sub-header"><span><spring:message code="title.common.purchaseOrderConditions"/></span></div>
<div class="sectionSpacerHeight clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.purchaseOrderRequired" />
    </div>
    <div class="floatL">
        <spring:message code="label.common.yes" />
        <input type="radio" data-ng-model="customerLocation.purchaseOrderRequired" data-ng-value="true" ng-boolean-radio />
        <spring:message code="label.common.no" />
        <input type="radio" data-ng-model="customerLocation.purchaseOrderRequired" data-ng-value="false" ng-boolean-radio />
    </div>
    <div class="radiobuttonSpacing floatL">&nbsp;</div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.duplicatePONumbers" />
    </div>
    <div class="floatL">
        <spring:message code="label.common.yes" />
        <input type="radio" data-ng-model="customerLocation.duplicatePoNumberAllowed" data-ng-value="true" ng-boolean-radio />
        <spring:message code="label.common.no" />
        <input type="radio" data-ng-model="customerLocation.duplicatePoNumberAllowed" data-ng-value="false" ng-boolean-radio />
    </div>
</div>

<div class="sectionSpacerHeight clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.specifyPOLength" />
    </div>
    <div class="floatL">
        <spring:message code="label.common.yes" />
        <input type="radio" data-ng-model="customerLocation.poLengthSpecified" data-ng-value="true" ng-boolean-radio />
        <spring:message code="label.common.no" />
        <input type="radio" data-ng-model="customerLocation.poLengthSpecified" data-ng-value="false" ng-change="specifyingValues()" ng-boolean-radio />
    </div>
    <div class="radiobuttonSpacing floatL">&nbsp;</div>
    <div ng-if="customerLocation.poLengthSpecified==true">
        <div class="customerLabelStyle floatL">
            <spring:message code="label.customerLocation.purchaseOrderLength" />
            <span class="red">*</span>
        </div>
        <div class="marR109 floatL">
            <INPUT TYPE="text" max-length data-ng-model="customerLocation.purchaseOrderLength" numbers-only  ng-required="customerLocation.poLengthSpecified"/>
        </div>
    </div>
</div>

<div class="sectionSpacerHeight clear"></div>

<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.PORegularExpression" />
        :
    </div>
    <div class="floatL">
        <INPUT TYPE="text" data-ng-model="customerLocation.poRegularExpression" />
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
    <div class="customerLabelStyle floatL">
        <spring:message code="label.customerLocation.PODetails" />
        :
    </div>
    <div class="floatL">
        <textarea max-length data-ng-model="customerLocation.poDetails" rows="4" cols="500" class="wid205 hgt40"></textarea>
    </div>
</div>
<div class="sectionSpacerHeight clear"></div>
<div>
    <div class="customerLabelStyle floatL150">
		<a class="text-link" href="#" ng-click="showSampleRegExpPatterns()">
			<spring:message code="label.customerLocation.POpatterns" /> 
		</a>
</div>
 <div popup="addCustomerComments" close="close()">
        <div class="modal-header" ng-show="sampleRegExpPOPatterns">
          <center>
                <h6>
                    <spring:message code="label.customerLocation.setPattern" />
                </h6>
         </center>
        </div>
        <div class="modal-body">
            <div class="clear"></div>
             	<center>
            	 <h6>
            		<div align="left" class="customerLabelStyle floatR">
            		  <b><u>Pattern</u></b>
            		</div>
            	 	<div class="customerLabelStyle floatL">
					  <b><u>Search Criteria</u></b>
					</div>
            	 <div class="clear"></div></br>
            		<div align="left" class="customerLabelStyle floatL">
            			<spring:message code="label.customerLocation.startWith" />
            		</div>
            	 <div>^CA</div>
            	 <div class="clear"></div>
            	 	<div align="left" class="customerLabelStyle floatL">
            			<spring:message code="label.customerLocation.endWith" />
            		</div>
            	    <div>CA$</div>
            	 <div class="clear"></div>
            		<div align="left" class="customerLabelStyle floatL">
            		  <spring:message code="label.customerLocation.startWithCharacter" />
            		</div>
            	    <div>^\w</div>
            	 <div class="clear"></div>
            		<div align="left" class="customerLabelStyle floatL">
            		<spring:message code="label.customerLocation.startWithDigit" />
            		</div>
            	 	<div>^\d</div>
            	 <div class="clear"></div>
            	 	<div align="left" class="customerLabelStyle floatL">
            		<spring:message code="label.customerLocation.startWithAndEndWith" />
            		</div>
            		<div>^CA.*BD$</div>
            	<div class="clear"></div>
            	<div class="clear"></div></br></br>
            		<spring:message code="label.customerLocation.notes" />
            </h6>
                <div ng-show='sampleRegExpPOPatterns'>
                    <button type="button" class="blue-btn" ng-click="close()">
                        <spring:message code="label.serviceRequest.underWarranty.ok" />
                    </button>
                </div>
            </center>
        </div>
    </div>
</div>
<div class="sectionSpacerHeight clear"></div>
    <div class="details-sub-header"><span><spring:message code="title.common.serviceRequestStandardText"/></span></div>
<div class="sectionSpacerHeight clear"></div>


<div>
    <div class="customerLabelStyle floatL">
        <spring:message code="title.common.serviceRequestStandardText" />
        :
    </div>
    <div class="floatL">
        <textarea max-length data-ng-model="customerLocation.customerNotes" rows="4" cols="500" class="wid500"></textarea>
    </div>
    <div class="fieldSpacerWidth floatL">&nbsp;</div>
</div>

