var serviceRequestApp = angular.module('createServiceRequest', [ 'ui.bootstrap', 'textArea', 'autoCompleter', 'titlePane', 'moneyType',
        'ngGrid', 'loadingIndicator', 'alertMsg', '$util', 'ui.event', 'angularFileUpload','popup','numbersOnly', 'focusMe']);

serviceRequestApp.factory('serviceRequestFactory', [ '$http', function($http) { 
    var serviceRequestService = {};
    serviceRequestService.save = function($scope) {
        $http.post('serviceRequestDraft/', JSON.stringify($scope.serviceRequest)).success(function(data) {
        	$scope.form.$dirty = false;
            $scope.serviceRequest = data.target;
            $scope.isEntryValidationCheck=false;
        });
    };
 
    
    serviceRequestService.fetchInventoryItemDetails = function($scope, newVal) {
        $http({
            method : 'GET',
            url : 'listServiceRequestInventoryItemDetails',
            params : {
                inventoryId : newVal
            }
        }).success(function(data) {
            if(data.originalResponse){
                data=data.originalResponse;
             }
            $scope.serviceRequest.forItem = data.inventory;
            $scope.serviceRequest.activeServiceRequestAudit.serialNumber=data.inventory.serialNumber;
            $scope.isFiledbyDealer = data.isFiledbyDealer;
            $scope.serviceRequest.customerLocation=$scope.serviceRequest.forItem.activeFleetInventoryAudit.shipTo;
            $scope.serviceRequest.customerPhoneNumber = $scope.serviceRequest.customerLocation.address.phone;
            //$scope.belongTo=data.belongTo;
            $scope.showWarrantyWarningMessage = data.inventory.underWarranty;
            $scope.showContractWarningMessage = data.inventory.inactiveContract;
            if(data.isServicingDealer) {
            $scope.isDealerCreateServiceRequest=!$scope.serviceRequest.forItem.activeFleetInventoryAudit.shipTo.createServiceRequest;
            }
            $scope.serviceRequest.customerLocation = data.inventory.activeFleetInventoryAudit.shipTo;
            $scope.serviceRequest.billTo = data.billTo;
            $scope.selfDiagonosisEnabled = data.inventory.activeFleetInventoryAudit.shipTo.selfDiagonosisEnabled;
            $scope.selfDiagnosisMandatory = data.inventory.activeFleetInventoryAudit.shipTo.selfDiagnosisMandatory;         
            $scope.contracts = data.contracts;
            $scope.contractDuration = data.contractDuration;
            $scope.contractContact = data.contractContact;
            $scope.dealerThreshold = data.dealerThreshold;
            $scope.isPreferredDealerValid = data.isPreferredDealerValid;
            $scope.isAlternateDealerValid = data.isAlternateDealerValid;
            $scope.isDealerSameAsDealerOnContract();
            $scope.PONumberRequiredOrNot();
            $scope.isInternalUserOrOwningDealer = data.isInternalUserOrOwningDealer;
            $scope.isCustomerUser=data.isCustomerUser;
            $scope.servicingDealer=data.isServicingDealer;
            $scope.fetchCallTypes();
            $scope.enableEmergencyRequest = $scope.emergencyRequesttag
                || $scope.serviceRequest.forItem.activeFleetInventoryAudit.shipTo.customer.dayTimeEmergency;
            var fleetInventoryIdForServiceCall=document.getElementById('fleetInventoryIdForServiceCall').value;
            if(!fleetInventoryIdForServiceCall){
                $scope.serviceCall = data.serviceCall;
            }
            var serviceCallId=document.getElementById('serviceCallId').value;
            if(serviceCallId){
                $http({
                    method : 'GET',
                    url : 'serviceCallDetails',
                    params : {
                        serviceCallId : serviceCallId
                    }
                }).success(function(data) {
                    $scope.serviceRequest.forServiceCall = data;
                    $scope.serviceRequest.activeServiceRequestAudit.problemDescription = data.associatedServiceCode.serviceCode.description;
                    $scope.serviceRequest.activeServiceRequestAudit.callType = data.associatedServiceCode.callType;
                });                        
            }
        });
    };

    return serviceRequestService;
} ]);

function ServiceRequestController($scope, $http, $util, $fileUploader, serviceRequestFactory) {
    $scope.submitted = false;
    $scope.selectedId = false;
    $scope.attachedDocuments = new Array();
    $scope.failedDocuments = [];
    $scope.searchServiceRequest=false;
    $scope.isEntryValidationCheck=false;
    $scope.isAlternateDealerValid = true;
	$scope.isPreferredDealerValid = true;
	$scope.isFiledbyDealer = false;
	$scope.isQuoteCreated = false;
	$scope.errorCodePresent=false;
	$scope.isInternalUserOrOwningDealer=false;
	$scope.isCustomerUser=false;
    $scope.servicingDealer=false;
    $scope.showErrorMessage=false;
    $scope.showQuoteDetail=false;
    $scope.isFieldsEditable=false;
    $scope.selfDiagonosisEnabled = false;
    $scope.selfDiagnosisMandatory = false;   
	    compressData = function() {
		var customerLocationId = {};
		var srId={};
		if ($scope.task && $scope.task.serviceRequest.customerLocation) {
			customerLocationId['id'] = $scope.task.serviceRequest.customerLocation.id;
			$scope.task.serviceRequest.customerLocation = {};
			$scope.task.serviceRequest.customerLocation = customerLocationId;
		}
		if ($scope.serviceRequest.customerLocation) {
			customerLocationId['id'] = $scope.serviceRequest.customerLocation.id;
			$scope.serviceRequest.customerLocation = {};
			$scope.serviceRequest.customerLocation = customerLocationId;
		}
		if ($scope.task && $scope.task.serviceRequest.forItem) {
			srId['id'] = $scope.task.serviceRequest.forItem.id;
			$scope.task.serviceRequest.forItem = {};
			$scope.task.serviceRequest.forItem = srId;
		}
		if ($scope.serviceRequest.forItem) {
			srId['id'] = $scope.serviceRequest.forItem.id;
			$scope.serviceRequest.forItem = {};
			$scope.serviceRequest.forItem = srId;
		}
		if ($scope.task && $scope.task.serviceRequest.quoteDetail) {
		    delete $scope.task.serviceRequest.quoteDetail;
		}
		if ($scope.serviceRequest.quoteDetail) {
		    delete $scope.serviceRequest.quoteDetail;
		}
		if ($scope.task && $scope.task.serviceRequest.claimDetail) {
		    delete $scope.task.serviceRequest.claimDetail;
		}
		if ($scope.serviceRequest.claimDetail) {
		    delete $scope.serviceRequest.claimDetail;
		}
	};
    load = function() {
        var taskId = document.getElementById('taskId').value;
        var folderName = document.getElementById('folderName').value;
        if (taskId) {
            $util.httpGet('serviceRequestDetails', {
                taskId : taskId
            }, function(data) {
            	if(data.originalResponse)
            	{
            	 data=data.originalResponse;
            	  }
                $scope.task = data.taskView;
                $scope.isFieldsEditable=data.isFieldsEditable;
                //$scope.belongTo=data.belongTo;
                $scope.serviceRequest = data.taskView.serviceRequest;
                $scope.ETASplit();
                if($scope.serviceRequest.customerLocation){
                $scope.selfDiagonosisEnabled = $scope.serviceRequest.customerLocation.selfDiagonosisEnabled;
                $scope.selfDiagnosisMandatory = $scope.serviceRequest.customerLocation.selfDiagnosisMandatory; 
                }
                $scope.isFiledbyDealer = data.isFiledbyDealer;
                $scope.audits = data.serviceRequestAudits;
                $scope.hideGridValueBasedOnUserType(data.serviceRequestAudits,data);
                $scope.task.takenTransition = data.taskView.takenTransition;
                $scope.quotedetail = data.taskView.serviceRequest.quoteDetail;
                $scope.contractDuration = data.contractDuration;
                $scope.contractContact = data.contractContact;
                $scope.dealerThreshold = data.dealerThreshold;
                $scope.isPreferredDealerValid = data.isPreferredDealerValid;
                $scope.isAlternateDealerValid = data.isAlternateDealerValid;
                $scope.isQuoteCreated = data.isQuoteCreated;
                if($scope.serviceRequest.forDealer== null){
                	$scope.dealerNameRequired=true;
                }
                if ($scope.serviceRequest.activeServiceRequestAudit.state != 'DRAFT') {
                    $scope.serviceRequest.activeServiceRequestAudit.notesForCustomer = "";
                    $scope.serviceRequest.activeServiceRequestAudit.notesForNMHG = "";
                    $scope.serviceRequest.activeServiceRequestAudit.notesForDealer = "";
                    $scope.serviceRequest.activeServiceRequestAudit.internalComments = "";
                    $scope.serviceRequest.activeServiceRequestAudit.attachments = data.taskView.serviceRequest.activeServiceRequestAudit.attachments;
                    $scope.documentsReadOnly = data.taskView.serviceRequest.activeServiceRequestAudit.attachments;
                }
                if($scope.serviceRequest.customerLocation != undefined || $scope.serviceRequest.customerLocation != null){
                $scope.enableEmergencyRequest = $scope.emergencyRequesttag
                || $scope.serviceRequest.customerLocation.customer.dayTimeEmergency;
                }else{
                	$scope.enableEmergencyRequest = $scope.emergencyRequesttag;
                }
                $scope.isDealerSameAsDealerOnContract();
                $scope.disableEnableLeaseEndDate();  
                $scope.isInternalUserOrOwningDealer = data.isInternalUserOrOwningDealer;
                $scope.isCustomerUser=data.isCustomerUser;
                $scope.servicingDealer=data.isServicingDealer;
                if (folderName) {
                	if (folderName == 'Workbench Service Request' || folderName == 'Draft Service Request' || folderName == 'Dealer Owned Draft Service Request' || folderName =='UnAssigned Service Request' || folderName =='Dealer Owned UnAssigned Service Request' || folderName=='Returned By Dealer' || folderName=='Returned By Dealer Owned Servicing Dealer'||
                	        folderName=='Assigned Service Request' || ((folderName=='Service Request Dispatched') && $scope.servicingDealer)){
                    $scope.fetchCallTypes();
                	}
                	if (folderName=='Returned By Dealer' || folderName=='UnAssigned Service Request' 
                	        || folderName=='Returned By Dealer Owned Servicing Dealer' || folderName=='Dealer Owned UnAssigned Service Request'){
                        $scope.getDealerLocations($scope.serviceRequest.forDealer.id);
                    }
                }
                if ($scope.isUserAdmin != 'true' && $scope.serviceRequest.activeServiceRequestAudit.callType) {
                	$scope.findCallTypeAssociated($scope.serviceRequest.activeServiceRequestAudit.callType.id);
                }
                
                if($scope.task.takenTransition=='Dispatch' || $scope.serviceRequest.displayStatus=='Dispatched')
            	{
            $util.httpGet('getTechniciansForDealer',{}, function(data) {
            	 $scope.technicians = data.items;
            });
            	}
                $scope.showQuoteDetail=data.showQuoteDetail;
                
            });
            
          
             
        }

        var selectedAuditId = document.getElementById('selectedAuditId').value;
        if (selectedAuditId) {
            $scope.selectedId = true;
            $util.httpGet('findServiceRequestAudit', {
                id : selectedAuditId
            }, function(data) {
                $scope.serviceRequest = data.serviceRequest;
                $scope.ETASplit();
                $scope.audits = data.serviceRequestAudits;
                $scope.hideGridValueBasedOnUserType(data.serviceRequestAudits,data);
                $scope.contractDuration = data.contractDuration;
                $scope.contractContact = data.contractContact;
                $scope.documentsReadOnly = data.serviceRequest.activeServiceRequestAudit.attachments;
                $scope.commentsReadOnly=true;
                $scope.isInternalUserOrOwningDealer = data.isInternalUserOrOwningDealer;
                $scope.isCustomerUser=data.isCustomerUser;
                $scope.servicingDealer=data.isServicingDealer;
                $scope.dealerThreshold = data.dealerThreshold;
            });
        }

        var serviceRequestId = document.getElementById('id').value;
        if (serviceRequestId) {
            $http({
                method : 'GET',
                url : 'serviceRequestInfo',
                params : {
                    id : serviceRequestId
                }
            }).success(function(data) {
                $scope.populateServiceRequestInfo(data);
                $scope.searchServiceRequest=data.isUserActor;
                $scope.dealerThreshold=data.dealerThreshold;
                $scope.showQuoteDetail=data.showQuoteDetail;
            });
        }

        var serviceRequestIDforSerialnumber = document.getElementById('serviceRequestIDforSerialnumber').value;
        if (serviceRequestIDforSerialnumber) {
        	 serviceRequestFactory.fetchInventoryItemDetails($scope, serviceRequestIDforSerialnumber);
        }

        var id = document.getElementById('serviceRequestId').value;
        if (id) {
            $http({
                method : 'GET',
                url : 'serviceRequestInfo',
                params : {
                    id : id
                }
            }).success(function(data) {
                $scope.commentsReadOnly=true;
                $scope.populateServiceRequestInfo(data);
                $scope.dealerThreshold=data.dealerThreshold;
            });
        }
        
        var fleetInventoryIdForServiceCall=document.getElementById('fleetInventoryIdForServiceCall').value;
        if(fleetInventoryIdForServiceCall){
            serviceRequestFactory.fetchInventoryItemDetails($scope, fleetInventoryIdForServiceCall);
        }

        $scope.toggleMin = function() {
            $scope.minDate = ( $scope.minDate ) ? null : new Date();
          };
          $scope.toggleMin();
          
        var folderName = document.getElementById('folderName').value;
        if (folderName == "" || folderName == 'Workbench Service Request' || folderName == 'Draft Service Request' || folderName == 'Dealer Owned Draft Service Request' || folderName =='UnAssigned Service Request' || folderName =='Dealer Owned UnAssigned Service Request' || folderName=='Returned By Dealer' || folderName=='Returned By Dealer Owned Servicing Dealer' || $scope.isQuoteCreated) {
            /*$util.httpGet('findlovs', {}, function(data) {
                $scope.callTypes = data;
            });*/
            $util.httpGet('listDocTypes', {}, function(data) {
                $scope.docTypes = data;
            });
           
        }
        
        $util.httpGet('userTimezone', {}, function(data) {
            if (data == "true") {
                $scope.emergencyRequesttag = true;
               
            } else {
                $scope.emergencyRequesttag = false;
            }
          
            
        });        
     
    };
    load();
    $scope.associatedCallType = {};
    $scope.findCallTypeAssociated = function(selectedCallType) {
    	if(selectedCallType) {
    		var isInternalOrOwningDealer = $scope.isUserAdmin ==='true' ? true : false ;
    		$util.httpGet('findAssociatedCallType',{id : selectedCallType, isInternalOrOwningDealer : isInternalOrOwningDealer },function(data){
    			$scope.associatedCallType = data;
    		});
    	}
    }
    
    $scope.callTypeChange = function () {
        var newVal = $scope.serviceRequest.activeServiceRequestAudit.callType;
        if(($scope.isUserAdmin == 'true' || $scope.isInternalUserOrOwningDealer))
            {
            angular.forEach($scope.callTypes, function(callType){
                if (newVal && newVal.id == callType.listOfValues.id ) {
                    if (!callType.isInternal) {
                        $scope.form.callType.$setValidity('notinternal', false);
                    } else {
                        $scope.form.callType.$setValidity('notinternal', true);
                    }
                    return;
                }
            });
            }
    
    };

    $scope.$watch('submitted', function(newVal, oldVal) {
    	 if (newVal) {
    	    var summaryTableId = getFrameAttribute("TST_ID");
             if (summaryTableId) {
                 manageTableRefresh(summaryTableId, true);
             }
    	 }
    });
    
    $scope.saveServiceRequestETA = function(form) {
    	compressData();
    	// Convert eta in String format to a JavaScript date
    	var etaDate = new Date($scope.eta);
    	// Get hours and minutes from eta date in HH:MM format
    	$scope.serviceRequest.activeServiceRequestAudit.technicianDetails.estimatedTimeOfArrival = etaDate.getHours() + ":" + etaDate.getMinutes();
         $http.post('serviceRequestETAUpdate/', JSON.stringify($scope.serviceRequest)).success(function(data) {
            	$scope.form.$dirty = false;
            	if(data.originalResponse)
            	{
            	 data=data.originalResponse;
            	}
                $scope.serviceRequest = data.target;
                if($scope.serviceRequest)
                	{
                $scope.task.serviceRequest=$scope.serviceRequest;
                $scope.setEta();
                	}
               
                $scope.isEntryValidationCheck=false;
                if(data.failureMessage){
                    $scope.populateFailureMessage(data);
                }
            });
    };

    $scope.setEta = function() {
    	if($scope.serviceRequest.activeServiceRequestAudit.technicianDetails && $scope.eta!=null){    		
          
          var time = new Date();
          time.setHours($scope.eta.getHours());
          time.setMinutes($scope.eta.getMinutes());
          $scope.serviceRequest.activeServiceRequestAudit.technicianDetails.estimatedTimeOfArrival=$scope.eta.getHours()+":"+$scope.eta.getMinutes();
    	}
    }
    
    // to split existing eta on load
    $scope.ETASplit = function() {
    	var time = new Date();
    	if($scope.serviceRequest.activeServiceRequestAudit.technicianDetails  && $scope.serviceRequest.activeServiceRequestAudit.technicianDetails.estimatedTimeOfArrival) {
    		var hoursAndMinutes =$scope.serviceRequest.activeServiceRequestAudit.technicianDetails.estimatedTimeOfArrival.split(":");
    	        time.setHours(hoursAndMinutes[0]);
    	        time.setMinutes(hoursAndMinutes[1]);
    	        $scope.eta = time;
    	} else {
	        $scope.eta = time;
    	}
    }
    

    $scope.save = function(form) {
    	compressData();
        serviceRequestFactory.save($scope);
    };

    $scope.submit = function(form) { 
    	compressData();
        if (!$scope.form.$valid) {
            $scope.submitted = true;
        } else {
            $http.post('submitServiceRequest/', JSON.stringify($scope.serviceRequest)).success(function(data) {
            	$scope.form.$dirty = false;
                $scope.shouldBeOpen = false;
                $scope.submitted = (data.successMessage) ? true : false;
                if(data.failureMessage){
                    $scope.populateFailureMessage(data);
                }
            });
        }
    };

    $scope.cancel = function() {
    	closeTab(getTabHavingLabel(getMyTabLabel()));
    };

    
    //check for the emergeny request condition
    $scope.validateServiceRequest = function(process) {
    	compressData();
        $scope.processRequest = process;
        $http.post('validateServiceRequest/', JSON.stringify($scope.serviceRequest)).success(function(data) {
        	if(data.originalResponse)
        	{
        	 data=data.originalResponse;
        	  }
        	$scope.isEntryValidationCheck = true;
        	 $scope.serviceRequest = data.target;
            $scope.shouldBeOpen = true;
            $scope.validateForm = (data.errors.length > 0) ? false : true;
            if ($scope.validateForm) {
                $http({
                    method : 'GET',
                    url : 'getmanageBUConfigurationData'
                }).success(function(data) {
                	$scope.form.$dirty = false;
                    $scope.selectedValue = data;
                    $scope.booleanValue = (data === 'true');
                    $scope.enableValue = $scope.booleanValue;
                    if (!($scope.booleanValue) && !$scope.serviceRequest.activeServiceRequestAudit.emergencyRequest) {
                        $scope.submit();
                    } else {
                        $scope.shouldBeOpen = true;
                        $scope.onlyESR = $scope.serviceRequest.activeServiceRequestAudit.emergencyRequest && !$scope.booleanValue && !$scope.isInternalUserOrOwningDealer;
                        $scope.onlyDisclaimer = !$scope.serviceRequest.activeServiceRequestAudit.emergencyRequest && $scope.booleanValue ||($scope.isInternalUserOrOwningDealer);
                        $scope.bothESRnDisclaimer = $scope.serviceRequest.activeServiceRequestAudit.emergencyRequest && $scope.booleanValue && !$scope.isInternalUserOrOwningDealer;
                    }
                });
                $scope.validForm = true;
                $scope.onlyESR = $scope.serviceRequest.activeServiceRequestAudit.emergencyRequest;
                $scope.onlyDisclaimer = !$scope.serviceRequest.activeServiceRequestAudit.emergencyRequest;
                $scope.bothESRnDisclaimer = $scope.serviceRequest.activeServiceRequestAudit.emergencyRequest;
            } else {
                $scope.validForm = false;
            }
        });
    };  

	$scope.isDealerSameAsDealerOnContract = function() {
		if ($scope.serviceRequest.dealerType != 'DIFFERENT_DEALER') {
			$scope.serviceRequest.dealerType = $scope.isPreferredDealerValid
					&& $scope.serviceRequest.dealerType != 'ALTERNATE_DEALER' ? 'PREFERRED_DEALER'
					: ($scope.isAlternateDealerValid ? 'ALTERNATE_DEALER'
							: 'DIFFERENT_DEALER');
		}
	};
    
    $scope.$watch('serviceRequest.forItem.serialNumber', function(newVal, oldVal) {
        if (angular.isNumber(newVal)) {            
        	serviceRequestFactory.fetchInventoryItemDetails($scope, newVal);
            
        }
    }); 
    
    /*$scope.$watch('belongTo',function(newVal,oldVal){
    	if(angular.isNumber(newVal)){  
    		
            $scope.isInternalUserOrOwningDealer=($scope.belongTo===$scope.activeOrganisation && $scope.isDealerOwned )|| $scope.isInternalUser;
            //$scope.customerUser=$scope.isCustomerUser==="true"?true:false;
            $scope.servicingDealer=$scope.belongTo!=$scope.activeOrganisation && $scope.isServicingDealer;
            //$scope.servicingDealer=$scope.servicingDealer=="true"?true:false;
    	}
    });*/
    

	$scope.fetchInventoryItemDetails = function(newVal){
	    serviceRequestFactory.fetchInventoryItemDetails($scope, newVal);
	};

    
    $scope.$watch('serviceRequest.forItem.assetNumber', function(newVal, oldVal) {
        if (angular.isNumber(newVal)) {
            serviceRequestFactory.fetchInventoryItemDetails($scope, newVal);
        }
    });
    $scope.$watch('serviceRequest.activeServiceRequestAudit.errorCode.code', function(newVal, oldVal) {  
        if (angular.isNumber(newVal)) {
            $util.httpGet('getErrorCodeDetails', {
                errorCodeId : newVal
            }, function(data) {
                $scope.serviceRequest.activeServiceRequestAudit.errorCode = data.target;
                $scope.serviceRequest.activeServiceRequestAudit.problemDescription=data.target.description;
            })
        }
    });
   
    $scope.$watch('selfDiagnosis.errorCode.code', function(newVal, oldVal) {
        $scope.disableSubmit=true; 
        $scope.errorCodePresent=false;
        $scope.errorMsgForErrorCode=false;
        if (angular.isNumber(newVal)) {
            $util.httpGet('getErrorCodeDetails', {
                errorCodeId : newVal
            }, function(data) {    
                $scope.selfDiagnosis.errorCode= data.target;              
                $scope.errorCodePresent=true;
                $scope.disableSubmit=false;
                $scope.disableSelection=true;
            })
        }
        else
            {
            $scope.disableSelection=false;
            }
        
    });

    $scope.close = function() {
        $scope.shouldBeOpen = false;
        $scope.emergencySR = false;
        $scope.addCustomerComments = false;
        $scope.selectSerialNumber = false;
        $scope.showcustomernotes = false;
        $scope.openUploadDocWindow = false;
        $scope.failedDocuments = [];
        $scope.selfDiagnoseWindow=false;
        $scope.showTroubleShootingAdvice=false;
        $scope.showFeedBack=false;
    };
    $scope.clear =function(){
    	//$scope.serviceRequest.activeServiceRequestAudit.technicianDetails="";
    }

    $scope.closeWarrantyWarningMessage = function() {
        $scope.showWarrantyWarningMessage = false;
    };

    $scope.closeContractWarningMessage = function() {
        $scope.showContractWarningMessage = false;
        $scope.serviceRequest = {};
    };
    
    $scope.closeDealerWarningMessage = function() {
    	  $scope.isDealerCreateServiceRequest = false;
          $scope.serviceRequest = {};
    }
    
    $scope.process = function(takenTransition) {
        if (takenTransition) {
            $scope.task.takenTransition = takenTransition;
        }
        compressData();
       $scope.setEta();
        $http.post('processServiceRequest/', JSON.stringify($scope.task)).success(function(data) {
            $scope.shouldBeOpen = false;
            $scope.submitted = (data.successMessage) ? true : false;
            if(data.failureMessage){
              $scope.populateFailureMessage(data);
            }
        });
    };   

    

	 $scope.dispatch = function() {
		if ($scope.serviceRequest.activeServiceRequestAudit.technicianDetails == null) {
			$scope.serviceRequest.activeServiceRequestAudit.technicianDetails = new Object();
			  var time = new Date();			 
	          $scope.serviceRequest.activeServiceRequestAudit.technicianDetails.estimatedTimeOfArrival = time.getHours()+":"+time.getMinutes();
		}
	};
    
    

    $scope.$watch('dealerId', function(newVal, oldVal) {
        if (newVal) {
            $util.httpGet('populateDealerDetails', {
                id : $scope.dealerId
            }, function(data) {
                $scope.serviceRequest.forDealer = data;
            });
        }
    });

    $scope.deleteDraftServiceRequest = function() {
    	compressData();
        $http.post('deleteDraftServiceRequest/', JSON.stringify($scope.serviceRequest)).success(function(data) {
            $scope.submitted = (data.successMessage) ? true : false;
            if($scope.submitted) {
            	$scope.form.$dirty = false;
            }
            if(data.failureMessage){
                $scope.populateFailureMessage(data);
            }
        });
    };

    
    $scope.displayQuoteDetails = function(id) {
        var url = "ServiceRequestQuoteDetail.action?id=" + id;
        var thisTabLabel = getMyTabLabel();
        parent.publishEvent("/tab/open", {
            label : "Quote Detail",
            url : url,
            decendentOf : thisTabLabel,
            forceNewTab : true
        });
    };
    
    $scope.equipmentHistoryPageDetail = function() {
        var thisTabLabel = getMyTabLabel();
        parent.publishEvent("/tab/open", {
            label :"Equiment History Details",
            url : "equipmentHistoryPage.action?equipmentHistoryId=" + $scope.serviceRequest.forItem.id,
            decendentOf : thisTabLabel,
            forceNewTab : true
        });
    };
    
    $scope.hideGridValueBasedOnUserType = function(audits,data) {
    	angular.forEach(audits, function(audit){
    		if(data.isServicingDealer) {
    			if(audit.userType == 'INTERNAL') {
    				audit.customer = "";
    				audit.NMHG = "";
    			}
    			if(audit.userType == 'CUSTOMER') {
    				audit.NMHG="";
    			}
    		}
		 });
    	angular.forEach(audits, function(audit){
    		if(data.isCustomerUser ){
    			if(audit.userType == 'INTERNAL') {
    				audit.dealer = "";
    				audit.NMHG = "";
    			}
    			if(audit.userType == 'DEALER USER') {
    				audit.NMHG = "";
    			}
    		}
    	});
    }

    $scope.gridForServiceRequestAudits = {
        data : 'audits',
        multiSelect : false,
        enableColumnResize : true,
        enableColumnReordering : true,
        columnDefs : [ {
            field : 'time',
            displayName : i18N.date,
            width : '8%'
        }, {
            field : 'state',
            displayName : i18N.state,
            width : '12%'
        }, {
            field : 'login',
            displayName : i18N.user,
            width : '12%'
        }, {
            field : 'userType',
            displayName : i18N.userType,
            width : '10%'
        }, {
            field : 'internalComments',
            displayName : i18N.internalComments,
            width : '14%'
        }, {
            field : 'NMHG',
            displayName : i18N.notesForNMHG,
            width : '14%'
        }, {
            field : 'dealer',
            displayName : i18N.notesForDealer,
            width : '14%'
        }, {
            field : 'customer',
            displayName : i18N.notesForCustomer,
            width : '14%'
        } ],
        plugins : [ new ngGridFlexibleHeightPlugin() ]
    };
    
    $scope.gridForServiceRequestAudits.columnDefs[4].visible = ($scope.isUserAdmin === "true") ? true : false;
   
  
    $scope.serviceRequestAudit = function(items) {
        var id = items[0].id;
        var url = "getServiceRequestAudit.action?id=" + id;
        var thisTabLabel = getMyTabLabel();
        parent.publishEvent("/tab/open", {
            label : "Service Request History",
            url : url,
            decendentOf : thisTabLabel,
            forceNewTab : true
        });
    };

    $scope.getCustomerNotes = function() {
        $scope.addCustomerComments = true;
        if ($scope.serviceRequest.customerLocation != undefined) {
            $scope.showcustomernotes = true;
            if (($scope.customernotes == undefined || $scope.customernotes == null)) {
                $scope.notes = new Array();
                $scope.customernotes = [];
                var comments = $scope.serviceRequest.customerLocation.customerNotes
                if ($scope.serviceRequest.activeServiceRequestAudit.additionalDetails != undefined) {
                    $scope.selectedComments = $scope.serviceRequest.activeServiceRequestAudit.additionalDetails.split(/\r\n|\r|\n/g);
                }
                $scope.notes = comments.split(/\r\n|\r|\n/g);
                angular.forEach($scope.notes, function(note) {
                    customernote = new Object();
                    customernote.data = note.trim();
                    if (customernote.checked == null || customernote.checked == undefined)
                        customernote.checked = false;
                    if ($scope.selectedComments != undefined) {
                        angular.forEach($scope.selectedComments, function(selectednote) {
                            if (selectednote == note) {
                                customernote.checked = true;
                            }
                        });
                    }
                    $scope.customernotes.push(customernote);
                });
            }
        } else {
            $scope.selectSerialNumber = true;
            $scope.showcustomernotes = false;
        }
    }

    $scope.addtoNotes = function() {
        $scope.selectedmessages = '';
        $scope.differentmessage = [];
        var oldComments = new Array();
        var textdata = new Array();
        if ($scope.serviceRequest.activeServiceRequestAudit.additionalDetails != undefined) {
            var selectedComments = $scope.serviceRequest.activeServiceRequestAudit.additionalDetails.split(/\r\n|\r|\n/g);
        }
        $scope.selectedmessages = '';
        angular.forEach($scope.customernotes, function(note) {
            if (note.checked) {
                if (($.inArray(note.data, $scope.differentmessage) < 0))
                    $scope.differentmessage.push(note.data);
            }
            textdata.push(note.data);
        });
        angular.forEach(selectedComments, function(selectednote) {

            if (($.inArray(selectednote, textdata) < 0))
                oldComments.push(selectednote);
        });
        angular.forEach($scope.differentmessage, function(selectednote) {
            $scope.selectedmessages = $scope.selectedmessages + selectednote + "\n";
        });
        angular.forEach(oldComments, function(oldnote) {
            $scope.selectedmessages = $scope.selectedmessages + oldnote + "\n";
        });
        $scope.serviceRequest.activeServiceRequestAudit.additionalDetails = $scope.selectedmessages;
        $scope.addCustomerComments = false;
    }

    $scope.disableEnableLeaseEndDate = function () {
        if ($scope.serviceRequest.forItem == null || $scope.serviceRequest.forItem.leaseEndDate == null || $scope.serviceRequest.forItem.leaseStartDate == null
                || $scope.serviceRequest.forItem.leaseId == null) {
            $scope.showAndhideLeaseInfo = false;
        } else {
            $scope.showAndhideLeaseInfo = true;
        }
    }
    $scope.PONumberRequiredOrNot = function () {
        if ($scope.serviceRequest.customerLocation.purchaseOrderRequired) {
            $scope.PONumberrequiredOrNot = true;
        } else {
            $scope.PONumberrequiredOrNot = false;
        }
    }

    $scope.calculateDistances = function(value) {
    	var service = new google.maps.DistanceMatrixService();
    	var origin = value;
    	var destination = $scope.getLocationAddress($scope.serviceRequest.customerLocation.physicalAddress);
    	var customerCountry = $scope.serviceRequest.customerLocation.physicalAddress.country;
        if (customerCountry == 'GB' || customerCountry == 'UK' || customerCountry == 'US') {
            unitSystem = google.maps.UnitSystem.IMPERIAL;
        } else {
            unitSystem = google.maps.UnitSystem.METRIC;
        }

    	service.getDistanceMatrix({
    		origins : [origin],
    		destinations : [ destination ],
    		travelMode : google.maps.TravelMode.DRIVING,
    		unitSystem : unitSystem,
    		avoidHighways : false,
    		avoidTolls : false
    		}, $scope.googleMapsDistanceApiCallback);
    }

    $scope.getLocationAddress = function (address) {
    	if(address){
        return address.addressLine1 + ',' + address.addressLine2 + ',' + address.city + ',' + address.state  + ',' + address.zipCode + ',' + address.country;
    	}
    }

    $scope.googleMapsDistanceApiCallback = function(response, status) {
    	$scope.$apply(function() {
    		if (google.maps.DistanceMatrixStatus.OK == status && google.maps.DistanceMatrixStatus.OK == response.rows[0].elements[0].status) {
    			$scope.distanceValue = response.rows[0].elements[0].distance.text;
    		} else {
    			$scope.distanceValue = i18N.location
    		}
    	});
    }

    $scope.getDealerLocations = function(value) {
        if (angular.isNumber(value)) {
            $util.httpGet('getDealerLocation', {
                id : value
            }, function(data) {
                if(data){
                    $scope.listOfLocation = data.listOfDealerLocation;
                }
            });
        }
    }

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
            $scope.serviceRequest.activeServiceRequestAudit.attachments.push(doc);
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
        $scope.serviceRequest.activeServiceRequestAudit.attachments.splice(index, 1);
    }
    
    $scope.validatePONumber = function(newVal,customerLocationId,PORegExp, isPONumDuplicateAllowed) {
    if(newVal!=null && customerLocationId!=null){
    	if(PORegExp == null){
    		PORegExp="";
    	}
   	 $util.httpGet('getPONumberDetails', {
         	poNumber : newVal,
         	locationId : customerLocationId,
         	regExp : PORegExp,
         	isPONumDuplicateAllowed: isPONumDuplicateAllowed
         }, function(data) {
         	 $scope.PONumberExits = data.PONumAvailable;
         	 if( $scope.PONumberExits){
         	 $scope.PONumberExits= true;
         	 } 
         	 var matRegExp=data.matchRegExp;
         	 $scope.PORegExpValidate(matRegExp,newVal);
         })  
    }
 };
 
 $scope.PORegExpValidate = function(matRegExp,newVal) { 
 	 $scope.PONumberDuplicate=false;
 	 if(matRegExp){
 		 $scope.PONumberDuplicate = false;
 	 }
 	 else if(newVal.length<=0){
 		$scope.PONumberDuplicate = false;
 	 }
 	 else{
 		 $scope.PONumberDuplicate = true;
 	 }

 };
	 $scope.$watch('serviceRequest.forDealer.name', function(newVal, oldVal) {
		if (newVal && angular.isNumber(newVal)) {
			$scope.fetchDealerDetails(newVal);
		}
	});

	$scope.$watch('serviceRequest.forDealer.serviceProviderNumber', function(
			newVal, oldVal) {
		if (newVal && angular.isNumber(newVal)) {
			$scope.fetchDealerDetails(newVal);
		}
	});
 
 $scope.fetchDealerDetails = function(newVal){
     $util.httpGet('populateDealerDetails', {
         id : newVal
     }, function(data) {
         $scope.serviceRequest.forDealer = data;
     });
	};
	
 
  $scope.locationWiseServiceRequest = function(location) {
		var thisTabLabel = getMyTabLabel();
		parent.publishEvent("/tab/open", {
			label : "Location Wise Service Request",
			url : "location_wiseServiceRequest.action?location=" + location
					+ "&folderName=Service Request History",
			decendentOf : thisTabLabel,
			forceNewTab : true
		});
	};
	
	$scope.serialNumberRequestHistory =function(serialNumber) {
		var thisTabLabel = getMyTabLabel();
		parent.publishEvent("/tab/open", {
			label : "Serial Number Request History",
			url : "serialNumberRequestHistory.action?serialNumber="
					+ serialNumber + "&folderName=Service Request History",
			decendentOf : thisTabLabel,
			forceNewTab : true
		});
	}
	
	$scope.equipmentDetailsPage =function(serialNumber) {
        var thisTabLabel = getMyTabLabel();
        parent.publishEvent("/tab/open", {
            label : "Equipment Details Page",
            url : "equipmentDetailsPage.action?serialNumber="
                    + serialNumber + "&folderName=Equipment Details Page",
            decendentOf : thisTabLabel,
            forceNewTab : true
        });
    }
	
	
	  $scope.isSerialNumber = true;
      $scope.toggleSerialNumber = function() {
          $scope.isSerialNumber = $scope.isSerialNumber === false ? true: false;
      };
      
      $scope.isDealerName = true;
      $scope.toggleDealerName = function() {
          $scope.isDealerName = $scope.isDealerName === false ? true: false;
      };
      
      $scope.$watch('serviceCall', function(newVal, oldVal) {
          if(newVal){
              $http.post('informationOnServiceCall/', JSON.stringify($scope.serviceCall)).success(function(data) {
                  $scope.form.$dirty = false;
                  $scope.isEntryValidationCheck=false;
              });
          }
      });
      $scope.getSystemList = function() {
          $scope.selfDiagnosisfeedback='';
          $scope.errorMsgForErrorCode=false;
          if($scope.selfDiagnosis){
         $scope.selfDiagnosis.errorCode.code="";
          }
        $scope.selfDiagnoseWindow = $scope.disableSubmit = $scope.disableFirstNext = $scope.disableNextTwo = $scope.disableNextThree = $scope.selfDiagnoseProcess = true;
        $scope.showQuesAnsOne = $scope.showQueAnsTwo = $scope.showQueAnsThree = false;
        $scope.subSystem = $scope.system = $scope.symptom = null;
        $util.httpGet('getDiagnosticGuide', {
            modelId : $scope.serviceRequest.forItem.model.id
        }, function(data) {
            if(data){
            $scope.diagnostic=data;
            $util.httpGet('populateSystemList', {             
                diagnosticGuide : data.id
            }, function(data) {
                $scope.diagnosticGuides = data;
            });
        }
            else{
                $scope.diagnosticGuideNotFound=true;
            }
        });
    }

    $scope.$watch('system', function(newVal, oldVal) {
        $scope.errorCodeWarning=false;
        $scope.disableSubmitforSystem=true;
        $scope.disableErrorCode=false;
        if (angular.isNumber(newVal)) {
            $scope.disableSubmitforSystem=false; 
           // $scope.disableErrorCode=true;
            $util.httpGet('populateSubSystemList', {
                system : newVal,
                diagnosticId:$scope.diagnostic.id
            }, function(data) {
                $scope.subSystemList = data;
            });
        }
        
        $scope.disableSubmit=$scope.disableSubmitforSystem || $scope.disableSubmitforSubsystem || $scope.disableSubmitforSymptom;  
        $scope.disableErrorCode=!$scope.disableSubmitforSystem ||! $scope.disableSubmitforSubsystem ||! $scope.disableSubmitforSymptom;
    });

    $scope.$watch('subSystem', function(newVal, oldVal) {
        $scope.disableSelection=false;
        $scope.disableErrorCode=false;
        $scope.disableSubmitforSubsystem=true;
        if (angular.isNumber(newVal)) {
          //  $scope.disableErrorCode=true;
            $scope.disableSubmitforSubsystem=false;   
            $util.httpGet('populateSymptomList', {
                subSystem : newVal,
                system:$scope.system,
                diagnosticId:$scope.diagnostic.id
            }, function(data) {
                $scope.symptomList = data;
            });
        }
        $scope.disableSubmit=$scope.disableSubmitforSystem || $scope.disableSubmitforSubsystem || $scope.disableSubmitforSymptom;
        $scope.disableErrorCode=!$scope.disableSubmitforSystem ||! $scope.disableSubmitforSubsystem ||! $scope.disableSubmitforSymptom;
    });  
      $scope.$watch('symptom', function(newVal, oldVal) {
          $scope.disableSubmitforSymptom=true;
          
      if(newVal)
          //$scope.disableErrorCodefor=true;
          $scope.disableSubmitforSymptom=false;   
      $scope.disableErrorCode=!$scope.disableSubmitforSystem ||! $scope.disableSubmitforSubsystem ||! $scope.disableSubmitforSymptom;
      $scope.disableSubmit=$scope.disableSubmitforSystem || $scope.disableSubmitforSubsystem || $scope.disableSubmitforSymptom;
      });
      
      $scope.$watch('symptom+subSystem+system', function(newVal, oldVal) {       
          $scope.disbleDiagnoseProcedure();
      });      
      
      $scope.findSelfDiagnose=function()
      {
          if($scope.errorCodePresent)
              {
              $util.httpGet('getSelfDiagnoseByErrorCode', {      
                  errorCodeId : $scope.selfDiagnosis.errorCode.id,
                  diagnosticGuideName:$scope.diagnostic.diagnosticGuideName
              }, function(data) {
                  if(data)
                  {
                      $scope.result=data;
                  $scope.finish();                                   
                  }
                  else{
                      $scope.errorCodeWarning=true;
                      $scope.errorMsgForErrorCode=true;
                  }
              }); 
              $scope.errorCodePresent=false;
              }
          else{
          if( $scope.nextQuestion)
              $scope.disableFirstNext=false;
          $util.httpGet('getSelfDiagnoseQuestion', {      
              id : $scope.symptom
          }, function(data) {
           $scope.selfDiagnosequestionOne=data;  
           $scope.QuestionAndAnswer=$scope.selfDiagnosequestionOne.description;
           $scope.disbleDiagnoseProcedure();
           $scope.showQuesAnsOne=true;
          }); 
      }
      }
      
      $scope.$watch('selfDiagnosequestionOne', function(newVal, oldVal) {
          if (newVal) {
              $util.httpGet('getSelfDiagnose', {      
                  id : $scope.symptom
              }, function(data) {                
               $scope.answersOne=data;
              });
          }
      });             
      $scope.showsecondQuestion=function()
      {
          if( $scope.nextQuestion.errorCode)
              {
              $scope.finish();
              $scope.result=$scope.nextQuestion;          
              }
          else{ 
          if( $scope.nextQuestiontwo)
              $scope.disableNextTwo=false;       
          else
              $scope.disableNextTwo=true;  
          $util.httpGet('getSelfDiagnose', {      
              id : $scope.nextQuestion.id
          }, function(data) {
           $scope.selfDiagnosequestionTwo=data[0];     
           $scope.QuestionAndAnswer+=";"+$scope.selfDiagnosequestionTwo.description;
           $scope.disbleDiagnoseProcedure();
           $scope.showQueAnsTwo=true;
          });
      }
      }
      
      $scope.$watch('selfDiagnosequestionTwo', function(newVal, oldVal) {
          if (newVal) {
              $util.httpGet('getSelfDiagnose', {      
                  id :  $scope.selfDiagnosequestionTwo.id
              }, function(data) {
               $scope.answersTwo=data;
              });
          }
      });  
      $scope.showThirdQuestion=function()
      { 
          if( $scope.nextQuestiontwo.errorCode)
              {
              $scope.result=$scope.nextQuestiontwo;    
              $scope.finish();
                  
              }
          else{ 
          if( $scope.result)
              $scope.disableNextThree=false; 
          $util.httpGet('getSelfDiagnose', {      
              id : $scope.nextQuestiontwo.id
          }, function(data) {
           $scope.selfDiagnosequestionThree=data[0];    
           $scope.QuestionAndAnswer+=";"+$scope.selfDiagnosequestionThree.description;
           $scope.disbleDiagnoseProcedure();
           $scope.showQueAnsThree=true;
          });
      }
      }
      
      $scope.$watch('selfDiagnosequestionThree', function(newVal, oldVal) {
          if (newVal) {
              $util.httpGet('getSelfDiagnose', {      
                  id :  $scope.selfDiagnosequestionThree.id
              }, function(data) {
               $scope.answersThree=data;
              
              });
          }
      });
      
      $scope.showprvFirstQuestion=function()
      {
          if( $scope.nextQuestion)$scope.disableFirstNext=false;              
          $scope.disbleDiagnoseProcedure();        
          $scope.showQuesAnsOne=true;      
      }
      
      $scope.showprvSecondQuestion=function()
      {
          $scope.disbleDiagnoseProcedure();
          $scope.showQueAnsTwo=true;
      }
      
      $scope.answerForFirstQuestion=function(answer)
      {         
          $scope.disableFirstNext=false;
          $scope.QuestionAndAnswer+=":"+answer.description;
          $scope.nextQuestion=answer;
      };
      $scope.answerselectedTwo=function(answer)
      {
          $scope.disableNextTwo=false;  
          $scope.QuestionAndAnswer+=":"+answer.description;
          $scope.nextQuestiontwo=answer;
      };
      $scope.answerselectedThree=function(answer)
      {
          $scope.disableNextThree=false;  
          $scope.QuestionAndAnswer+=":"+answer.description;
          $scope.result=answer;
      };
      
      $scope.finish=function()
      {     
          if ($scope.result.errorCode != null) {
            $util.httpGet('getErrorCodeForProduct', {
                errorCode : $scope.result.errorCode.code,
                product:$scope.serviceRequest.forItem.product.id
            }, function(data) {
                if(data.target.length>0){
                $scope.result.errorCode=data.target[0];
                $scope.errorCodeWindow();
                }
                else{
                    $scope.result.errorCode=null;  
                $scope.errorCodeWindow();
                }

            });
        }  
          else
              {
              $scope.errorCodeWindow();
              }
      }      
    
      
      $scope.errorCodeWindow =function()
      {
          if( $scope.result.errorCode==null)
              $scope.errorCodeWarning=true;
          else
              $scope.errorCodeWarning=false; 
          $scope.disableAllScreen();         
          $scope.showTroubleShootingAdvice=true;
          $scope.troubleShootingInfo=true;  
      }
      
      $scope.selfDiagnosePrb =function()
      {   
          $scope.showFeedBack=true;
          $scope.troubleShootingInfo=false;
          $scope.submitServiceRequestSD=false;
      }
      
      $scope.submitServiceRequest=function()
      {
          $scope.selfDiagnosePrb();
          $scope.faultLocation=$scope.result.systemAndSubsytem;
          $scope.submitServiceRequestSD=true;
      }
      
      $scope.disableAllScreen=function()
      { 
          $scope.disbleDiagnoseProcedure();
          $scope.selfDiagnoseProcess=false;          
      }
      $scope.diagnoseAnother=function()
      {
          $scope.getProblemDescriptionAndErrorCode();
          $scope.selfDiagnoseWindow=true;
          $scope.selfDiagnoseProcess=true;
          $scope.showFeedBack=false;
          $scope.showTroubleShootingAdvice=false;
          $scope.getSystemList();       
      };
      

      $scope.getProblemDescriptionAndErrorCode = function() {
        if ($scope.errorCodes && $scope.problemDiscriptions && $scope.result.errorCode) {
            $scope.errorCodes += "," + $scope.result.errorCode.code;
            $scope.faultLocations += "," + $scope.faultLocation;
            $scope.problemDiscriptions += "\n" + $scope.result.problemDescription;
        } else if($scope.result.errorCode) {           
            $scope.errorCodes = $scope.result.errorCode.code;               
            $scope.problemDiscriptions = $scope.result.problemDescription;
            $scope.faultLocations = $scope.faultLocation;
        }
        else
            {
            $scope.errorCodeWarning=true;
            }
    };
    
    $scope.submitServiceRequestWithFeedBack=function()
    {
        $scope.getProblemDescriptionAndErrorCode();
        $scope.serviceRequest.activeServiceRequestAudit.problemDescription = $scope.problemDiscriptions;    
        $scope.serviceRequest.activeServiceRequestAudit.errorCodes= $scope.errorCodes;      
        $scope.serviceRequest.activeServiceRequestAudit.faultLocations= $scope.faultLocations;        
        $scope.closeSelfDiagnosis();
    };
            
      $scope.closeSelfDiagnosis=function()
       {
          $scope.selfDiagnoseWindow = false;
        $scope.disableAllScreen();
        $scope.troubleShootingInfo = false;
        $scope.savefeedback = new Object();
        $scope.savefeedback.serialNumber = $scope.serviceRequest.forItem.serialNumber;        
        $scope.savefeedback.errorCodes = $scope.errorCodes;
        if($scope.serviceRequest.activeServiceRequestAudit.errorCode && !($.inArray($scope.serviceRequest.activeServiceRequestAudit.errorCode.code, $scope.errorCodes)<=-1))
            {
            $scope.errorCodes=$scope.serviceRequest.activeServiceRequestAudit.errorCode.code+"\n"+$scope.errorCodes;            
            }
        $scope.temp=new Array();
        $scope.temp=$scope.savefeedback.errorCodes.split(",");
        $scope.errorCodeFound=false;
        angular.forEach($scope.temp, function(errorcode){
            angular.forEach($scope.temp, function(errorcode){  
                if(!$scope.errorCodeFound){
                $util.httpGet('getErrorCodeByCode', {      
                    errorCode :  errorcode            
                }, function(data) {
                    if(data)
                        {
                        $scope.serviceRequest.activeServiceRequestAudit.errorCode=data.target;
                        $scope.errorCodeFound=true;
                        }
                });
                }
            });
        });
      
        
        $scope.$watch('selfDiagnosis.errorCode.code', function(newVal, oldVal) {
            if (angular.isNumber(newVal)) {
              $scope.disableSelection=true;
            }
            else
                {
                $scope.disableSelection=false;
                }
          
        }); 
        
        
      $scope.savefeedback.questionAnswer = $scope.QuestionAndAnswer;
        $scope.savefeedback.feedBack = "";
        if ($scope.selfDiagnosisfeedback)
            $scope.savefeedback.feedBack = $scope.selfDiagnosisfeedback;
        $http.post('saveFeedback/', JSON.stringify($scope.savefeedback)).success(function(data) {
           
        });        
      };
      $scope.disbleDiagnoseProcedure=function()
      {
          $scope.showQueAnsTwo=false;
          $scope.showQuesAnsOne=false;
          $scope.showQueAnsThree=false;
      };
      $scope.clearSelfDiagnoseData=function()
      {
          $scope.serviceRequest.activeServiceRequestAudit.errorCode=null;
          $scope.serviceRequest.activeServiceRequestAudit.problemDescription = "";    
          $scope.serviceRequest.activeServiceRequestAudit.errorCodes= "";      
          $scope.serviceRequest.activeServiceRequestAudit.faultLocations= ""; 
          
          $scope.problemDiscriptions="";
          $scope.errorCodes="";
          $scope.faultLocations="";          
          $scope.faultLocation="";
          
      }
      
      $scope.printCustomerPGS = function()
      {
      	 var thisTabLabel = getMyTabLabel();
           parent.publishEvent("/tab/open", {
          	 label: "Customer Program Guide Summary",
               url: "viewCustomerProgramGuideSummary",
               decendentOf : thisTabLabel,
               forceNewTab : true
           });  
      };
      
      $scope.printDealerPGS = function()
      {
      	 var thisTabLabel = getMyTabLabel();
      	 var customerId = $scope.serviceRequest.customerLocation.customer.id;
      	 var customerName = encodeURIComponent($scope.serviceRequest.customerLocation.customerName);
           parent.publishEvent("/tab/open", {
          	 label: "Dealer Program Guide Summary",
               url: "viewDealerProgramGuideSummary?customerId="+customerId+"&customerName="+customerName,
               decendentOf : thisTabLabel,
               forceNewTab : true
           });          	
      };
      
      $scope.dpgsEnabled = function()
      {
    	  var enabled = false;
    	  if($scope.serviceRequest.customerLocation)
    		  {
    			enabled = true;
    		  }
    	  return enabled;
      };
      
      $scope.printPGS = function()
      {
      	 var thisTabLabel = getMyTabLabel();
      	 var customerId = $scope.serviceRequest.customerLocation.customer.id;
      	 var customerName = encodeURIComponent($scope.serviceRequest.customerLocation.customerName);
      	 var dealerId;
      	 var dealerName;
      	 if($scope.serviceRequest.forDealer)
      		{
      			dealerId = $scope.serviceRequest.forDealer.id;
      			dealerName = encodeURIComponent($scope.serviceRequest.forDealer.name);
      		}
      	 else
      		{
      		 	dealerId = $scope.serviceRequest.forItem.preferredDealer.id;
      		 	dealerName = encodeURIComponent($scope.serviceRequest.forItem.preferredDealer.name);
      		}
           parent.publishEvent("/tab/open", {
          	 label: "Program Guide Summary",
               url: "viewProgramGuideSummary?dealerId="+dealerId+"&customerId="+customerId+"&dealerName="+dealerName+"&customerName="+customerName,
               decendentOf : thisTabLabel,
               forceNewTab : true
           });          	
      };
      
      $scope.enabled = function()
      {
    	  var enabled = false;
    	  if($scope.serviceRequest.customerLocation)
    		  {
    		  if($scope.serviceRequest.forDealer || $scope.serviceRequest.forItem.preferredDealer)
    			  {
    			  	enabled = true;
    			  }
    		  }
    	  return enabled;
      };
      
      $scope.fetchCallTypes = function() {
    	  $util.httpGet('findlovs', {
    		  isInternalUserOrOwningDealer : $scope.isInternalUserOrOwningDealer
    	  }, function(data) {
              $scope.callTypes = data;
              $scope.callTypeChange();
          });
      }
      
      $scope.populateServiceRequestInfo = function(data){
    	  $scope.serviceRequest = data.serviceRequest;
          $scope.ETASplit();
          if($scope.serviceRequest.customerLocation){
              $scope.selfDiagonosisEnabled = $scope.serviceRequest.customerLocation.selfDiagonosisEnabled;
              $scope.selfDiagnosisMandatory = $scope.serviceRequest.customerLocation.selfDiagnosisMandatory; 
          }
          
          $scope.audits = data.serviceRequestAudits;
          $scope.contractDuration = data.contractDuration;
          $scope.quotedetail = data.serviceRequest.quoteDetail;
          $scope.documentsReadOnly = data.serviceRequest.activeServiceRequestAudit.attachments;          
          $scope.isInternalUserOrOwningDealer = data.isInternalUserOrOwningDealer;
          $scope.isCustomerUser=data.isCustomerUser;
          $scope.servicingDealer=data.isServicingDealer;
          $scope.dealerThreshold = data.dealerThreshold;
          $scope.fetchCallTypes();
          $scope.hideGridValueBasedOnUserType(data.serviceRequestAudits,data);
          if (($scope.isCustomerUser || $scope.servicingDealer) && $scope.serviceRequest.activeServiceRequestAudit.callType) {
          	$scope.findCallTypeAssociated($scope.serviceRequest.activeServiceRequestAudit.callType.id);
          }
     }
      

          $scope.emergencyServiceRequest = function() {
        if ($scope.servicingDealer) {
            $scope.emergencySR = true;
        }
    }
          $scope.populateFailureMessage = function(data){
              $scope.showErrorMessage = (data.failureMessage) ? true : false;
          }
          $scope.resetDiffDealer= function()
          {
              if($scope.form.dealerName.$error.invalid || $scope.form.dealerNumber.$error.invalid )
              $scope.serviceRequest.forDealer=null;
          }
          
          $scope.equipmentHistoryPageDetailBySerialNumber = function() {
              var thisTabLabel = getMyTabLabel();
              parent.publishEvent("/tab/open", {
                  label :"Equiment History Details",
                  url : "equipmentDetailsPage.action?serialNumber=" + $scope.serviceRequest.activeServiceRequestAudit.serialNumber,
                  decendentOf : thisTabLabel,
                  forceNewTab : true
              });
          };
}

ServiceRequestController.$inject = [ '$scope', '$http', '$util', '$fileUploader', 'serviceRequestFactory' ];
serviceRequestApp.controller('ServiceRequestController', ServiceRequestController);

