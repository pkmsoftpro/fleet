<%@taglib prefix="authz" uri="authz"%>
<div>
	<div>
		 <div class="labelStyle floatL">
			<spring:message code="label.quote.causalPartNumber" />
		</div>
		 <div class="floatL">
			<INPUT TYPE="text" 
                data-ng-readonly="true" data-ng-model="activeAudit.serviceInformation.causalPart.itemNumber"/>
		</div>
		<div class="fieldSpacerWidth" style="float: left;">&nbsp;</div>
		 <div class="labelStyle floatL">
			<spring:message code="label.quote.causalPartDescription" />
		</div>
		 <div class="floatL">
			<div>{{activeAudit.serviceInformation.causalPart.item.description}}</div>
		</div>
	</div>
  <div class="clear"></div>
	 <div>
		 <div class="labelStyle floatL">
            <spring:message code="label.quote.faultCode" />
		</div>
		 <div class="floatL wid222">&nbsp;<span>{{activeAudit.serviceInformation.faultCode}}</span></div>
		 <div class="fieldSpacerWidth" style="float: left;">&nbsp;</div>
		<div class="labelStyle floatL"  style="padding-left: 22px;"><spring:message code="label.quote.componentCode"/></div>
		<div class="hgt28 floatL">
		<INPUT TYPE="text" data-ng-model="activeAudit.serviceInformation.componentCode.name" disabled="disabled" /></div>
   </div>
  <div class="clear"></div>
	 <div>
		 <div class="labelStyle floatL">
			<spring:message code="label.quote.faultFound" />
		</div>
		 <div class="floatL">
			<INPUT TYPE="text"  disabled="disabled" data-ng-model="activeAudit.serviceInformation.faultFound.name"/>
		</div>
		<div class="fieldSpacerWidth" style="float: left;">&nbsp;</div>
		 <div class="labelStyle floatL">
			<spring:message code="label.quote.causedBy" />
		</div>
		 <div class="floatL">
			<INPUT TYPE="text" disabled="disabled" data-ng-model="activeAudit.serviceInformation.causedBy.name" />
			
		</div>
	</div>

	<div>
		<div class="labelStyle floatL">
			<spring:message code="label.quote.problemReported" />
		</div>
		<div class=" floatL">
			<textarea data-ng-readonly="true" max-length rows="4" cols="500"class="wid500" data-ng-model="activeAudit.problemReported"></textarea>
		</div>

		<div class="clear"></div>

		<div class="labelStyle floatL">
			<spring:message code="label.quote.conditionFound" />
		</div>
		<div class=" floatL">
			<textarea data-ng-readonly="true" max-length rows="4" cols="500"class="wid500" data-ng-model="activeAudit.conditionFound"></textarea>
		</div>

		<div class="clear"></div>


		<div class="labelStyle floatL" ng-show="module=='claim'">
			<spring:message code="label.quote.workPerformed" />
		</div>
		<div class="labelStyle floatL" ng-show="module=='quote'">
			<spring:message code="label.quote.workToBePerformed" />
		</div>
		<div class=" floatL">
			<textarea data-ng-readonly="true" max-length rows="4" cols="500"class="wid500" data-ng-model="activeAudit.workPerformed"></textarea>
		</div>
	</div>

</div>
