var customerLocationApp = angular.module('customerLocation', [ 'ui.bootstrap', '$strap.directives', 'textArea', 'autoCompleter', 'titlePane','subSection', 'moneyType',
        'ngGrid', 'repeater', 'loadingIndicator', 'alertMsg','numbersOnly','popup','isNumber']);

customerLocationApp.factory('loactionFactory', ['$http', function($http) {
    var locationService = {};

    locationService.saveLocation = function($scope, url, isSave) {
        $scope.customerLocation.save = isSave;
        if (!isSave) {
            if ($scope.customerLocation.active == true)
                $scope.customerLocation.active = 'false';
            else
                $scope.customerLocation.active = 'true';
        }
        $http.post(url, JSON.stringify($scope.customerLocation)).success(function(data) {
            $scope.customerLocation = data.target;
        });
    };

    locationService.getDealerThresholdAmountByPercentage = function($scope) {
    	if($scope.customerLocation.dealerQuoteVariance >= 0){
        
    		return ($scope.customerLocation.quoteThreshold.amount - ((($scope.customerLocation.quoteThreshold.amount) * (-$scope.customerLocation.dealerQuoteVariance)) / 100));	
    	}
    	else{
    		return ($scope.customerLocation.quoteThreshold.amount - ((($scope.customerLocation.quoteThreshold.amount) * (-$scope.customerLocation.dealerQuoteVariance)) / 100));
    	}
    	
    };

    locationService.getDealerThresholdFlatAmt = function($scope) {
    	if($scope.customerLocation.dealerQuoteVariance >= 0){
    		return ($scope.customerLocation.quoteThreshold.amount - (-$scope.customerLocation.dealerQuoteVariance));
    	}
    	else{
    		 return ($scope.customerLocation.quoteThreshold.amount - (-$scope.customerLocation.dealerQuoteVariance));
    	}
       
    };

    return locationService;
}]);

customerLocationApp.controller('CustomerLocationController', ['$scope', '$http', '$parse', 'loactionFactory', function($scope, $http, $parse, loactionFactory) {

    load = function() {
        $http({
            method : 'GET',
            url : 'customerLocationDetail',
            params : {
                id : $scope.customerLocId
            }
        }).success(function(data) {
            $scope.customerLocation = data.customerLocation;
            $scope.contacts = data.contacts;
            $scope.countries = data.countries;
            $scope.customer = data.customer;
        });
    };

    $scope.$watch('customerLocId', function(newVal, oldVal) {
        load();
        loadMachines();
    });

            loadMachines = function() {

                $http({
                    method : 'GET',
                    url : 'contractsInformationByLocation',
                    params : {
                        id : $scope.customerLocId
                    }
                }).success(function(data) {
                    $scope.contract = data.contract;
                    $scope.machines = data.machines;
                });
            };


                $scope.gridForMachines = {
                data : 'machines',
                enableColumnResize : true,
                enableColumnReordering : true,
                columnDefs : [ {
                    field : 'serialNumber',
                    displayName : 'Serial Number',
                    cellTemplate:'<a ng-click="findInventoryBySerialNumber(row.getProperty(col.field))">{{row.getProperty(col.field)}}</a>'
                }, {
                    field : 'equipmentType',
                    displayName : 'Equipment Type'
                }, {
                    field : 'modelName',
                    displayName : 'Model'
                }, {
                    field : 'modelYear',
                    displayName : 'Year'
                }, {
                    field : 'brandType',
                    displayName : 'Manufacturer'
                }, {
                    field : 'assetNumber',
                    displayName : 'Asset Number'
                }, {
                    field : 'maintenanceType',
                    displayName : 'Maintainance Type'
                } ],
                plugins : [ new ngGridFlexibleHeightPlugin() ]
            };

            $scope.gridForLocationContacts = {
                data : 'contacts',
                multiSelect : false,
                enableColumnResize : true,
                enableColumnReordering : true,
                columnDefs : [ {
                    field : 'firstName',
                    displayName : 'First Name'
                }, {
                    field : 'lastName',
                    displayName : 'Last Name'
                }, {
                    field : 'department',
                    displayName : 'Department'
                }, {
                    field : 'jobTitle',
                    displayName : 'Title'
                }, {
                    field : 'phone',
                    displayName : 'Phone'
                }, {
                    field : 'phoneExt',
                    displayName : 'Phone Ext'
                }, {
                    field : 'fax',
                    displayName : 'Fax'
                }, {
                    field : 'faxExt',
                    displayName : 'Fax Ext'
                }, {
                    field : 'email',
                    displayName : 'Email'
                } ],
                plugins : [ new ngGridFlexibleHeightPlugin() ]
            };

    // updating location details on customer Location Detail page.
    $scope.save = function(isSave) {
        loactionFactory.saveLocation($scope, 'updateCustomerLocation/', isSave);
    };

    // Calculating the Dealer Quote Variance
    $scope.calculateDealerThresholdAmount = function() {
        if ($scope.customerLocation) {
            $scope.customerLocation.calculatedDealerThreshold = $scope.customerLocation.varianceInPercentage == true ? loactionFactory.getDealerThresholdAmountByPercentage($scope)
                    : loactionFactory.getDealerThresholdFlatAmt($scope);
        }
    };

    // For setting Polength to zero
    $scope.specifyingValues = function() {
        if ($scope.customerLocation) {
            if ($scope.customerLocation.poLengthSpecified == false) {
                $scope.customerLocation.purchaseOrderLength = null;
            }
            if ($scope.customerLocation.periodicServiceCall == false) {
                $scope.customerLocation.numberOfDays = null;
            }
        }
    };
    
    $scope.showSampleRegExpPatterns=function() {
    	$scope.sampleRegExpPOPatterns=true;
    	$scope.addCustomerComments=true;
    }
    $scope.close=function(){
    	$scope.sampleRegExpPOPatterns=false;
    	$scope.addCustomerComments=false;
    }
    //For hiperlink on Contracts
     $scope.getContractDetails = function(id) {
     var url = "contract_detail_Read_Only.action?id="+id;
     var thisTabLabel = getMyTabLabel();    
     parent.publishEvent("/tab/open", {label: "Contract",
     url: url,
     decendentOf: thisTabLabel,
     forceNewTab: true});
     };

    $scope.closeAlert = function(index) {
        $scope.alerts.splice(index, 1);
    };
    

    $scope.$watch('customerLocation.physicalAddress.country', function(newVal, oldVal) {
        if (newVal) {
            if ($scope.customerLocation) {
                $http({
                    method : 'GET',
                    url : 'listStates',
                    params : {
                        selectedCountry : newVal
                    }
                }).success(function(data) {
                    $scope.states = data;
                });
            }
        }
    });
    
    $scope.$watch('customerLocation.address.country', function(newVal, oldVal) {
        if (newVal) {
            if ($scope.customerLocation) {
                $http({
                    method : 'GET',
                    url : 'listStates',
                    params : {
                        selectedCountry : newVal
                    }
                }).success(function(data) {
                    $scope.billingStates = data;
                });
            }
        }
    });
    
    $scope.findInventoryBySerialNumber = function(serialNumber) {
        if (angular.isUndefined(serialNumber)) {
            return;
        }
        var url = "findInventoryBySerialNumber.action?serialNumber=" + serialNumber;
        var thisTabLabel = getMyTabLabel();
        parent.publishEvent("/tab/open", {
            label : "Equipment History",
            url : url,
            decendentOf : thisTabLabel,
            forceNewTab : true
        });
    }
    
    $scope.isReadOnly = function() {
        return !(document.getElementById('isDealerOwned') && document.getElementById('isDealerOwned').value === "true");
    };
    
    $scope.isMandatory = function() {   
        if($scope.customerLocation && $scope.customerLocation.address!=undefined)
        {
            if($scope.customerLocation.address.city!=undefined||$scope.customerLocation.address.state!=undefined||
                    $scope.customerLocation.address.country!=undefined||$scope.customerLocation.address.zipCode!=undefined||$scope.customerLocation.address.addressLine1!=undefined)
            {
            return true
            }
        }
        return false;
    };
    
    
    $scope.displayAllCustomerContacts = function(locationId){
        if (angular.isUndefined(locationId) || locationId.length === 0) {
            return;
        }
        var url = "listAllCustomerContacts.action?id="+locationId+"&folderName='List Contacts'";
        var thisTabLabel = getMyTabLabel();
        parent.publishEvent("/tab/open", {
            label : "Customer Contacts",
            url : url,
            decendentOf : thisTabLabel,
            forceNewTab : true
        });
      };

}]);