<div class="overflow-hidden">
   <div class="clear"></div>
      <div ng-show="servicingDealer">
             <c:if test="${(folderName!='Claims Submitted')}">
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
        <c:if test="${(folderName!='Forwarded Internally')
                &&(folderName!='Returned To Dealer')
                &&(folderName!='Advice Request')
                &&(folderName!='Claims Submitted')}">
                <div class="labelStyle floatL"><input type="hidden" id="isDocType" value="true" />
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
     	  <%@include file="claimAttachedDocuments.jsp"%>
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