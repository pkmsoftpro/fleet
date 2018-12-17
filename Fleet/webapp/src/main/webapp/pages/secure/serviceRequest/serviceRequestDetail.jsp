<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div ng-show="isEntryValidationCheck==false">
    <div alert-msg></div>
</div>
<c:if test="${folderName == null or folderName=='Draft Service Request' or folderName=='Dealer Owned Draft Service Request' or folderName=='Workbench Service Request'}">
	<div>
		<input name="dirtyValue" id="dirtyValue" ng-disabled="form.$dirty"  type="hidden"  />
	</div>
</c:if>

<div>
    <div class="clear"></div>
    <div class='status' data-ng-if="serviceRequest.id!=null">
        <spring:message code="label.common.status" />
        - {{serviceRequest.displayStatus}}
        <jsp:include page="../common/programGuideSummary.jsp"></jsp:include>
    </div>
    <div class='status' data-ng-if="serviceRequest.id==null">
        <spring:message code="label.common.status" />
        - {{serviceRequest.serviceRequestNumber}}
        <jsp:include page="../common/programGuideSummary.jsp"></jsp:include>
    </div>
    <div class="clear"></div>
</div>
<div class="page-container">
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.general" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
        <!-- this div holds all the accordion info, paste all accordion information inside this-->
        <div>
            <div>
                <div class="labelStyle floatL">
                    <table>
                        <tr>
                            <td ng-show="isSerialNumber"><spring:message code="label.serviceRequest.serialNumber" /> <span class="red">*</span></td>
							<td ng-hide="isSerialNumber"><spring:message code="label.serviceRequest.assetNumber" /> <span class="red">*</span></td>
						</tr>
						<tr>
                             <td>
	                             <a class="text-link" href="#"
									ng-click="toggleSerialNumber()" ng-hide="isSerialNumber">
											<spring:message code="label.common.showSerialNumber" /> 
								 </a>
								 <a class="text-link" href="#" ng-click="toggleSerialNumber()"
									ng-show="isSerialNumber"> <spring:message code="label.common.showAssetNumber" />
								 </a>
								 </br>
	                             <a id="homeSerialNumberRequestHistory" class="text-link" href="#" ng-click="serialNumberRequestHistory(serviceRequest.forItem.serialNumber)"
	                                ng-show="serviceRequest.forItem.serialNumber"> <spring:message code="label.serviceRequest.serialNumberRequestHistory" />
	                             </a>
                            </td>
                        </tr>                        
                    </table>
                </div>
                <div class="floatL">
                    <div data-ng-if="serviceRequest.id==null || serviceRequest.activeServiceRequestAudit.state == 'DRAFT'">
                    	<div ng-show="serviceRequest.forItem.id && isSerialNumber">
	                    	<td>
		                    	<input type="text"  url="listInventoryItems" id="serialNumber" name="serialNumber" ng-show="isSerialNumber" 
		                        	data-ng-model="serviceRequest.forItem.serialNumber" fbs-typeahead required />
	                        	</br>
	                        	<a id="homeEquipmentDetailsPage" class="text-link-ehp" href="#" ng-click="equipmentDetailsPage(serviceRequest.forItem.serialNumber)"
		                                ng-show="serviceRequest.forItem.id && isSerialNumber"> <spring:message code="label.serviceRequest.equipmentDetailPage" />
		                        </a>
	                        </td>
                        </div>
                        <div ng-show="!serviceRequest.forItem.id && isSerialNumber">
	                        <input type="text"  url="listInventoryItems" id="serialNumber" name="serialNumber" ng-show="isSerialNumber" 
		                        	data-ng-model="serviceRequest.forItem.serialNumber" fbs-typeahead required />
                        </div>
                    </div>
                    <div data-ng-if="serviceRequest.id!=null && !serviceRequest.activeServiceRequestAudit.state == 'DRAFT'">
							<a ng-href="#" data-ng-click="equipmentHistoryPageDetail()" ng-show="isSerialNumber"><div class="wid222">{{serviceRequest.forItem.serialNumber}}</div></a>
					</div>
					<div data-ng-if="serviceRequest.id==null || serviceRequest.activeServiceRequestAudit.state == 'DRAFT'">
                    	<input type="text"  url="listInventoryItemsByAssetNumber" id="assetNumber" name="assetNumber" ng-hide="isSerialNumber"
                        	data-ng-model="serviceRequest.forItem.assetNumber" fbs-typeahead required />
                    </div>
                    <div data-ng-if="serviceRequest.id!=null && !serviceRequest.activeServiceRequestAudit.state == 'DRAFT'">
							<a ng-href="#" data-ng-click="equipmentHistoryPageDetail()" ng-hide="isSerialNumber"><div class="wid222">{{serviceRequest.forItem.assetNumber}}</div></a>
					</div>
                </div>
                
                <div class="floatL">
                	<div ng-show='isSerialNumber && form.serialNumber.$error.invalid' class="floatL">
                		<img src="../image/ui-ext/validation/alerts.gif" class="marT10" tooltip="<spring:message code='label.serviceRequest.contractMessage.forCustomer'/>" />
                	</div>
                </div>
                
                <div class="floatL">
                	<div ng-show='!isSerialNumber && form.assetNumber.$error.invalid' class="floatL">
                		<img src="../image/ui-ext/validation/alerts.gif" class="marT10" tooltip="<spring:message code='label.serviceRequest.contractMessage.assetNumber'/>" />
                	</div>	
                </div>
                 <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.customerPoNumber" />
                  </div> 
                <div class="floatL" >
                     <input type="text" name="serviceRequest.activeServiceRequestAudit.customerPoNumber" id="customerPONumber"   
                    ng-blur="validatePONumber(serviceRequest.activeServiceRequestAudit.customerPoNumber,serviceRequest.customerLocation.id,
                    serviceRequest.customerLocation.poRegularExpression, serviceRequest.customerLocation.duplicatePoNumberAllowed)" 
                    data-ng-model="serviceRequest.activeServiceRequestAudit.customerPoNumber" 
                    maxlength="{{serviceRequest.customerLocation.purchaseOrderLength}}" ng-required="serviceRequest.customerLocation.purchaseOrderRequired" />
                </div>
                <div class="fieldSpacerWidth floatL ">
        			 <div ng-if="PONumberDuplicate">
                    	 <div ng-show='PONumberDuplicate' class="floatL">
                        <img id="serialNumberAlert" src="../image/ui-ext/validation/alerts.gif" class="marT10" class="visibility-hidden"
                            tooltip="<spring:message code='label.serviceRequest.PONumber.invalid'/>" />
                    	</div>
                    </div> 
                   <div ng-if="PONumberExits"> 
                    	 <div ng-show='PONumberExits' class="floatL">
                        <img id="serialNumberAlert" src="../image/ui-ext/validation/alerts.gif" class="marT10" class="visibility-hidden"
                            tooltip="<spring:message code='label.serviceRequest.PONumber.duplicate'/>" />
                    	</div>
                     </div>                    
                </div>               
            </div>
            <div class="clear"></div>

            <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.serviceRequestNumber" />
                </div>
                <div class="floatL">
                    <input type="text" data-ng-readonly="true" data-ng-model="serviceRequest.serviceRequestNumber"
                        data-ng-init="serviceRequest.serviceRequestNumber='Draft'">
                </div>
                 <div class="labelStyle floatL" ng-show="serviceRequest.forContract">
                    <spring:message code="columnTitle.contract.contractCode" />
                  </div> 
                <div class="floatL" >
                       <input type="text" data-ng-readonly="true" data-ng-model="serviceRequest.forContract.code" ng-show="serviceRequest.forContract" />
                </div>
                <div data-ng-if="serviceRequest.id!=null">
	                <div class="labelStyle floatL">
	                    <spring:message code="label.quote.workOrderNumber" />
	                </div>
	                <div class="floatL" >
	                       <input type="text"  data-ng-model="serviceRequest.activeServiceRequestAudit.trackingNumber" data-ng-readonly="true" />
	                </div>
                </div>
                
            </div>
            
			             
            
            
        </div>
    </div>

    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.customerInfo" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
              <div>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.customerName" />
            </div>
            <div class="floatL marR20">
                <input type="text" class="textInput" data-ng-readonly="true" data-ng-model="serviceRequest.customerLocation.customerName" />
            </div>
            <div class="labelStyle floatL marL2">
                <spring:message code="label.serviceRequest.customerBillTo" />
            </div>
            <div class="floatL">
                <input type="text" data-ng-readonly="true" data-ng-model="serviceRequest.billTo" />
            </div>
        </div>

        <div class="clear"></div>
        <input id="location" type="hidden" data-ng-model="serviceRequest.customerLocation.id" value="{{serviceRequest.customerLocation.id}}" />
        <div>
            <div class="labelStyle floatL">
                <spring:message code="label.quote.customerLocation" />
                <br> <a href="" id="homeOpenLocationServiceEvents" ng-click="locationWiseServiceRequest(serviceRequest.customerLocation.id)"
                    ng-show="serviceRequest.customerLocation.id" class="text-link"> <spring:message
                        code="label.serviceRequest.openLocationServiceEvents" />
                </a>
            </div>
            <div class="floatL marR20">
                <input type="text" data-ng-readonly="true" data-ng-model="serviceRequest.customerLocation.locationsMapkey" />
            </div>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.customerPhoneNumber" />
            </div>
            <div class="floatL">
                <input type="text"  data-ng-model="serviceRequest.customerPhoneNumber" />
            </div>
        </div>
        <div class="clear"></div>
        <div>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.customerAddress" />
            </div>
            <div class="floatL marR20">
                <input type="text" data-ng-readonly="true" data-ng-model="serviceRequest.customerLocation.address.addressLine1" />
            </div>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.customerContract" />
            </div>
            <div class="floatL">
                <input type="text" data-ng-model="serviceRequest.customerContact"/>
            </div>
        </div>
		<div class="clear"></div>
		<div>
			<div class="labelStyle floatL">
				<spring:message code="label.serviceRequest.postalCode" />
			</div>
			<div class="floatL marR20">
				<input type="text" data-ng-readonly="true" data-ng-model="serviceRequest.customerLocation.address.zipCode" />
			</div>
		</div>
		<div>
            <div ng-show="isCustomerUser">
                <div class="labelStyle floatL">
                    <spring:message code="label.common.threshold" />:
                </div>
                <div class="floatL marR20">
                    <input type="text" disable="true" ng-style="{width:'182px'}" ng-model="serviceRequest.customerLocation.quoteThreshold" money> </input>
                </div>
            </div>

            <div ng-show="servicingDealer">
                <div class="labelStyle floatL">
                    <spring:message code="label.common.threshold" />:
                </div>
                <div class="floatL marR20">
                    <span ng-bind="serviceRequest.customerLocation.preferredCurrency"></span><input type="text" ng-readonly="true" ng-style="{width:'182px'}"
                        ng-model="dealerThreshold"> </input>
                </div>
           </div>
            <div ng-show="isInternalUserOrOwningDealer">
             <div class="labelStyle floatL">
                    <spring:message code="label.common.customerThreshold" />:
                </div>
                <div class="floatL marR20">
                    <input type="text" disable="true" ng-style="{width:'182px'}" ng-model="serviceRequest.customerLocation.quoteThreshold" money> </input>
                </div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.dealerQuoteThreshold" />
                </div>
                <div class="floatL marR20">
                    <span ng-bind="serviceRequest.customerLocation.preferredCurrency"></span><input type="text" ng-readonly="true" ng-style="{width:'182px'}"
                        ng-model="dealerThreshold"> </input>
                </div>
           </div>

        </div>

    </div>

    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.equiptmentDetails" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
        <!-- this div holds all the accordion info, paste all accordion information inside this-->

        <div>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.assetNumber" />
            </div>
            <div class="floatL marR20">
                <input type="text" data-ng-readonly="true" data-ng-model="serviceRequest.forItem.assetNumber" />
            </div>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.contractStartDate" />
            </div>
            <div class="floatL">
                <input type="text" data-ng-readonly="true" data-ng-model="contractDuration.fromDate" readonly>
            </div>
        </div>

        <div>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.modelNumber" />
            </div>
            <div class="floatL marR20">
                <input type="text" data-ng-readonly="true" data-ng-model="serviceRequest.forItem.model.name" />
            </div>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.contractEndDate" />
            </div>
            <div class="floatL">
                <input type="text" data-ng-readonly="true" data-ng-model="contractDuration.tillDate" readonly>
            </div>
        </div>

        <div>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.productDescription" />
            </div>
            <div class="floatL marR20">
                <input type="text" data-ng-readonly="true" data-ng-model="serviceRequest.forItem.product.name" />
            </div>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.lastServiceDate" />
            </div>
            <div class="floatL">
                <input type="text" data-ng-readonly="true" data-ng-model="serviceRequest.forItem.lastServiceDate" />
            </div>
        </div>

        <div>    
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.leaseStartDate" />
            </div>
            <div class="floatL marR20">
                <input type="text" data-ng-model="serviceRequest.forItem.leaseStartDate" data-ng-readonly="true"/>
            </div>
              <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.leaseEndDate" />
            </div>
            <div class="floatL">
                <input type="text" data-ng-model="serviceRequest.forItem.leaseEndDate" data-ng-readonly="true"/>
            </div>
        </div>

        <div>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.maintenanceType" />
            </div>
            <div class="floatL marR20">
                <input type="text" data-ng-readonly="true" data-ng-model="serviceRequest.forItem.maintenanceType" />
            </div>
          
        </div>

    </div>

    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.dealership" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
        <!-- this div holds all the accordion info, paste all accordion information inside this-->

        <div>
             <div ng-show="!servicingDealer">
                <div>
                    <div class="labelStyle floatL">
                        <spring:message code="label.serviceRequest.chooseDealerInformation" />
                        <span class="red" ng-hide="serviceRequest.dealerType=='DIFFERENT_DEALER'">*</span>
                    </div>
                    <div class="floatL">
                        <button type="button" class="blue-btn marR20"  data-ng-init="serviceRequest.dealerType='PREFERRED_DEALER'" name="dealerType"
                            data-ng-model="serviceRequest.dealerType" data-btn-radio="'PREFERRED_DEALER'" ng-required="serviceRequest.dealerType == ''" ng-show="isPreferredDealerValid" ng-click=resetDiffDealer()>
                            <spring:message code="label.serviceRequest.preferredDealer" />
                        </button>
                    </div>
                        <div class="marR20 floatL"></div>
                        <div class="floatL">
                            <button type="button" class="blue-btn marR20" name="dealerType" data-ng-model="serviceRequest.dealerType"
                                data-btn-radio="'ALTERNATE_DEALER'" ng-required="serviceRequest.dealerType == ''" ng-show="isAlternateDealerValid">
                                <spring:message code="label.serviceRequest.alternateDealer" />
                            </button>
                        </div>
                    <div class="marR20 floatL"></div>
                    <div class="floatL">
                        <button type="button" class="blue-btn marR20" name="dealerType" data-ng-model="serviceRequest.dealerType" ng-show="isInternalUserOrOwningDealer || (isCustomerUser && serviceRequest.customerLocation.customer.needDifferentDealerEnabled)" data-btn-radio="'DIFFERENT_DEALER'">
                            <spring:message code="label.serviceRequest.needDifferentDealer" />
                        </button>
                    </div>
                </div>
            </div>
           <div ng-show="servicingDealer">
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.DealerName" />
                </div>
                <div class="floatL marR20">
                    <input type="text" data-ng-model="serviceRequest.forDealer.name" data-ng-disabled="true" />
                </div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.DealerPhoneNumber" />
                </div>
                <div class="floatL">
                    <input type="text" data-ng-model="serviceRequest.forDealer.address.phone" data-ng-disabled="true" readonly />
                </div>
            </div> 

            <div class="fieldSpacerHeight clear hgt10"></div>

            <div ng-if="serviceRequest.dealerType == 'PREFERRED_DEALER' && !servicingDealer">

                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.preferredDealerName" />
                </div>
                <div class="floatL">
                    <input type="text" data-ng-model="serviceRequest.forItem.preferredDealer.name" readonly />
                </div>

                <div class="clear"></div>

                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.preferredDealerId" />
                </div>
                <div class="floatL">
                    <input type="text" data-ng-model="serviceRequest.forItem.preferredDealer.serviceProviderNumber" readonly />
                </div>
                <div class="clear"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.preferredDealerPhoneNumber" />
                </div>
                <div class="floatL">
                    <input type="text" data-ng-model="serviceRequest.forItem.preferredDealer.address.phone" readonly />
                </div>
            </div>

            <div ng-if="serviceRequest.dealerType == 'ALTERNATE_DEALER' && !servicingDealer">
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.alternateDealerName" />
                </div>
                <div class="floatL">
                    <input type="text" data-ng-model="serviceRequest.forItem.alternateDealer.name" readonly />
                </div>

                <div class="clear"></div>

                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.alternateDealerId" />
                </div>
                <div class="floatL">
                    <input type="text" data-ng-model="serviceRequest.forItem.alternateDealer.serviceProviderNumber" readonly />
                </div>
                <div class="clear"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.alternateDealerPhoneNumber" />
                </div>
                <div class="floatL">
                    <input type="text" ng-model="serviceRequest.forItem.alternateDealer.address.phone" readonly />
                </div>
            </div>
            <div ng-hide="servicingDealer">
            <div ng-if="serviceRequest.dealerType == 'DIFFERENT_DEALER'">
                <div class="labelStyle floatL">
               
                <table >
                    <tr><td ng-show="isDealerName"><spring:message code="label.common.dealerName" />:</td>
                    <td ng-hide="isDealerName"><spring:message code="label.common.dealerNumber" />:</td><tr>
                        <td><a class="text-link" href="#" ng-click="toggleDealerName()" ng-hide="isDealerName">
                                        <spring:message code="label.common.showDealerName" /> 
                        </a>
                        <a class="text-link" href="#" ng-click="toggleDealerName()" ng-show="isDealerName"> 
                                        <spring:message code="label.common.showDealerNumber" />
                        </a>
                        </td>
                     </tr>
                     </table>
                     
                </div>
                <div class="floatL">
                    <input type="text" url="listServiceProviders" id="dealerName" name="dealerName" ng-show="isDealerName" 
                        data-ng-model="serviceRequest.forDealer.name" fbs-typeahead data-ng-required="serviceRequest.dealerType == 'DIFFERENT_DEALER' && isInternalUserOrOwningDealer"/>
                      
                        
                    <input type="text" url="listServiceProviderByNumber" id="dealerNumber" name="dealerNumber" ng-hide="isDealerName" 
                        data-ng-model="serviceRequest.forDealer.serviceProviderNumber" fbs-typeahead data-ng-required="serviceRequest.dealerType == 'DIFFERENT_DEALER' && isInternalUserOrOwningDealer"/>
                      
                
                </div>
                <span class="floatL">
                	<div data-ng-show='isDealerName && form.dealerName.$error.invalid && isDealerName'>
                		<img src="../image/ui-ext/validation/alerts.gif" class="marT10" tooltip="<spring:message code='label.common.dealerName.invalid'/>"></img>
                	</div>
                	<div data-ng-show='!isDealerName && form.dealerNumber.$error.invalid'>
                		<img src="../image/ui-ext/validation/alerts.gif" class="marT10" tooltip="<spring:message code='label.common.dealerNumber.invalid'/>"></img>
                	</div>
                </span>
             </div>
            </div>
    </div>
</div>
    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.callCondition" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
        <!-- this div holds all the accordion info, paste all accordion information inside this-->

        <div>
            <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.callType" />
                     <span class="red">*</span>
                </div>
                   <div class="floatL marR20">
                    <select data-ng-model="serviceRequest.activeServiceRequestAudit.callType.id" name="callType"
                        ng-options="callType.listOfValues.id as callType.listOfValues.name for callType in callTypes" class="dropdown-normal" required
                        data-ng-change="callTypeChange()">
                        <option value="">
                            <spring:message code="label.serviceRequest.select" />
                        </option>
                    </select>
                    <div class="alert-error" data-ng-show="form.callType.$error.notinternal" >
            			<spring:message code="error.common.callType.internal" />
            		</div>
                </div>
            </div>
            <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.serviceRequest.equipmentDown" />
                </div>
                <div class="floatL">
					<div class="floatL">
                    <spring:message code="label.common.yes" />
                    <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.equipmentDown" ng-value="true" ng-boolean-radio
                        data-ng-init="serviceRequest.activeServiceRequestAudit.equipmentDown=false" />
                    <spring:message code="label.common.no" />
                    <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.equipmentDown" ng-value="false" ng-boolean-radio
                        data-ng-init="serviceRequest.activeServiceRequestAudit.equipmentDown=false" />
					</div>
                    <div class="floatR marL5" ng-show='serviceRequest.activeServiceRequestAudit.equipmentDown'>
                        <img src="../image/Redwarning.png" />
                    </div>

                </div>
            </div>
        </div>
        <div class="radioClear"></div>
        <div>
            <%--
			<div class="labelStyle floatL">
				<spring:message code="label.serviceRequest.rental/LoanerStartDate" />
			</div>
			<div class="floatL">
				<input type="text">
			</div>
			--%>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.quoteJob" />
            </div>
            <div class="floatL">
                <spring:message code="label.common.yes" />
                <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.quoteRequired" ng-value="true" ng-boolean-radio
                    data-ng-init="serviceRequest.activeServiceRequestAudit.quoteRequired=false" />
                <spring:message code="label.common.no" />
                <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.quoteRequired" ng-value="false" ng-boolean-radio
                    data-ng-init="serviceRequest.activeServiceRequestAudit.quoteRequired=false" />
            </div>
        </div>
        <div class="radioClear"></div>

         <div ng-show="enableEmergencyRequest">
            <div class="floatL">
                <div ng-show="serviceRequest.activeServiceRequestAudit.emergencyRequest!=true" class="labelStyleforNOEmergencyRequest">
                    <spring:message code="label.serviceRequest.emergencyRequest" />
                </div>
                <div ng-show="serviceRequest.activeServiceRequestAudit.emergencyRequest==true" class="labelStyleforEmergencyRequest">
                    <spring:message code="label.serviceRequest.emergencyRequest" />
                </div>
            </div>
            <div class="floatL">
                <spring:message code="label.common.yes" />
                <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.emergencyRequest" ng-value="true" ng-boolean-radio
                    data-ng-init="serviceRequest.activeServiceRequestAudit.emergencyRequest=false" ng-click="emergencyServiceRequest()" />                   
                <spring:message code="label.common.no" />
                <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.emergencyRequest" ng-value="false" ng-boolean-radio
                    data-ng-init="serviceRequest.activeServiceRequestAudit.emergencyRequest=false" />
            </div>
        </div>
        <div class="radioClear"></div>
    </div>

    <div class="accordion-header contentPane">
        <!-- accordion header -->
        <spring:message code="title.common.problemDescription" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
    <div class="overflow-hidden accordion-info">
        <!-- this div holds all the accordion info, paste all accordion information inside this-->

        <div>
        <div ng-show="selfDiagonosisEnabled">
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.Self-Diagnose" /> <span ng-show="selfDiagnosisMandatory" class="red">*</span>
            </div>
           
            <div class="floatL">
                <spring:message code="label.common.yes" />
                <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.selfDiagnosed" ng-value="true" ng-boolean-radio ng-click="getSystemList()"
                    data-ng-init="serviceRequest.activeServiceRequestAudit.selfDiagnosed=false" ng-required="selfDiagnosisMandatory" />
                <spring:message code="label.common.no" />
                <input type="radio" data-ng-model="serviceRequest.activeServiceRequestAudit.selfDiagnosed" ng-value="false" ng-boolean-radio
                    data-ng-init="serviceRequest.activeServiceRequestAudit.selfDiagnosed=false" ng-required="selfDiagnosisMandatory" ng-click="clearSelfDiagnoseData()"/>
            </div>
            
            </div>

            <div class="radioClear"></div>

            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.ErrorCode" />
            </div>
            <div class="floatL">
                <input type="text"  url="populateErrorCodesByProductId?productId={{serviceRequest.forItem.product.id}}"  data-ng-model="serviceRequest.activeServiceRequestAudit.errorCode.code"
                    fbs-typeahead />
            </div>
            <div class="clear"></div>


            
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.ErrorCodes" />
            </div>
            <div class="floatL">
                <input type="text" data-ng-model="serviceRequest.activeServiceRequestAudit.errorCodes"/>       
            </div>
            <div class="clear"></div>
            
            
            
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.FaultCodelocation" />
            </div>
            <div class="floatL">
                <input type="text"  data-ng-model="serviceRequest.activeServiceRequestAudit.faultLocations"/>       
            </div>
            <div class="clear"></div>
            
            
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.potentialProblemDescription" />
                <span class="red">*</span>
            </div>
            <div class="floatL">
                <textarea name="problemDescription" max-length data-ng-model="serviceRequest.activeServiceRequestAudit.problemDescription" rows="4" cols="500"
                class="width500" required ></textarea>
            </div>
            <div class="clear"></div>
            <div class="labelStyle floatL">
                <spring:message code="label.serviceRequest.additionalDetails" />
            </div>
            <div class="floatL">
                <textarea name="additionalDetails" max-length data-ng-model="serviceRequest.activeServiceRequestAudit.additionalDetails" rows="4" cols="500"
                    class="width500"></textarea>
                <!--   <textarea name="additionalDetails" max-length data-ng-model="serviceRequest.customerLocation.customerNotes" rows="4" cols="500"
            class="width500" required></textarea>      -->
           </div>
           <div ng-show="isInternalUserOrOwningDealer">
            <div  ng-hide="serviceRequest.customerLocation.customerNotes==null">
                <button type="button" class="blue-btn" data-ng-click="getCustomerNotes()">
                    <spring:message code="label.common.customernotes" />
                </button>
            </div>
          </div>
            
			
            <div class="clear"></div>
            <div ng-show="isCustomerUser">
                <div class="clear"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.quote.notesForDealer" />:
                </div>
                <div class="floatL">
                    <textarea max-length data-ng-model="serviceRequest.activeServiceRequestAudit.notesForDealer" rows="4" cols="500" class="width500"></textarea>
                </div>
                <div class="clear"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.quote.notesForNMHG" />:<span class="red" ng-show="serviceRequest.dealerType == 'DIFFERENT_DEALER'">*</span>
                </div>
                 <div class="floatL">
                    <textarea max-length data-ng-model="serviceRequest.activeServiceRequestAudit.notesForNMHG" rows="4" cols="500" class="width500" ng-required="(isCustomerUser && serviceRequest.dealerType == 'DIFFERENT_DEALER')"></textarea>
                </div> 
            </div>
            <div class="clear"></div>
             <div ng-show="isInternalUserOrOwningDealer">
               <div class="clear"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.common.internalComments" />:
                </div>
                <div class="floatL">
                    <textarea max-length data-ng-model="serviceRequest.activeServiceRequestAudit.internalComments" rows="4" cols="500" class="width500"></textarea>
                </div>
                <div class="clear"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.quote.notesForDealer" />:
                </div>
                <div class="floatL">
                    <textarea max-length data-ng-model="serviceRequest.activeServiceRequestAudit.notesForDealer" rows="4" cols="500" class="width500"></textarea>
                </div>
                <div class="clear"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.quote.notesForCustomer" />:
                </div>
                <div class="floatL">
                    <textarea max-length data-ng-model="serviceRequest.activeServiceRequestAudit.notesForCustomer" rows="4" cols="500" class="width500"></textarea>
                </div>
           </div>
            <div class="clear"></div>
           <div ng-show="servicingDealer">
                <div class="clear"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.quote.notesForNMHG" />:
                </div>
                <div class="floatL">
                    <textarea max-length data-ng-model="serviceRequest.activeServiceRequestAudit.notesForNMHG" rows="4" cols="500" class="width500"></textarea>
                </div>
                <div class="clear"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.quote.notesForCustomer" />:
                </div>
                <div class="floatL">
                    <textarea max-length data-ng-model="serviceRequest.activeServiceRequestAudit.notesForCustomer" rows="4" cols="500" class="width500"></textarea>
                </div>
                <div class="clear"></div>
            </div>
            <div class="clear"></div>
        </div>
    </div>
    
</div>

  <div class="accordion-header contentPane">       
        <spring:message code="title.common.attachment" />
        <span class="expand-collapse collapse-icon"></span>
    </div>
  <div class="overflow-hidden accordion-info">
   <div class="clear"></div>
            <div class="labelStyle floatL">
                <spring:message code="label.common.Attachment" />
                :
            </div>
            <div class="floatL">
                <button type="button" class="blue-btn" data-ng-click="uploadDocuments()">
                    <spring:message code="label.common.Attach" />
                </button>
            </div>
           
            <div class="clear"></div>
            <div class="radioClear"></div>
            <div>
                <%@include file="attachedDocuments.jsp"%>
            </div>
            <div class="clear"></div>
  </div>
<br/>

<div class="overflow-hidden marT10">

    <div class="centered marB10">
        <c:if test="${folderName!='Draft Service Request' && folderName!='Dealer Owned Draft Service Request' && folderName!='Workbench Service Request'}">

           <button type="button" class="blue-btn" data-ng-click="save()" ng-disabled='(form.serialNumber.$error.invalid || form.serialNumber.$error.required)||(form.assetNumber.$error.invalid || form.assetNumber.$error.required)'>
                <spring:message code="label.Common.save" />
            </button>


            <button type="button" class="blue-btn" data-ng-click="validateServiceRequest('')" ng-disabled='form.$invalid ||PONumberDuplicate==true||PONumberExits'>
                <spring:message code="label.Common.validate" />
            </button>
            <button type="button" class="blue-btn" data-ng-click="cancel()">
                <spring:message code="label.Common.cancel" />
            </button>
        </c:if>
    </div>
    <div class="centered marB10">
        <c:if test="${folderName=='Draft Service Request' || folderName=='Dealer Owned Draft Service Request' || folderName=='Workbench Service Request'}">
            <button type="button" class="blue-btn" data-ng-click="save()">
                <spring:message code="label.Common.save" />
            </button>
            <button type="button" class="blue-btn" data-ng-click="validateServiceRequest('Submit Service Request')" ng-disabled='form.$invalid ||PONumberDuplicate==true||PONumberExits'>
                <spring:message code="label.Common.validate" />
            </button>

            <button type="button" class="blue-btn" data-ng-click="deleteDraftServiceRequest()">
                <spring:message code="label.common.delete" />
            </button>
			<button type="button" class="blue-btn" data-ng-click="cancel()">
                <spring:message code="label.Common.cancel" />
            </button>
        </c:if>
    </div>
    <div popup="shouldBeOpen" close="close()">
        <div class="modal-header">
                <span class="boldText"> <spring:message code="label.Common.validate" /></span>
        </div>
         <div class="modal-body"  style="height:220px; width:550px;">
        	<jsp:include page="validateServiceRequest.jsp"></jsp:include>
        </div>
        
    </div>
    
    <jsp:include page="showServiceRequestWarningMessage.jsp"/>

    <div popup="emergencySR" close="close()">
        <div class="modal-header">
            <center>
                <h6>
                    <spring:message code="label.serviceRequest.emergencySR" />
                </h6>
            </center>
        </div>
        <div class="modal-body">
            <center>
                <spring:message code="label.home.emrgencySROP" />
            </center>
            <div class="clear"></div>
            <div class="clear"></div>
            <center>
                <button type="button" class="blue-btn" ng-click="close()">
                    <spring:message code="label.serviceRequest.underWarranty.ok" />
                </button>
            </center>
        </div>
    </div>
 	<div popup="openUploadDocWindow" close="close()">
        <div class="modal-header">
            <h6>
                <spring:message code="label.common.attachmentwindow" />
            </h6>
        </div>
        <div class="modal-body">
            <jsp:include page="../fileUpload/fileUpload.jsp"></jsp:include>
            <div class="clear"></div>

        </div>
    </div>
     <div popup="selfDiagnoseWindow" close="close()">
        <div class="modal-header">
            <center>
                <h6>
                   <%--  <spring:message code="label.serviceRequest.emergencySR" /> --%>
                   Service Diagnosis User Guide
                </h6>
            </center>
        </div>
        <div class="modal-body">
            <jsp:include page="selfDiagnosisUserGuide.jsp"/>
        </div>
    </div>
    
</div>