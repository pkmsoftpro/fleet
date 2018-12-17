
<div>
<div data-ng-repeat="claimAdditionalAttributes in fleetClaim.claimAdditionalAttributes">
        	<div class="labelStyle floatL">
					{{claimAdditionalAttributes.attributes.attributeName}} <span>:</span>
					<span ng-show="claimAdditionalAttributes.attributes.mandatory" style="color:red;">*</span>
			</div>	
    		
        		<div ng-if="claimAdditionalAttributes.attributes.attributeType=='Text'">
           			<div class="floatL">
                		<input class="labelStyle floatL" ng-disabled="true"  type="text" data-ng-model="claimAdditionalAttributes.attrValue" ng-required="claimAdditionalAttributes.attributes.mandatory" />
            		</div>
            		<div class="fieldSpacerWidth floatL">&nbsp;</div>
            	</div >
        		<div ng-if="claimAdditionalAttributes.attributes.attributeType=='Text Area'">
           			<div class="floatL">
                		<textarea ng-disabled="true"  max-length rows="4" cols="500" class="wid200" data-ng-model="claimAdditionalAttributes.attrValue" ng-required="claimAdditionalAttributes.attributes.mandatory" ></textarea>
            		</div>
            		<div class="fieldSpacerWidth floatL">&nbsp;</div>
       			</div>
        		<div ng-if="claimAdditionalAttributes.attributes.attributeType=='Number'">
           			<div class="floatL">
						<input ng-disabled="true" class="labelStyle floatL"  type="text"  data-ng-model="claimAdditionalAttributes.attrValue"  numbers-only="numbers-only" ng-required="claimAdditionalAttributes.attributes.mandatory" />
            		</div>
            		<div class="fieldSpacerWidth floatL">&nbsp;</div>
        		</div>
        		<div ng-if="claimAdditionalAttributes.attributes.attributeType=='Date'">
           		    <div class="floatL">
					    <input  type="text" ng-disabled="true" datepicker-popup={{dateFormat}}  class="wid200" min="minDate"  data-ng-model="claimAdditionalAttributes.attrValue" ng-required="claimAdditionalAttributes.attributes.mandatory"  />
            	    </div>
            	    <div class="fieldSpacerWidth floatL">&nbsp;</div>
        		</div>
                <div ng-if="claimAdditionalAttributes.attributes.attributeType=='Single Select'">
                    <div class="floatL">
                        <input ng-disabled="true" class="labelStyle floatL"  type="text" data-ng-model="claimAdditionalAttributes.attrValue"/>
                       
                    </div>
                </div>		       
    </div>
  </div>

