<%@taglib prefix="authz" uri="authz"%>	
<c:if test="${folderName=='New'|| folderName=='In Progress' || folderName=='Transferred' || folderName=='Replies' || folderName=='Claims Revised by Dealer'|| folderName=='Appeals' || folderName=='Pending Authorization'}">
	<div class="accordion-header contentPane">
		<!-- accordion header -->
		<spring:message code="title.common.actions" />
		<span class="expand-collapse collapse-icon"></span>
	</div>

	<div class="overflow-hidden accordion-info">
		<div class="actionslabelStyle ">
			<span> <spring:message code="label.common.dealerFailure" /> </span> 
			<select class="marL27 hgt60" ng-style="{'width': '40%'}" id="dealerFailure" multiple="true" data-ng-model="activeAudit.dealerFailure" ng-options="dealerFailure.name for dealerFailure in dealerFailures"> </select>
			
			<div class="clear"></div>
			
			<span> <spring:message code="label.common.reviewResponsibility" /> </span> 
			<select class="marL27 hgt60" ng-style="{'width': '40%'}" data-ng-model="activeAudit.reviewResponsibility" ng-options="reviewResponsibility.name for reviewResponsibility in reviewResponsibilities" multiple="multiple"> </select>
			
			<div class="clear"></div>
			
			<div ng-show="task.fleetClaim.approve">
				<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Accept" /> 
				<span class="action-radioLabel"> <spring:message code="label.common.accept" /></span> 
				<select class=" hgt60" ng-style="{'width': '40%'}" data-ng-model="activeAudit.fleetClaimAcceptanceReason" ng-options="fleetClaimAcceptanceReason.name for fleetClaimAcceptanceReason in fleetClaimAcceptanceReasons" 
							multiple="multiple" ng-disabled="task.takenTransition!='Accept'"> </select>
			</div>
			
			<div class="clear"></div>
			
			<div ng-if="task.takenTransition!='Accept' && task.takenTransition!=null"> {{removeAcceptReason();}}</div>
			<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Deny"/> 
			<span class="action-radioLabel"> <spring:message code="label.common.deny" /></span> 
			<select class=" hgt60" ng-style="{'width': '40%'}" data-ng-model="activeAudit.fleetClaimRejectionReason" ng-options="fleetClaimRejectionReason.name for fleetClaimRejectionReason in fleetClaimRejectionReasons"
				multiple="multiple" ng-required="task.takenTransition=='Deny'" ng-disabled="task.takenTransition!='Deny'">
			</select>
			
			<div class="clear"></div>

			<div ng-if="task.takenTransition!='Deny' && task.takenTransition!=null">{{removeDenyReason();}}</div>
			
			<div class="clear"></div>
			
			<div>
				<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Request FSS Advice" /> 
				<span class="action-radioLabel">
					<spring:message code="label.common.requestFssAdvice" />
				</span> 
				<select class="wid194" data-ng-model="internalUserName" data-ng-options="name for name in task.listFSSAdvisors" ng-required="task.takenTransition=='Request FSS Advice'"
					ng-disabled="task.takenTransition!='Request FSS Advice'">
					<option value="">
						<spring:message code="label.serviceRequest.select" />
					</option>
				</select>
				<div ng-if="task.takenTransition!='Request FSS Advice'">
					{{removeInternalUser();}}
				</div>
			</div>
			<div>
				<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Transfer" /> 
				<span class="action-radioLabel"> 
					<spring:message code="label.common.transferTo" />
				</span> 
				<select class="wid194" ng-style="{'width': '80%'}" data-ng-model="AdvisorUserName" data-ng-options="name for name in task.listInternalUsers" ng-required="task.takenTransition=='Transfer'"
					ng-disabled="task.takenTransition!='Transfer'">
					<option value="">
						<spring:message code="label.serviceRequest.select" /></option>
				</select>
				<div ng-if="task.takenTransition!='Transfer'">
					{{removeAdvisorUser();}}
				</div>
			</div>
			<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Request Dealer Information"> 
				<span class="action-radioLabel"> 
					<spring:message code="label.common.requestDealerInformation" />
				</span>
			<div>
				<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="ON HOLD" /> 
				<span class="action-radioLabel"> 
					<spring:message code="label.common.putOnHold" />
				</span>
			</div>
			<div>
				<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Re-process"> 
				<span class="action-radioLabel">
					<spring:message code="label.common.reprocess" />
				</span>
			</div>
			<div ng-show="task.fleetClaim.approveAndTransfer">
				<input type="radio" class="action-radio" data-ng-model="task.takenTransition" required="required" value="Approve And Transfer"/>
				<span class="action-radioLabel"> 
					<spring:message code="labe.common.approveAndTransferToNextUser" />
				</span>
			</div>
			
			<div ng-show="!task.fleetClaim.approveAndTransfer && !task.fleetClaim.approve">
				<span style="color: red;"><spring:message code="label.common.error.loaSetUp" /></span>
			</div>
		</div>
	</div>
	<div class="hgt50"></div>
	<div class="centered marB10">
           <authz:ifPermitted resource="cloneClaim">
			<button type="button" class="blue-btn btn-primary" data-ng-click="cloneAsWarrantyClaim()" >
				<spring:message code="label.common.cloneAsWarrantyClaim" />
			</button>           
			<button type="button" class="blue-btn btn-primary" data-ng-click="cloneAsFleetClaim()" >
				<spring:message code="label.Common.cloneAsFleetClaim" />
			</button>
           </authz:ifPermitted>
			<button type="button" class="blue-btn btn-primary" data-ng-click="validateClaim()" ng-disabled='form.$invalid'>
				<spring:message code="label.Common.validate" />
			</button>
			<button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
				<spring:message code="label.Common.cancel" />
			</button>
	</div>
</c:if>
