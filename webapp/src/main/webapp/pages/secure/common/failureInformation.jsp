<%@taglib prefix="authz" uri="authz"%>
<div>
	<div>
		 <div class="labelStyle floatL">
			<spring:message code="label.quote.causalPartNumber" />
		</div>
		 <div class="floatL" data-ng-init="URL=module=='quote'?'listCausalPartNumbers?id=':'listCausalPartNumbersForClaim?brand='">
			<INPUT TYPE="text"  url="{{URL}}{{moduleId}}" data-ng-readonly="isReadOnly()"
                data-ng-model="activeAudit.serviceInformation.causalPart.itemNumber" fbs-typeahead ng-change="causalPartDescription(activeAudit.serviceInformation.causalPart.itemNumber)"  />
		</div>
		<div class="fieldSpacerWidth" style="float: left;">&nbsp;</div>
		 <div class="labelStyle floatL">
			<spring:message code="label.quote.causalPartDescription" />
		</div>
		 <div class="floatL">
			<div data-ng-model="activeAudit.serviceInformation.causalPart.item.description" 
                data-ng-bind="activeAudit.serviceInformation.causalPart.item.description"></div>
		</div>
	</div>
   <div class="fieldSpacerHeight" style="clear: both;"></div>
	 <div>
		 <div class="labelStyle floatL" ng-show="!isReadOnly()">
			<a data-ng-click="listFaultCodes(equipment.id,activeAudit.serviceInformation.causalPart.item.id)"><spring:message code="label.quote.faultCode" /></a>
		</div>
        <div class="labelStyle floatL" ng-show="isReadOnly()">
            <spring:message code="label.quote.faultCode" />
        </div>
		 <div class="floatL wid223">&nbsp;<span>{{activeAudit.serviceInformation.faultCode}}</span></div>
		 <div class="fieldSpacerWidth" style="float: left;">&nbsp;</div>
			<div class="labelStyle floatL"><spring:message code="label.quote.componentCode"/>
			 <span  ng-show="!servicingDealer" class="red">*</span>
			 </div>
		<div class="hgt28 floatL">
		<select  data-ng-model="activeAudit.serviceInformation.componentCode.id" data-ng-disabled="isReadOnly()"
			 ng-options="componentCode.id as componentCode.name for componentCode in componentCodes"   class="wid223 hgt26" data-ng-required="!servicingDealer && !isReadOnly()">
			    <option value="">
                    <spring:message code="label.serviceRequest.select" />
                </option>
                     </select>
	    </div>
   </div>
   <div class="clear"></div>
	 <div>
		 <div class="labelStyle floatL">
			<spring:message code="label.quote.faultFound" />
			 <span ng-show="!servicingDealer" class="red">*</span>
		</div>
		 <div class="floatL">
			<select   data-ng-model="activeAudit.serviceInformation.faultFound.id" data-ng-disabled="isReadOnly()"
			 ng-options="faultFound.key as faultFound.label for faultFound in faultFoundList" style="width: 223px; height: 26px;" data-ng-change="listCausedBy(activeAudit.serviceInformation.faultFound.id,equipment.id)" data-ng-required="!servicingDealer && !isReadOnly()">
			  <option value="">
                    <spring:message code="label.serviceRequest.select" />
                </option>
			 </select>
		</div>
		<div class="fieldSpacerWidth" style="float: left;">&nbsp;</div>
		 <div class="labelStyle floatL">
			<spring:message code="label.quote.causedBy" />
			 <span class="red" ng-show="!servicingDealer">*</span>
		</div>
		 <div class="floatL">
			<select data-ng-model="activeAudit.serviceInformation.causedBy.id" data-ng-disabled="isReadOnly()"   ng-options="causedBy.key as causedBy.label for causedBy in causedByList" style="width: 223px; height: 26px;" data-ng-required="!servicingDealer && !isReadOnly()">
			 <option value="">
                    <spring:message code="label.serviceRequest.select" />
                </option>
			</select>
		</div>
	</div> 
       <div>
            <div class="labelStyle floatL">
                <spring:message code="label.quote.problemReported" />
                <span class="red">*</span>
            </div>
             <div class=" floatL">
                <textarea max-length rows="4" cols="500" class="wid500" data-ng-readonly="isReadOnly()" data-ng-model="activeAudit.problemReported" ng-required="true"
                    ></textarea>
            </div>

            <div class="clear"></div>

            <div class="labelStyle floatL">
                <spring:message code="label.quote.conditionFound" />
                <span class="red">*</span>
            </div>
             <div class=" floatL">
                <textarea max-length rows="4" cols="500" class="wid500" data-ng-readonly="isReadOnly()" data-ng-model="activeAudit.conditionFound" ng-required="true"
                    ></textarea>
            </div>

            <div class="clear"></div>

            <div class="labelStyle floatL" ng-show="module=='claim'">
                <spring:message code="label.quote.workPerformed" />
                <span class="red">*</span>
            </div>
            <div class="labelStyle floatL" ng-show="module=='quote'">
                <spring:message code="label.quote.workToBePerformed" />
                <span class="red">*</span>
            </div>
             <div class=" floatL">
                <textarea max-length rows="4" cols="500" class="wid500" data-ng-readonly="isReadOnly()" data-ng-model="activeAudit.workPerformed" ng-required="true"
                    ></textarea>
            </div>
        </div>
</div>
 <div popup="showFaultLocationTree" close="closePopup()">
	<div class="modal-header">
		<center>
			<h6>
				<spring:message code="label.quote.faultCode" />
			</h6>
		</center>
	</div>
	<div class="modal-body">
		<center>
			<div ng-show='selectCausalPart'>
				<spring:message code="label.quote.selectCausalPart" />
			</div>
			<div ng-show='selectSerialNumber'>
				<spring:message code="label.quote.selectSerialNumber" />
			</div>
	<div ng-show='showFaultCodeTree'>
    <ui-tree ng-model="assets" load-fn="loadChildren" expand-to="hierarchy" selected-id="(activeAudit.serviceInformation.faultCodeRef!=null)?activeAudit.serviceInformation.faultCodeRef.id:'111'" attr-node-id="id"></ui-tree>
	</div>
	</center>
	<div class="fieldSpacerHeight" style="clear: both;"></div>
	<div class="fieldSpacerHeight" style="clear: both;"></div>
	<center>
		<div ng-show='showFaultCodeTree'>
			<button type="button" class="blue-btn" ng-click="addtoFaultCodes()">
				<spring:message code="label.common.ok" />
			</button>
			<button type="button" class="blue-btn" ng-click="closePopup()">
				<spring:message code="label.Common.close" />
			</button>
		</div>
		<div ng-show='selectCausalPart'>
			<button type="button" class="blue-btn" ng-click="closePopup()">
				<spring:message code="label.common.ok" />
			</button>
		</div>
		<div ng-show='selectSerialNumber'>
			<button type="button" class="blue-btn" ng-click="closePopup()">
				<spring:message code="label.common.ok" />
			</button>
		</div>

	</center>
</div>
</div>