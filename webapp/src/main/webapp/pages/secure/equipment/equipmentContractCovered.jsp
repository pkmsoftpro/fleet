
<div class="containerDiv marL25 wid994">
    <div class="rowDivHeader">
        <div class="cellDivHeader wid142">
            <spring:message code="label.customerLocation.contractCode" />
        </div>
        <div class="cellDivHeader wid142">
            <spring:message code="label.customerLocation.contractType" />
        </div>
        <div class="cellDivHeader wid142">
            <spring:message code="columnTitle.equipment.CustomerBillTo" />
        </div>
        <div class="cellDivHeader wid142">
            <spring:message code="columnTitle.inventory.customerName" />
        </div>
        <div class="cellDivHeader wid142">
            <spring:message code="columnTitle.contract.contractStartDate" />
        </div>
        <div class="cellDivHeader wid142">
            <spring:message code="columnTitle.contract.contractEndDate" />
        </div>
        <div class="cellDivHeader wid142">
            <spring:message code="label.common.status" />
        </div>
    </div>
    <div class="cell-bottom-border" data-ng-repeat="contract in contractAudits">
    
        <div class="cellDiv wid142" ><a href  ng-click ="displayContractDetails(contract.contractId)">{{contract.contractCode}} </a></div>
        <div class="cellDiv wid142">{{contract.contractType}}</div>
        <div class="cellDiv wid142">{{contract.billTo}}</div>
        <div class="cellDiv wid142">{{contract.customerName}}</div>
        <div class="cellDiv wid142">{{contract.fromDate}}</div>
        <div class="cellDiv wid142">{{contract.tillDate}}</div>
        <div class="cellDiv wid142">{{contract.status}}</div>
    </div>
</div>

