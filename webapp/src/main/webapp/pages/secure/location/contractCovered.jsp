
<div class="containerDiv marL25 wid1000">
    <div class="rowDivHeader">
        <div class="cellDivHeader wid200">
            <spring:message code="label.customerLocation.contractCode" />
        </div>
        <div class="cellDivHeader wid200">
            <spring:message code="label.customerLocation.contractType" />
        </div>
        <div class="cellDivHeader wid200">
            <spring:message code="label.common.status" />
        </div>
        <div class="cellDivHeader wid200">
            <spring:message code="columnTitle.contract.contractStartDate" />
        </div>
        <div class="cellDivHeader wid200">
            <spring:message code="columnTitle.contract.contractEndDate" />
        </div>
    </div>
<div class="cell-bottom-border" data-ng-repeat="contract in contract">
    <div class="cellDiv wid200"><a ng-click="getContractDetails(contract.id)" class="cursor-pointer"> {{contract.code}}</a></div>
    <div class="cellDiv wid200">{{contract.type}}</div>
    <div class="cellDiv wid200">{{contract.activeContractAudit.status}}</div>
    <div class="cellDiv wid200">{{contract.activeContractAudit.availability.fromDate}}</div>
    <div class="cellDiv wid200">{{contract.activeContractAudit.availability.tillDate}}</div>
</div>
</div>

