var contractApp = angular.module('createContract', [ 'ui.bootstrap', '$strap.directives', 'textArea', 'autoCompleter', 'titlePane', 'ngGrid','$util', 
                                                     'moneyType','repeater','loadingIndicator','alertMsg','angularFileUpload','popup' ]);

contractApp.controller('ContractController', ['$scope', '$http', '$parse', '$util', '$fileUploader', function($scope, $http, $parse, $util, $fileUploader) {
    $scope.attachedDocuments = new Array();
    $scope.failedDocuments = [];
    var actionUrl = 'getContract/';
    var successForm=false;
    var submitForm=false;
    $scope.fleetClaimForm = true;
    $scope.checkedCostCategories = {};    
    var fleet;
    load = function() {
        var contractId=document.getElementById('contractId').value;     
        //var dateFormat=document.getElementById('dateFormat').value;
        //var dateFormat="\\\'"+document.getElementById('dateFormat').value+" HH:mm\\\'";
    	$scope.id = contractId;
    	$scope.contractId = contractId;
    	if(contractId)
    	{
		$http({method: 'GET', url: 'contractInfo',params: {id: contractId}}).
	    success(function(data) {
	    	 $scope.contract = data.contract;
	    	 
	    	 $scope.contract.activeContractAudit.attachments=data.attachments;
	    	 $scope.tripList = data.tripList;
	    	 $scope.tripTypeList = data.tripTypeList;
	    	 $scope.isPrimary = data.isPrimary;
	    	 $scope.customerBillTo = data.customerBillTo;
	            $scope.checkedCostCategories = [];
	            angular.forEach($scope.contract.activeContractAudit.applicableCostCategories, function(applicableCostCategory) {
	                $scope.checkedCostCategories.push(applicableCostCategory.id);
	            });
	            $scope.loadCostCategories();	    
	            $scope.audits = data.contract.contractAudits;
	            $scope.contract.activeContractAudit.comments = "";
        	});
    	}
    	
    	
    	var selectedAuditId = document.getElementById('selectedAuditId').value;
        if (selectedAuditId) {
            $scope.selectedId = true;
            $util.httpGet('findContractAudit', {
                id : selectedAuditId
            }, function(data) {
                $scope.contractAudit = data.contractAudit;
                $scope.contract=data.contractAudit.forContract;
                $scope.attachments=data.attachments;
                $scope.checkedCostCategoriesAudit = [];
                angular.forEach($scope.contractAudit.applicableCostCategories, function(applicableCostCategory) {
	                $scope.checkedCostCategoriesAudit.push(applicableCostCategory.id);
	            });
                $scope.loadCostCategoriesAudit();
            });
        }   
        
        $util.httpGet('contractParams', {}, function(data) {            
            $scope.contractTypeList=data.contractTypes;
            $scope.contractStatus=data.contractStatus;
            $scope.loadCostCategories();
        });
    };
    

    load();
    
    
    getLocationAddress = function(address) {
        if(address!=undefined && address!=null && address.addressLine2!=null)
            {
        return address.addressLine1 + ',' + address.addressLine2 + ',' + address.city + ',' + address.state + ',' + address.zipCode + ','
                + address.country;
            }
        else if (address!=undefined && address!=null && address.addressLine2===null)
            {
            return address.addressLine1 + ','+ address.city + ',' + address.state + ',' + address.zipCode + ','
            + address.country;
            }
        else
            {
            return "";
            }
    }

    calculateDistances = function(origin, destination) {
        var service = new google.maps.DistanceMatrixService();
        var customerCountry = destination.country;
        if (customerCountry == 'GB' || customerCountry == 'UK' || customerCountry == 'US') {
            unitSystem = google.maps.UnitSystem.IMPERIAL;
        } else {
            //need to be changed to METRIC
            unitSystem = google.maps.UnitSystem.IMPERIAL;
        }
        origin = getLocationAddress(origin);
        destination = getLocationAddress(destination);
        service.getDistanceMatrix({
            origins : [ origin ],
            destinations : [ destination ],
            travelMode : google.maps.TravelMode.DRIVING,
            unitSystem : unitSystem,
            avoidHighways : false,
            avoidTolls : false
        }, $scope.googleMapsDistanceApiCallback);
    }

    $scope.googleMapsDistanceApiCallback = function(response, status) {
        $scope.$apply(function() {
            if (google.maps.DistanceMatrixStatus.OK == status && google.maps.DistanceMatrixStatus.OK == response.rows[0].elements[0].status) {
                var distanceValue = response.rows[0].elements[0].distance.text;
                var distanceValue = distanceValue.replace(/\,/g,"");
                
                
                $scope.contract.activeContractAudit.applicableTravelMatrix[0].milesPerTrip =  $scope.contract.activeContractAudit.applicableTravelMatrix[1].milesPerTrip = distanceValue.substr(0,distanceValue.indexOf(' ')); 
                $scope.contract.activeContractAudit.applicableTravelMatrix[0].hour= $scope.ratio*$scope.contract.activeContractAudit.applicableTravelMatrix[0].milesPerTrip;
                $scope.contract.activeContractAudit.applicableTravelMatrix[1].hour= $scope.ratio*$scope.contract.activeContractAudit.applicableTravelMatrix[1].milesPerTrip;
            } else {      
                $scope.contract.activeContractAudit.applicableTravelMatrix[0].milesPerTrip =  $scope.contract.activeContractAudit.applicableTravelMatrix[1].milesPerTrip = 0;
                $scope.contract.activeContractAudit.applicableTravelMatrix[0].hour= $scope.ratio*$scope.contract.activeContractAudit.applicableTravelMatrix[0].milesPerTrip;
                $scope.contract.activeContractAudit.applicableTravelMatrix[1].hour= $scope.ratio*$scope.contract.activeContractAudit.applicableTravelMatrix[1].milesPerTrip;
            }
        });
    }
    $scope.$watch('contract.activeContractAudit.applicableTravelMatrix[0].milesPerTrip+contract.activeContractAudit.applicableTravelMatrix[1].milesPerTrip', function(newNames, oldNames) {
        $scope.hour=[];
        if(newNames)
            $scope.travelRation();
    });
    $scope.travelRation=function()
    {
        if($scope.contract.activeContractAudit.applicableTravelMatrix[0].milesPerTrip!=undefined && $scope.contract.activeContractAudit.applicableTravelMatrix[1].milesPerTrip!=null){
            $scope.contract.activeContractAudit.applicableTravelMatrix[0].hour= $scope.ratio*$scope.contract.activeContractAudit.applicableTravelMatrix[0].milesPerTrip;
            $scope.contract.activeContractAudit.applicableTravelMatrix[1].hour= $scope.ratio*$scope.contract.activeContractAudit.applicableTravelMatrix[1].milesPerTrip;
        }
    };
    $scope.doesContain = function(j) {
        var containsFlag = false;
        for (i = 0; i <= $scope.checkedCostCategories.length; i++) {
            checkedCostCategory = $scope.checkedCostCategories[0].id;
            if (j.id == checkedCostCategory.id) {
                containsFlag = true;
           }
        }
        return containsFlag;
    };
    
    $scope.loadCostCategories = function() {
        $http({
            method : 'GET',
            url : 'getCostCategories'
        }).success(function(data) {
            $scope.costCategories = [];
            angular.forEach(data, function(costCateg) {
                costCategory = new Object();
                costCategory.data = costCateg;
                costCategory.checked = $.inArray(costCateg.id, $scope.checkedCostCategories) >= 0;
                $scope.costCategories.push(costCategory);
                $scope.costCategories = $scope.costCategories;
            });
        });
    };
    
    $scope.loadCostCategoriesAudit = function() {
        $http({
            method : 'GET',
            url : 'getCostCategories'
        }).success(function(data) {
            $scope.AuditcostCategories = [];
            angular.forEach(data, function(costCateg) {
                costCategory = new Object();
                costCategory.data = costCateg;
                costCategory.checked = $.inArray(costCateg.id, $scope.checkedCostCategoriesAudit) >= 0;
                $scope.AuditcostCategories.push(costCategory);
                $scope.AuditcostCategories = $scope.AuditcostCategories;
            });
        });
    };
    var updateUrl = 'updateContract/';
    
    $scope.closeAlert = function(index) {
        $scope.alerts.splice(index, 1);
      };
      
    $scope.save = function(form) {
       
        $scope.contract.activeContractAudit.applicableCostCategories = [];
        angular.forEach($scope.costCategories, function(data) {
            if (data.checked) {
                $scope.contract.activeContractAudit.applicableCostCategories.push(data.data);
            }
        });
        $http.post(updateUrl, JSON.stringify($scope.contract)).success(function(data) {       
           $scope.contract = data.target; 
         $util.httpGet('hoursToMilesRation',
                   {                        
                   },
                   function(data) {
                       $scope.ratio=data;                   
           $scope.contract.activeContractAudit.applicableTravelMatrix[0].hour= $scope.ratio*$scope.contract.activeContractAudit.applicableTravelMatrix[0].milesPerTrip;
           $scope.contract.activeContractAudit.applicableTravelMatrix[1].hour= $scope.ratio*$scope.contract.activeContractAudit.applicableTravelMatrix[1].milesPerTrip;
           
                   });
        
           $scope.getAttachments($scope.contract.id);           
          
           $scope.contract.activeContractAudit.comments = "";
           $scope.audits = data.target.contractAudits;
        	successForm=true;
        });
    };
    $scope.getAttachments=function(contractId)
    {
        $util.httpGet('getAttachemnts',
                {      
            id:contractId
                },
                function(data) {
                    $scope.contract.activeContractAudit.attachments=data.attachments;        
                });
    }
    
    $scope.contractAuditpagingOptions = {pageSizes: [10, 20, 30], pageSize: 10, currentPage: 1};
    $scope.totalcontractAudititems =0;
    
    $scope.gridForContractAuditHistory = {
    		data : 'audits',
    		multiSelect:false,
    		enableColumnResize: true,
            enableColumnReordering : true,
            showFooter: true,
            enablePaging: true,
            pagingOptions: $scope.contracttAuditpagingOptions,
            totalServerItems: 'totalcontractAudititems',
    		columnDefs : [ { 
    			field : 'd.updatedTime',
    			displayName : 'Date / Time',
    			cellFilter: "date:\'MM/dd/yyyy   HH:mm\'",
    			width:'15%'
    		}, { 
    			field : 'updatedBy.completeNameAndLogin',
    			displayName : 'User',
    			width:'20%'
    		},{ 
    			field : 'comments',
    			displayName : 'Comments',
    			width:'50%'
    		} ],
    	plugins : [  new ngGridFlexibleHeightPlugin() ]
    };

    $scope.getMachineCoveredDataAsync = function (pageSize,currentPage){
      var auditId = -1;
      if (selectedAuditId != null && selectedAuditId.value)
      auditId = selectedAuditId.value;
        $http({
            method : 'GET',
            url : 'applicableMachines',
            params : {
                pageNumber : currentPage,
                pageSize : pageSize,
                id : $scope.id,
                auditId : auditId
            }
        }).success(function(data) {
            $scope.fleetInventoryItems = data.applMachines;
            $scope.totalMachinesCovered = data.totalRecords;
        });
     };
    
    $scope.machineCoveredOptions = {pageSizes: [10, 20, 30], pageSize: 10, currentPage: 1};
    $scope.getMachineCoveredDataAsync($scope.machineCoveredOptions.pageSize, $scope.machineCoveredOptions.currentPage);
    $scope.$watch('machineCoveredOptions', function(newVal, oldVal) {
    if (newVal !== oldVal || newVal.currentPage !== oldVal.currentPage) {
     $scope.getMachineCoveredDataAsync($scope.machineCoveredOptions.pageSize, $scope.machineCoveredOptions.currentPage);
     }
    }, true);
    
    $scope.totalMachinesCovered = 0;
    $scope.gridForMachines = {
            data : 'fleetInventoryItems',
            multiSelect:false,
            enablePaging: true,
            enableColumnResize: true,
            enableColumnReordering : true,
            showFooter: true,
            totalServerItems: 'totalMachinesCovered',
            pagingOptions: $scope.machineCoveredOptions,
            columnDefs : [ {
                field : 'fleetInventoryItem.serialNumber',
                displayName : 'Serial Number',
                cellTemplate:'<a ng-click="findInventoryBySerialNumber(row.getProperty(col.field))">{{row.getProperty(col.field)}}</a>'
            }, {
                field : 'fleetInventoryItem.equipmentType',
                displayName : 'Equipment Type'
            }, {
                field : 'fleetInventoryItem.modelName',
                displayName : 'Model'
            }, {
                field : 'fleetInventoryItem.modelYear',
                displayName : 'Year'
            }, {
                field : 'fleetInventoryItem.brandType',
                displayName : 'Manufacturer'
            }, {
                field : 'fleetInventoryItem.assetNumber',
                displayName : 'Asset Number'
            }, {
                field : 'fleetInventoryItem.maintenanceType',
                displayName : 'Maintainance Type'
            },{
                field : 'status',
                displayName : 'Status'
            }, {
                field : 'fromDate',
                displayName : 'Contract Start Date'
            },{
                field : 'tillDate',
                displayName : 'Contract End Date'
            } ],
            plugins : [ new ngGridFlexibleHeightPlugin() ]
      };
    
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
   
    $scope.contractAudit = function(items){  
    	 if(items.length > 0 ){
        var id = items[0].id;
        var url = "getContractAudit.action?id=" + id+"&contractId="+$scope.contract.id;
        var thisTabLabel = getMyTabLabel();  
        parent.publishEvent("/tab/open", {
            label: "ContractAudit History",
            url: url,
            decendentOf: thisTabLabel,
            forceNewTab: true
        });
       }
    };
    
    $scope.submit = function() {
        $scope.contract.activeContractAudit.applicableCostCategories = [];
        angular.forEach($scope.costCategories, function(data) {
            if (data.checked) {
                $scope.contract.activeContractAudit.applicableCostCategories.push(data.data);
            }
        });
        $http.post('submitContract/', JSON.stringify($scope.contract)).success(function(data) {
            $scope.submitForm = (data.successMessage) ? true : false;
        /*    $util.httpGet('hoursToMilesRation',
                    {                        
                    },
                    function(data) {
                        $scope.ratio=data;                   
            $scope.contract.activeContractAudit.applicableTravelMatrix[0].hour= $scope.ratio*$scope.contract.activeContractAudit.applicableTravelMatrix[0].milesPerTrip;
            $scope.contract.activeContractAudit.applicableTravelMatrix[1].hour= $scope.ratio*$scope.contract.activeContractAudit.applicableTravelMatrix[1].milesPerTrip;
            
                    });
            $scope.getAttachments($scope.contract.id); */     
            $scope.audits = data.target.contractAudits;
        });
    };
    
/*    $scope.fleetInventoryItemsCount=0;
    $scope.pageSize=5;
    $scope.totalPages=0;
    $scope.filterCriteria={
            pageNumber: 1,
            sortDir: 'asc',
            sortedBy: 'id'
    }
    
    $scope.fetchResult = function () { 
    	  var auditId=-1;
          if(selectedAuditId!=null && selectedAuditId.value)
        	  auditId =selectedAuditId.value;
          $http({method: 'GET', url: 'applicableMachines',params: {pageNumber: $scope.filterCriteria.pageNumber,pageSize: $scope.pageSize, id: $scope.id, auditId: auditId}}).
            success(function(data) {
              $scope.fleetInventoryItems = data.applMachines;
              $scope.fleetInventoryItemsCount = $scope.fleetInventoryItems.length;
              $scope.totalPages = data.totalPages;
           });   
    };
    
    $scope.selectPage = function (page) {
        $scope.filterCriteria.pageNumber = page;
        if($scope.contractId)
        {
        $scope.fetchResult();
        }
    };
    $scope.selectPage(1);*/
    

    $util.httpGet('listDocTypes', {}, function(data) {
        $scope.docTypes = data;
    });

    var uploader = $scope.uploader = $fileUploader.create({
        scope : $scope,
        url : 'saveFile',
        formData : [ {
            key : 'value'
        } ]
    });

    uploader.bind('complete', function(event, xhr, item, response) {
        angular.forEach(response[0], function(doc) {
            $scope.failedDocuments.push(doc);
        });
        angular.forEach(response[1], function(doc) {
        	if($scope.contract.activeContractAudit.attachments == null){
        		$scope.contract.activeContractAudit.attachments = [];	
        	}
            $scope.contract.activeContractAudit.attachments.push(doc);
        });
    });

    uploader.bind('completeall', function(event, items) {
        if ($scope.failedDocuments.length == 0) {
            $scope.openUploadDocWindow = false;
        } else {
            uploader.queue = [];
        }

    });

    $scope.uploadDocuments = function() {
        $scope.openUploadDocWindow = true;
    }

    $scope.deleteDocument = function(index) {
        $scope.contract.activeContractAudit.attachments.splice(index, 1);
    }

    $scope.close = function() {
        $scope.openUploadDocWindow = false;
        $scope.failedDocuments = [];
    };
    
    $scope.displayEquipmentDetails = function(id) {
        if (angular.isUndefined(id)) {
            return;
        }
        var url = "equipmentDetailsInfo.action?id=" + id;
        var thisTabLabel = getMyTabLabel();
        parent.publishEvent("/tab/open", {
            label : "Equipment History",
            url : url,
            decendentOf : thisTabLabel,
            forceNewTab : true
        });
    }
    
    $scope.isReadOnly = function() {
        return !($scope.isDealerOwned);
    };
    
    $scope.$watch('contract.activeContractAudit.forCustomer.name', function(newValue, oldValue) {
        $util.httpGetWithId('getCustomerAndItsLocations', {
            id : newValue
        }, newValue, function(data) {
            $scope.contract.activeContractAudit.forCustomer.preferredCurrency=data.fleetCustomer.preferredCurrency;
            $scope.customerBillTo=data.fleetCustomer.customerNumber;
        });
    });
    
    
    $scope.$watch('contract.activeContractAudit.servicingDealer.name+contract.activeContractAudit.shipTo.code', function(newValue, oldValue) {
        if (!angular.isUndefined($scope.contract)&&!angular.isUndefined($scope.contract.activeContractAudit.servicingDealer)
                && !angular.isUndefined($scope.contract.activeContractAudit.shipTo)) {
            $scope.travelDetails();
            if ($scope.isDealerOwned) {
                $scope.fetchAddress();
            }
        }
    });
    
    $scope.travelDetails= function()
    {
        if ($scope.contract.activeContractAudit.servicingDealer.address != undefined && $scope.contract.activeContractAudit.shipTo.address !=undefined) {
            var origin = $scope.contract.activeContractAudit.servicingDealer.address;
            var destination = $scope.contract.activeContractAudit.shipTo.address;
            $util.httpGet('hoursToMilesRation', {}, function(data) {

                if ($scope.contract.activeContractAudit.applicableTravelMatrix == undefined
                        || $scope.contract.activeContractAudit.applicableTravelMatrix.length == 0) {
                    $scope.contract.activeContractAudit.applicableTravelMatrix = new Array();
                    travelDetail1 = new Object();
                    travelDetail1.trip = "PLANNED";
                    $scope.contract.activeContractAudit.applicableTravelMatrix.push(travelDetail1);
                    travelDetail2 = new Object();
                    travelDetail2.trip = "UNPLANNED";
                    $scope.contract.activeContractAudit.applicableTravelMatrix.push(travelDetail2);
                }

                $scope.hour = [];
                $scope.ratio = data;

                if ($scope.contract.activeContractAudit.applicableTravelMatrix[0].milesPerTrip == 0
                        || $scope.contract.activeContractAudit.applicableTravelMatrix[0].milesPerTrip == undefined
                        || $scope.contract.activeContractAudit.applicableTravelMatrix[1].milesPerTrip == 0
                        || $scope.contract.activeContractAudit.applicableTravelMatrix[1].milesPerTrip == undefined) {
                    calculateDistances(origin, destination);
                }
                $scope.contract.activeContractAudit.applicableTravelMatrix[0].hour = $scope.ratio
                        * $scope.contract.activeContractAudit.applicableTravelMatrix[0].milesPerTrip;
                $scope.contract.activeContractAudit.applicableTravelMatrix[1].hour = $scope.ratio
                        * $scope.contract.activeContractAudit.applicableTravelMatrix[1].milesPerTrip;
                $scope.travelRation();

            });
        }
    };
    
    $scope.$watch('contract.activeContractAudit.forCustomer.name', function(newVal, oldVal) {
       if(angular.isNumber(newVal))
           {
           $scope.contract.activeContractAudit.forCustomer.id=newVal;
           }
    });
    
    $scope.$watch('contract.activeContractAudit.shipTo.code', function(newVal, oldVal) {
       if(angular.isNumber(newVal))
           {
           $scope.contract.activeContractAudit.shipTo.id=newVal;
           }
    });
  
    $scope.$watch('contract.activeContractAudit.servicingDealer.name', function(newVal, oldVal) {
       if(angular.isNumber(newVal))
           {
           $scope.contract.activeContractAudit.servicingDealer.id=newVal;
           }
    });
    
    $scope.fetchAddress = function()
    {
          if ($scope.contract.activeContractAudit.servicingDealer.address == undefined
                                        && $scope.contract.activeContractAudit.shipTo.address == undefined
                                        && $scope.contract.activeContractAudit.shipTo.id != undefined
                                        && $scope.contract.activeContractAudit.servicingDealer.id != undefined) {
            $util.httpGet('getOrgAddress', {
                serviceProviderId : $scope.contract.activeContractAudit.servicingDealer.id,
                locationId : $scope.contract.activeContractAudit.shipTo.id
            }, function(data) {
                $scope.contract.activeContractAudit.servicingDealer.address = data.serviceProviderAddress;
                $scope.contract.activeContractAudit.shipTo.address = data.locationAddress;
                $scope.travelDetails();
            });
        }
    
    }
    
    $scope.printContract=function()
    {
    	 var thisTabLabel = getMyTabLabel();
         parent.publishEvent("/tab/open", {
        	 label: "Print Contract",
             url: "printContract.action?contractId=" +$scope.contract.id,
             decendentOf : thisTabLabel,
             forceNewTab : true
         });          	
    };
    
}]);

contractApp.controller('SubContractController', ['$scope', '$http', '$util',function($scope, $http, $util) {
    load = function() {
        var subContractId = document.getElementById('subContractId').value;
        //var dateFormat=document.getElementById('dateFormat').value;
        if (subContractId) {
            $util.httpGet('subContractDetails', {
                subContractId : subContractId
            }, function(data) {
                if(data){
                $scope.subContract = data.subContract;
                $scope.audits = $scope.subContract.subContractAudits;
                $scope.activeSubContractInventories=$scope.subContract.subContractInventories;
                $scope.isServicingDealer=data.isServicingDealer;
                $scope.isFleetCoordinatorOrDealerOwnedCoordinator =data.isFleetCoordinatorOrDealerOwnedCoordinator;
                if ($scope.subContract.state != 'UNPUBLISHED')
                    $scope.subContract.activeSubContractAudit.comments = "";
                }
            });                
        }
    };
    load();
    
    $scope.cancel = function() {
        closeTab(getTabHavingLabel(getMyTabLabel()));
    };
    
    $scope.submit = function() {
        if($scope.takenAction == undefined)
            $scope.takenAction=null;
        $http.post('processSubContract/', JSON.stringify($scope.subContract), {headers : {"takenAction": $scope.takenAction}}).success(function(data) {
            $scope.subContract = data.target;
            if (data.successMessage) {
                $scope.alerts = [{
                    type : 'success', msg : data.successMessage
                }];
                $scope.submitForm = true;
            } else{
                $scope.alerts = [{
                    type : 'error',msg : data.errors
                }];
            }
           });
    };
    
    $scope.save = function() {
        $http.post('saveSubContract/', JSON.stringify($scope.subContract)).success(function(data) {
            $scope.subContract = data.target;
        });
    };
    
    $scope.gridForSubContractAuditHistory = {
            data : 'audits',
            enableColumnResize: true,
            enableColumnReordering : true,
            columnDefs : [ { 
                field : 'd.updatedTime',
                displayName : 'Date / Time',
                cellFilter: "date:\'MM/dd/yyyy   HH:mm\'", width:'15%'
            }, { 
                field : 'updatedBy.completeNameAndLogin',
                displayName : 'User',
                width:'20%'
            },{ 
                field : 'comments',
                displayName : 'Comments',
                width:'50%'
            } ],
        plugins : [  new ngGridFlexibleHeightPlugin() ]
    };
}]);