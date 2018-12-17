var equipmentApp = angular.module('equipmentApp', [ 'ui.bootstrap', '$strap.directives', 'textArea', 'autoCompleter', 'titlePane', 'repeater', 'loadingIndicator','alertMsg', '$util', 'ngGrid', 'moneyType', 'subSection', 'numbersOnly','isNumber' ]);

equipmentApp.controller('EquipmentController', ['$scope', '$parse', '$http', '$util', '$filter', '$rootScope', function ($scope, $parse, $http, $util, $filter, $rootScope) {
	 $scope.hide = false;
	 $scope.isInternalUserOrOwningDealer = false;
	 $scope.updated = false;
	load = function() {
		if ($scope.inventoryId !=null){		
    	$http({method: 'GET', url: 'equipmentDetailsById',params: {id:$scope.inventoryId}}).	
	    success(function(data) {
	    	$scope.fleetInventoryItem = data.fleetInventoryItem;
	    	$scope.customerId = data.customerId;
	    	$scope.listOfServiceCodes = data.associatedServiceCodes;
	    	$scope.contractAudits = data.contractAudits;
            $scope.fleetInventoryAudits = data.fleetInventoryAudits;
            $scope.listOfEquipmentCondition = data.listEquipmentCondition;
            $scope.fleetInventoryItem.equipmentAttributes = data.equipmentAttributes;
            angular.forEach($scope.listOfServiceCodes,function(row){
	    	  if(row.id!=null)
	    		  $scope.selectedCodes.push(row);
	  	   });
	    	$scope.billing = data.billing;
	    	$scope.fleetInventoryItem.recentBilling=data.billing;
	    	$scope.recentMachineHours = data.recentMachineHours;
	    	$scope.recentMtrReadingDate = data.recentMtrReadingDate;
	    	$scope.inventoryItem = data.inventoryItem;
	    	$scope.additionalAttributesList = data.additionalAttributesList;
	    	$scope.monthOnLeaseRemaining = data.difInMonths;
	    	$scope.readOnly = !data.equipmentInfoNonEditable;
	    	
	    	$scope.isInternalUser = data.isInternalUser;
	    	$scope.isDealerOwned = data.isDealerOwned;
	    	$scope.isServicingDealer = data.isServicingDealer;
	    	$scope.isCustomerUser = data.isCustomerUser;
	    	$scope.isInternalUserOrOwningDealer = $scope.isInternalUser || $scope.isDealerOwned ;
	    	$scope.productFamily=data.productFamily;
	    	$scope.unitAge=data.unitAge;
	    	$util.httpGet('findlovs', {isInternalUserOrOwningDealer : $scope.isInternalUserOrOwningDealer}, function(data) {
                $scope.callTypes = data;
        });
	    	
	    	$scope.currentShipTo = data.currentShipTo;
	    }); 
	  }
	};
   load();
   
   $scope.getSingleSelectOptions = function(index){
	   return $scope.fleetInventoryItem.equipmentAttributes[index].attributes.singleSelectValues.split(";");
   }
   
   $scope.getMonthOnLeaseRemaining = function(leaseEndDate){
	   var leaseEndDateSelected = new Date(leaseEndDate);
	   var todaysDate = new Date();
	   var one_day=1000*60*60*24;
	   var date1_ms = leaseEndDateSelected.getTime();
	   var date2_ms = todaysDate.getTime();
	   var difference_ms = date1_ms - date2_ms;
	   var difference_days = Math.round(difference_ms/one_day); 
	   var difference_months = Math.round(difference_days * 0.033);
       $scope.monthOnLeaseRemaining = difference_months;
    }
   
   $scope.getUnitAge = function(modelYear){
	   $scope.unitAge=0;
	   if (modelYear!="") {
		   $scope.unitAge = new Date().getFullYear() - modelYear ;
	   }
	}	 
   
     $scope.updateData = function(){
  	$scope.fleetInventoryItem.associatedServiceCodes=$scope.selectedCodes;
    	if ($scope.inventoryId !=null){    
        $http.post('updateEquipmentData/', JSON.stringify($scope.fleetInventoryItem)).success(function(data) {
            $scope.fleetInventoryItem = data.target;
            $scope.updated = (data.successMessage) ? true : false;
        });
     }
    }; 	 
   $scope.cancel = function() {
	closeTab(getTabHavingLabel(getMyTabLabel()));
    };
    
    $scope.printPGS = function()
    {
    	 var thisTabLabel = getMyTabLabel();
    	 var customerId = $scope.customerId;
    	 var customerName = encodeURIComponent($scope.fleetInventoryItem.activeFleetInventoryAudit.shipTo.customerName);
    	 var pgsUrl = "viewProgramGuideSummary?customerId="+customerId+"&customerName="+customerName;
    	 var dealerId; 
    	 var dealerName;
    	 if($scope.fleetInventoryItem.preferredDealer)
    		 {
	    		 dealerId = $scope.fleetInventoryItem.preferredDealer.id;
	    		 dealerName = encodeURIComponent($scope.fleetInventoryItem.preferredDealer.name);
	    		 pgsUrl = pgsUrl + "&dealerId="+dealerId+"&dealerName="+dealerName;
    		 }
    	 else if($scope.fleetInventoryItem.alternateDealer)
    		 {
	    		 dealerId = $scope.fleetInventoryItem.alternateDealer.id;
	    		 dealerName = encodeURIComponent($scope.fleetInventoryItem.alternateDealer.name);
	    		 pgsUrl = pgsUrl + "&dealerId="+dealerId+"&dealerName="+dealerName;
    		 }
         parent.publishEvent("/tab/open", {
        	 label: "Program Guide Summary",
             url: pgsUrl,
             decendentOf : thisTabLabel,
             forceNewTab : true
         });          	
    };
    
    $scope.callTypeChange = function(index,value) {
    	if( value==null)
    		$scope.listOfServiceCodes[index].callType=null;	
    };

    $scope.makeEquipmentInactive = function(){
    	$http.post('makeEquipmentInactive/', JSON.stringify($scope.fleetInventoryItem)).success(function(data) {
  	        $scope.successForm = (data.successMessage) ? true : false;       
  	        $scope.quoteForm = true;
  	        $scope.fleetInventoryItem.inactiveRequestSent=false;  	            
  	    });      
    }
		 	
    $scope.selectedCodes=[];
    $scope.totalServerItems = 0;
    $scope.gridOptions = {
 	       data: 'listOfServiceCodes',
 	       enableColumnResize: true,
 	       showSelectionCheckbox: true,
 	       selectWithCheckboxOnly:true,
 	       enableCellSelection: true,
 	       selectedItems:$scope.selectedCodes,
 	       columnDefs: [{field: "serviceCode.code",displayName: i18N.code },
 	                    {field: "serviceCode.description",displayName: i18N.description },
 	                    {field: "callType",width:130 ,displayName: i18N.callType, cellTemplate: '<select style="width:126px!important;" ng-model="listOfServiceCodes[row.rowIndex].callType.id" ng-change="callTypeChange(row.rowIndex,listOfServiceCodes[row.rowIndex].callType.id)" ng-options="callType.listOfValues.id as callType.listOfValues.name for callType in callTypes"> <option value="">--SELECT--</option></select>' },
 	                    {field: "paymentFee",displayName: i18N.dealerPayment,width :110},
 	                    {field: "invoiceFee",displayName: i18N.customerBilling,width :110},
 	                    {field: "frequency",displayName: i18N.frequency,width :130},
 	                    {field: "overrideFrequency",displayName: i18N.overrideFrequency, enableCellEdit: true,width :176, 
 	                    	cellTemplate: '<input type="text" style="margin-left:30px!important;width:80px!important;" data-ng-model="listOfServiceCodes[row.rowIndex].overrideFrequency"><span data-ng-if="listOfServiceCodes[row.rowIndex].hourlyFrequency==true"> Hrs</span><span data-ng-if="listOfServiceCodes[row.rowIndex].hourlyFrequency==false"> Days</span></input>'
 	                    }
 	                    ],
 	       plugins : [ new ngGridFlexibleHeightPlugin()]
    };
    
    $scope.displayContractsCoveredDetails = function(selectedItems) {
        if (angular.isUndefined(selectedItems) || selectedItems.length === 0) {
            return;
        }
        id = selectedItems.entity.contract.id;
        var url = "contractsCoveredDetails?id=" + id;
        var thisTabLabel = getMyTabLabel();
        parent.publishEvent("/tab/open", {
            label : "Contract Details",
            url : url,
            decendentOf : thisTabLabel,
            forceNewTab : true
        });
    };

    $scope.displayServiceRequestDetails = function(selectedItems) {
        if (angular.isUndefined(selectedItems) || selectedItems.length === 0) {
            return;
        }
        id = selectedItems.entity.serviceRequestId;  
        var url = "servicRequestDetails?id=" + id;
        var thisTabLabel = getMyTabLabel();
        parent.publishEvent("/tab/open", {
            label : "ServiceRequest Details",
            url : url,
            decendentOf : thisTabLabel,
            forceNewTab : true
        });
    };
    
    
    $scope.serviceRequestpagingOptions = {pageSizes: [10, 20, 30], pageSize: 10, currentPage: 1};
    $scope.totalSRItems = 0;
    $scope.gridForServiceRequestHistory = {
            data : 'serviceRequestHistory',
            selectedItems : $scope.mySelections,
            afterSelectionChange : function(selectedItems) {
                $scope.displayServiceRequestDetails(selectedItems);
            },
            multiSelect:false,
            enablePaging: true,
            enableColumnResize: true,
            enableColumnReordering : true,
            showFooter: true,
            totalServerItems: 'totalSRItems',
            pagingOptions: $scope.serviceRequestpagingOptions,
            columnDefs : [ 
              { field : 'serviceRequestNumber',displayName : i18N.serviceRequestNumber},
              { field : 'callType', displayName : i18N.callType},
              { field : 'requestedDate',displayName : i18N.requestedDate}, 
              { field : 'dateCompleted',displayName : i18N.dateCompleted},
              { field : 'status',displayName : i18N.status },
              { field : 'viewLinkedQuotes',displayName : i18N.viewLinkedQuotes},
              { field : 'viewLinkedClaims',displayName : i18N.viewLinkedClaims}
              ],
               plugins : [ new ngGridFlexibleHeightPlugin() ]
     };
    $scope.equipmentAuditpagingOptions = {pageSizes: [10, 20, 30], pageSize: 10, currentPage: 1};
    $scope.totalEquipmentAudittems = 0;
    
    $scope.gridForEquipmentAudits = {
            data : 'fleetInventoryAudits',
            selectedItems : $scope.mySelections,
            multiSelect:false,
            enablePaging: true,
            enableColumnResize: true,
            enableColumnReordering : true,
            showFooter: true,
            totalServerItems: 'totalEquipmentAudittems',
            pagingOptions: $scope.equipmentAuditpagingOptions,
            columnDefs : [ 
              { field : 'modelYear',displayName : 'Model Year'},
              { field : 'productClass', displayName : 'Product Class' },
              { field : 'contractCode;',displayName : 'Contract Code'}, 
              { field : 'equipmentType',displayName : 'Equipment Type'},
              { field : 'batterySerialNumber',displayName : 'Battery Serial Number'},
              { field : 'chargerSerialNumber', displayName : 'Charger Serial Number' },
              { field : 'attachmentSerialNumber;;',displayName : 'Attachment Serial Number'}, 
              { field : 'tireType;',displayName : 'Tire Type'},
              { field : 'batteryVoltage', displayName : 'Battery Voltage' },
              { field : 'meterTrending',displayName : 'Meter Trending'}, 
              { field : 'sicCode',displayName : 'Sic Code'}
              ],
               plugins : [ new ngGridFlexibleHeightPlugin() ]
     };
    
    
    $scope.getSRPagedDataAsync = function (pageSize,currentPage){
        $http({
            method : 'GET',
            url : 'srlistingBasedOnInventory',
            params : {
                pageNumber : currentPage,
                pageSize : pageSize,
                id : $scope.inventoryId
            }
        }).success(function(data) {
            $scope.totalSRItems = data.totalRecords;
            $scope.serviceRequestHistory = data.serviceRequestHistory;
        });
     };
    $scope.getSRPagedDataAsync($scope.serviceRequestpagingOptions.pageSize, $scope.serviceRequestpagingOptions.currentPage);
    $scope.$watch('serviceRequestpagingOptions', function(newVal, oldVal) {
    if (newVal !== oldVal || newVal.currentPage !== oldVal.currentPage) {
     $scope.getSRPagedDataAsync($scope.serviceRequestpagingOptions.pageSize, $scope.serviceRequestpagingOptions.currentPage);
     }
   }, true);
    $scope.contractsCoveredpagingOptions = {pageSizes: [10, 20, 30], pageSize: 10, currentPage: 1};
    $scope.totalcontractsCoveredItems = 0;

    $scope.gridForContractsCovered = {
  	     data: 'contractAudits',
  	     selectedItems : $scope.mySelections,
         afterSelectionChange : function(selectedItems) {
             $scope.displayContractsCoveredDetails(selectedItems);
         },
         multiSelect : false,
         multiSelect:false,
         enablePaging: true,
         enableColumnResize: true,
         enableColumnReordering : true,
         showFooter: true,
         totalServerItems: 'totalcontractsCoveredItems',
         pagingOptions: $scope.contractsCoveredpagingOptions,

  	     columnDefs : [ 
  	                 { field : 'contractCode', displayName :  i18N.contractCode},
  	                 { field : 'contractType',displayName :  i18N.contractType },
  	                 { field : 'billTo',displayName :  i18N.customerBillTo },
  	                 { field : 'customerName',displayName :  i18N.customerName },
  	                 { field : 'fromDate',displayName :  i18N.contractStartDate },
  	                 { field : 'tillDate',displayName :  i18N.contractEndDate },
  	                 { field : 'status',displayName :  i18N.status }

  	                 ],
  	     plugins : [ new ngGridFlexibleHeightPlugin() ]
    };
    
    $scope.transactionHistoryOptions = {pageSizes: [10, 20, 30], pageSize: 10, currentPage: 1};
    $scope.transactionHistoryItems = 0;
    
    $scope.mySelections = [];
    $scope.gridForTransactionHistory = {
     	 data: 'transactionHistory',
     	 selectedItems : $scope.mySelections,
         afterSelectionChange : function(selectedItems) {
        	 $scope.getTransactionHistory(selectedItems);
        	 $scope.displaylocationDetails($scope.mySelections);
         },
         multiSelect : false,
         multiSelect:false,
         enablePaging: true,
         enableColumnResize: true,
         enableColumnReordering : true,
         showFooter: true,
         totalServerItems: 'transactionHistoryItems',
         pagingOptions: $scope.transactionHistoryOptions,

     	 columnDefs : [ 
     	               { field : 'dateAndTime',displayName :  i18N.dateAndTime, cellFilter: "date:\'MM/dd/yyyy   HH:mm\'", width:'30%'},
     	               { field : 'fromShipTo',displayName :  i18N.fromShipTo },
     	               { field : 'toShipTo',displayName :  i18N.toShipTo },
     	               { field : 'userId',displayName :  i18N.userId }

     	               ],
     	 plugins : [ new ngGridFlexibleHeightPlugin() ]
    };
    
    $scope.getTransactionHistory = function (pageSize,currentPage){
        $http({
            method : 'GET',
            url : 'getTransactionHistoryDetails',
            params : {
                pageNumber : currentPage,
                pageSize : pageSize,
                inventoryId : $scope.inventoryId
            }
        }).success(function(data) {
            $scope.transactionHistory = data.transactionHistory;
        });
     };
     
     $scope.displaylocationDetails = function(id) {
    	 if (angular.isUndefined(id[0]) || id.length === 0) {
             return;
         }
    	 id = id[0].toShipToId;
         var url = "customerLocation.action?id=" + id;
         var thisTabLabel = getMyTabLabel();
         parent.publishEvent("/tab/open", {
             label : "Customer Location",
             url : url,
             decendentOf : thisTabLabel,
             forceNewTab : true
         });
     }
         
     $scope.getTransactionHistory($scope.transactionHistoryOptions.pageSize, $scope.transactionHistoryOptions.currentPage);
     $scope.$watch('transactionHistoryOptions', function(newVal, oldVal) {
 	    if (newVal !== oldVal || newVal.currentPage !== oldVal.currentPage) {
 	    	$scope.getTransactionHistory($scope.transactionHistoryOptions.pageSize, $scope.transactionHistoryOptions.currentPage);
 	    }
     }, true);
     
    //Start Pagination for upcoming service calls
    $scope.schedulepagingOptions = {pageSizes: [10, 20, 30], pageSize: 10, currentPage: 1};
    $scope.totalDueServiceItems = 0;
        $scope.gridForUpcomingSchedules = {
            data : 'listOfServiceSchedules',
            multiSelect:false,
            enablePaging: true,
            enableColumnResize: true,
            enableColumnReordering : true,
            showFooter: true,
            totalServerItems: 'totalDueServiceItems',
            pagingOptions: $scope.schedulepagingOptions,
            columnDefs : [ 
               {field : 'code',displayName : i18N.code}, 
               {field : 'description',displayName : i18N.description},
               {field : 'dueDate',displayName : i18N.serviceDueOn,
               	cellTemplate:'<div ng-class="{red: row.getProperty(\'colorFlag\')==1, orange:row.getProperty(\'colorFlag\')<=0,yellow: row.getProperty(\'colorFlag\')==2,green: row.getProperty(\'colorFlag\')==3}">{{row.getProperty(col.field)}}</div>'},
               {field : 'callType',displayName : i18N.callType},
               {field : 'customerBillTo',displayName : i18N.customerBillTo},
               {field : 'dealerName',displayName :i18N.dealerName }, 
               {field : 'dealerPayment',displayName : i18N.dealerPayment},
			   {field : 'customerPayment',displayName : i18N.customerBilling}],
    		   plugins : [ new ngGridFlexibleHeightPlugin() ]
       };
        
        $scope.gridForUpcomingSchedules.columnDefs[6].visible= $scope.internalView || $scope.dealerView;
        $scope.gridForUpcomingSchedules.columnDefs[7].visible= $scope.internalView || $scope.customerView;
        
        $scope.getSchedulePagedDataAsync = function (pageSize,currentPage){
            $http({
                method : 'GET',
                url : 'listDueScheduleServices',
                params : {
                    pageNumber : currentPage,
                    pageSize : pageSize,
                    id : $scope.inventoryId
                }
            }).success(function(data) {
                $scope.totalDueServiceItems = data.totalRecords;
                $scope.listOfServiceSchedules = data.listOfServiceSchedules;
            });
         };
        $scope.getSchedulePagedDataAsync($scope.schedulepagingOptions.pageSize, $scope.schedulepagingOptions.currentPage);
        $scope.$watch('schedulepagingOptions', function(newVal, oldVal) {
        if (newVal !== oldVal || newVal.currentPage !== oldVal.currentPage) {
         $scope.getSchedulePagedDataAsync($scope.schedulepagingOptions.pageSize, $scope.schedulepagingOptions.currentPage);
         }
        }, true);
      
        $scope.machineHoursOptions = {pageSizes: [10, 20, 30], pageSize: 10, currentPage: 1};
        $scope.totalMachineHours = 0;
        $scope.gridForMachineHours = {
                data : 'machineHours',
                multiSelect:false,
                enablePaging: true,
                enableColumnResize: true,
                enableColumnReordering : true,
                showFooter: true,
                totalServerItems: 'totalMachineHours',
                pagingOptions: $scope.machineHoursOptions,
                columnDefs : [ {
                    field : 'mtrReadingDate',
                    displayName : i18N.readingDateTime,
                    cellFilter: "date:\'MM/dd/yyyy   HH:mm\'", width:'50%'
                }, {
                    field : 'mtrReading',
                    displayName : i18N.hours
                }],
                plugins : [ new ngGridFlexibleHeightPlugin() ]
            };
        
        $scope.getMachineHoursDataAsync = function (pageSize,currentPage){
            $http({
                method : 'GET',
                url : 'getMachineHours',
                params : {
                    pageNumber : currentPage,
                    pageSize : pageSize,
                    inventoryId : $scope.inventoryId
                }
            }).success(function(data) {
                $scope.machineHours = data.machineHours;
            });
         };
        $scope.getMachineHoursDataAsync($scope.machineHoursOptions.pageSize, $scope.machineHoursOptions.currentPage);
        $scope.$watch('machineHoursOptions', function(newVal, oldVal) {
        if (newVal !== oldVal || newVal.currentPage !== oldVal.currentPage) {
         $scope.getMachineHoursDataAsync($scope.machineHoursOptions.pageSize, $scope.machineHoursOptions.currentPage);
         }
        }, true);
        
        $scope.failureCodeOptions = {pageSizes: [10, 20, 30], pageSize: 10, currentPage: 1};
        $scope.totalFailureCode = 0;
        $scope.gridForFailureCodes = {
                data : 'fleetFailureCode',
                multiSelect:false,
                enablePaging: true,
                enableColumnResize: true,
                enableColumnReordering : true,
                showFooter: true,
                totalServerItems: 'totalFailureCode',
                pagingOptions: $scope.failureCodeOptions,
                columnDefs : [ {
                    field : 'failureCode.failureDate',
                    displayName : i18N.alarmCodeDateTime,
                    cellFilter: "date:\'MM/dd/yyyy   HH:mm\'", width:'35%'
                }, {
                    field : 'failureCode.alarmCode.code',
                    displayName : i18N.alarmCodeReported, width:'30%'
                },{
                    field : 'failureCode.alarmCode.description',
                    displayName : i18N.alarmCodeDescription, width:'35%'
                }],
                plugins : [ new ngGridFlexibleHeightPlugin() ]
            };
        
        $scope.getFailureCodeDataAsync = function (pageSize,currentPage){
            $http({
                method : 'GET',
                url : 'getFailureCode',
                params : {
                    pageNumber : currentPage,
                    pageSize : pageSize,
                    inventoryId : $scope.inventoryId
                }
            }).success(function(data) {
                $scope.fleetFailureCode = data.fleetFailureCode;
            });
         };
        $scope.getFailureCodeDataAsync($scope.failureCodeOptions.pageSize, $scope.failureCodeOptions.currentPage);
        $scope.$watch('failureCodeOptions', function(newVal, oldVal) {
        if (newVal !== oldVal || newVal.currentPage !== oldVal.currentPage) {
         $scope.getFailureCodeDataAsync($scope.failureCodeOptions.pageSize, $scope.failureCodeOptions.currentPage);
         }
        }, true);
      
     //End Pagination for upcoming service calls
     //start Pagination for claim listing
     $scope.fleetClaimPagingOptions = {pageSizes: [10, 20, 30], pageSize: 10, currentPage: 1};
      $scope.totalClaimItems = 0;
      $scope.gridForClaimHistory = {
              data : 'fleetClaimHistory',
              selectedItems : $scope.mySelections,
              afterSelectionChange : function(selectedItems) {
                  $scope.displayClaimDetails(selectedItems);
              },
              multiSelect:false,
              enablePaging: true,
              enableColumnResize: true,
              enableColumnReordering : true,
              showFooter: true,
              totalServerItems: 'totalClaimItems',
              pagingOptions: $scope.fleetClaimPagingOptions,
              columnDefs : [ 
                { field : 'fleetClaimNumber',displayName : i18N.claimNumber},
                { field : 'customerBillTo',displayName : i18N.customerBillTo},
                { field : 'callType', displayName : i18N.callType},
                { field : 'fleetClaimDate',displayName : i18N.claimDate}, 
                { field : 'fleetClaimState',displayName : i18N.claimState},
                { field : 'dealerAmount',displayName : i18N.dealerAmount},
                { field : 'customerAmount',displayName : i18N.customerAmount},
                { field : 'hoursOnUnit',displayName : i18N.hoursOnUnit},
                { field : 'faultLocation',displayName : i18N.faultLocation}
                ],
             plugins : [ new ngGridFlexibleHeightPlugin() ]
       };
      $scope.gridForClaimHistory.columnDefs[5].visible= $scope.internalView || $scope.dealerView;
      $scope.gridForClaimHistory.columnDefs[6].visible= $scope.internalView || $scope.customerView;
    	
      $scope.getClaimPagedDataAsync = function (pageSize,currentPage){
          $http({
              method : 'GET',
              url : 'listFleetClaimsOnInventory',
              params : {
                  pageNumber : currentPage,
                  pageSize : pageSize,
                  inventoryId : $scope.inventoryId
              }
          }).success(function(data) {
              $scope.totalClaimItems = data.totalRecords;
              $scope.fleetClaimHistory = data.fleetClaimHistory;
          });
      };
      $scope.getClaimPagedDataAsync($scope.fleetClaimPagingOptions.pageSize, $scope.fleetClaimPagingOptions.currentPage);
      $scope.$watch('fleetClaimPagingOptions', function(newVal, oldVal) {
          if (newVal !== oldVal || newVal.currentPage !== oldVal.currentPage) {
              $scope.getClaimPagedDataAsync($scope.fleetClaimPagingOptions.pageSize, $scope.fleetClaimPagingOptions.currentPage);
          }
      }, true);
      //end Pagination for claim listing
      $scope.displayClaimDetails = function(selectedItems) {
          if (angular.isUndefined(selectedItems) || selectedItems.length === 0) {
              return;
          }
          id = selectedItems.entity.fleetClaimId;  
          var url = "fleetClaimDetailsReadonly?id=" + id;
          var thisTabLabel = getMyTabLabel();
          parent.publishEvent("/tab/open", {
              label : "Fleet Claim Details",
              url : url,
              decendentOf : thisTabLabel,
              forceNewTab : true
          });
      };

      $scope.showWarrantyInfo = function(){
    	  	var serialNumber =$scope.fleetInventoryItem.serialNumber;
            $util.openWarrantyTab('viewEquipmentHistoryForQuickSearch.action?action=EQUIPMENT%20HISTORY&context=InventorySearches&serialNumber='+serialNumber+'&actionType=equipmentHistory',serialNumber,'Home', true);
      };
      
      $scope.displayContractDetails = function(id) {
          var url = "contract_detail?id=" + id;
          var thisTabLabel = getMyTabLabel();
          parent.publishEvent("/tab/open", {
              label : "Contract Detail",
              url : url,
              decendentOf : thisTabLabel,
              forceNewTab : true
          });
      };
      
}]);

equipmentApp.controller('equipmentSearchController', ['$scope', '$parse', '$http', '$util', function($scope, $parse, $http, $util) {
   $scope.updated = false;
   $scope.searchFleetInventory = function(id) {
   	   var id =$scope.inventoryId;
   	   if(id !=null){
       var url = "equipmentDetailsInfo.action?id=" + id;
       var thisTabLabel = getMyTabLabel();
       parent.publishEvent("/tab/open", {
           label : "Equiment History Details",
           url : url,
           decendentOf : thisTabLabel,
           forceNewTab : true
       });
   	   }else{
   		   //$scope.form.invalid=true;
   	   } 
   };
   /*$scope.setFleetInventoryId = function(value){
	   if (+value && value.toString().length>2) {
		   $scope.inventoryId=value;
	 } 
   };*/
   
   $scope.$watch('fleetInventoryitem.serialNumber', function(newVal, oldVal) {
       if (angular.isNumber(newVal)) {
    	   $scope.inventoryId=newVal;           
       }
   }); 
   $scope.setFleetInventoryAssetNumber = function(assetNumber){
	   if (+assetNumber && assetNumber.toString().length>2) {
		   $scope.inventoryId=assetNumber;
	 } 
   };
   $scope.reset = function() {
   	$scope.fleetInventoryitem= "";
   };
}]);

equipmentApp.controller('equipmentTransferController', ['$scope', '$parse', '$http', '$util', function($scope, $parse, $http, $util) {
	$scope.updated = false;
    $scope.listSerialNumbersForTransfer = function() {
            $scope.addInputRow('serialNumber', 'series',
                    'model', 'shipTo', 'itemCondition', 'buildDate');
        };

        $scope.getSerialnoDetails = function(index, value) {
            if (+value && value.toString().length > 2) {
             	$http({method: 'GET', url: 'getFleetInfoByid',params: {id:value}}).	
         	    	success(function(data) {
         	    		if(data){
         	    			$scope.equipmentTransferUnitBean.fleetInventoryItems[index].id = data.id;
         	    			var product={};product['groupCode']=data.product.groupCode;product['id']=data.product.id;
                            var model={};model['groupCode']=data.model.groupCode;model['id']=data.model.id;                            
                            $scope.equipmentTransferUnitBean.fleetInventoryItems[index].product = product;
                            $scope.equipmentTransferUnitBean.fleetInventoryItems[index].model =model;
                            var activeFleetInventoryAudit={};var shipTo = {};
                            shipTo['code']=data.activeFleetInventoryAudit.shipTo.code;
                            activeFleetInventoryAudit['id'] = data.activeFleetInventoryAudit.id;
                            shipTo['id']=data.activeFleetInventoryAudit.shipTo.id;
                            shipTo['code']=data.activeFleetInventoryAudit.shipTo.code;
                            activeFleetInventoryAudit['shipTo'] =shipTo;
                            $scope.equipmentTransferUnitBean.fleetInventoryItems[index].activeFleetInventoryAudit = activeFleetInventoryAudit;
                            $scope.equipmentTransferUnitBean.fleetInventoryItems[index].equipmentCondition = data.equipmentCondition;
                            $scope.equipmentTransferUnitBean.fleetInventoryItems[index].installDate = data.installDate;
                            }
                         });
             		}
          };

     	   	 $scope.getCustomerLocationsByCustomerName = function(value){
     			 $scope.locations=null;
     		            $util.httpGet('getCustomerAndItsLocations', {
     		                id : value
     		            }, function(data) {
     		                $scope.locations = data.locations;
     		                $scope.equipmentTransferUnitBean.fleetCustomer = data.fleetCustomer;
     		            });	
     		 	};
     		 	
     		 	 $scope.$watch('equipmentTransferUnitBean.fleetCustomer.customerNumber', function(newVal, oldVal) {
     				if (newVal && angular.isNumber(newVal)) {
     					$scope.getCustomerLocationsByCustomerId(newVal);
     				}
     			});
     		 	 
     		 	$scope.getCustomerLocationsByCustomerId = function(value){
        			 $scope.locations=null;
        		            $util.httpGet('getCustomerAndItsLocations', {
        		                id : value
        		            }, function(data) {
        		                $scope.locations = data.locations;
        		                $scope.equipmentTransferUnitBean.fleetCustomer = data.fleetCustomer;
        		            });	
        		 	};

     			$scope.$watch('equipmentTransferUnitBean.fleetCustomer.name', function(
     					newVal, oldVal) {
     				if (newVal && angular.isNumber(newVal)) {
     					$scope.getCustomerLocationsByCustomerName(newVal);
     				}
     			});

        $scope.performTransfer = function(){
        	$http.post('generateTransferUnitEmail/', JSON.stringify($scope.equipmentTransferUnitBean)).success(function(data) {
        		if (data.errors.length > 0){
        			  $scope.alerts = [{type : 'error', msg : data.errors }];
        			 }
        		else if (data.successMessage.length > 0){
        			  $scope.alerts = [{type : 'success', msg : data.successMessage}];
        			}
        	});
        };

    $scope.searchTransferUnits = function(id) {
    	var id =$scope.fleetinventoryitem.serialNumber;
        var url = "transferUnitListing.action?id=" + id;
        var thisTabLabel = getMyTabLabel();
        parent.publishEvent("/tab/open", {
            label : "Transfer Customer Unit Listing",
            url : url,
            decendentOf : thisTabLabel,
            forceNewTab : true
        });
    };
    
    $scope.equipmentTransferUnitBean={};
    $scope.searchFleetInventory = function(id) {
     	var id =$scope.fleetinventoryitem.inventoryItem.serialNumber;
         var url = "equipmentDetailsByNumber.action?id=" + id;
         var thisTabLabel = getMyTabLabel();
         parent.publishEvent("/tab/open", {
             label : "Equiment History Details",
             url : url,
             decendentOf : thisTabLabel,
             forceNewTab : true
         });
     };
     
	  $scope.isCustomerNumber = false;
      $scope.toggleCustomerNumber = function() {
          $scope.isCustomerNumber = $scope.isCustomerNumber === false ? true: false;
      };

}]);