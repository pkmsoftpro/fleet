

<c:if test="${folderName=='Assigned Service Request'}">
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.actions" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div ng-show="servicingDealer">
        <div class="overflow-hidden accordion-info">
            <div class="actionslabelStyle">
                <input type="radio" class="action-radio" data-ng-model="task.takenTransition" data-ng-click="dispatch()" value="Dispatch"
                    required="required">
                <spring:message code="label.common.serviceRequest.dispatch" />
            </div>
            <div class="actionslabelStyle">
                <input type="radio" class="action-radio" data-ng-model="task.takenTransition" value="Sent Back to NMHG"
                    required="required" data-ng-click="clear()">
                <spring:message code="label.common.serviceRequest.SendBacktoNMHG" />
            </div>
            <div class="centered marB10">
                    <button type="button" class="blue-btn btn-primary" data-ng-click="process()" ng-disabled='form.$invalid'>
                        <spring:message code="label.common.submit" />
                    </button>
                    <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()" >
                        <spring:message code="label.Common.cancel" />
                    </button>
                <div class="hgt20"></div>
            </div>
        </div>
    </div>
    <div ng-show="isInternalUserOrOwningDealer">
        <div class="overflow-hidden accordion-info">
            <div class="padL10">
                <input type="radio" class="action-radio" data-ng-model="task.takenTransition" value="close"
                    required="required">
                <spring:message code="label.common.serviceRequest.close" />
            </div>
            <div class="centered marB10">
                <button type="button" class="blue-btn btn-primary" data-ng-click="process()" ng-disabled='form.$invalid'>
                    <spring:message code="label.common.submit" />
                </button>
                 <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
                    <spring:message code="label.Common.cancel" />
                </button>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${folderName=='UnAssigned Service Request' || folderName=='Dealer Owned UnAssigned Service Request'}">
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.actions" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
        <div class="actionslabelStyle">
            <input type="radio" class="action-radio" data-ng-model="task.takenTransition" value="Assign"
                required="required">
            <spring:message code="label.common.serviceRequest.assign" />
        </div>
        <div class="actionslabelStyle">
            <input type="radio" class="action-radio" data-ng-model="task.takenTransition" value="close"
                required="required">
            <spring:message code="label.common.serviceRequest.close" />
        </div>
        <div class="centered marB10">
                <button type="button" class="blue-btn btn-primary" data-ng-click="process()" ng-disabled='form.$invalid'>
                    <spring:message code="label.common.submit" />
                </button>
                <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()" >
                    <spring:message code="label.Common.cancel" />
                </button>
            <div class="hgt20"></div>
        </div>
    </div>
</c:if>


<c:if test="${folderName=='Service Request Dispatched'}">
     <div ng-show="servicingDealer">
		<div class="accordion-header contentPane">
			<!-- accordion header -->
			<spring:message code="title.common.actions" />
			<span class="expand-collapse collapse-icon"></span>
		</div>
		<div class="overflow-hidden accordion-info">
            <div class="actionslabelStyle">
                <input type="radio" class="action-radio" name="takenTransition1"
                    data-ng-model="task.takenTransition" value="On Hold" required="required" />
                <spring:message code="label.common.serviceRequest.onHold" />
            </div>
            <div class="actionslabelStyle">
                <input type="radio" class="action-radio" name="takenTransition1"
                    data-ng-model="task.takenTransition" value="Sent Back to NMHG" required="required" />
                <spring:message code="label.common.serviceRequest.SendBacktoNMHG" />
            </div>
            <div class="actionslabelStyle">
                <input type="radio" class="action-radio" name="takenTransition1"
                    data-ng-model="task.takenTransition" value="WIP" required="required" />
                <spring:message code="label.common.serviceRequest.wip" />
            </div>
            <div class="actionslabelStyle">
                <input type="radio" class="action-radio" name="takenTransition1"
                    data-ng-model="task.takenTransition" value="Complete" required="required" />
                <spring:message code="label.common.serviceRequest.complete" />
            </div>
            <div class="centered marB10">
                <button type="button" class="blue-btn btn-primary" data-ng-click="process()" ng-disabled='form.takenTransition1.$invalid'>
                    <spring:message code="label.common.submit" />
                </button>
                <button type="button" class="blue-btn btn-primary" data-ng-click="saveServiceRequestETA()">
                    <spring:message code="label.common.save" />
                </button>
				<button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
					<spring:message code="label.Common.cancel" />
              	</button>
            </div>
        </div>
   </div>
    <div ng-show="isInternalUserOrOwningDealer">
		<div class="accordion-header contentPane">
			<!-- accordion header -->
			<spring:message code="title.common.actions" />
			<span class="expand-collapse collapse-icon"></span>
		</div>
		<div class="overflow-hidden accordion-info">
            <div class="actionslabelStyle">
                <input type="radio" class="action-radio" data-ng-model="task.takenTransition" value="close"
                    required="required">
                <spring:message code="label.common.serviceRequest.close" />
            </div>
            <div class="centered marB10">
                <button type="button" class="blue-btn btn-primary" data-ng-click="process()" ng-disabled='form.$invalid'>
                    <spring:message code="label.common.submit" />
                </button>
                 <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
                    <spring:message code="label.Common.cancel" />
                </button>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${folderName=='Returned By Dealer' || folderName=='Returned By Dealer Owned Servicing Dealer'}">
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.actions" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
        <div class=" actionslabelStyle">
            <input type="radio" class="action-radio" data-ng-model="task.takenTransition" value="reAssign"
                required="required">
            <spring:message code="label.common.serviceRequest.reAssign" />
        </div>
        <div class=" actionslabelStyle">
            <input type="radio" class="action-radio" data-ng-model="task.takenTransition" value="close"
                required="required">
            <spring:message code="label.common.serviceRequest.close" />
        </div>
        <div class="centered marB10">
            <button type="button" class="blue-btn btn-primary" data-ng-click="process()" ng-disabled='form.$invalid'>
                <spring:message code="label.common.submit" />
            </button>
             <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
                <spring:message code="label.Common.cancel" />
            </button>
        </div>
    </div>
</c:if>

<c:if test="${folderName=='Service Requests Completed' || folderName=='Dealer Owned Service Requests Completed'}">
    <div ng-show="isInternalUserOrOwningDealer">
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="title.common.actions" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
            <div class="actionslabelStyle">
                <input type="radio" class="action-radio" data-ng-model="task.takenTransition" value="close"
                    required="required">
                <spring:message code="label.common.serviceRequest.close" />
            </div>
            <div class="centered marB10">
                <button type="button" class="blue-btn btn-primary" data-ng-click="process()" ng-disabled='form.$invalid'>
                    <spring:message code="label.common.submit" />
                </button>
                 <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()">
                    <spring:message code="label.Common.cancel" />
                </button>
            </div>
        </div>
   </div>
</c:if>

