<div data-ng-init="activeAudit.attachments = activeAudit.attachments == null ? [] : activeAudit.attachments"
    data-ng-model="activeAudit.attachments">
  <table border="1" cellspacing="0" cellpadding="0" class="accordion-table">
        <tr class="tableHeader">
            <th class="labelStyle"><spring:message code="label.manageDocuments.date" /></th>
            <th class="labelStyle"><spring:message code="label.manageDocuments.fileName" /></th>
            <th class="labelStyle"><spring:message code="label.attachment.documentType" /></th>            
            <th class="labelStyle"  ng-show="loggedInUserType=='INTERNAL'"><spring:message code="label.attachment.shareWithUser" /></th>
            <th class="labelStyle"><spring:message code="label.manageDocuments.user" /></th>
            <th class="labelStyle"><spring:message code="label.manageDocuments.userRole" /></th>
            <th class="labelStyle"><spring:message code="label.manageDocuments.delete" /></th>
        </tr>        
	
          <tr ng-show="(loggedInUserType=='DEALER USER') && (document.uploadedBy.userType=='DEALER USER'||document.uploadedBy.userType=='CUSTOMER'||document.isSharedWithDealer)" class="tableData" data-ng-repeat="document in activeAudit.attachments" >
				<td ><div id="docDate" >{{document.updatedOn}} </div></td>
            	<td><a id="downLoadDoc"  href="download?id={{document.id}}">{{document.fileName}} </a></td>
             	<td>
                	<div>
                    	<select data-ng-model="document.documentType.id" ng-options="docType.id as docType.name for docType in docTypes" ng-style="{width:'200px'}" class="dropdown-normal"
                    		data-ng-readonly="document.uploadedBy.userType=='INTERNAL' ||document.uploadedBy.userType=='CUSTOMER'" ng-disabled="document.uploadedBy.userType!='DEALER USER'">
                        	<option value=""><spring:message code="label.serviceRequest.select" /></option>
                    	</select>
                	</div>
            	</td>
            	<td><div id="userRole" >{{document.uploadedBy.completeNameAndLogin}}</div></td>
            	<td><div id="docDate"  >{{document.uploadedBy.userType}} </div></td>
            	<td>
            		<div class="floatL marL110" ng-if="document.uploadedBy.userType=='DEALER USER'">
                 		<a id="deletedoc" class="text-link" href="" data-ng-click="deleteDocument($index)" ><i class="icon-trash"></i></a>
              		</div>
            	</td>
        	</tr>
		
          <tr ng-show="loggedInUserType=='INTERNAL'" class="tableData" data-ng-repeat="document in activeAudit.attachments">
			<td><div id="docDate" >{{document.updatedOn}} </div></td>
            <td><a id="downLoadDoc" href="download?id={{document.id}}">{{document.fileName}} </a></td>
        	<td>
                <div>
                    <select data-ng-model="document.documentType.id" ng-options="docType.id as docType.name for docType in docTypes" ng-style="{width:'200px'}" class="dropdown-normal"
                     data-ng-readonly="document.uploadedBy.userType=='DEALER USER'||document.uploadedBy.userType=='CUSTOMER'" ng-disabled="document.uploadedBy.userType!='INTERNAL'">
                        <option value=""><spring:message code="label.serviceRequest.select" /></option>
                    </select>
                </div>
            </td>
            <td>
            	  <div ng-if="document.uploadedBy.userType=='INTERNAL'">
            		<div class="marR20">
             		<input type="checkbox" data-ng-model="document.isSharedWithDealer">
        			<spring:message code="label.attachment.dealer"/><br>
        			</div>
        			<input type="checkbox" data-ng-model="document.isSharedWithSupplier">
        			<spring:message code="label.attachment.customer" />
        		  </div>
        	</td>
            <td><div id="userRole" >{{document.uploadedBy.completeNameAndLogin}}</div></td>
            <td><div id="docDate" >{{document.uploadedBy.userType}} </div></td>
             <td>
              	<div class="floatL marL110" ng-if="document.uploadedBy.userType=='INTERNAL'">
                 		<a id="deletedoc" class="text-link" href="" data-ng-click="deleteDocument($index)" ><i class="icon-trash"></i></a>
              	</div>
            </td>
          </tr>
         	<tr ng-show="loggedInUserType=='CUSTOMER' && (document.uploadedBy.userType=='DEALER USER'||document.uploadedBy.userType=='CUSTOMER'||document.isSharedWithSupplier)" class="tableData" data-ng-repeat="document in activeAudit.attachments">
				<td ><div id="docDate" >{{document.updatedOn}} </div></td>
            	<td><a id="downLoadDoc"  href="download?id={{document.id}}">{{document.fileName}} </a></td>
             	<td>
                	<div>
                    	<select data-ng-model="document.documentType.id" ng-options="docType.id as docType.name for docType in docTypes" ng-style="{width:'200px'}" class="dropdown-normal"
                    		data-ng-readonly="document.uploadedBy.userType=='DEALER USER'||document.uploadedBy.userType=='INTERNAL'" ng-disabled="document.uploadedBy.userType!='CUSTOMER'">
                        	<option value=""><spring:message code="label.serviceRequest.select" /></option>
                    	</select>
                	</div>
            	</td>
            	<td><div id="userRole" >{{document.uploadedBy.completeNameAndLogin}}</div></td>
            	<td><div id="docDate"  >{{document.uploadedBy.userType}} </div></td>
            	<td>
              <div class="floatL marL110" ng-if="document.uploadedBy.userType=='CUSTOMER'">
                 		<a id="deletedoc" class="text-link" href="" data-ng-click="deleteDocument($index)" ><i class="icon-trash"></i></a>
              </div>
            </td>
        	</tr>
	
  </table>
</div>