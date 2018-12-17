<div ng-show="documentsReadOnly.length>0">
    <div class="overflow-hidden accordion-info">
        <table border="1" cellspacing="0" cellpadding="0" class="accordion-table">
            <tr class="tableHeader">
            	<th class="labelStyle"><spring:message code="label.attachment.date" /></th>
                <th class="labelStyle"><spring:message code="label.attachment.fileName" /></th>
                <th class="labelStyle"><spring:message code="label.attachment.documentType" /></th>
                <th ng-show="loggedInUserType=='INTERNAL'" class="labelStyle"><spring:message code="label.attachment.shareWithUser" /></th>
                <th class="labelStyle"><spring:message code="label.attachment.user" /></th>
                <th class="labelStyle"><spring:message code="label.attachment.userRole" /></th>          
            </tr>
          	<tr  class="tableData" data-ng-repeat="document in activeAudit.attachments" ng-show="loggedInUserType=='DEALER USER' && (document.uploadedBy.userType=='DEALER USER'||document.uploadedBy.userType=='CUSTOMER'||document.isSharedWithDealer)">
				<td ><div id="docDate" >{{document.updatedOn}} </div></td>
            	<td><a id="downLoadDoc"  href="download?id={{document.id}}">{{document.fileName}} </a></td>
             	<td>
                	<div class="floatL marR20" >
                    	<select data-ng-model="document.documentType.id" ng-options="docType.id as docType.name for docType in docTypes" class="dropdown-normal"
                    		data-ng-readonly="document.uploadedBy.userType=='INTERNAL' ||document.uploadedBy.userType=='CUSTOMER'" disabled="true">
                        	<option value=""><spring:message code="label.serviceRequest.select" /></option>
                    	</select>
                	</div>
            	</td>
            	<td><div id="userRole" >{{document.uploadedBy.completeNameAndLogin}}</div></td>
            	<td><div id="docDate"  >{{document.uploadedBy.userType}} </div></td>
           </tr>
           <tr ng-show="loggedInUserType=='INTERNAL'" class="tableData" data-ng-repeat="document in activeAudit.attachments">
			<td><div id="docDate" >{{document.updatedOn}} </div></td>
            <td><a id="downLoadDoc" href="download?id={{document.id}}">{{document.fileName}} </a></td>
        	<td><div class="marR20">{{document.documentType.name}}</div></td>
            <td>
            	<div ng-if="document.uploadedBy.userType=='INTERNAL'">
            	<div class="marR20">
             		<input type="checkbox" data-ng-model="document.isSharedWithDealer" data-ng-disabled="true">
        			<spring:message code="label.attachment.dealer"/>
        		</div>
        			<input type="checkbox" data-ng-model="document.isSharedWithSupplier" data-ng-disabled="true">
        			<spring:message code="label.attachment.customer" />
        		</div>
        	</td>
            <td><div id="userRole" >{{document.uploadedBy.completeNameAndLogin}}</div></td>
            <td><div id="docDate" >{{document.uploadedBy.userType}} </div></td>
          </tr>
          <tr class="tableData" data-ng-repeat="document in activeAudit.attachments" ng-show="loggedInUserType=='CUSTOMER' && (document.uploadedBy.userType=='DEALER USER'||document.uploadedBy.userType=='CUSTOMER'||document.isSharedWithSupplier)">
				<td ><div id="docDate" >{{document.updatedOn}} </div></td>
            	<td><a id="downLoadDoc"  href="download?id={{document.id}}">{{document.fileName}} </a></td>
             	<td><div class="marR20">{{document.documentType.name}}</div></td>
            	<td><div id="userRole" >{{document.uploadedBy.completeNameAndLogin}}</div></td>
            	<td><div id="docDate"  >{{document.uploadedBy.userType}} </div></td>
          </tr>
        </table>
    </div>
</div>