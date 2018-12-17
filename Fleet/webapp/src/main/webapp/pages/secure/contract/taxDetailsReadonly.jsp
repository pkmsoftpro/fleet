
<div class="containerDiv wid800" ng-model="contractAudit.applicableTaxDetails" repeatAttrs="customerState,certificationNumber">
    <input type="hidden" name="contractAudit.applicableTaxDetails" data-ng-model="contractAudit.applicableTaxDetails">
    <!-- Header Section -->
    <div class="rowDivHeader wid800">
        <div class="cellDivHeader wid300">Customer State</div>
        <div class="cellDivHeader wid300">Certification Number</div>
        <div class="cellDivHeader wid200">
            <a class="add-row" ng-click="addInputRow('contractAudit.applicableTaxDetails','customerState,certificationNumber')"></a>
        </div>
    </div>

    <!-- Repeat Template Section -->
    <div data-ng-class-odd="'rowDivOdd'" data-ng-class-even="'rowDivEven'" class=" wid800" ng-repeat="item in contractAudit.applicableTaxDetails">
        <div class="cellDiv wid300">
            <input class="marTB2" type="text" data-ng-model='item.customerState' data-ng-readonly="true"/>
        </div>
        <div class="cellDiv wid300">
            <input class="marTB2" type="text" class="repeat" data-ng-model='item.certificationNumber' data-ng-readonly="true"/>
        </div>
        <div class="cellDiv wid200">
            <a class="class" ng-click="deleteThis($index,'contractAudit.applicableTaxDetails')"><i class="icon-trash"></i> </a>
        </div>
    </div>
</div>