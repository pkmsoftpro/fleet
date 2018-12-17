<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>


<script type="text/javascript">
    dojo.require("dijit.layout.LayoutContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.require("dijit.layout.TabContainer");
</script>
<style type="text/css">
	
	.cellPaymentHeader {
		border: 1px solid #99BBE8;
		background: #C8DEFB;
		font-family: Arial, Helvetica, sans-serif;
		font-size: 10px;
		text-align: center;
		font-weight: bold;
		height: 24px;
	}
	
	.cellPaymentCell {
		border: 1px solid #99BBE8;
		background: #FFFFFF;
		font-family: Arial, Helvetica, sans-serif;
		font-size: 9px;
		font-weight: bold;
		text-align: center;
	}
	
	.cellPaymentTable {
		border-bottom: 1px solid #efefef;
		border-right: 0px;
		border-top: 0px;
		border-left: 0px;
		cell-spacing: 0;
		cell-padding: 0;	
		background: #FFFFFF;
		font-family: Arial, Helvetica, sans-serif;
		font-size: 9px;
		font-weight: bold;
		text-align: center;
	}
	
	.cellPaymentoCostCategory {
		border-right: 1px solid #efefef;
		background: #FFFFFF;
		font-family: Arial, Helvetica, sans-serif;
		font-size: 10px;
		font-weight: bold;
		text-align: center;
	}
	.alert-success {
		text-align:center;
		margin : 10px;
		height : 25px;
    	background-color: #DFF0D8;
   		border-color: #D6E9C6;
   	 	color: #468847;
	}
	.alert-danger, .alert-error {
		text-align:center;
		margin : 10px;
		height : 25px;
 	   	background-color: #F2DEDE;
    	border-color: #EED3D7;
    	color: #B94A48;
	}
</style>
<c:set var="fleetClaim" value="${taskView.fleetClaim}"/>

	<div dojoType="dijit.layout.LayoutContainer" >
	    <div  dojoType="dijit.layout.TabContainer" tabPosition="bottom" layoutAlign="client">
	        <div dojoType="dijit.layout.ContentPane" title="General" class="scrollYNotX">
	        	<div class="section_header">
					<spring:message code="title.common.claimDetails" />
				</div>
	        	<div >
					<table class="grid" cellspacing="0" cellpadding="0" style="width:90%;" align="center">
		                 <tr>
		                     <td  nowrap="nowrap" style="text-align:right">
		                     	<spring:message code="label.fleetClaim.claimNumber" /> :
		                     </td>
		                     <td  nowrap="nowrap" class="labelStyle">
		                     	<c:out value="${fleetClaim.fleetClaimNumber}"/>
		                     </td>
		                     <td nowrap="nowrap" style="text-align:right">
		                     	<spring:message code="label.fleetClaim.makeNumber" /> :
		                     </td>
		                     <td  nowrap="nowrap" class="labelStyle">
		                     	<c:out value="${fleetClaim.forItem.inventoryItem.brandType}"/>
		                     </td>
		                 </tr>
		                 <tr>
		                     <td nowrap="nowrap" style="text-align:right">
		                     	<spring:message code="label.fleetClaim.workOrderNumber" /> :
		                     </td>
		                     <td  nowrap="nowrap" class="labelStyle">
		                     	<c:out value="${fleetClaim.activeFleetClaimAudit.workOrderNumber}" />
		                     </td>
		                      <td nowrap="nowrap" style="text-align:right">
		                     	<spring:message code="label.fleetClaim.meterReading" /> : 
		                     </td>
		                     <td  nowrap="nowrap" class="labelStyle">
		                     	${fleetClaim.activeFleetClaimAudit.meterReading}
		                     </td>
		                 </tr>
		                 <tr>
		                     <td nowrap="nowrap" style="text-align:right">
		                     	<spring:message code="label.fleetClaim.model" /> :
		                     </td>
		                     <td  nowrap="nowrap" class="labelStyle">
		                     	<c:out value="${fleetClaim.forItem.model.name}" />
		                     </td>
		                     <td nowrap="nowrap" style="text-align:right">
		                     	<spring:message code="label.fleetClaim.poNumber" /> :
		                     </td>
		                     <td  nowrap="nowrap" class="labelStyle">
		                     	${fleetClaim.activeFleetClaimAudit.customerPoNumber}
		                     </td>
		                 </tr>
		                 <tr>
		                     <td nowrap="nowrap" style="text-align:right">
		                     	<spring:message code="label.fleetClaim.callType" /> :
		                     </td>
		                     <td  nowrap="nowrap" class="labelStyle">
		                     	<c:out value="${callType.description}" />
		                     </td>
		                     <td nowrap="nowrap" style="text-align:right">
		                     	<spring:message code="label.fleetClaim.serviceCall" /> :
		                     </td>
		                     <td nowrap="nowrap" class="labelStyle">
		                     	<c:out value="${fleetClaim.forServiceRequest.forServiceCall.status}" />
		                     </td>
		                 </tr>
		             </table>
			             <br />
						<table class="grid" cellspacing="0" cellpadding="0" style="width:90%;" align="center">
			                 <tr>
                 				<th class="cellPaymentHeader">
                 					<spring:message code="label.fleetClaim.labor" />	
                 				</th>
                 				<th class="cellPaymentHeader">
                 					<spring:message code="label.quote.OEMParts" />
                 				</th>
                 				<th class="cellPaymentHeader">
                 					<spring:message code="label.quote.nonOEMParts" />
                 				</th>
                 				<th class="cellPaymentHeader">
                 					<spring:message code="label.fleetClaim.transportation" />
                 				</th>
                 				<th class="cellPaymentHeader">
                 					<spring:message code="label.fleetClaim.travel" />
                 				</th>
                 				<th class="cellPaymentHeader">
                 					<spring:message code="label.fleetClaim.misc" />
                 				</th>
                 				<th class="cellPaymentHeader">
                 					<spring:message code="label.fleetClaim.tax" />
                 				</th>
                 				<td rowspan="2" style="text-align:right;width:10%;">
                 					<c:if test="${(folderName == 'Pre-Invoice Pending Approval')}">
	                					<a class="button" id="dipsuteButton" onclick="showDisputeComments()"> Dispute </a>
	                					<script type="text/javascript">
	                						dojo.require('dojo.fx.Toggler');
	                						var toggler;
	                						function basicToggle1(){
	               							   toggler = new dojo.fx.Toggler({
	               							   	  node: "disputeCommentsId"
	               							   });
	               								toggler.hide();
	               							}
	                						dojo.ready(basicToggle1);
	                						function showDisputeComments(){
	                							toggler.show();
	                						}
	                						
	                						function hideDisputeComments(){
	                							toggler.hide();
	                						}
	                					</script>
                 					</c:if>
                 				</td>
                 			</tr>
                 			<tr>
                 				<td class="cellPaymentCell">
                 					<c:forEach items="${fleetClaim.activeFleetClaimAudit.payment.lineItemGroups}" var="lineItemGroup">
                 						<c:if test="${lineItemGroup.name == 'LABOR'}">
                 							<c:out value="${lineItemGroup.acceptedAmountCustomer}"/>
                 						</c:if>
                 					</c:forEach>
                 					<c:if test="${fn:length(fleetClaim.activeFleetClaimAudit.payment.lineItemGroups) == 0}">
                 						--
                 					</c:if>
                 				</td>
                 				<td class="cellPaymentCell">
                 					<c:forEach items="${fleetClaim.activeFleetClaimAudit.payment.lineItemGroups}" var="lineItemGroup">
                 						<c:if test="${lineItemGroup.name == 'OEM_PARTS'}">
                 							<c:out value="${lineItemGroup.acceptedAmountCustomer}"/>
                 						</c:if>
                 					</c:forEach>
                 					<c:if test="${fn:length(fleetClaim.activeFleetClaimAudit.payment.lineItemGroups) == 0}">
                 						--
                 					</c:if>
                 				</td>
                 				<td class="cellPaymentCell">
                 					<c:forEach items="${fleetClaim.activeFleetClaimAudit.payment.lineItemGroups}" var="lineItemGroup">
                 						<c:if test="${lineItemGroup.name == 'NON_OEM_PARTS'}">
                 							<c:out value="${lineItemGroup.acceptedAmountCustomer}"/>
                 						</c:if>
                 					</c:forEach>
                 					<c:if test="${fn:length(fleetClaim.activeFleetClaimAudit.payment.lineItemGroups) == 0}">
                 						--
                 					</c:if>
                 				</td>	
                 				<td class="cellPaymentCell">
                 					<c:forEach items="${fleetClaim.activeFleetClaimAudit.payment.lineItemGroups}" var="lineItemGroup">
                 						<c:if test="${lineItemGroup.name == 'DRAYAGE'}">
                 							<c:out value="${lineItemGroup.acceptedAmountCustomer}"/>
                 						</c:if>
                 					</c:forEach>
                 					<c:if test="${fn:length(fleetClaim.activeFleetClaimAudit.payment.lineItemGroups) == 0}">
                 						--
                 					</c:if>
                 				</td>	
                 				<td class="cellPaymentCell">
                 					<c:forEach items="${fleetClaim.activeFleetClaimAudit.payment.lineItemGroups}" var="lineItemGroup">
                 						<c:if test="${lineItemGroup.name == 'TRAVEL'}">
                 							<c:out value="${lineItemGroup.acceptedAmountCustomer}"/>
                 						</c:if>
                 					</c:forEach>
                 					<c:if test="${fn:length(fleetClaim.activeFleetClaimAudit.payment.lineItemGroups) == 0}">
                 						--
                 					</c:if>
                 				</td>
                 				<td class="cellPaymentCell">
                 					<c:forEach items="${fleetClaim.activeFleetClaimAudit.payment.lineItemGroups}" var="lineItemGroup">
                 						<c:if test="${lineItemGroup.name == 'MISCELLANEOUS'}">
                 							<c:out value="${lineItemGroup.acceptedAmountCustomer}"/>
                 						</c:if>
                 					</c:forEach>
                 					<c:if test="${fn:length(fleetClaim.activeFleetClaimAudit.payment.lineItemGroups) == 0}">
                 						--
                 					</c:if>
                 				</td>
                 				<td class="cellPaymentCell">
                 					<c:forEach items="${fleetClaim.activeFleetClaimAudit.payment.lineItemGroups}" var="lineItemGroup">
                 						<c:if test="${lineItemGroup.name == 'US_TAXES'}">
                 							<c:out value="${lineItemGroup.acceptedAmountCustomer}"/>
                 						</c:if>
                 					</c:forEach>
                 					<c:if test="${fn:length(fleetClaim.activeFleetClaimAudit.payment.lineItemGroups) == 0}">
                 						--
                 					</c:if>
                 				</td>	
                 			</tr>
			             </table>
	        	</div>
	        	<c:if test="${(folderName == 'Pre-Invoice Pending Approval')}">
	        		<form action="./invoiceDispute" id="formDispute">
	        			<input type="hidden" name="id" value="${taskView.taskId}">
			        	<div id="disputeCommentsId" >
			        		<div class="section_header" style="width: 95%;margin: 15px;">
								<spring:message code="title.common.claimDispute"/>
							</div>
							<div >
								<table class="grid" cellspacing="0" cellpadding="0" align="center">
									<tr>
										<td style="text-align:right;">
											<spring:message code="title.common.claimDisputeReason"/>
										</td>
										<td>
											<script type="text/javascript">
												var displayReason = new Array();
												<c:forEach items="${rejectionReasons}" var="reason" varStatus="index">
													displayReason.push({id : ${reason.id},description: '${reason.description}',code: '${reason.code}'});
												</c:forEach>
												
												function setReason(selectionObj) {
													for(eachReason  in displayReason) {
														if(eachReason.id == selectionObj[selectionObj.selectedIndex].value) {
															dojo.byId('disputeReasonInDetail').innerHTML=eachReason.description;
															return;
														} 
													}
													
													if(selectionObj[selectionObj.selectedIndex].value == 'select') {
														dojo.byId('disputeReasonInDetail').innerHTML='';
													}
													
												}
											</script>
											<div class="floatL marR20">
												<select id="disputeReason" name="disputeReasonId">
													<option value="select">Select</option>
													<c:forEach items="${rejectionReasons}" var="reason" >
														<option value="${reason.id}"> ${reason.name}</option>
													</c:forEach>
												</select>
												<span id="disputeErrorId" style="display:none;">
													&nbsp;
	                    							<b style="color : red;"><spring:message code="label.common.error.invalidReason" /></b>					
				       							</span>
											</div>
										</td>
									</tr>
									<tr>
										<td style="text-align:right;">
											<spring:message code="title.common.claimDisputeReasonComments"/>
										</td>
										<td>
											<textarea rows="4" cols="100" id="disputeReasonInDetail" name="disputeReasonDetail"></textarea>
										</td>
									</tr>
									<tr>
										<td>
										</td>
										<td>
											<span id="buttonSec">
												<a class="button" onclick="disputeInvoice()" id="idSubmit"> <spring:message code="label.common.submit"/> </a>
												<a class="button" id="disputeCancel" onclick="hideDisputeComments()"> <spring:message code="button.common.cancel"/> </a>
											</span>
											<span id="loader" style="display:none;">
												<spring:url value="../image/icons/images/loadingAnimation_rtl.gif" var="loadImg_url"/>
												<img alt="Loading..." src="${loadImg_url}"/>		
											</span>
										</td>
									</tr>
								</table>	
							</div>
			        	</div>
			       </form> 	
	        	</c:if>
			</div>
			<script type="text/javascript">
				function disputeInvoice() {
					var selctedReason = dojo.byId("disputeReason");
					if (selctedReason[selctedReason.selectedIndex].value != 'select') {
						var url = "./invoiceDispute";
						var buttonSecObj = dojo.byId("buttonSec");
						var loader = dojo.byId("loader");
						buttonSecObj.style.display = "none";
						loader.style.display = "block";
						dojo.xhrPost({
							url : url,
							form: dojo.byId("formDispute"),
							load: function(result) {
								var data = dojo.fromJson(result);
								if(data == "FAILURE") {
									dojo.byId('preview').innerHTML=dojo.byId("disputeError").innerHTML;	
									refreshIt();// refresh summary table
								} else {
									dojo.byId('preview').innerHTML=dojo.byId("disputeSuccess").innerHTML;
									refreshIt();// refresh summary table
								}
						    },
						    error: function() {
						    	dojo.byId('preview').innerHTML=dojo.byId("disputeError").innerHTML;//worstcase
						   }
						});
					} else {
						var errorObj = dojo.byId("disputeErrorId");
						errorObj.style.display = "block";
					}
				}
				
			</script>
			<div dojoType="dijit.layout.ContentPane" title="Payment Information" class="scrollYNotX">
		      	<div class="section_header">
					<span><spring:message code="label.quote.paymentDetails"/></span>
				</div>
				<br/>
				<table class="grid" cellspacing="0" cellpadding="0" style="width:95%;border:1px solid #bbb;" align="center">
					<tr>
						<td class="cellPaymentHeader wid100"><spring:message code="label.payment.category" /></td>
				
						<td class="cellPaymentHeader"><spring:message code="label.quote.partNumber" /></td>
				
						<td class="cellPaymentHeader"><spring:message code="label.quote.quantity" /></td>
				
						<td class="cellPaymentHeader"><spring:message code="label.payment.baseRate" /></td>
				
						<%-- <td class="cellPaymentHeader"><spring:message code="label.quote.conditionType" /></td>
				
						<td class="cellPaymentHeader"><spring:message code="label.quote.conditionTypeValue" /></td>
						
						<td class="cellPaymentHeader"><spring:message code="label.quote.adjustedPrice" /></td> --%>
				
						<td class="cellPaymentHeader"><spring:message code="label.payment.customerInvoice" /></td>
						
						<%-- <td class="cellPaymentHeader"><spring:message code="label.payment.acceptedAmount" /></td> --%>
					</tr>
					<c:forEach items="${fleetClaim.activeFleetClaimAudit.payment.lineItemGroups}" var="lineItemGroup">
						<c:if test="${lineItemGroup.name == 'OEM_PARTS'}">
							<tr>	
									<td class="cellPaymentCell" rowspan="${fn:length(fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.oemPartsInstalled)}">${lineItemGroup.displayName}</td>
									<c:forEach items="${fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.oemPartsInstalled}" var="oemPART" varStatus="loopStatus">
										<td class="cellPaymentCell">${oemPART.installedBrandItem.itemNumber}</td>
										<td class="cellPaymentCell">${oemPART.numberOfUnits}</td>
										<td class="cellPaymentCell">${oemPART.basePricePerUnitCustomer}</td>
										<%-- <td class="cellPaymentCell">${oemPART.conditionTypeCustomer}</td>
										<td class="cellPaymentCell">${oemPART.conditionTypeValueCustomer}</td>
										<td class="cellPaymentCell">${oemPART.basePricePerUnitCustomer}</td> --%>
										<c:if test="${loopStatus.index == 0}">
											<td class="cellPaymentCell" rowspan="${fn:length(fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.oemPartsInstalled)}">${lineItemGroup.baseAmountCustomer}</td>										
											<%-- <td class="cellPaymentCell" rowspan="${fn:length(fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.oemPartsInstalled)}">${lineItemGroup.acceptedAmountCustomer}</td> --%>										
										</c:if>
										<c:if test="${loopStatus.index >= 0}">
											</tr>
											<tr>
										</c:if>
									</c:forEach>
									<c:if test="${fn:length(fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.oemPartsInstalled) == 0}">
										<td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell"> -- </td>
										<%-- <td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell"> -- </td> --%>
										<td class="cellPaymentCell">${lineItemGroup.baseAmountCustomer}</td>										
										<%-- <td class="cellPaymentCell">${lineItemGroup.acceptedAmountCustomer}</td> --%>
									</c:if>
								</tr>
						</c:if>
						
						<!--  NON OEM PARTS data population -->
						<c:if test="${lineItemGroup.name == 'NON_OEM_PARTS'}">
							<tr>	
									<td class="cellPaymentCell" rowspan="${fn:length(fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled)}">${lineItemGroup.displayName}</td>
									<c:forEach items="${fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled}" var="nonOEMPART" varStatus="loopStatus">
										<td class="cellPaymentCell">${nonOEMPART.partNumber}</td>
										<td class="cellPaymentCell">${nonOEMPART.numberOfUnits}</td>
										<td class="cellPaymentCell">${nonOEMPART.basePricePerUnitCustomer}</td>
										<%-- <td class="cellPaymentCell">${nonOEMPART.conditionTypeCustomer}</td>
										<td class="cellPaymentCell">${nonOEMPART.conditionTypeValueCustomer}</td>
										<td class="cellPaymentCell">${nonOEMPART.basePricePerUnitCustomer}</td> --%>
										<c:if test="${loopStatus.index == 0}">
											<td class="cellPaymentCell" rowspan="${fn:length(fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled)}">${lineItemGroup.baseAmountCustomer}</td>										
											<%-- <td class="cellPaymentCell" rowspan="${fn:length(fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled)}">${lineItemGroup.acceptedAmountCustomer}</td> --%>										
										</c:if>
										<c:if test="${loopStatus.index >= 0}">
											</tr>
											<tr>
										</c:if>
									</c:forEach>
									<c:if test="${fn:length(fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled) == 0}">
										<td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell"> -- </td>
										<%-- <td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell"> -- </td> --%>
										<td class="cellPaymentCell">${lineItemGroup.baseAmountCustomer}</td>										
										<%-- <td class="cellPaymentCell">${lineItemGroup.acceptedAmountCustomer}</td> --%>
									</c:if>
								</tr>
						</c:if>
						
						<!-- MISC LINE ITEMS-->
						<c:if test="${lineItemGroup.name == 'MISCELLANEOUS'}">
							<tr>	
									<td class="cellPaymentCell" rowspan="${fn:length(fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.miscLineItems)}">${lineItemGroup.displayName}</td>
									<c:forEach items="${fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.miscLineItems}" var="miscItem" varStatus="loopStatus">
										<td class="cellPaymentCell">${miscItem.miscDescriptionForDisplay}</td>
										<td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell">${miscItem.baseMiscPriceCustomer}</td>
										<%-- <td class="cellPaymentCell">${lineItemGroup.conditionTypeCustomer}</td>
										<td class="cellPaymentCell">${miscItem.conditionTypeValueCustomer}</td>
										<td class="cellPaymentCell">${miscItem.baseMiscPriceCustomer}</td> --%>
										<c:if test="${loopStatus.index == 0}">
											<td class="cellPaymentCell" rowspan="${fn:length(fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.miscLineItems)}">${lineItemGroup.baseAmountCustomer}</td>										
											<%-- <td class="cellPaymentCell" rowspan="${fn:length(fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.miscLineItems)}">${lineItemGroup.acceptedAmountCustomer}</td> --%>										
										</c:if>
										<c:if test="${loopStatus.index >= 0}">
											</tr>
											<tr>
										</c:if>
									</c:forEach>
									<c:if test="${fn:length(fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.miscLineItems) == 0}">
										<td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell"> -- </td>
										<%-- <td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell"> -- </td>
										<td class="cellPaymentCell"> -- </td> --%>
										<td class="cellPaymentCell"> -- </td>
										<%-- <td class="cellPaymentCell"> -- </td> --%>
									</c:if>
								</tr>
						</c:if>
						
						<!-- MISC LINE ITEMS-->
						<c:if test="${lineItemGroup.name == 'LABOR' || lineItemGroup.name == 'TRAVEL' || lineItemGroup.name == 'DRAYAGE'}">
							<tr>	
								<td class="cellPaymentCell">${lineItemGroup.displayName}</td>
								<td class="cellPaymentCell"> -- </td>
								<td class="cellPaymentCell"> -- </td>
								<td class="cellPaymentCell">${lineItemGroup.modifierAmountForCustomer}</td>
								<%-- <td class="cellPaymentCell">${lineItemGroup.conditionTypeDealer.code}</td>
								<td class="cellPaymentCell">${lineItemGroup.conditionTypeValueDealer}</td>
								<td class="cellPaymentCell">${lineItemGroup.modifierAmountForDealer}</td> --%>
								<td class="cellPaymentCell">${lineItemGroup.baseAmountCustomer}</td>										
								<%-- <td class="cellPaymentCell">${lineItemGroup.acceptedAmountCustomer}</td> --%>										
							</tr>
						</c:if>
						
						<c:if test="${lineItemGroup.name == 'TOTAL_AMOUNT'}">
							<tr>	
								<td class="cellPaymentCell">${lineItemGroup.displayName}</td>
								<td class="cellPaymentCell"> -- </td>
								<td class="cellPaymentCell"> -- </td>
								<td class="cellPaymentCell">${lineItemGroup.modifierAmountForCustomer}</td>
								<%-- <td class="cellPaymentCell">${lineItemGroup.conditionTypeDealer.code}</td>
								<td class="cellPaymentCell">${lineItemGroup.conditionTypeValueDealer}</td>
								<td class="cellPaymentCell">${lineItemGroup.modifierAmountForDealer}</td> --%>
								<td class="cellPaymentCell">${lineItemGroup.baseAmountCustomer}</td>										
								<%-- <td class="cellPaymentCell">${lineItemGroup.acceptedAmountCustomer}</td> --%>										
							</tr>
						</c:if>
					</c:forEach>
				</table>	
			</div>
			
			<div id="disputeError" style="display: none;">
				<div class="alert-danger">
					<h4><spring:message code="lable.fleetClaim.error.dispute" arguments="${fleetClaim.fleetClaimNumber}"/></h4>					
				</div>
			</div>
			
			<div id="disputeSuccess" style="display: none;">
				<div class="alert-success">
					<h4><spring:message code="lable.fleetClaim.dispute.succes" arguments="${fleetClaim.fleetClaimNumber}"/></h4>					
				</div>
			</div>
	</div>
