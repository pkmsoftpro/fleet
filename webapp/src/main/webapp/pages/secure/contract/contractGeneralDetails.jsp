        <div alert-msg></div>
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="title.common.general" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
            <div>
                <div class="labelStyle ti0 floatL">
                    <spring:message code="label.newContract.contractCode" /><span class="red">*</span>
                </div>
                <div class="floatL">
                    <%-- <c:out value="${contract.code}"/> ${contract.code}  --%>
                    <INPUT TYPE="text" data-ng-model="contract.code" data-ng-readonly="contractId!=''" data-ng-required='true'>
                </div>
                <div class="fieldSpacerWidth floatL"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.contractType" /><span class="red">*</span>
                </div>
                  <div ng-show="contractId!=''">
                <div class="floatL">
                 <INPUT TYPE="text" data-ng-model="contract.type" data-ng-readonly="contractId!=''">
                </div>
                </div>
                  <div ng-hide="contractId!=''">
                   <div class="floatL">
                    <select id="contractType" data-ng-model="contract.type" name="contractType" ng-options="c for c in contractTypeList" class="dropdown-normal"
               data-ng-readonly="isReadOnly()" data-ng-required="true">
                <option value="">-- Select --</option>
               </select>
                </div>
                </div>
            </div>
            <div class="clear"></div>
             <div>
                <div class="labelStyle ti0 floatL">
                    <spring:message code="label.newContract.contractStartDate" /><span class="red">*</span>
                </div>
                <div class="floatL">
	                <input type="text" data-ng-model='contract.activeContractAudit.availability.fromDate' datepicker-popup={{dateFormat}} data-ng-required='true' data-ng-disabled="isReadOnly()"/>
               </div>
                <div class="fieldSpacerWidth floatL"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.contractEndDate" /><span class="red">*</span>
                </div>
                <div class="floatL">
                	<input type="text" data-ng-model='contract.activeContractAudit.availability.tillDate' datepicker-popup={{dateFormat}} min="contract.activeContractAudit.availability.fromDate" data-ng-required='true' data-ng-disabled="isReadOnly()"/>
                </div>
            </div>
            <div class="clear"></div>
           <div>
               <div ng-if="contractId==''">
                <div class="floatL">
                <div ng-init="contract.activeContractAudit.status='ACTIVE'"></div>
                </div>
                </div>
                <div ng-show="contractId!=''">
                 <div class="labelStyle ti0 floatL">
                    <spring:message code="label.newContract.contractStatus" /><span class="red">*</span>
                </div>
                <div class="floatL">
                <select id="contractStatus" data-ng-model="contract.activeContractAudit.status" name="contractStatus" ng-options="c for c in contractStatus" class="dropdown-normal"
               data-ng-disabled="isDealerOwned==false">
                <option value="">-- Select --</option>
               </select>
                </div>
                </div>
                <div class="clear"></div> 
                <div class="labelStyle floatL">
                    <spring:message code="label.common.servicingDealer" /><span class="red">*</span>
                </div>
                <div ng-show="!isDealerOwned">
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contract.activeContractAudit.servicingDealer.name" data-ng-readonly="isReadOnly()">
                </div>
                </div>
                <div ng-hide="!isDealerOwned">
                <div class="floatL">
                    <input type="text" url="listServiceProviders" ng-model="contract.activeContractAudit.servicingDealer.name" fbs-typeahead  data-ng-required="true" data-ng-readonly="contractId!=''"/>
                </div>
                </div>
            </div>
            <div class="clear"></div>
           
            <div>
                <div class="labelStyle ti0 floatL">
                    <spring:message code="label.serviceRequest.customerName" /><span class="red">*</span>
                </div>
                <div ng-show="!isDealerOwned">
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contract.activeContractAudit.forCustomer.name" data-ng-readonly="isReadOnly()">
                </div>
                </div>
                <div ng-hide="!isDealerOwned">
                <div class="floatL">
                   <input type="text" url="listCustomersBelongsToAnOrganization"  ng-model="contract.activeContractAudit.forCustomer.name"  fbs-typeahead data-ng-required="true" data-ng-readonly="contractId!=''"/>
                </div>
                </div>
              <div class="fieldSpacerWidth floatL"></div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.customerBillTo" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="customerBillTo" data-ng-readonly="true">
                </div>
            </div>
            <div class="clear"></div>
            
            <div>
                <div class="labelStyle ti0 floatL">
                    <spring:message code="label.newContract.customerShipTo" /><span class="red">*</span>
                </div>
              <div data-ng-if="contractId!=''">
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contract.activeContractAudit.shipTo.code" data-ng-readonly="true">
               </div>
               </div>
             <div data-ng-if="contractId==''">
             <div class="floatL">
               <!-- <INPUT TYPE="text" data-ng-model="contract.activeContractAudit.shipTo.name"  typeahead-min-length='3' typeahead-on-select="setLocation($item)" typeahead="location.name as location.name for location in listLocationsOfACustomer($viewValue,contract.activeContractAudit.forCustomer.id)" required /> -->
               <INPUT TYPE="text" id='locationName' name='locationCode' typeahead-min-length='3' url="listLocationsCodeOfACustomer?customerId={{contract.activeContractAudit.forCustomer.id}}" data-ng-model="contract.activeContractAudit.shipTo.code"
            fbs-typeahead required />
               </div>
               </div>
                <div class="fieldSpacerWidth floatL"></div>
                 <div ng-show="!isDealerOwned">
                <div class="labelStyle floatL">
                    <spring:message code="label.contract.primary" />
                </div>
                <div class="floatL">{{isPrimary}}</div>
              </div>
            </div>
            <div class="clear"></div>
            <div>
                <div class="labelStyle ti0 floatL">
                    <spring:message code="label.common.currency" />
                </div>
                <div class="floatL">
                    <INPUT TYPE="text" data-ng-model="contract.activeContractAudit.forCustomer.preferredCurrency" data-ng-readonly="true">
                </div>
            </div>
            <div class="clear"></div>
            <div>
                <div class="labelStyle ti0 floatL font11p">
                    <spring:message code="label.newContract.alertWindow" />
                </div>
                <div class="floatL">
                    <INPUT type="text" data-ng-model="contract.activeContractAudit.alertWindowFromExpiryDate" class="wid120"> <span
                        class="labelStyle pad0 align-top font11p"> <spring:message code="label.newContract.alertWindow.days" /> </span>
                </div>
            </div>
            <div class="clear"></div>
            <div ng-if='isDealerOwned'>
              <div>
                <div class="labelStyle ti0 floatL">
                    <spring:message code="label.invoice.minHours" />
                </div>
                <div class="floatL">
                    <input TYPE="text" data-ng-model="contract.minHours" class="wid120"/>
                </div>
            </div>
            <div>
             <div class="clear"></div>
            <div class="labelStyle floatL">
                    <spring:message code="label.invoice.isLocationLevelInvoiceRequired" />
                </div>
                <INPUT type="checkbox" data-ng-model="contract.isLocationLevelInvoice" >
            </div>
            </div>
        </div>
              
      <div class="fieldSpacerHeight hgt25 clear"></div>
        <%-- <%@include file="machinesCovered.jsp"%> --%>
       <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="label.newContract.machinesCovered" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        
        <div class="overflow-hidden accordion-info">
            <div class="gridStyle marL25 history-table" data-ng-grid="gridForMachines"></div>
        </div>

        <div class="fieldSpacerHeight hgt25 clear"></div>

        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="label.newContract.costCategories" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
            <%@include file="costCategories.jsp"%>
        </div>
        <div class="clear"></div>
 
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="label.newContract.travelMatrix" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
       <div class="overflow-hidden accordion-info">
            <%@include file="travelMatrix.jsp"%>
        </div> 
       
        <div class="clear"></div>
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="label.newContract.taxInformation" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
            <!-- Repeat Table Test Widget -->
            <!-- <div class="containerDiv marL25 wid800" ng-model="contract.activeContractAudit.applicableTaxDetails" repeatAttrs="customerState,certificationNumber"> -->
                <div class="containerDiv"
        ng-init="contract.activeContractAudit.applicableTaxDetails = contract.activeContractAudit.applicableTaxDetails == null ? [] : contract.activeContractAudit.applicableTaxDetails"
        ng-model="contract.activeContractAudit.applicableTaxDetails" repeater>
                <input type="hidden" name="contract.activeContractAudit.applicableTaxDetails" data-ng-model="contract.activeContractAudit.applicableTaxDetails">
                <!-- Header Section -->
                <div class="rowDivHeader wid800">
                    <div class="cellDivHeader wid300">Customer State</div>
                    <div class="cellDivHeader wid300">Certification Number</div>
                    <div class="cellDivHeader wid200">
						<a class="add-row" ng-click="addInputRow('contract.activeContractAudit.applicableTaxDetails','customerState,certificationNumber')"></a>
                    </div>
                </div>

                <!-- Repeat Template Section -->
                <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" class=" wid800"
                    ng-repeat="item in contract.activeContractAudit.applicableTaxDetails">
                    <div class="cellDiv wid300">
                        <input class="marTB2" type="text" data-ng-model='item.customerState' />
                    </div>
                    <div class="cellDiv wid300">
                        <input class="marTB2" type="text" class="repeat" data-ng-model='item.certificationNumber' />
                    </div>
                    <div class="cellDiv wid200">
                        <a class="class" ng-click="deleteThis($index,'contract.activeContractAudit.applicableTaxDetails')"><i class="icon-trash"></i> </a>
                    </div>
                </div>
            </div>
        </div>
       
       <div ng-show="contractId!=''">
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="label.newContract.history" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        
        <div class="overflow-hidden accordion-info">
            <div class="gridStyle marL25 history-table" data-ng-grid="gridForContractAuditHistory" data-ng-click="contractAudit(selectedItems)"></div> 
        </div>
        </div>
       		        <div class="accordion-header contentPane">
            <spring:message code="label.common.attachments" />
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
     
        <div class="accordion-header contentPane">
            <!-- accordion header -->
            <spring:message code="label.newContract.commentsHeader" />
            <span class="expand-collapse collapse-icon"></span>
        </div>
        <div class="overflow-hidden accordion-info">
            <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.newContract.comments" /><span class="red">*</span>
                </div>
                <div class="floatL">
                    <textarea name="comments" max-length data-ng-model="contract.activeContractAudit.comments" style="width: 600px; height: 70px" cols="40" data-ng-required="true"></textarea>
                </div>
            </div>
        </div>    
        <div class="clear"></div>
<div data-ng-if="contractId!=''">
    <button type="button" class="blue-btn btn-primary marL455" data-ng-click="save()" ng-disabled='form.$invalid'>
        <spring:message code="label.contract.update" />
    </button>
   <c:if test="${isDealerOwned}">
    <button type="button" class="blue-btn btn-primary" data-ng-click="printContract()">
        <spring:message code="label.common.print" />
    </button>
   </c:if>
</div>
<div data-ng-if="contractId==''">
    <button type="button" class="blue-btn btn-primary marL455" data-ng-click="submit()" ng-disabled='form.$invalid'>
        <spring:message code="label.common.save" />
    </button>
</div>