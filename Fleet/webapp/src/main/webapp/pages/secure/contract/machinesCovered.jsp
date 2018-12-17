<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>


<div class="accordion-header contentPane">
    <spring:message code="label.newContract.machinesCovered" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">

    <div class="containerDiv marL25 wid1000 ">
        <table border="1" cellspacing="0" cellpadding="0">
            <tr class="tableHeader">
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contract.serialNumber" /></th>
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contract.equipmentType" /></th>
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contract.model" /></th>
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contract.year" /></th>
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contract.manufacturer" /></th>
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contract.assetNumber" /></th>
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contract.inventoryStatus" /></th>
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contract.contractStartDate" /></th>
                <th class="labelStyle cellDivHeader"><spring:message code="columnTitle.contract.contractEndDate" /></th>
            </tr>
            <tr class="tableData" data-ng-repeat="contractInventory in fleetInventoryItems">
                <td border="1"><a id="inventorySerialNumber" class="text-link"
                    data-ng-click="displayEquipmentDetails(contractInventory.fleetInventoryItem.id)" href="#">{{contractInventory.fleetInventoryItem.serialNumber}}</a>
                </td>
                <td>{{contractInventory.fleetInventoryItem.equipmentType}}</td>
                <td>{{contractInventory.fleetInventoryItem.modelName}}</td>
                <td>{{contractInventory.fleetInventoryItem.modelYear}}</td>
                <td>{{contractInventory.fleetInventoryItem.brandType}}</td>
                <td>{{contractInventory.fleetInventoryItem.assetNumber}}</td>
                <td>{{contractInventory.status}}</td>
                <td>{{contractInventory.fromDate}}</td>
                <td>{{contractInventory.tillDate}}</td>
            </tr>
        </table>
        <div ng-show="fleetInventoryItemsCount == '0'">
            <center>
                <h5>
                    <spring:message code="label.contract.noMachines" />
                </h5>
            </center>
        </div>
    </div>
    <div class="machines-pagination" ng-show="totalPages > 1">
        <pagination num-pages="totalPages" current-page="filterCriteria.pageNumber" max-size="5" class="" boundary-links="true"
            on-select-page="selectPage(page)"></pagination>
    </div>
</div>