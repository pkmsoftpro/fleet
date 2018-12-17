<div class="overflow-hidden">
   <div class="clear"></div>
            <!-- <div class="labelStyle floatL">
                <spring:message code="label.common.Attachment" />
                :
            </div>
            <div class="floatL">
                <button type="button" class="blue-btn" data-ng-click="uploadDocuments()">
                    <spring:message code="label.common.Attach" />   
                </button>
            </div> -->
           
            <div class="clear"></div>
            <div class="radioClear"></div>
             <div class="overflow-hidden">
     			<%@include file="claimAttachedDocumentsReadonly.jsp"%>
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