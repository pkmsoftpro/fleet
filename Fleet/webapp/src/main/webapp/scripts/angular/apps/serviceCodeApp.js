var manageservicecode = angular.module('servicecodeapp', [ 'ui.bootstrap', '$strap.directives', 'textArea', 'autoCompleter', 'titlePane', 'subSection','numbersOnly',
        'ngGrid', 'repeater', 'moneyType', '$util', 'ui.event', 'loadingIndicator','alertMsg','isNumber' ]);
manageservicecode.controller('ServiceCodeController', ['$scope', '$http', '$parse', '$util', function($scope, $http, $parse, $util) {
    load = function() {
        if ($scope.servicecodeid) {
            $http({
                method : 'GET',
                url : 'servicecodeinfo',
                params : {
                    id : $scope.servicecodeid
                }
            }).success(function(data) {
                $scope.serviceCodeDefinition = data.serviceCodeDefinition;
                $scope.listCategories = data.listCategories;
                $scope.invoicingCurrenciesList = data.invoicingCurrenciesList;
                $scope.dateFormat=data.dateFormat;
                $scope.serviceCodeAudits =data.serviceCodeAudits;
                if($scope.serviceCodeDefinition.fixedHrs==true){
                   $scope.laborHrs=$scope.serviceCodeDefinition.serviceCodeLaborDetails[0].fixedLaborHrs;
                }else
                	$scope.jobcodesection = true;
            });
        } else{
            $http({
                method : 'GET',
                url : 'newservicecodeinfo'
            }).success(function(data) {
                $scope.invoicingCurrenciesList = data.invoicingCurrenciesList;
                $scope.listCategories = data.listCategories;
                $scope.serviceCodeDefinition.category =$scope.listCategories[0];
                $scope.dateFormat=data.dateFormat;
                $scope.jobcodesection = false;
                $scope.fixedHrs=true;
            });
        }
    };
    load();
    // To Save the Service code
    $scope.saveServiceCode = function() {
    	if($scope.serviceCodeDefinition.fixedHrs==true){
    		$scope.serviceCodeDefinition.serviceCodeLaborDetails.splice(0,$scope.serviceCodeDefinition.serviceCodeLaborDetails.length);
    		var items={laborHrs:''};
    		$scope.form["serviceCodeDefinition.serviceCodeLaborDetails"].$modelValue.push(items);
    		$scope.serviceCodeDefinition.serviceCodeLaborDetails[0].fixedLaborHrs=$scope.laborHrs;
    	}
        var actionUrl = 'saveServiceCode';
        $http.post(actionUrl, JSON.stringify($scope.serviceCodeDefinition)).success(function(data) {
           
        });
        window.scrollTo(0, 0);
    };

    $scope.generateModelDescription = function(inx, value) {
    	if (+value && value.toString().length>2) {
            $util.httpGet('generatModelDescription', {
                id : value
            }, function(data) {
            	if(data){
                $scope.serviceCodeDefinition.serviceCodeInterval[inx].itemGroup.id = data.id;
                $scope.serviceCodeDefinition.serviceCodeInterval[inx].itemGroup.name = data.name;
                $scope.serviceCodeDefinition.serviceCodeInterval[inx].itemGroup.description = data.description;
            	}
            });
        }
    };
    $scope.generateItemDescription = function(inx, value) {
        if (+value && value.toString().length>2) {
            $util.httpGet('generatItemDescription', {
                id : value
            }, function(data) {
            	if(data){
                $scope.serviceCodeDefinition.serviceCodeOEMParts[inx].replacedItem.id = data.id;
                $scope.serviceCodeDefinition.serviceCodeOEMParts[inx].replacedItem.number = data.number;
                $scope.serviceCodeDefinition.serviceCodeOEMParts[inx].replacedItem.description = data.description;
            	}
            });
        }
    };
     $scope.generateJobCodelDescription = function(inx, value) {
        if (+value && value.toString().length>2) {
            $util.httpGet('generateJobCodelDescription', {
                id : value
            }, function(data) {
            	if(data){
                $scope.serviceCodeDefinition.serviceCodeLaborDetails[inx].serviceProcedureDefinition = data;
            	}
            });
        }
    };

    $scope.gridForserviceactionhistory = {
        data : 'serviceCodeAudits',
        multiSelect : false,
        sortInfo:{ fields: ['updatedTime'], directions: ['desc']},
        columnDefs : [ {
            field : 'updatedTime',
            displayName : i18N.date,
            width: 200
        }, {
            field : 'completedNameAndLogin',
            width: 200,
            displayName : i18N.user
        }, {
            field : 'comments',
            width: 600,
            displayName : i18N.comments
        } ],
        plugins : [ new ngGridFlexibleHeightPlugin() ]
    };

    $scope.showJobcodes = function() {
        $scope.jobcodesection = true;
    };

    $scope.hideJobcodes = function() {
        $scope.jobcodesection = false;
    };
    $scope.calculateNonOemExtendedPrice = function(amount, numberOfUnits) {
        return amount * numberOfUnits;
    };
}]);
