<div data-ng-init="activeAudit.attachments = activeAudit.attachments == null ? [] : activeAudit.attachments"
    data-ng-model="activeAudit.attachments">
  <table border="1" cellspacing="0" cellpadding="0" class="accordion-table">
        <tr class="tableHeader">
            <th class="labelStyle"><spring:message code="label.manageDocuments.date" /></th>
            <th class="labelStyle"><spring:message code="label.manageDocuments.fileName" /></th>
            <th class="labelStyle"><spring:message code="label.attachment.documentType" /></th>
         <th class="labelStyle" ng-show="loggedInUserType=='INTERNAL'"><spring:message code="label.attachment.shareWithUser" /></th>    
            <th class="labelStyle"><spring:message code="label.manageDocuments.user" /></th>
            <th class="labelStyle"><spring:message code="label.manageDocuments.userRole" /></th>
        </tr>
        
		<tr data-ng-show="(loggedInUserType=='DEALER USER') && (document.uploadedBy.userType=='DEALER USER'||document.uploadedBy.userType=='CUSTOMER'||document.isSharedWithDealer)" class="tableData" data-ng-repeat="document in activeAudit.attachments" >       
				<td ><div id="docDate" >{{document.updatedOn}} </div></td>
            	<td><a id="downLoadDoc"  href="download?id={{document.id}}">{{document.fileName}} </a></td>
             	<td><div class="marR20" >{{document.documentType.name}}</div></td>
            	<td><div id="userRole" >{{document.uploadedBy.completeNameAndLogin}}</div></td>
            	<td><div id="docDate"  >{{document.uploadedBy.userType}} </div></td>
       	</tr>		
		
		<tr ng-show="loggedInUserType=='INTERNAL'" class="tableData" data-ng-repeat="document in activeAudit.attachments">          
			<td><div id="docDate" >{{document.updatedOn}} </div></td>
            <td><a id="downLoadDoc" href="download?id={{document.id}}">{{document.fileName}} </a></td>
        	<td><div class="floatL marR20">{{document.documentType.name}}</div></td>
            <td>
            	  <div ng-if="document.uploadedBy.userType=='INTERNAL'">
            		<div class="marR20">
             		<input type="checkbox" data-ng-model="document.isSharedWithDealer" ng-disabled="true">
        			<spring:message code="label.attachment.dealer"/><br>
        			</div>
        			<input type="checkbox" data-ng-model="document.isSharedWithSupplier" ng-disabled="true">
        			<spring:message code="label.attachment.customer" />
        		  </div>
        	</td>
            <td><div id="userRole" >{{document.uploadedBy.completeNameAndLogin}}</div></td>
            <td><div id="docDate" >{{document.uploadedBy.userType}} </div></td>
          </tr>
		
          <tr data-ng-show="loggedInUserType=='CUSTOMER' && (document.uploadedBy.userType=='DEALER USER'||document.uploadedBy.userType=='CUSTOMER'||document.isSharedWithSupplier)" class="tableData" data-ng-repeat="document in activeAudit.attachments" >
				<td ><div id="docDate" >{{document.updatedOn}} </div></td>
            	<td><a id="downLoadDoc"  href="download?id={{document.id}}">{{document.fileName}} </a></td>
             	<td><div class="marR20" >{{document.documentType.name}}</div></td>
            	<td><div id="userRole" >{{document.uploadedBy.completeNameAndLogin}}</div></td>
            	<td><div id="docDate"  >{{document.uploadedBy.userType}} </div></td>
         </tr>
		
  </table>
</div>