<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!-- ServiceIntervalSection -->
<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.serviceCode.serviceInterval" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div class="containerDiv wid1000"
        data-ng-init="serviceCodeDefinition.serviceCodeInterval = serviceCodeDefinition.serviceCodeInterval == null ? [] : serviceCodeDefinition.serviceCodeInterval"
        data-ng-model="serviceCodeDefinition.serviceCodeInterval" repeater>
        <input type="hidden" name="serviceCodeDefinition.serviceCodeInterval" data-ng-model="serviceCodeDefinition.serviceCodeInterval">
        <!-- Header Section -->
        <div class="rowDivHeader wid1000">
            <div class="cellDivHeader wid250">
                <spring:message code="label.serviceCode.model" />
            </div>
            <div class="cellDivHeader wid350">
                <spring:message code="label.serviceCode.modelDescription" />
            </div>
            <div class="cellDivHeader wid300">
                <spring:message code="label.serviceCode.frequency" />
            </div>
            <div class="cellDivHeader wid120">
                <a class="add-row"
                    data-ng-click="addInputRow('serviceCodeDefinition.serviceCodeInterval','itemGroup.id,itemGroup.description,frequency,hourlyService')"></a>
            </div>
        </div>
        <!-- Repeat Template Section -->

        <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" ng-repeat="serviceInterval in serviceCodeDefinition.serviceCodeInterval">
            <div class="cellDiv wid250">
                <input type="text" fbs-typeahead
                    data-ng-model='serviceInterval.itemGroup.name' url="getModels"
                    ng-change="generateModelDescription($index,serviceInterval.itemGroup.name)" data-ng-required="true"></input>
            </div>
            <div class="cellDiv wid350">
                <div data-ng-bind="serviceInterval.itemGroup.description" required></div>
            </div>
            <div class="cellDiv wid300">
                <input style="width: 130px!important;" type="text" name='serviceInterval.frequency'
                    data-ng-model='serviceInterval.frequency' required></input> 
                 <select 
                    data-ng-model="serviceInterval.hourlyService"  data-ng-init="serviceInterval.hourlyService =serviceInterval.hourlyService.length==0 ? false : serviceInterval.hourlyService"
                    ng-options="ft.value as ft.name for ft in  [{value: false, name: 'Days'},{value: true, name: 'Hrs'}]" ng-style="{'width': '25%'}">
                </select>
            </div>
            <div class="cellDiv wid120">
                <a class="class" data-ng-click="deleteThis($index,'serviceCodeDefinition.serviceCodeInterval')"><i class="icon-trash"></i> </a>
            </div>
        </div>
    </div>
</div>
<div class="clear"></div>
<!-- ServiceIntervalSection -->

<!-- FlatFee & Invoice Section -->

<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.serviceCode.flatFee" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div class="containerDiv wid1000"
        data-ng-init="serviceCodeDefinition.serviceCodeFee = serviceCodeDefinition.serviceCodeFee == null ? [] : serviceCodeDefinition.serviceCodeFee"
        ng-model="serviceCodeDefinition.serviceCodeFee" repeater>
        <input type="hidden" name="serviceCodeDefinition.serviceCodeFee" data-ng-model="serviceCodeDefinition.serviceCodeFee" />
        <!-- Header Section -->
        <div class="rowDivHeader wid1000">
            <div class="cellDivHeader wid225">
                <spring:message code="label.serviceCode.fromDate" />
            </div>
            <div class="cellDivHeader wid225">
                <spring:message code="label.serviceCode.tillDate" />
            </div>
            <div class="cellDivHeader wid223">
                <spring:message code="label.serviceCode.paymentAmount" />
            </div>
            <div class="cellDivHeader wid223">
                <spring:message code="label.serviceCode.invoiceAmount" />
            </div>
            <div class="cellDivHeader wid100">
                <a class="add-row"
                    data-ng-click="addInputRow('serviceCodeDefinition.serviceCodeFee','duration.fromDate,duration.tillDate,paymentFee,invoiceFee')"></a>
            </div>
        </div>

        <!-- Repeat Template Section -->
        <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" ng-repeat="flatfee in serviceCodeDefinition.serviceCodeFee"
            style="width: 1000px">
            <div class="cellDiv wid225">
                <input  type="text" 
                    data-ng-model='flatfee.duration.fromDate' datepicker-popup="{{dateFormat}}"  required/>
            </div>
            <div class="cellDiv wid225" >
                <input  data-ng-model='flatfee.duration.tillDate' datepicker-popup="{{dateFormat}}"  required/>
                  
            </div>
            <div class="cellDiv wid223">
                <select id="paymentFeeCurrency" data-ng-model="flatfee.paymentFee.currency" ng-options="ic for ic in invoicingCurrenciesList" data-ng-change="flatfee.invoiceFee.currency=flatfee.paymentFee.currency"
                    data-ng-required="true" ng-style="{'width': '30%'}"></select> <INPUT TYPE="text" name="flatfee.paymentFee.amount"
                    data-ng-model="flatfee.paymentFee.amount" is-number required>
            </div>
            <div class="cellDiv wid223">
                <select id="invoiceFeeCurrency"  data-ng-model="flatfee.invoiceFee.currency"  ng-options="ic for ic in invoicingCurrenciesList" data-ng-disabled='true' 
                     ng-style="{'width': '30%'}"></select> <INPUT TYPE="text" name="flatfee.invoiceFee.amount"
                    data-ng-model="flatfee.invoiceFee.amount" is-number required>
            </div>
            <div class="cellDiv wid100">
                <a class="class" data-ng-click="deleteThis($index,'serviceCodeDefinition.serviceCodeFee')"><i class="icon-trash"></i> </a>
            </div>
        </div>
    </div>
 </div>
<!-- Parts Section -->
<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="title.serviceCode.inclusions" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div class="details-sub-header"><span><spring:message code="label.serviceCode.oemParts"/></span></div>
    <div class="containerDiv wid1000"
        data-ng-init="serviceCodeDefinition.serviceCodeOEMParts = serviceCodeDefinition.serviceCodeOEMParts == null ? []: serviceCodeDefinition.serviceCodeOEMParts"
        data-ng-model="serviceCodeDefinition.serviceCodeOEMParts" repeater>
        <input type="hidden" name="serviceCodeDefinition.serviceCodeOEMParts"
            data-ng-model="serviceCodeDefinition.serviceCodeOEMParts">
        <!-- Header Section -->
        <div class="rowDivHeader wid1000">
            <div class="cellDivHeader wid300">
                <spring:message code="label.serviceCode.inclusion.partNumber" />
            </div>
            <div class="cellDivHeader wid500">
                <spring:message code="label.serviceCode.inclusion.description" />
            </div>
            <div class="cellDivHeader wid100">
                <spring:message code="label.serviceCode.inclusion.quantity" />
            </div>
            <div class="cellDivHeader wid100">
                <a class="add-row"
                    data-ng-click="addInputRow('serviceCodeDefinition.serviceCodeOEMParts','replacedItem.id,replacedItem.description,numberOfUnits,pricePerUnit,extendedPricePerUnit')"></a>
            </div>
        </div>

        <!-- Repeat Template Section -->
        <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'"
            ng-repeat="oemparts in serviceCodeDefinition.serviceCodeOEMParts" style="width: 1000px">
            <div class="cellDiv wid300">
                <input  type="text" data-ng-model='oemparts.replacedItem.number'
                    ng-change="generateItemDescription($index,oemparts.replacedItem.number)" url="listNMHGPartNumbers" fbs-typeahead></input>
           </div>
            <div class="cellDiv wid500" >
                <div data-ng-model="oemparts.replacedItem.description" data-ng-bind='oemparts.replacedItem.description'></div>
            </div>
            <div class="cellDiv wid100">
                <input  type="text" name="oemparts.numberOfUnits"
                    data-ng-model='oemparts.numberOfUnits' required />
            </div>
            <div class="cellDiv wid100">
                <a class="class" data-ng-click="deleteThis($index,'serviceCodeDefinition.serviceCodeOEMParts')"><i class="icon-trash"></i>
                </a>
            </div>
        </div>

    </div>
    <div class="details-sub-header"><span><spring:message code="label.serviceCode.nonoemParts"/></span></div>
    <div class="containerDiv wid1000"
        data-ng-init="serviceCodeDefinition.serviceCodeNonOEMParts = serviceCodeDefinition.serviceCodeNonOEMParts == null ? [] : serviceCodeDefinition.serviceCodeNonOEMParts"
        data-ng-model="serviceCodeDefinition.serviceCodeNonOEMParts" repeater>
        <input type="hidden" name="serviceCodeDefinition.serviceCodeNonOEMParts"
            data-ng-model="serviceCodeDefinition.serviceCodeNonOEMParts">
        <!-- Header Section -->
        <div class="rowDivHeader wid1000">
            <div class="cellDivHeader wid200">
                <spring:message code="label.serviceCode.inclusion.partNumber" />
            </div>
            <div class="cellDivHeader wid250">
                <spring:message code="label.serviceCode.inclusion.description" />
            </div>
            <div class="cellDivHeader wid80">
                <spring:message code="label.serviceCode.inclusion.quantity" />
            </div>
            <div class="cellDivHeader wid223">
                <spring:message code="label.serviceCode.inclusion.unitPrice" />
            </div>
            <div class="cellDivHeader wid190">
                <spring:message code="label.serviceCode.inclusion.extendPrice" />
            </div>
            <div class="cellDivHeader wid80">
                <a class="add-row"
                    data-ng-click="addInputRow('serviceCodeDefinition.serviceCodeNonOEMParts','partNumber.description,numberOfUnits,pricePerUnit,extendedPricePerUnit')"></a>
            </div>
        </div>

        <!-- Repeat Template Section -->
        <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'"
            ng-repeat="nonoem in serviceCodeDefinition.serviceCodeNonOEMParts" class="wid1000">
            <div class="cellDiv wid200">
                <input  type="text" name="nonoem.partNumber"
                    data-ng-model='nonoem.partNumber' required />
            </div>
            <div class="cellDiv wid250">
                <input  type="text" name="nonoem.description"
                    data-ng-model='nonoem.description' required />
            </div>
            <div class="cellDiv wid80">
                <input  type="text" name="nonoem.numberOfUnits"
                    data-ng-model='nonoem.numberOfUnits' required />
            </div>
            <div class="cellDiv wid223"
                data-ng-init="nonoem.pricePerUnit.currency = nonoem.pricePerUnit.currency == null ? '${currency}' : nonoem.pricePerUnit.currency">
                <select  class="wid60" data-ng-model="nonoem.pricePerUnit.currency"  ng-options="ic for ic in invoicingCurrenciesList" ></select>
                <input  type="text" data-ng-model='nonoem.pricePerUnit.amount' data-ng-required="true"  is-number required/>
            </div>
            <div class="cellDiv wid190" 
                data-ng-init="nonoem.extendedPricePerUnit.currency = nonoem.extendedPricePerUnit.currency == null ? '${currency}' : nonoem.extendedPricePerUnit.currency">
                <div ng-show='nonoem.pricePerUnit.amount*nonoem.numberOfUnits'>&nbsp{{nonoem.pricePerUnit.currency}}&nbsp{{nonoem.pricePerUnit.amount*nonoem.numberOfUnits|number:2}}</div>
            </div>
            <div class="cellDiv wid80">
                <a class="class" data-ng-click="deleteThis($index,'serviceCodeDefinition.serviceCodeNonOEMParts')"><i class="icon-trash"></i>
                </a>
            </div>
        </div>

    </div>
    <!--End Parts Section -->
    <!-- Labor Section -->
    <div class="details-sub-header"><span><spring:message code="label.serviceCode.laborDetails"/></span></div>
    <div class="sectionSpacerHeight" style="clear: both;"></div>
    <div data-ng-model="serviceCodeDefinition.serviceCodeLaborDetails"
        data-ng-init="serviceCodeDefinition.serviceCodeLaborDetails = serviceCodeDefinition.serviceCodeLaborDetails == null ? [] : serviceCodeDefinition.serviceCodeLaborDetails" repeater>
        <input type="radio" data-ng-init="serviceCodeDefinition.fixedHrs = servicecodeid.length == 0? true:serviceCodeDefinition.fixedHrs" data-ng-click="hideJobcodes()" data-ng-model="serviceCodeDefinition.fixedHrs" data-ng-value="true" ng-boolean-radio>
        <spring:message code="label.serviceCode.laborDetails.fixedHrs" />
        <input style="margin-bottom: 2px; margin-top: 2px; width: 130px;"   name="laborHrs" data-ng-model="laborHrs" ng-hide="jobcodesection" is-number/>
        <div class="fieldSpacerWidth" style="float: left;">&nbsp;</div>
        <input type="radio" data-ng-click="showJobcodes()" data-ng-model="serviceCodeDefinition.fixedHrs" data-ng-value="false" ng-boolean-radio>
        <spring:message code="label.serviceCode.laborDetails.jobCodes" />
        <br />
    </div>
    <div class="fieldSpacerWidth" style="float: top;">&nbsp;</div>
    <div ng-show="jobcodesection">
        <div class="containerDiv wid1000" data-ng-model="serviceCodeDefinition.serviceCodeLaborDetails">
            <input type="hidden" name="serviceCodeDefinition.serviceCodeLaborDetails" data-ng-model="serviceCodeDefinition.serviceCodeLaborDetails">
            <!-- Header Section -->
            <div class="rowDivHeader wid1000">
                <div class="cellDivHeader wid250">
                    <spring:message code="label.serviceCode.laborDetails.jobCode" />
                </div>
                <div class="cellDivHeader" style="width: 675px;">
                    <spring:message code="label.serviceCode.laborDetails.jobCodeDescription" />
                </div>
                <div class="cellDivHeader wid100">
                    <a class="add-row"
                        data-ng-click="addInputRow('serviceCodeDefinition.serviceCodeLaborDetails','serviceProcedureDefinition.code,serviceProcedureDefinition.description')"></a>
                </div>
            </div>

            <!-- Repeat Template Section -->
            <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" ng-repeat="ld in serviceCodeDefinition.serviceCodeLaborDetails"
                style="width: 1000px">
                <div class="cellDiv wid250">
                   <input  type="text" data-ng-model='ld.serviceProcedureDefinition.code'  url="listJobcodes" fbs-typeahead ng-change="generateJobCodelDescription($index,ld.serviceProcedureDefinition.code)" />
                </div>
                <div class="cellDiv" style="width: 675px;">
                    <div>{{ld.serviceProcedureDefinition.description}}</div>
                </div>
                <div class="cellDiv wid100">
                    <a class="class" data-ng-click="deleteThis($index,'serviceCodeDefinition.serviceCodeLaborDetails')"><i class="icon-trash"></i>
                    </a>
                </div>
            </div>

        </div>
    </div>
</div>
<!-- End Labor Section -->