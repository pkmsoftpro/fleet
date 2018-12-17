<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div ng-show="selfDiagnoseProcess">
<div class="labelStyle floatL">
    <spring:message code="label.serviceRequest.serialNumber" />
</div>
<div class="floatL">{{serviceRequest.forItem.serialNumber}}</div>
<div class="clear"></div>

<div class="labelStyle floatL">
    <spring:message code="label.serviceRequest.productDescription"/>
</div>
<div class="floatL">{{ serviceRequest.forItem.product.name}}</div>
<div class="clear"></div>
<div class="labelStyle floatL">
    <spring:message code="label.serviceRequest.modelNumber" />
</div>
<div class="floatL">{{ serviceRequest.forItem.model.name}}</div>
<div class="clear"></div>

<div ng-show="diagnosticGuideNotFound">
<spring:message code='label.common.diagnosticGuide.notAvailable'/>
</div>
<div ng-show="!diagnosticGuideNotFound">
<div class="labelStyle floatL">
    <spring:message code="label.serviceRequest.ErrorCode" />
</div>

<div class="floatL">
  <input type="text" data-ng-readonly="disableErrorCode" url="populateErrorCodesByProductId?productId={{serviceRequest.forItem.product.id}}" data-ng-model="selfDiagnosis.errorCode.code"  fbs-typeahead />
  </div>
   <div class="floatL">
                    <div ng-show='errorMsgForErrorCode' class="floatL">
                        <img src="../image/ui-ext/validation/alerts.gif" class="marT10" tooltip="<spring:message code='label.common.errorCode.invalid'/>" />
                    </div>  
                </div>

    <div class="labelStyle floatL">
        <spring:message code="label.serviceRequest.system" />
        <span class="red">*</span>
    </div>
    
    <div class="floatL marR20">
        <select ng-model="system"  data-ng-disabled="disableSelection" ng-options="diagnosticGuide.id as diagnosticGuide.name for diagnosticGuide in diagnosticGuides" class="dropdown-normal">
            <option value="">
                <spring:message code="label.serviceRequest.select" />
            </option>
        </select>

    </div>


<div class="clear"></div>

<div class="labelStyle floatL">
    <spring:message code="label.serviceRequest.subSystem" />
    <span class="red">*</span>
</div>
<div class="floatL marR20">
    <select ng-model="subSystem" data-ng-disabled="disableSelection" ng-options="subSystem.id as subSystem.name for subSystem in subSystemList" class="dropdown-normal">
        <option value="">
            <spring:message code="label.serviceRequest.select" />
        </option>
    </select>
</div>

<div class="clear"></div>

<div class="labelStyle floatL">
    <spring:message code="label.serviceRequest.symptom" />
    <span class="red">*</span>
</div>
<div class="floatL marR20">
    <select ng-model="symptom" data-ng-disabled="disableSelection" ng-options="symp.selfDiagnose.id  as  symp.symptom for symp in symptomList" class="dropdown-normal">
        <option value="">
            <spring:message code="label.serviceRequest.select" />
        </option>
    </select>
</div>
<div class="clear"></div>
<br>
<br>
<div class="centerbutton">
    <button type="button" class="blue-btn" ng-click="findSelfDiagnose()" ng-disabled="disableSubmit">
        <spring:message code="label.common.submit" />
    </button>

    <button type="button" class="blue-btn" ng-click="selfDiagnoseWindow=false">
        <spring:message code="button.common.abort" />
    </button>
</div>
</div>
</div>

<!-- first question -->
<div class="borderforSelfDiagnosisTop" ng-show="showQuesAnsOne">
<div class="borderforSelfDiagnosisQuestion" >
    {{selfDiagnosequestionOne.description}}
    <div ng-repeat="ans in answersOne">
        <input type="radio"   ng-model="$parent.questionone" value="{{ans}}" ng-click="answerForFirstQuestion(ans)">{{ans.description}} <br />
         
    </div>
</div>


<div class="borderforSelfDiagnosisQuestion">
  <div>{{selfDiagnosequestionOne.matter}}</div>   
 <div>{{selfDiagnosequestionOne.toCheck}}</div>
</div>
<div class="centerbutton">
    <button type="button" class="blue-btn" ng-click="showsecondQuestion()" ng-disabled="disableFirstNext">
        <spring:message code="button.common.next" />
    </button>
    </div>
</div>


<!-- Second question -->
<div class="borderforSelfDiagnosisTop" ng-show="showQueAnsTwo">
<div class="borderforSelfDiagnosisQuestion">
    {{selfDiagnosequestionTwo.description}}
    <div ng-repeat="ans in answersTwo">
        <input type="radio"   ng-model="$parent.questiontwo" value="{{ans}}" ng-click="answerselectedTwo(ans)">{{ans.description}} <br />         
    </div>
</div>

<div class="borderforSelfDiagnosisQuestion" >
  <div>{{selfDiagnosequestionTwo.matter}}</div>   
 <div>{{selfDiagnosequestionTwo.toCheck}}</div>
</div>
<div class="centerbutton">   
    <button type="button" class="blue-btn" ng-click="showprvFirstQuestion()" >
        <spring:message code="button.common.previous" />
    </button>
     <button type="button" class="blue-btn" ng-click="showThirdQuestion()" ng-disabled="disableNextTwo">
        <spring:message code="button.common.next" />
    </button>
    </div>
</div>

<!-- Third question -->
<div class="borderforSelfDiagnosisTop" ng-show="showQueAnsThree">
<div class="borderforSelfDiagnosisQuestion">
    {{selfDiagnosequestionThree.description}}
    <div ng-repeat="ans in answersThree">
        <input type="radio"   ng-model="$parent.question" value="{{ans}}" ng-click="answerselectedThree(ans)">{{ans.description}} <br />         
    </div>
</div>

<div class="borderforSelfDiagnosisQuestion" n>
  <div>{{selfDiagnosequestionThree.matter}}</div>   
 <div>{{selfDiagnosequestionThree.toCheck}}</div>
</div>
<div class="centerbutton">   
    <button type="button" class="blue-btn" ng-click="showprvSecondQuestion()" >
        <spring:message code="button.common.previous" />
    </button>
     <button type="button" class="blue-btn" ng-click="finish()" ng-disabled="disableNextThree">
        <spring:message code="button.common.finish" />
    </button>
    </div>
</div>
 <!-- Final Result -->
 <div ng-show="showTroubleShootingAdvice">
  <jsp:include page="selfDiagnoseResult.jsp"/>
</div>
