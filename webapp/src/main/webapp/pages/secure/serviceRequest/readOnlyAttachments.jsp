<div ng-show="documentsReadOnly.length>0">
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.attachment" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
        <table border="1" cellspacing="0" cellpadding="0" class="accordion-table">
            <tr class="tableHeader">
                <th class="labelStyle"><spring:message code="label.attachment.fileName" /></th>
                <th class="labelStyle"><spring:message code="label.attachment.documentType" /></th>             
            </tr>
            <tr class="tableData" data-ng-repeat="document in serviceRequest.activeServiceRequestAudit.attachments">
              
                <td><a id="downLoadDoc" class="text-link" href="download?id={{document.id}}">{{document.fileName}} </a></td>
                <td>{{document.documentType.description}}                    
                </td>               
            </tr>
        </table>
    </div>
</div>
