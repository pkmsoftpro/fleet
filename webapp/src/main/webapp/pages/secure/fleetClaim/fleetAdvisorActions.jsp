
<c:if test="${folderName=='Advice Request'}">
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.actions" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
		<div class="actionslabelStyle">
				<input type="radio" class="action-radio" data-ng-model="activeAudit.decision"  required="required" value="Recommended to Approve">
				<span class="action-radioLabel">
				<spring:message code="lable.common.advice.approve" />
				</span>
			 <div class="clear"></div>
				<input type="radio" class="action-radio" data-ng-model="activeAudit.decision" required="required" value="Recommended to Reject">
				<span class="action-radioLabel">
				<spring:message code="lable.common.advice.reject" />
				</span>
	</div>
    <div class="hgt50"></div>
    <div class="centered marB10">
            <button type="button" class="blue-btn btn-primary" data-ng-click="validateClaim('Advice')" ng-disabled='form.$invalid'>
                <spring:message code="label.common.Advice" />
            </button>
            <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
                <spring:message code="label.Common.cancel" />
            </button>
    </div>
   </div>
</c:if>

<c:if test="${folderName=='Pre-Invoice Disputed'}">
	<div class="hgt50"></div>
	 <div class="centered marB10">
			<button type="button" class="blue-btn btn-primary"  data-ng-click="validateClaim('ReSubmit')" ng-disabled='form.$invalid'>
				<spring:message code="label.common.resubmit" />
			</button>
			<button type="button" class="blue-btn btn-primary" data-ng-click="cancel()" >
				<spring:message code="label.Common.cancel" />
			</button>
	</div>		
</c:if>

