<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div ng-show="troubleShootingInfo">
    <div class="labelStyle floatL">
        <spring:message code="label.serviceRequest.troubleShooting.finish" />
    </div>
    <div class="clear"></div>
     Error Code: {{result.errorCode.code}} 
     <div ng-show="errorCodeWarning">
      <div class="labelStyle floatL">
        <spring:message code="label.serviceRequest.troubleShooting.noErrorCode" />
    </div>
     </div>
      <div class="clear"></div>
    <div>
        <spring:message code="label.serviceRequest.troubleShooting.message" />
    </div>

    <div class="centerbutton">
        <button type="button" class="blue-btn" ng-click="selfDiagnosePrb()">
            <spring:message code="button.common.selfDiagnoseTheProblem" />
        </button>
        <button type="button" class="blue-btn" ng-click="submitServiceRequest()">
            <spring:message code="button.common.submitServiceRequest" />
        </button>
    </div>
</div>
<div ng-show="showFeedBack">
    <div class="labelStyle floatL">
        <spring:message code="label.serviceRequest.selfDiagnose.wasHelpful" />
    </div>
    <div class="floatL">
        <div class="floatL">
            <spring:message code="label.common.yes" />
            <input type="radio" ng-model="feedback" ng-value="true" ng-boolean-radio ng-init="feedback=false" />
            <spring:message code="label.common.no" />
            <input type="radio" ng-model="feedback" ng-value="false" ng-boolean-radio ng-init="feedback=false" />
        </div>


    </div>

    <div class="clear"></div>
    <div class="labelStyle floatL">
        <spring:message code="title.common.comments" />
    </div>

    <div class="floatL">
        <textarea name="feedback" max-length ng-model="selfDiagnosisfeedback" rows="4" class="width250"></textarea>
    </div>
    <div class="clear"></div>

    <div class="centerbutton" ng-show="submitServiceRequestSD==false">
        <button type="button" class="blue-btn" ng-click="closeSelfDiagnosis()" ng-disabled="disableNext">
            <spring:message code="label.common.submit" />
        </button>
    </div>
     <div class="centerbutton" ng-show="submitServiceRequestSD">
        <button type="button" class="blue-btn" ng-click="submitServiceRequestWithFeedBack()" ng-disabled="disableNext">
            <spring:message code="label.common.submit" />
        </button>
         <button type="button" class="blue-btn" ng-click="diagnoseAnother()" ng-disabled="disableNext">
            <spring:message code="label.serviceRequest.selfDiagnose.anotherOne" />
        </button>
    </div>
    
    
</div>

