<div
    data-ng-init="contract.activeContractAudit.attachments = contract.activeContractAudit.attachments == null ? [] : contract.activeContractAudit.attachments"
    data-ng-model="contract.activeContractAudit.attachments">
    <table border="1" cellspacing="0" cellpadding="0" class="accordion-table">
        <tr class="tableHeader">
            <th class="labelStyle"><spring:message code="label.attachment.fileName" /></th>
            <th class="labelStyle"><spring:message code="label.attachment.documentType" /></th>
            <th class="labelStyle"><spring:message code="label.attachment.delete" /></th>
        </tr>
        <tr class="tableData" data-ng-repeat="document in contract.activeContractAudit.attachments">

            <td><a id="downLoadDoc" class="text-link" href="download?id={{document.id}}">{{document.fileName}} </a></td>
            <td>
                <div class="floatL marL110">
                    <select data-ng-model="document.documentType.id" ng-options="docType.id as docType.name for docType in docTypes" ng-style="{width:'80px'}" class="dropdown-normal">
                        <option value=""><spring:message code="label.serviceRequest.select" /></option>
                    </select>
                </div>
            </td>
            <td><div class="floatL marL150"><a id="deletedoc" class="text-link" ng-click="deleteDocument($index)" ><i class="icon-trash"></i></a></div></td>
        </tr>
    </table>
</div>




