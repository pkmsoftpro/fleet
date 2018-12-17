<%@taglib prefix="authz" uri="authz"%>

	<div class="accordion-header contentPane">
			<!-- accordion header -->
			<spring:message code="title.common.actions" />
			<span class="expand-collapse collapse-icon"></span>
	</div>
	<div class="overflow-hidden accordion-info">
				<div   ng-if="activeAudit.dealerFailure!=null && activeAudit.dealerFailure.length > 0">
					 <div  class="hgt50">
					  		<div class="labelStyle floatL">
						    		<spring:message code="label.common.dealerFailure" />
						    </div>
			             	<div class="floatL">${activeAudit.dealerFailure}
						    		<div ng-repeat="reason in activeAudit.dealerFailure">
						    			{{reason.description}}
						    		</div>
						    		
						    	</div>
			               
		             </div>
	             </div>
            	 <div class="clear"></div>
            	 <div   ng-if="activeAudit.reviewResponsibility!=null && activeAudit.reviewResponsibility.length > 0">
					 <div  class="hgt50">
					  		<div class="labelStyle floatL">
						    		<spring:message code="label.common.reviewResponsibility" />:
						    </div>
			             	<div class="floatL">${activeAudit.reviewResponsibility}
						    		<div ng-repeat="reason in activeAudit.reviewResponsibility">
						    			{{reason.description}}
						    		</div>
						    		
						    	</div>
			               
		             </div>
	             </div>
	              <div class="clear"></div>
				 <div   ng-if="activeAudit.fleetClaimRejectionReason!=null && activeAudit.fleetClaimRejectionReason.length > 0">
					<div class="hgt50">
						         <div class="labelStyle floatL">
						    		<spring:message code="title.attributes.rejectionReason" />:
						    	</div>
						    	<div class="floatL">${activeAudit.fleetClaimRejectionReason}
						    		<div ng-repeat="reason in activeAudit.fleetClaimRejectionReason">
						    			{{reason.description}}
						    		</div>
						    		
						    	</div>
					 </div>
				</div>
				 <div class="clear"></div>
				<div  ng-if="activeAudit.fleetClaimAcceptanceReason!=null && activeAudit.fleetClaimAcceptanceReason.length > 0" >
				 <div class="hgt50">
					         <div class="labelStyle floatL">
					    		<spring:message code="title.attributes.acceptanceReason" />:
					    	</div>
					    	<div class="floatL">${activeAudit.fleetClaimAcceptanceReason}
					    		<div ng-repeat="reason in activeAudit.fleetClaimAcceptanceReason">
					    			{{reason.description}}
					    		</div>
					    		
					    	</div>
				 </div>
			   </div>
			    <div class="clear"></div>
				
	</div>



