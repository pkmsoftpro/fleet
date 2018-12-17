<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="marL25 wid70p">
    <div class="contractHeader">
        <div class="contractLabelStyle floatL" style="margin:0px auto 10px 60px;align:right;">
             <div align="center"><spring:message code="label.newContract.select" /></div>
        </div>
        <div class="contractLabelStyle floatL" style="margin:0px auto 10px 20px">
            <spring:message code="label.contract.majorCostCategory" />
        </div>
    </div>
    <div data-ng-repeat="costCategory in costCategories">
        <span ng-if="costCategory.data.categoryGroup=='MAJOR COST CATEGORY'">
            <div class="floatL" data-ng-class-odd="'odd'" data-ng-class-even="'even'">
                <input class="floatL marL150" type="checkbox" ng-model="costCategory.checked" data-ng-disabled="true">
                <div class="floatL marL110">{{costCategory.data.name }}</div>
            </div> </span>
    </div>
    <div class="contractLabelStyle floatL marL280">
        <spring:message code="label.contract.taxes" />
    </div>
    <div data-ng-repeat="costCategory in costCategories">
        <span ng-if="costCategory.data.categoryGroup=='TAXES'">
            <div class="floatL" data-ng-class-odd="'odd'" data-ng-class-even="'even'">
                <input class="floatL marL150" type="checkbox" ng-model="costCategory.checked" data-ng-disabled="true">
                <div class="floatL marL110">{{costCategory.data.name }}</div>
            </div> </span>
    </div>
    <div class="contractLabelStyle floatL marL280">
        <spring:message code="label.contract.canadianTaxes" />
    </div>
    <div data-ng-repeat="costCategory in costCategories">
        <span ng-if="costCategory.data.categoryGroup=='CANADIAN TAXES'">
            <div class="floatL" data-ng-class-odd="'odd'" data-ng-class-even="'even'" >
                <input class="floatL marL150" type="checkbox" ng-model="costCategory.checked" data-ng-disabled="true">
                <div class="floatL marL110">{{costCategory.data.name }}</div>
            </div> </span>
    </div>
</div>