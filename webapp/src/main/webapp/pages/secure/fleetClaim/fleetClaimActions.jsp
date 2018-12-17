<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="authz" uri="authz"%>
<c:choose>
	<c:when test="${folderName!= null}">
		<div ng-show="servicingDealer">
			<%@include file="dealerActions.jsp"%>
		</div>
        <div ng-show="isFleetProcesor">
			<%@include file="fleetProcessorActions.jsp"%>
            </div>
        <div ng-show="isInternalUserOrOwningDealer">
			<%@include file="fleetAdvisorActions.jsp"%>
        </div>
		<authz:ifUserNotInRole roles="fleetServiceSpecialist">
		<input type="hidden" data-ng-model='activeAudit.decision' value=""/>
		</authz:ifUserNotInRole>
		<c:if test="${folderName=='Draft Claims' || folderName=='Claims Workbench' || folderName=='Dealer Owned Draft Claims' || folderName=='Dealer Owned Claims Workbench'}">
		<div class="centered marB10">
			<button type="button" class="blue-btn btn-primary" data-ng-click="validateClaim('Submit Claim')" ng-disabled='form.$invalid'>
				<spring:message code="label.Common.validate" />
			</button>
			<button type="button" class="blue-btn btn-primary" data-ng-click="save()" ng-disabled='form.$invalid'>
				<spring:message code="label.Common.save" />
			</button>
			<button type="button" class="blue-btn btn-primary" data-ng-click="deleteDraftFleetClaim()" ng-disabled='(form.serialNumber.$error.invalid || form.serialNumber.$error.required)'>
				<spring:message code="label.common.delete" />
			</button>
			<button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
			<spring:message code="label.Common.cancel" />
		</button>
		</div>
	</c:if>
	</c:when>
	<c:otherwise>
		<div class="centered marB10">
				<button type="button" class="blue-btn btn-primary" data-ng-click="validateClaim()" ng-disabled='form.$invalid'>
					<spring:message code="label.Common.validate" />
				</button>
				<button type="button" class="blue-btn btn-primary" data-ng-click="save()" ng-disabled='(form.serialNumber.$error.invalid || form.serialNumber.$error.required)'>
					<spring:message code="label.Common.save" />
				</button>
					<button data-ng-show="fleetClaim.id!=null" type="button" class="blue-btn btn-primary" data-ng-click="deleteDraftFleetClaim()" ng-disabled='(form.serialNumber.$error.invalid || form.serialNumber.$error.required)'>
						<spring:message code="label.common.delete" />
					</button>
				<button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
					<spring:message code="label.Common.cancel" />
				</button>
		</div>

	</c:otherwise>
</c:choose>
