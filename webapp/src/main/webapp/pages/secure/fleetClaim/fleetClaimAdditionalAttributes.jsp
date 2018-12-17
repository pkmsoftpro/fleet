
<div>
<div data-ng-repeat="claimAdditionalAttributes in fleetClaim.claimAdditionalAttributes">
        	<div class="labelStyle floatL">
					{{claimAdditionalAttributes.attributes.attributeName}} <span>:</span>
					<span ng-show="claimAdditionalAttributes.attributes.mandatory" style="color:red;">*</span>
			</div>	
    		
        		<div ng-if="claimAdditionalAttributes.attributes.attributeType=='Text'">
           			<div class="floatL">
                		<input class="floatL"   type="text" data-ng-model="claimAdditionalAttributes.attrValue" ng-required="claimAdditionalAttributes.attributes.mandatory" />
            		</div>
            	</div >
        		<div ng-if="claimAdditionalAttributes.attributes.attributeType=='Text Area'">
           			<div>
                		<textarea  max-length rows="4"  data-ng-model="claimAdditionalAttributes.attrValue" ng-required="claimAdditionalAttributes.attributes.mandatory" ></textarea>
            		</div>
       			</div>
        		<div ng-if="claimAdditionalAttributes.attributes.attributeType=='Number'">
           			<div class="floatL">
						<input class=" floatL"  type="text"  data-ng-model="claimAdditionalAttributes.attrValue"  numbers-only="numbers-only" ng-required="claimAdditionalAttributes.attributes.mandatory" />
            		</div>
        		</div>
        		<div ng-if="claimAdditionalAttributes.attributes.attributeType=='Date'">
           		    <div class="floatL">
					    <input  type="text"  datepicker-popup={{dateFormat}}  min="minDate"  data-ng-model="claimAdditionalAttributes.attrValue" ng-required="claimAdditionalAttributes.attributes.mandatory"  />
            	    </div>
        		</div>
                <div ng-if="claimAdditionalAttributes.attributes.attributeType=='Single Select'">
                    <div class="floatL">
                        <select class=" floatL" data-ng-model="claimAdditionalAttributes.attrValue"  class="dropdown-normal" ng-options="obj for obj in getSingleSelectOptions($index)">
                        </select>
                    </div>
                </div>
                		       
    </div>
  </div>

