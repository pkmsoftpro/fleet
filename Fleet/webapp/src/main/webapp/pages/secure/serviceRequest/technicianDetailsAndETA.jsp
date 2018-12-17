<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div ng-show="servicingDealer">
    <c:choose>
        <c:when test="${folderName=='Assigned Service Request' || folderName=='Service Request Dispatched'}">
            <div>
                

               
                 <div ng-show="task.takenTransition=='Dispatch' || serviceRequest.displayStatus=='Dispatched'">
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.technician" />
                </div>
                <div class="floatL">
                    <select data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.technician.id"
                        ng-options="technician.key as technician.label for technician in technicians" class="dropdown-normal hgt26 wid223"
                        ng-disabled="task.takenTransition=='Sent Back to NMHG'||task.takenTransition=='Complete'">
                        <option value="">
                            <spring:message code="label.serviceRequest.select" />
                        </option>
                    </select>
                </div>

                <div class="clear"></div>
                
                 <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.isTechnicianCertified" />
                </div>
                <div class="floatL">
                    <spring:message code="label.common.yes" />
                    <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.technicianCertified" ng-value="true"
                        ng-boolean-radio ng-disabled="task.takenTransition=='Sent Back to NMHG'||task.takenTransition=='Complete'"  />
                    <spring:message code="label.common.no" />
                    <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.technicianCertified" ng-value="false"
                        ng-boolean-radio ng-disabled="task.takenTransition=='Sent Back to NMHG'||task.takenTransition=='Complete'" />
                </div>
                <div class="clear"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.comments" /> <span ng-show="serviceRequest.customerLocation.etaOnServiceRequest" class="red">*</span>
                </div>
                <div class="floatL">
                    <textarea  max-length data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.dealerComments" rows="4" cols="500"
                        class="wid500" ng-disabled="task.takenTransition=='Sent Back to NMHG'||task.takenTransition=='Complete'" ng-required="serviceRequest.customerLocation.etaOnServiceRequest && task.takenTransition=='Dispatch'"></textarea>
                </div>


                <div class="clear"></div>

                <div class="labelStyle floatL padT22">
                    <spring:message code="label.serviceRequest.eta" /><span ng-show="serviceRequest.customerLocation.etaOnServiceRequest" class="red">*</span>
                </div>
                <div class="floatL marR10 padT22">
                   <INPUT TYPE="text" data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.dateOfArrival" 
                       datepicker-popup={{dateFormat}} class="wid80" min="minDate" ng-required="serviceRequest.customerLocation.etaOnServiceRequest && task.takenTransition=='Dispatch'"
                       ng-disabled="task.takenTransition=='Sent Back to NMHG'||task.takenTransition=='Complete'">
                </div>
                <div class="floatL">
                    <div data-ng-model="eta" timepicker
                        class="wid80 time-picker-input" ng-required="serviceRequest.customerLocation.etaOnServiceRequest && task.takenTransition=='Dispatch'" 
                        ng-disabled="task.takenTransition=='Sent Back to NMHG'||task.takenTransition=='Complete'">
                </div>
                
                <div class="clear"></div>
            </div>
       </div>
             <div class="clear"></div></div>
        </c:when>
        <c:otherwise>
            <div ng-show="serviceRequest.activeServiceRequestAudit.state != 'UN_ASSIGNED'">
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.technician" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.technician.completeName">
                </div>

                <div class="clear"></div>

                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.isTechnicianCertified" />
                </div>
                <div class="floatL">
                    <spring:message code="label.common.yes" />
                    <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.technicianCertified" ng-value="true"
                        ng-boolean-radio ng-readonly="true" ng-disabled="true" />
                    <spring:message code="label.common.no" />
                    <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.technicianCertified" ng-value="false"
                        ng-boolean-radio ng-readonly="true" ng-disabled="true"/>
                </div>
                <div class="clear"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.comments" />
                </div>
                <c:choose>
        			<c:when test="${folderName=='Service Request Dispatched'}">
                		<div class="floatL">
                    		<textarea my-maxlength data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.dealerComments" rows="4" cols="500"
                        	class="wid500"></textarea>
                		</div>
                	</c:when>
                	<c:otherwise>
               		 <div class="floatL">
                    	<textarea my-maxlength data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.dealerComments" rows="4" cols="500"
                        class="wid500" ng-readonly="true"></textarea>
                	</div>
                	</c:otherwise>
                </c:choose>

                <div class="clear"></div>
                <div class="labelStyle floatL padT33">
                    <spring:message code="label.serviceRequest.eta" />
                </div>
                
                <div  class="floatL padT33">
                    <INPUT TYPE="text" data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.dateOfArrival" datepicker-popup={{dateFormat}} class="wid80" ng-readonly="true"
                    ng-disabled="true">
                </div>
                <div class="floatL">
                    <div data-ng-model="eta" timepicker
                        class="wid80" readonly-input="true" disabled="true">
                </div>
                <div class="clear"></div>
            </div>
            
             <div class="clear"></div></div>
        </c:otherwise>
    </c:choose>
</div>
<div ng-hide="servicingDealer">
    <div ng-show="serviceRequest.activeServiceRequestAudit.state != 'UN_ASSIGNED'">
       

       <div ng-show="serviceRequest.displayStatus=='Dispatched' || ((serviceRequest.displayStatus=='On Hold') && (selectedId)) 
                                                || ((serviceRequest.displayStatus=='Work In Progress') && (selectedId))">
        <div class="labelStyle floatL">
            <spring:message code="label.serviceRequest.technician" />
        </div>
        <div class="floatL">
            <INPUT TYPE="text" data-ng-readonly="true" data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.technician.completeName">
        </div>

        <div class="clear"></div>
        <div class="labelStyle floatL">
            <spring:message code="label.serviceRequest.isTechnicianCertified" />
        </div>
        <div class="floatL">
            <spring:message code="label.common.yes" />
            <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.technicianCertified" ng-value="true" ng-boolean-radio
                ng-readonly="true" disabled="true"/>
            <spring:message code="label.common.no" />
            <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.technicianCertified" ng-value="false" ng-boolean-radio
                ng-readonly="true" disabled="true"/>
        </div>

        <div class="clear"></div>
       
        <div class="labelStyle floatL">
            <spring:message code="label.serviceRequest.comments" />
        </div>
        <div class="floatL">
            <textarea my-maxlength data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.dealerComments" rows="4" cols="500" class="wid500"
                ng-readonly="true"></textarea>
        </div>

        <div class="clear"></div>

        <div class="labelStyle floatL padT33">
            <spring:message code="label.serviceRequest.eta" />
        </div>
        <div class="floatL padT33">
            <INPUT TYPE="text" data-ng-model="serviceRequest.activeServiceRequestAudit.technicianDetails.dateOfArrival" datepicker-popup={{dateFormat}} class="wid80" ng-readonly="true"
            disabled="true">
        </div>
        <div class="floatL">
            <div data-ng-model="eta" timepicker
                class="wid80" ng-readonly="true" disabled="true" readonly-input="true" >
        </div>
        <div class="clear"></div>
    </div> 
    </div><div class="clear"></div></div>
</div>
