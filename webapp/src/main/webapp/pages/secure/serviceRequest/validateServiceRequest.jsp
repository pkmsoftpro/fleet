<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<div class="">
    <div>
        <div ng-if="validateForm==false">
            <div class="red">
                <spring:message code="label.common.errors" />
            </div>
        </div>
    </div>
    <div>
        <div alert-msg></div>
    </div>
</div>
<div ng-show="validateForm==true">
    <div ng-show='onlyDisclaimer'>
        <spring:message code="label.home.disclaimerOP" />
    </div>
    <div ng-show='onlyESR'>
        <spring:message code="label.home.emrgencySROP" />
    </div>
    <div ng-show='bothESRnDisclaimer'>
        <spring:message code="label.home.disclaimerESROP" />
    </div>
    <div class="clear"></div>
    <div class="centered">
        <div class="floatL marL200">
            <input type="radio" data-ng-readonly="false" data-ng-model="accepted" ng-value="true" ng-boolean-radio />
            <spring:message code="label.home.disclaimer.agree" />
            <input type="radio" data-ng-readonly="false" data-ng-model="accepted" ng-value="false" ng-boolean-radio />
            <spring:message code="label.home.disclaimer.disagree" />
        </div>
        <div class="clear"></div>
        <div div class="centered marB10">
            <button type="button" ng-show="processRequest == ''" class="blue-btn" data-ng-click="submit()" ng-disabled="!accepted">
                <spring:message code="label.common.submit" />
            </button>
            <button type="button" class="blue-btn" ng-click="close()">
                <spring:message code="label.Common.cancel" />
            </button>
            <button type="button" ng-show="processRequest == 'Submit Service Request'" class="blue-btn" data-ng-click="process('Submit Service Request')"
                ng-disabled="!accepted">
                <spring:message code="label.common.submit" />
            </button>
        </div>
    </div>
</div>

<center>
    <div ng-show="validateForm==false">
        <button type="button" class="blue-btn" ng-click="close()">
            <spring:message code="label.Common.cancel" />
        </button>
    </div>
    </div>
</center>

