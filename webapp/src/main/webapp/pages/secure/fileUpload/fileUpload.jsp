<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="clear"></div>
<div class="labelStyle floatL">
    <spring:message code="label.common.selectFile" />
</div>
<div class="floatL">
    <input ng-show="singleFileUpload" ng-click="failedDocuments = []" ng-disabled="uploader.hasHTML5 && uploader.isUploading" ng-file-select type="file" />
    <input ng-show="!singleFileUpload" ng-click="failedDocuments = []" ng-disabled="uploader.hasHTML5 && uploader.isUploading" ng-file-select type="file" multiple />
</div>
<div class="clear"></div>
<div class="clear"></div>
<div ng-init="uploader.queue=[]">

    <div class="floatL">
        <table class="table">
            <tr>
                <th width="50%"><spring:message code="label.attachment.fileName" /></th>
                <th ng-show="uploader.hasHTML5"><spring:message code="label.attachment.fileSize" /></th>
                <th ng-show="uploader.hasHTML5"><spring:message code="label.attachment.progress" /></th>
            </tr>
            <tr ng-repeat="item in uploader.queue">
                <td>{{ item.file.name }}</td>
                <td ng-show="uploader.hasHTML5" nowrap>{{ item.file.size/1024/1024|number:6 }} MB</td>
                <td ng-show="uploader.hasHTML5">{{item.progress}}</td>
                <td><i class="glyphicon glyphicon-ok" ng-show="item.isUploaded"></i></td>
                <td nowrap>                  
                    <button type="button" class="blue-btn" ng-click="item.remove()">
                        <span class="glyphicon glyphicon-trash"></span><spring:message code="label.attachment.remove" />
                    </button>
                </td>
            </tr>
        </table>
    </div>
    <div class="clear"></div>

    <div class="floatL">
        <div ng-show=" failedDocuments.length>0">
            <spring:message code="warning.file.size.check" />
        </div>
        <div data-ng-repeat="failedDoc in failedDocuments">
            <div class="warningmsg">{{failedDoc.fileName}} ({{failedDoc.size/1024/1024|number:3}} MB)</div>
        </div>

        <button ng-show="!singleFileUpload" type="button" class="blue-btn" ng-click="uploader.uploadAll()" ng-disabled="uploader.isUploading || !uploader.getNotUploadedItems().length">
            <span class="glyphicon glyphicon-upload"></span> <spring:message code="label.attachment.uploadAll" />
        </button>
        <button ng-show="!singleFileUpload" type="button" class="blue-btn" ng-click="uploader.clearQueue()" ng-disabled="!uploader.queue.length">
            <span class="glyphicon glyphicon-trash"></span> <spring:message code="label.attachment.removeAll" />
        </button>
        <button type="button" class="blue-btn" ng-click="close()">
            <span class="glyphicon glyphicon-trash"></span> <spring:message code="label.attachment.cancel"/>
        </button>
        <span class="red" ng-show="uploader.isUploading"><img src='../image/loading.gif' height="20" width="20"/> <spring:message code="label.common.uploading"/></span>
    </div>
</div>
