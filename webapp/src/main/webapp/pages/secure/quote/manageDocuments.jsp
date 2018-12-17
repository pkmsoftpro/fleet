<div class="overflow-hidden">
   <div class="clear"></div>
        <div ng-show="servicingDealer">
        <c:if test="${(folderName!='Quotes Submitted')
                &&(folderName!='Quotes Accepted')
                &&(folderName!='Quotes Expired')
                &&(folderName!='Quotes Accepted Internal')
                &&(folderName!='Quotes Accepted Dealer Owned')
                &&(folderName!='Quotes Expired Internal')
                &&(folderName!='Quotes Expired Dealer Owned')}">
            <div class="labelStyle floatL">
                <spring:message code="label.common.Attachment" />
                :
            </div>
            <div class="floatL">
                <button type="button" class="blue-btn" data-ng-click="uploadDocuments()">
                    <spring:message code="label.common.Attach" />   
                </button>
            </div>
        </c:if>
        </div>
        <div ng-show="isCustomerUser">
        <c:if test="${(folderName!='Quotes Accepted')
                &&(folderName!='Quotes Sent For Revision')
                &&(folderName!='Quotes Reverted')
                &&(folderName!='Quotes Rejected')
                &&(folderName!='Quotes Expired')
                &&(folderName!='Quotes Accepted Internal')
                &&(folderName!='Quotes Accepted Dealer Owned')
                &&(folderName!='Quotes Expired Internal')
                &&(folderName!='Quotes Expired Dealer Owned')
                &&(folderName!='Quotes Reverted Dealer Owned')
                &&(folderName!='Quotes Rejected Internal')
                &&(folderName!='Quotes Rejected Dealer Owned')
                &&(folderName!='Quotes Reverted Internal')}">
                <div class="labelStyle floatL">
                <spring:message code="label.common.Attachment" />
                :
                </div>
                <div class="floatL">
                    <button type="button" class="blue-btn" data-ng-click="uploadDocuments()">
                        <spring:message code="label.common.Attach" />   
                    </button>
                </div> 
        </c:if>
       </div>
       <div ng-show="isInternalUserOrOwningDealer">
        <c:if test="${(folderName!='Quotes Accepted')
                &&(folderName!='Quotes Sent For Revision')
                &&(folderName!='Quotes Reverted')
                &&(folderName!='Quotes Rejected')
                &&(folderName!='Quotes Expired')
                &&(folderName!='Quotes Accepted Internal')
                &&(folderName!='Quotes Accepted Dealer Owned')
                &&(folderName!='Quotes Reverted Dealer Owned')
                &&(folderName!='Quotes Rejected Internal')
                &&(folderName!='Quotes Rejected Dealer Owned')
                &&(folderName!='Quotes Reverted Internal')
                &&(folderName!='Quotes Expired Internal')
                &&(folderName!='Quotes Expired Dealer Owned')}">
                <div class="labelStyle floatL">
                <spring:message code="label.common.Attachment" />
                :
                </div>
                <div class="floatL">
                    <button type="button" class="blue-btn" data-ng-click="uploadDocuments()">
                        <spring:message code="label.common.Attach" />   
                    </button>
                </div>
        </c:if>
       </div>
           
            <div class="clear"></div>
            <div class="radioClear"></div>
             <div class="overflow-hidden">
     			<%@include file="quoteAttachedDocuments.jsp"%>
			</div>
            <div class="clear"></div>
  </div>
  <div popup="openUploadDocWindow" close="close()">
        <div class="modal-header">
            <h6>
                <spring:message code="title.common.manageDocuments" />
            </h6>
        </div>
        <div class="modal-body">
            <jsp:include page="../fileUpload/fileUpload.jsp"></jsp:include>
            <div class="clear"></div>
        </div>
    </div>