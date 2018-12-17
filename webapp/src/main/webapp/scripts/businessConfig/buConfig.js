var buConfig = angular.module('businessConfigInfo', [ 'ui.bootstrap', '$strap.directives', 'textArea', 'autoCompleter', 'titlePane', 'alertMsg', '$util' ]);

buConfig.controller('businessConfigInfo', ['$scope', '$http', '$parse', function($scope, $http, $parse) {

    $scope.isCollapsed = false;
    $scope.isSrDisclaimer=false;
    $scope.myvalue = true;
    load = function() {
        $http({
            method : 'GET',
            url : 'getmanageBUConfigurationData'
        }).success(function(data) {
            $scope.selectedValue = (data === 'true');
        });
    }

    load();
    $scope.save = function(form) {
        var updatedSelect = $scope.selectedValue;
        $http({
            method : 'POST',
            url : 'updateConfig',
            params : {
                valueSelected : updatedSelect
            }

        }).success(function(data) {
        });
    }
    $scope.closeAlert = function(index) {
        $scope.alerts.splice(index, 1);
    };
}]);