<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="authz" uri="authz"%>
<div class="clear"></div>
<div title-pane content-pane-title="<spring:message code="label.quote.summary"/>" collapse="false"></div>
<div>
<div>
    <div ng-if="validation==false">
        <div class="red">
            <spring:message code="label.common.errors" />:
        </div>
    </div>
</div>
<div>
    <div alert-msg></div>
</div>
</div>
<div ng-show="validation==true">
	<hr class="wid955">
<div class="clear"></div>
	<div class="details-sub-header">
		<span><spring:message code="label.quote.applicableContract" /> {{quote.serviceRequest.contractCode}}</span>
		<div ng-show="isInternalUserOrOwningDealer">
		<span><spring:message code="label.common.faultFound" />:  {{quote.activeQuoteAudit.serviceInformation.faultFound.name}}</span>
		<br/><span><spring:message code="label.common.causedBy" />:  {{quote.activeQuoteAudit.serviceInformation.causedBy.name}}</span>
		<br/><span><spring:message code="columnTitle.claimsListing.callType" />:  {{quote.serviceRequest.activeServiceRequestAudit.callType.name}}</span>
		</div>
	</div><div class="clear"></div>
<div>
    <%@include file="../common/payment.jsp"%></div>
<div class="clear"></div>

<div class="centered marB10">
    <c:choose>
        <c:when test="${folderName!= null}">
            <button type="button" class="blue-btn btn-primary" data-ng-click="processQuote()">
                <spring:message code="label.common.submit" />
            </button>
        </c:when>
        <c:otherwise>
            <button type="button" class="blue-btn btn-primary" data-ng-click="submit()">
                <spring:message code="label.common.submit" />
            </button>
        </c:otherwise>
    </c:choose>
    <button type="button" class="blue-btn btn-primary" ng-click="edit()">
        <spring:message code="label.common.edit" />
    </button>
    <button type="button" class="blue-btn btn-primary" data-ng-click="printQuoteSummary()">
        <spring:message code="label.common.print" />
    </button>

    <div ng-show="isInternalUserOrOwningDealer" class="dis-inblock">
        <button type="button" class="blue-btn btn-primary" ng-click="emailAttach('${searchQuoteId}')">
            <spring:message code="label.Common.email" />
        </button>
    </div>
</div>
<div popup="openEmailWindow" close="close()">
    <div class="modal-header">
        <center>
            <h6>
                <spring:message code="label.quote.sendEmail" />
            </h6>
        </center>
    </div>
    <div class="modal-body">
        <center>
            <div ng-show='subscribedEmailUser'>
                <div data-ng-repeat="customer in customers">
                    <div class="floatL" data-ng-class-odd="'odd'" data-ng-class-even="'even'">
                        <input class="floatL" type="checkbox" data-ng-model="customer.checked" />{{customer.name }}
                    </div>
                    <div class="clear"></div>
                </div>
               
            </div>
  <div ng-hide="SuccessMessageForemail">
 <div>
                 <div class="floatL">
                 You can also enter customers Email id
                 </div>
                 </div>
                  <div class="clear"></div>
                 
                 
                  <div class="floatL">
                 <b>Note: </b>  <spring:message code="label.quote.email.list.note"/>                  
                  </div>
                                   
           
                 
                <div class="floatL">               
                <textarea name="customerEmailIdList" ng-model="customerEmailIdList" class="wid500"></textarea>
               </div>
                 <div class="clear"></div>
    </div>   
    <div ng-show="invalidEmail">
                <spring:message code="label.quote.email.invalid" />
                
                 <div data-ng-repeat="emailId in invalidEmailIdList">
            <div class="warningmsg">{{emailId}}</div>
        </div>
            </div>
                    
            <div ng-show="SuccessMessageForemail && !invalidEmail">
                <spring:message code="label.quote.email.success" />
                        
            </div>

        </center>
        <div class="clear"></div>
        <div class="clear"></div>
        <center>


            <button ng-show='!SuccessMessageForemail' type="button" class="blue-btn" ng-click="addCustomerToEmailList()">
                <spring:message code="label.common.send" />

                <button ng-show="SuccessMessageForemail" type="button" class="blue-btn" ng-click="closePopup()">
                    <spring:message code="label.common.ok" />

                </button>
                <button type="button" class="blue-btn" ng-click="closePopup()">
                    <spring:message code="label.Common.cancel" />
                </button>
        </center>
    </div>
</div>
</div>

<div ng-show="validation==false">
    <div class="centered marB10">
        <button type="button" class="blue-btn btn-primary" ng-click="edit()">
            <spring:message code="label.common.edit" />
        </button>
    </div>
</div>

