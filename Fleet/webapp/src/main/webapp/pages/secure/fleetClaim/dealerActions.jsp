
<div class="centered marB10">
	<c:if test="${folderName=='Claims Received for Revision'}">
			<button type="button" class="blue-btn btn-primary" data-ng-click="validateClaim('DealerReturned')" ng-disabled='form.$invalid'>
				<spring:message code="label.common.resubmit" />
			</button>
			<button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
			<spring:message code="label.Common.cancel" />
		</button>
	</c:if>
		
</div>