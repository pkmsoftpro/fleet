var quoteApp = angular.module('createQuote', [ 'ui.bootstrap', 'textArea', 'autoCompleter', 'titlePane', 'repeater', 'loadingIndicator', 'alertMsg', '$util',
        'ngGrid', 'moneyType', 'subSection', 'uiTreeType', 'numbersOnly', 'angularFileUpload','popup','isNumber'])

quoteApp.factory('quoteFactory', ['$http', function($http) {
    var quoteService = {};

    quoteService.deleteDraftQuote = function($scope) {
        $http.post('deleteDraftQuote/', JSON.stringify($scope.quote)).success(function(data) {
            $scope.successForm = (data.successMessage) ? true : false;
            if ($scope.successForm) {
            	$scope.form.$dirty = false;
                $scope.quoteForm = false;
            }  else if(data.failureMessage) {
                $scope.populateFailureMessage(data);
            } else {
                $scope.quoteForm = true;
            }
        });
    };

    quoteService.saveQuote = function($scope) {
        $http.post('saveQuote/', JSON.stringify($scope.quote)).success(function(data) {
        	$scope.form.$dirty = false;
            $scope.quote = data.target;
            $scope.activeAudit = data.target.activeQuoteAudit;
            $scope.isEntryValidationCheck=false;
        });
    };

    return quoteService;
}]);

quoteApp
        .controller(
                'QuoteController', ['$scope', '$http', '$util', 'quoteFactory', '$modal', '$fileUploader','$timeout',
                function($scope, $http, $util, quoteFactory, $modal, $fileUploader,$timeout) {
                    $scope.labelTravelsHours = 'Please enter Hours in Decimals.';
                    $scope.attachedDocuments = new Array();
                    $scope.failedDocuments = [];
                    $scope.quoteForm = true;
                    $scope.selectedId = false;
                    $scope.validateForm = false;
                    $scope.summaryForm = false;
                    $scope.successForm = false;
                    $scope.searchQuote = false;
                    $scope.searchQuote = false;
                    $scope.isApproveTransfer = false;
                    $scope.isApprovedAlready = false;
                    $scope.isApprove = false;
                    $scope.isInternalUser = false;
                    $scope.isClaimCreated = false;
                    $scope.assets = [];
                    $scope.jobCodes = [];
                    $scope.isEntryValidationCheck=false;
                    $scope.isCustPaymentAdjustmentEnabled=false;
                    $scope.invalidAddress=false;
                    $scope.isInternalUserOrOwningDealer=false;
                	$scope.isCustomerUser=false;
                    $scope.servicingDealer=false;
                    $scope.isInternalOrDealerOwned=false;
                    $scope.map;
                    $scope.geocoder;
                    $scope.mapZoom;
                    $scope.equipment;
                    $scope.moduleId;
                    $scope.module="quote";
                    $scope.isClaimAssociated=false;
                    $scope.showErrorMessage=false;
                    compressData = function() {
                		var fsr = {};
                		var asra={};
                		var callType = {};
                		if ($scope.task && $scope.task.quote.serviceRequest) {
                			fsr['id'] = $scope.task.quote.serviceRequest.id;
                			asra['id'] = $scope.task.quote.serviceRequest.activeServiceRequestAudit.id;
                			asra['customerPoNumber'] = $scope.task.quote.serviceRequest.activeServiceRequestAudit.customerPoNumber;
               				callType['id'] = $scope.quote.serviceRequest.activeServiceRequestAudit.callType.id;
                			$scope.task.quote.serviceRequest = {};
                			$scope.task.quote.serviceRequest = fsr;
                			$scope.task.quote.serviceRequest.activeServiceRequestAudit={};
                			$scope.task.quote.serviceRequest.activeServiceRequestAudit=asra;
                			$scope.task.quote.serviceRequest.activeServiceRequestAudit.callType = callType;
                		}
                		if ($scope.quote.serviceRequest) {
                			fsr['id'] = $scope.quote.serviceRequest.id;
                			asra['id'] = $scope.quote.serviceRequest.activeServiceRequestAudit.id;
                			asra['customerPoNumber'] = $scope.quote.serviceRequest.activeServiceRequestAudit.customerPoNumber;
               				callType['id'] = $scope.quote.serviceRequest.activeServiceRequestAudit.callType.id;
                			$scope.quote.serviceRequest = {};
                			$scope.quote.serviceRequest = fsr;
                			$scope.quote.serviceRequest.activeServiceRequestAudit={};
                			$scope.quote.serviceRequest.activeServiceRequestAudit=asra;
               				$scope.quote.serviceRequest.activeServiceRequestAudit.callType = callType;
                		}
                	};

                    load = function() {
                        var taskId = document.getElementById('taskId').value;
                        
                        if (taskId) {
                            $util.httpGet('quoteDetail', {
                                taskId : taskId,
                                folderName:$scope.folderName
                            }, function(data) {
                            	if(data.originalResponse)
                            	{
                            	 data=data.originalResponse;
                            	}
                                $scope.task = data.taskView;
                                if (data.quote) {
                                    $scope.init(data);
                                    $scope.isClaimAssociated=data.isClaimAssociated!=null?data.isClaimAssociated:false;
                                    $scope.isCustPaymentAdjustmentEnabled = data.isCustPaymentAdjustmentEnabled;
                                    $scope.task.quote = data.quote;
                                    $scope.isFlatRate = data.quote.activeQuoteAudit.flatRate;
                                    $scope.applicableTravelMatrix = data.travelMatrix;
                                    $scope.serviceDealerAddress=getLocationAddress(data.serviceDealerAddress);                                    
                                    $scope.customerAddress=getLocationAddress(data.customerAddress);
                                    $scope.isApproveTransfer = data.isApproveTransfer;
                                    $scope.isApprovedAlready = data.isApprovedAlready;
                                    $scope.isApprove = data.isApprove;
                                    $scope.isInternalUser = data.isInternalUser;
                                    $scope.isClaimCreated = data.isClaimCreated;
                                    $scope.initializeUserType(data);
                                    $scope.fetchCallTypes();
                                    $scope.isInternalOrDealerOwned = data.isInternalUserOrOwningDealer;
                                    $scope.gridForQuoteAudits.columnDefs[4].visible = $scope.isInternalOrDealerOwned;
                                    $scope.customerPoNumber= data.quote.serviceRequest.activeServiceRequestAudit.customerPoNumber;
                                   /* if($scope.applicableTravelMatrix)
                                    {
                                    $scope.getapplicableTravelMatrix();
                                    }*/
                                    $scope.documentsReadOnly = data.quote.activeQuoteAudit.attachments;
                                    $scope.dealerThreshold = data.dealerThreshold;
                                    if (data.quote.serviceRequest.forItem.id) {
                                       // $scope.applicableCostCategories($scope.quote.serviceRequest.forItem.id);
                                        $scope.applicableCostCategoriesList = data.applicableCostCategories;
                                        
                                        prepareFaultFoundList(data.quote.serviceRequest.forItem.id);
                                        $scope.populateApplicableMiscLineItems($scope.quote.forDealer.id,$scope.quote.serviceRequest.customerLocation.customer.id,
                                                $scope.quote.serviceRequest.customerLocation.id);
                                    }
                                    if ($scope.activeAudit.serviceInformation.faultFound
                                            && $scope.activeAudit.serviceInformation.faultFound.id) {
                                        $scope.listCausedBy($scope.activeAudit.serviceInformation.faultFound.id,
                                                data.quote.serviceRequest.forItem.id);
                                    }
                                    if ($scope.quote.serviceRequest.customerLocation.poRegularExpression) {
                                        $scope.regExpPattern = new RegExp($scope.quote.serviceRequest.customerLocation.poRegularExpression);
                                    }
                                    if ($scope.activeAudit.quoteState != 'DRAFT') {
                                        $scope.activeAudit.notesForCustomer = "";
                                        $scope.activeAudit.notesForNMHG = "";
                                        $scope.activeAudit.notesForDealer = "";
                                        $scope.activeAudit.internalComments = "";
                                    }
                                    $scope.laborMultipliers = data.laborMultipliers;
                                    $scope.populateLaborDetails();
                                  };
                                  if(!$scope.isInternalUserOrOwningDealer && $scope.quote.serviceRequest.activeServiceRequestAudit.callType) {
                                  	$scope.findCallTypeAssociated($scope.quote.serviceRequest.activeServiceRequestAudit.callType.id);
                                  }
                            });
                        }
                        
                        if(document.getElementById('serviceRequestId')!=null && document.getElementById('serviceRequestId').value!="") {
                     	   var serviceRequestId=document.getElementById('serviceRequestId').value;
                     	   $util.httpGet('pageDetailsWithSR', {serviceRequestId:serviceRequestId}, function(data) {
                     		   $scope.quote.serviceRequest = data.serviceRequest;
                     		   $scope.populateServiceRequests(data.serviceRequest.forItem.id);
                     		   $scope.initializeUserType(data);
                     		   $scope.fetchCallTypes();
                     	   	});
                        }

                        var searchQuoteId = document.getElementById('searchQuoteId').value;
                        if (searchQuoteId) {
                            $util.httpGet('quoteSearchDetail', {
                                searchQuoteId : searchQuoteId
                            }, function(data) {
                                $scope.init(data);
                                $scope.searchQuote = true;
                                $scope.applicableTravelMatrix = data.travelMatrix;
                               /* if($scope.applicableTravelMatrix)
                                {
                                $scope.getapplicableTravelMatrix();
                                }*/
                                $scope.serviceDealerAddress=getLocationAddress(data.serviceDealerAddress);                                    
                                $scope.customerAddress=getLocationAddress(data.customerAddress);
                                $scope.applicableCostCategoriesList = data.applicableCostCategories;
                                prepareFaultFoundList(data.quote.serviceRequest.forItem.id);
                                if ($scope.activeAudit.serviceInformation.faultFound
                                        && $scope.activeAudit.serviceInformation.faultFound.id) {
                                    $scope.listCausedBy($scope.activeAudit.serviceInformation.faultFound.id,
                                            data.quote.serviceRequest.forItem.id);
                                }
                                $scope.populateApplicableMiscLineItems(data.quote.forDealer.id,data.quote.serviceRequest.customerLocation.customer.id,
                                        data.quote.serviceRequest.customerLocation.id);
                                $scope.laborMultipliers = data.laborMultipliers;
                                $scope.populateLaborDetails();
                                $scope.processQuote=data.isUserActor;
                                $scope.dealerThreshold = data.dealerThreshold;
                                $scope.documentsReadOnly = $scope.activeAudit.attachments;
                                $scope.isInternalOrDealerOwned = data.isInternalUserOrOwningDealer;
                                $scope.gridForQuoteAudits.columnDefs[4].visible = $scope.isInternalOrDealerOwned;
                                $scope.initializeUserType(data);
                                $scope.fetchCallTypes();
                                if(!$scope.isInternalUserOrOwningDealer && $scope.quote.serviceRequest.activeServiceRequestAudit.callType) {
                                  	$scope.findCallTypeAssociated($scope.quote.serviceRequest.activeServiceRequestAudit.callType.id);
                                 }
                            });
                        }
                        var selectedAuditId = document.getElementById('selectedAuditId').value;
                        if (selectedAuditId) {
                            $scope.selectedId = true;
                            $util.httpGet('quoteAuditDetail', {
                                id : selectedAuditId
                            }, function(data) {
                            	if(data.originalResponse)
                            	{
                            	    data=data.originalResponse;
                            	}
                                $scope.initAudit(data);
                                prepareFaultFoundList(data.quote.serviceRequest.forItem.id);
                                if ($scope.activeAudit.serviceInformation.faultFound
                                        && $scope.activeAudit.serviceInformation.faultFound.id) {
                                    $scope.listCausedBy($scope.activeAudit.serviceInformation.faultFound.id,
                                            data.quote.serviceRequest.forItem.id);
                                }
                                $scope.applicableTravelMatrix = data.travelMatrix;
                               /* if($scope.applicableTravelMatrix)
                                {
                                $scope.getapplicableTravelMatrix();
                                }*/
                                $scope.serviceDealerAddress=getLocationAddress(data.serviceDealerAddress);                                    
                                $scope.customerAddress=getLocationAddress(data.customerAddress);
                                $scope.applicableCostCategoriesList = data.applicableCostCategories;
                              /*  $scope.populateApplicableMiscLineItems(data.quote.forDealer.id,data.quote.serviceRequest.customerLocation.customer.id,
                                        data.quote.serviceRequest.customerLocation.id);*/
                                $scope.dealerThreshold = data.dealerThreshold;
                                $scope.laborMultipliers = data.laborMultipliers;
                                $scope.populateLaborDetails();
                                $scope.documentsReadOnly = $scope.activeAudit.attachments;
                                $scope.initializeUserType(data);
                                $scope.fetchCallTypes();
                                if(!$scope.isInternalUserOrOwningDealer && $scope.quote.serviceRequest.activeServiceRequestAudit.callType) {
                                    $scope.findCallTypeAssociated($scope.quote.serviceRequest.activeServiceRequestAudit.callType.id);
                                }
                            });
                        }
 
                    };
                    load();

                    $scope.isReadOnly = function() {
                        return (document.getElementById('readOnly').value === "true") ? true : false;
                    };

                    $util.httpGet('numberOfTripsList', {}, function(data) {
                        $scope.noOfTrips = data;

                    });
                    
                 
                    $util.httpGet("findAllLovsForQuote",{},function(data){
                		  $scope.docTypes = data.documentTypes;
                		  $scope.componentCodes = data.componentCodes;
                		  $scope.fleetRecommendations = data.fleetRecommendations;
                	  });
              	 
                  
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
                    
                    $scope.init = function(data) {
                        $scope.quote = data.quote;
                        $scope.activeAudit= data.quote.activeQuoteAudit;
                        
                        $scope.preferredCurrency=data.quote.serviceRequest.forItem.preferredCurrency;
                        $scope.moduleId=$scope.quote.id;
                        $scope.equipment=data.quote.serviceRequest.forItem;
                        $scope.audits = data.quoteAudits;
                        $scope.hideGridValueBasedOnUserType(data.quoteAudits,data);
                        $scope.isFlatRate = data.quote.activeQuoteAudit.flatRate;
                        if (data.isUserCustomer) {
                            $scope.audits.splice(0, ($scope.audits.length - 1));
                        }
                    }
                    
                    $scope.initializeUserType = function(data) {
                    	if(data.isInternalUserOrOwningDealer) {
                    	   $scope.isInternalUserOrOwningDealer = data.isInternalUserOrOwningDealer;
                    	}
                        if(data.isCustomerUser) {
                           $scope.isCustomerUser=data.isCustomerUser;                            
                    	}
                        if(data.isServicingDealer) {
                           $scope.servicingDealer=data.isServicingDealer;
                    	}
                           $scope.loggedInUserType=data.loggedInUserType;
                    }
                    
                    $scope.initAudit = function(data) {
                        $scope.quote = data.quote;
                        $scope.preferredCurrency=data.quote.serviceRequest.forItem.preferredCurrency;
                        $scope.moduleId=$scope.quote.id;
                        $scope.equipment=data.quote.serviceRequest.forItem;
                        $scope.audits = data.quoteAudits;
                        $scope.hideGridValueBasedOnUserType(data.quoteAudits,data);
                        $scope.isFlatRate = data.quoteAudit.flatRate;
                        $scope.activeAudit= data.quoteAudit;
                        $scope.documentsReadOnly = data.quoteAudit.attachments;
                        $scope.initializeUserType(data);
                        if (data.isUserCustomer) {
                            $scope.audits.splice(0, ($scope.audits.length - 1));
                        }
                    }

                    $scope.save = function(form) {
                    	compressData();
                    	appendAudit();
                        quoteFactory.saveQuote($scope);
                    };

                    
                    $scope.toggleFlatRate = function() {
                        $scope.isFlatRate = $scope.isFlatRate === false ? true: false;
                    };
                    
                    $scope.submit = function() {
                    	compressData();
                    	appendAudit();
                        $http.post('submitQuote/', JSON.stringify($scope.quote)).success(function(data) {
                        	$scope.form.$dirty = false;
                            $scope.successForm = (data.successMessage) ? true : false;
                            if ($scope.successForm) {
                                $scope.validateForm = false;
                            } else if(data.failureMessage) {
                                $scope.populateFailureMessage(data);                                
                            } else {
                                $scope.validateForm = true;
                            }
                        });
                    };

                     $scope.validateQuote = function(takenTransition) {
                                compressData();
                                appendAudit();
                                if (takenTransition) {
                                    $scope.task.takenTransition = takenTransition;
                                    $scope.quote.takenTransition = takenTransition;
                                }
                                if($scope.task && $scope.task.takenTransition){
                              	  $scope.quote.takenTransition = $scope.task.takenTransition;
                                }                                
                                $scope.activeAudit.flatRate= $scope.isFlatRate;
                                $http.post('validateQuote/', JSON.stringify($scope.quote)).success(function(data) {
                                    if (data.originalResponse) {
                                        data = data.originalResponse;
                                    }
                                    if(data.failureMessage) {
                                        $scope.populateFailureMessage(data);                                
                                    } else {
                                    if(data.isApproveTransfer){
                                    	$scope.isApproveTransfer = data.isApproveTransfer;
                                    	$scope.isApprove = data.isApprove;
                                    	$scope.isApprovedAlready = data.isApprovedAlready;
                                    }
                                    if($scope.task && $scope.task.quote){
                                    	$scope.task.quote = data.target;
                                    }
                                    $scope.quote = data.target;
                                    $scope.activeAudit=$scope.quote.activeQuoteAudit;
                                    $scope.form.$dirty = false;
                                    $scope.isEntryValidationCheck = true;
                                    $scope.validateForm = true;
                                    $scope.quoteForm = false;
                                    $scope.isApproveTransfer = $scope.quote.approveAndTransfer;
                                    $scope.isApprove = $scope.quote.approve;
                                    $scope.validation = (data.errors.length > 0) ? false : true;
                                    if ($scope.validation) {
                                        $scope.activeQuoteAudit = data.target.activeQuoteAudit;
                                        $scope.activeAudit = data.target.activeQuoteAudit;
                                        $scope.isFlatRate = $scope.quote.activeQuoteAudit.flatRate;
                                    }
                                   } 
                                });
                     };

                    $scope.quoteSummary = function() {
                        $scope.quoteForm = false;
                        $scope.summaryForm = true;
                    };

                    $scope.closeSummary = function() {
                        $scope.quoteForm = true;
                        $scope.summaryForm = false;
                    };
                    
                    $scope.revertQuote = function(takenTransition) {
                        $scope.quoteForm = false;
                        $scope.processQuote(takenTransition);
                        $scope.validateForm = false;
                    }

                    $scope.edit = function() {
                        $scope.validateForm = false;
                        $scope.quoteForm = true;
                    };

                    $scope.cancel = function() {
                        closeTab(getTabHavingLabel(getMyTabLabel()));
                    };

                    $scope.processQuote = function(takenTransition) {
                    	compressData();
                    	appendAudit();
                        if (takenTransition) {
                            $scope.task.takenTransition = takenTransition;
                        }
                        /*if ($scope.task.transferTo && $scope.task.takenTransition == 'Transfer') {
                            $scope.task.transferTo = $scope.task.transferTo;
                        }*/
                        $http.post('processQuote/', JSON.stringify($scope.task)).success(function(data) {
                        	if(data.originalResponse)
                        		{
                        		data=data.originalResponse;
                        		}
                            $scope.successForm = (data.successMessage) ? true : false;
                            if ($scope.successForm) {
                                $scope.validateForm = false;
                            } else if(data.failureMessage) {
                                $scope.populateFailureMessage(data);                                
                            } else {
                                $scope.validateForm = true;
                            }
                        });
                    };

                    $scope.reopenQuote = function(takenTransition) {
                        if (takenTransition) {
                        	appendAudit();
                            $scope.task.takenTransition = takenTransition;
                            $http.post('reopenQuote/', JSON.stringify($scope.task)).success(function(data) {
                                window.location = 'quote_detail?folderName=Quotes Received&id=' + data;
                            });
                        }
                    };

                    $scope.$watch('quote.serviceRequest.activeServiceRequestAudit.callType.id', function(newVal, oldVal) {
                    	
                    	if(newVal)
                    		{
                    		 $scope.executeCallTypeFunction(newVal);
                    		}
                    });
                    
                    $scope.executeCallTypeFunction=function(newVal){
                        
                        angular.forEach($scope.callTypes, function(callType){
                            if (newVal == callType.listOfValues.id) {
                                $scope.getapplicableTravelMatrix(callType.isPlanned);
                            }
                        });
              		  if ($scope.isInternalUser && newVal && $scope.callTypes) {
              			  var isInternal = false;
              			  angular.forEach($scope.callTypes, function(callType){
              				 if (newVal == callType.listOfValues.id && callType.isInternal == true) {
              					 isInternal = true;
              				 }
              			 });
              			 if (!isInternal && $scope.form.callType && !$scope.isReadOnly()) {
              				 $scope.form.callType.$setValidity('notinternal', false);
              			 } else if ($scope.form.callType) {              			 
              				 $scope.form.callType.$setValidity('notinternal', true);
              			 }
              			 
              		  } 
                    };
                    
                    $scope.associatedCallType = {};
                    $scope.findCallTypeAssociated = function(selectedCallType) {
                    	var isInternalOrOwningDealer = $scope.isUserAdmin ==='true' ? true : false ;
                    	if(selectedCallType) {
                    		$util.httpGet('findAssociatedCallType',{id : selectedCallType, isInternalOrOwningDealer : isInternalOrOwningDealer},function(data){
                    			if ($scope.quote.id) { // Except creation of quote all the time calltype should be readonly.
                    				$scope.associatedCallType = data;
                    			} else { // Quote creation time we are setting associated external calltype for internal call type. This case exists only when internal user changes calltype in SR  
                    				$scope.quote.serviceRequest.activeServiceRequestAudit.callType=data;
                    			}
                    		});
                    		
                    		
                    	}
                    }
                    $scope.hideGridValueBasedOnUserType = function(audits,data) {
                    	angular.forEach(audits, function(audit){
                    		if(data.isServicingDealer) {
                    			if(audit.userType== 'INTERNAL') {
                    				audit.customer="";
                    				audit.NMHG="";
                    				}
                    			if(audit.userType== 'CUSTOMER') {
                    				audit.NMHG="";
                    				}
                    		}
            			 });
                    angular.forEach(audits, function(audit){
                    if(data.isCustomerUser ){
                    	if(audit.userType== 'INTERNAL') {
                    		audit.dealer="";
                    		audit.NMHG="";
                    	 }
                    	if(audit.userType== 'DEALER USER') {
                    		audit.NMHG="";
                    		audit.dealer="";
                    	 }
                     }
                    });
                    }
                    
                    $scope.gridForQuoteAudits = {
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
                            width : '10%'
                        }, {
                            field : 'login',
                            displayName : i18N.user,
                            width : '10%'
                        }, {
                            field : 'userType',
                            displayName : i18N.userType,
                            width : '10%'
                        }, {
                            field : 'internalComments',
                            displayName : i18N.internalComments
                        }, {
                            field : 'NMHG',
                            displayName : i18N.notesForNMHG,
                            width : '15%'
                        }, {
                            field : 'dealer',
                            displayName : i18N.notesForDealer,
                            width : '15%'
                        }, {
                            field : 'customer',
                            displayName : i18N.notesForCustomer,
                            width : '15%'
                        } ],
                        plugins : [ new ngGridFlexibleHeightPlugin() ]
                    };

                    //$scope.gridForQuoteAudits.columnDefs[4].visible = (document.getElementById('isUserAdmin').value === "true") ? true : false;
                    $scope.$watch('userType', function(newVal, oldVal) {
                        if(newVal)
                            {            
                        	$scope.gridForQuoteAudits.columnDefs[4].visible = $scope.userType =="INTERNAL" ? true: false;
                            }
                    });

                    $scope.quoteAudit = function(items) {
                        var id = items[0].id;
                        var url = "getQuoteAudit.action?id=" + id;
                        var thisTabLabel = getMyTabLabel();
                        parent.publishEvent("/tab/open", {
                            label : "Quote History",
                            url : url,
                            decendentOf : thisTabLabel,
                            forceNewTab : true
                        });
                    };

                    $scope.$watch('quote.serviceRequest.forItem.serialNumber', function(newVal, oldVal) {
                    	if(angular.uppercase($scope.quote.quoteNumber) == 'DRAFT'){
                    		$scope.populateServiceRequests(newVal);
                    	}
                    });
                    if(document.getElementById('serialNumberForQuotes')!=null)
                    	{
                    var  inventoryItemId= document.getElementById('serialNumberForQuotes').value;
                    if(inventoryItemId)
                    	{
                    	 $util.httpGet('getFleetInventoryItem', {
                                id : inventoryItemId
                            }, function(data) {                            
                                $scope.forItem=data.forItem;
                                $scope.populateServiceRequests($scope.forItem.id);
                            });
                    	}
                    	}

                    $scope.$watch('quote.serviceRequest.id', function(newVal, oldVal) {
                        if ($scope.quote.id == null) {
                        	if($scope.activeAudit!=undefined && $scope.activeAudit.serviceInformation.serviceDetail!=undefined && $scope.activeAudit.serviceInformation.serviceDetail!=null)
                        		{
                        		    $scope.activeAudit.serviceInformation={};
                        		    $scope.activeAudit.serviceInformation.serviceDetail={};
                        		    $scope.activeAudit.serviceInformation.serviceDetail.laborDetails=[];
                        		    $scope.activeAudit.serviceInformation.serviceDetail.oemPartsReplaced=[];
                        			$scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails=[];
                        			$scope.activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled=[];	
                        			$scope.activeAudit.serviceInformation.serviceDetail.oemPartsInstalled=[];
                        			$scope.activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail=[];
                        			$scope.activeAudit.serviceInformation.serviceDetail.travelDetails={};
                        			$scope.quote.filedOnDate=$scope.filedOnDate;
                        	
                        		}
                            $util.httpGetWithId('selectedServiceRequestDetails', {
                                serviceRequestId : newVal
                            }, newVal, function(data) {
                            	if(data.originalResponse)
                            	{
                            	 data=data.originalResponse;
                            	 
                            	  }
                            	 $scope.serviceDealerAddress=getLocationAddress(data.serviceDealerAddress);
                                 $scope.customerAddress=getLocationAddress(data.customerAddress);
                                $scope.quote.serviceRequest = data.serviceRequest;
                             $scope.activeAudit.problemReported=data.serviceRequest.activeServiceRequestAudit.problemDescription;
                             $scope.customerPoNumber= data.serviceRequest.activeServiceRequestAudit.customerPoNumber;
                              /* // $scope.ownedBy=data.ownedBy;                                
                                $scope.internalUser=false;
                                if($scope.quote.id==undefined||$scope.quote.id==null)
                                    {            
                                    $scope.internalUser=(data.ownedBy===parseInt($scope.loggedInUserOrgId) )|| $scope.isInternalUser;
                                    }*/                               
                                $scope.preferredCurrency=data.serviceRequest.forItem.preferredCurrency;
                                $scope.equipment= data.serviceRequest.forItem;
                                $scope.applicableTravelMatrix = data.travelMatrix;
                                $scope.applicableCostCategoriesList = data.applicableCostCategories;
                                $scope.initializeUserType(data);
                                $scope.fetchCallTypes();
                                $scope.regExpPattern = new RegExp($scope.quote.serviceRequest.customerLocation.poRegularExpression);
                                $scope.dealerThreshold = data.dealerThreshold;
                                prepareFaultFoundList(data.serviceRequest.forItem.id);                              
                                $scope.populateApplicableMiscLineItems($scope.quote.forDealer.id,data.serviceRequest.customerLocation.customer.id,
                                		data.serviceRequest.customerLocation.id);
                                $scope.laborMultipliers = data.laborMultipliers;
                                $scope.populateLaborDetails();
                                if(!$scope.isInternalUserOrOwningDealer && $scope.quote.serviceRequest.activeServiceRequestAudit.callType) {
                                	$scope.findCallTypeAssociated($scope.quote.serviceRequest.activeServiceRequestAudit.callType.id);
                                }
                                if(data.serviceRequest.forServiceCall!=null && data.serviceRequest.forServiceCall.associatedServiceCode!=null && data.serviceRequest.forServiceCall.associatedServiceCode.serviceCode!=null)
                        		{
                        		$scope.addInputRow('activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails','serviceCodeDefinition.code','serviceCodeDefinition.description','standardHours','dummyColumn','additionalLaborHours','reasonForAdditionalHours');
                        		var standardCodeIndex=$scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails.length-1;
                        		 $scope.setServiceCodeDefinition(data.serviceRequest.forServiceCall.associatedServiceCode.serviceCode,standardCodeIndex);
                        		}
                            });
                           
                        }
                    });

                           $scope.getapplicableTravelMatrix = function(planned) {
                               
                               var callType=planned?"PLANNED":"UNPLANNED";
                                if ($scope.applicableTravelMatrix) {
                                    $util
                                            .httpGet(
                                                    'travelMatrixValue',
                                                    {
                                                    },
                                                    function(data) {
                                                        if ($scope.activeAudit.serviceInformation.serviceDetail.travelDetails === null)
                                                        	$scope.activeAudit.serviceInformation.serviceDetail.travelDetails = new Object();
                                                        
                                                        angular.forEach($scope.applicableTravelMatrix, function(travelMatrix) {
                                                         if(travelMatrix.trip==callType)
                                                             {
                                                        	 $scope.activeAudit.serviceInformation.serviceDetail.travelDetails.travelHours=(travelMatrix.milesPerTrip*data).toFixed(2);
                                                        	 $scope.activeAudit.serviceInformation.serviceDetail.travelDetails.milesPerTrip=travelMatrix.milesPerTrip;
                                                             }
                                                      
                                                        });  

                                                    });
                                }
                            };


                            $scope.populateApplicableMiscLineItems = function(dealerId, customerId, customerLocationId) {
                                var quoteSubmittedDate;
                                if($scope.quote!=null && $scope.quote.filedOnDate != null && $scope.quote.filedOnDate!="")
                                	{
                                	quoteSubmittedDate=$scope.quote.filedOnDate;
                                	}
                                else
                                	{
                                	var today= new Date();
                                	quoteSubmittedDate=today.getMonth()+1+"/"+today.getDate()+"/"+today.getFullYear();
                                	}

                                $util.httpGet('applicableMiscLineItems', {
                                    dealerId : dealerId,
                                    customerId : customerId,
                                    customerLocationId : customerLocationId,
                                    duration : quoteSubmittedDate
                                }, function(data) {
                                    $scope.applicableMiscLineItems = data;
                                    if ($scope.activeAudit.serviceInformation.serviceDetail.miscLineItems == undefined) {
                                        $scope.activeAudit.serviceInformation.serviceDetail.miscLineItems = [];
                                    }
                                    $scope.newMiscLineItems = [];
                                    $scope.oldMiscLineItems = [];
                                    $scope.miscLineItems = [];
                                    angular.forEach($scope.activeAudit.serviceInformation.serviceDetail.miscLineItems, function(miscLineItem) {
                                        $scope.miscLineItems.push(miscLineItem.miscSubCostCodes.id);
                                    });

                                    for (i = 0; i < $scope.applicableMiscLineItems.length; i++) {
                                        JsonObj = [];
                                        var item = {};
                                        item['miscSubCostCodes'] = $scope.applicableMiscLineItems[i];
                                        item['miscDescription'] = $scope.applicableMiscLineItems[i].description;
                                        item['miscDescriptionForDisplay'] = $scope.applicableMiscLineItems[i].description;
                                        JsonObj.push(item);
                                        if ($.inArray(item.miscSubCostCodes.id, $scope.miscLineItems) < 0) {
                                            $scope.newMiscLineItems.push(item);
                                        }
                                        else if ($.inArray(item.miscSubCostCodes.id, $scope.miscLineItems) >= 0) {
                                            $scope.oldMiscLineItems.push(item.miscSubCostCodes.id);
                                        }
                                    }

                                   // for (i = 0; i < $scope.oldMiscLineItems.length; i++) {
                                        angular.forEach($scope.activeAudit.serviceInformation.serviceDetail.miscLineItems, function(miscLineItem) {
                                            //if ($scope.oldMiscLineItems[i] == miscLineItem.miscSubCostCodes.id) {
                                                $scope.newMiscLineItems.push(miscLineItem);
                                           // }
                                        });
                                  //  }
                                    
                                    $scope.activeAudit.serviceInformation.serviceDetail.miscLineItems=[];
                                    angular.forEach($scope.newMiscLineItems, function(miscLineItem) {
                                    $scope.activeAudit.serviceInformation.serviceDetail.miscLineItems.push(miscLineItem);
                                    });

                                });
                            };
                    
                    $scope.populateServiceRequests = function(newVal) {
                    	
                    	$util.httpGetWithId('listServiceRequestsForInventoryItem', {
                    		inventoryId : newVal
                    	}, newVal, function(data) {
                    		$scope.serviceRequests = data.items;
                    		
                    		if($scope.forItem!="")
                            {
                    		    $scope.quote.serviceRequest=new Object();
                    		    $scope.quote.serviceRequest.forItem=$scope.forItem;
                            }
                    	
                    	});
               		  
                    };
                    
                    $scope.populateLaborDetails = function() {
                        if($scope.activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail.length == 0){
                            angular.forEach($scope.laborMultipliers, function(laborMultiplier) {
                             var item={};
                                  item['overTimeLaborMultiplier']=laborMultiplier.laborMultiplier;
                                  item['overTimeLaborHours']='';
                                  item['reasonForOverTimeLaborHours']='';
                                  item['overTimeMultiplierValue']=laborMultiplier.overTimeMultiplierValue;
                                  $scope.activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail.push(item);
                                      });
                               }
                    }

                    prepareFaultFoundList = function(invItemId) {
                        $util.httpGet('fault_found_list', {
                      	  invItemId:invItemId
                        }, function(data) {
                            $scope.faultFoundList = data.items;
                        });
                    };

                    $scope.listCausedBy = function(faultFoundId, inventoryItemId) {
                        $util.httpGet('find_caused_by_list', {
                            faultFound : faultFoundId,
                            invItemId : inventoryItemId
                        }, function(data) {
                            $scope.causedByList = data.items;
                        });
                    };

                    $scope.deleteDraftQuote = function(form) {
                    	compressData();
                    	appendAudit();
                        quoteFactory.deleteDraftQuote($scope);
                    };
                    
                   


                

                    $scope.closeAlert = function(index) {
                        $scope.alerts.splice(index, 1);
                    };

                    $scope.$watch('dealerId', function(newVal, oldVal) {
                        if (newVal) {
                            $util.httpGet('populateDealerDetails', {
                                id : $scope.dealerId
                            }, function(data) {
                                $scope.quote.forDealer = data;
                            });
                        }
                    });

                    $scope.itemDescription = function(index, value) {
                        if (!value) {
                            $scope.activeAudit.serviceInformation.serviceDetail.oemPartsReplaced[index].replacedBrandItem = null;
                        } else if (+value && value.toString().length > 2) {
                            $util
                                    .httpGet(
                                            'itemDescription',
                                            {
                                                id : value
                                            },
                                            function(data) {
                                                if (data) {
                                                    $scope.activeAudit.serviceInformation.serviceDetail.oemPartsReplaced[index].replacedBrandItem = data;
                                                    $scope.activeAudit.serviceInformation.serviceDetail.oemPartsReplaced[index].replacedBrandItem.item = data.item;
                                                    $scope.activeAudit.serviceInformation.serviceDetail.oemPartsReplaced[index].replacedBrandItem.item.description = data.item.description;
                                                    $scope.activeAudit.serviceInformation.serviceDetail.oemPartsReplaced[index].replacedBrandItem.itemNumber = data.itemNumber;
                                                    $scope.activeAudit.serviceInformation.serviceDetail.oemPartsReplaced[index].replacedBrandItem.id = data.id;
                                                }
                                            });
                        }
                    };

                    $scope.installedItemDescription = function(index, value) {
                        if (!value) {
                            $scope.activeAudit.serviceInformation.serviceDetail.oemPartsInstalled[index].installedBrandItem = null;
                        } else if (+value && value.toString().length > 2) {
                            $util
                                    .httpGet(
                                            'itemDescription',
                                            {
                                                id : value
                                            },
                                            function(data) {
                                                if (data) {
                                                    $scope.activeAudit.serviceInformation.serviceDetail.oemPartsInstalled[index].installedBrandItem = data;
                                                    $scope.activeAudit.serviceInformation.serviceDetail.oemPartsInstalled[index].installedBrandItem.item = data.item;
                                                    $scope.activeAudit.serviceInformation.serviceDetail.oemPartsInstalled[index].installedBrandItem.item.description = data.item.description;
                                                    $scope.activeAudit.serviceInformation.serviceDetail.oemPartsInstalled[index].installedBrandItem.itemNumber = data.itemNumber;
                                                    $scope.activeAudit.serviceInformation.serviceDetail.oemPartsInstalled[index].installedBrandItem.id = data.id;
                                                }
                                            });
                        }
                    };

                    $scope.causalPartDescription = function(value) {
                        if (value.toString().length == 0) {
                            $scope.activeAudit.serviceInformation.causalPart = null;
                        } else if (+value && value.toString().length > 2) {
                            $scope.selectedFaultCode = null;
                            $util.httpGet('itemDescription', {
                                id : value
                            }, function(data) {
                                if (data) {
                                    $scope.activeAudit.serviceInformation.causalPart = data;
                                    $scope.activeAudit.serviceInformation.causalPart.item = data.item;
                                    $scope.activeAudit.serviceInformation.causalPart.item.description = data.item.description;
                                    $scope.activeAudit.serviceInformation.causalPart.itemNumber = data.itemNumber;
                                    $scope.activeAudit.serviceInformation.causalPart.id = data.id;
                                }
                            });
                        }
                    };

                    $scope.calculateExtendedPrice = function(index, numberOfUnits, pricePerUnit) {
                        if ($scope.quote) {
                            $scope.activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled[index].extendedPricePerUnit.amount = pricePerUnit
                                    * numberOfUnits;
                        }
                    };

                    $scope.listFaultCodes = function(invItemId, causalPart) {
                        $scope.showFaultLocationTree = true;
                        if (invItemId != undefined) {
                                $scope.showFaultCodeTree = true;
                                if ($scope.assets.length == 0) {
                                    $util.httpGet('find_fault_code_tree', {
                                        invItemId : invItemId,
                                        assemblyId : ""
                                    }, function(data) {
                                        if (data.asmChildren) {
                                            $scope.assets = data.asmChildren;
                                        } else {
                                            $scope.assets = data;
                                        }
                                    });
                                }                            
                        } else {
                            $scope.selectSerialNumber = true;
                            $scope.showFaultCodeTree = false;
                        }
                    };

                    $scope.listJobCodes = function(invItemId, causalPart) {
                        $scope.showLaborTree = true;
                        if (invItemId != undefined) {
                                $scope.showJobCodeTree = true;
                                if ($scope.jobCodes.length == 0) {
                                    $util.httpGet('find_serviceProcedure_tree', {
                                        invItemId : invItemId,
                                        assemblyId : ""
                                    }, function(data) {
                                        if (data.asmChildren) {
                                            $scope.jobCodes = data.asmChildren;
                                        } else {
                                            $scope.jobCodes = data;
                                        }
                                    });
                                }                           
                        } else {
                            $scope.selectSerialNumber1 = true;
                            $scope.showJobCodeTree = false;
                        }
                    };

                    $scope.hierarchy = "1,11";
                    $scope.loadJobCodes = function(nodeId, callback) {
                        var invItemId = $scope.quote.serviceRequest.forItem.id;
                        var quoteId = "";
                        if ($scope.quote.id) {
                            quoteId = $scope.quote.id;
                        }
                        $util.httpGet('find_serviceProcedure_tree', {
                            invItemId : invItemId,
                            assemblyId : nodeId,
                            quoteId : quoteId
                        }, function(data) {
                            callback(data);
                        });
                    }

                    $scope.addtoJobCodes = function() {
                        for ( var i = 0; i < $scope.selected.length; i++) {
                            $scope.addInputRow('activeAudit.serviceInformation.serviceDetail.laborDetails', 'serviceProcedure.definition.code',
                                    'hoursSpent', 'serviceProcedure.definition', 'additionalLaborHours', 'costPerHour', 'reasonForAdditionalHours');
                            var index = $scope.activeAudit.serviceInformation.serviceDetail.laborDetails.length - 1;
                            $scope.asset = angular.fromJson($scope.selected[i].toString());
                            $scope.activeAudit.serviceInformation.serviceDetail.laborDetails[index].serviceProcedure = {};
                            $scope.activeAudit.serviceInformation.serviceDetail.laborDetails[index].serviceProcedure.id = $scope.asset.serviceProcedureId;
                            $scope.activeAudit.serviceInformation.serviceDetail.laborDetails[index].completeCode = $scope.asset.completeCode;
                            $scope.activeAudit.serviceInformation.serviceDetail.laborDetails[index].completeName = $scope.asset.completeName;
                            $scope.activeAudit.serviceInformation.serviceDetail.laborDetails[index].hoursSpent = $scope.asset.suggestedLabourHours;
                            $scope.activeAudit.serviceInformation.serviceDetail.laborDetails[index].serviceProcedure.definedFor = {};
                            $scope.activeAudit.serviceInformation.serviceDetail.laborDetails[index].serviceProcedure.definedFor.id = $scope.asset.id;
                            $scope.activeAudit.serviceInformation.serviceDetail.laborDetails[index].serviceProcedure.definedFor.definition = {};
                            $scope.activeAudit.serviceInformation.serviceDetail.laborDetails[index].serviceProcedure.definedFor.definition.id = $scope.asset.definition.id;
                            $scope.activeAudit.serviceInformation.serviceDetail.laborDetails[index].serviceProcedure.definedFor.definition.code = $scope.asset.definition.code;
                        }
                        $scope.showLaborTree = false;
                        $scope.selectCausalPart1 = false;
                        $scope.showJobCodeTree = false;
                        $scope.selectSerialNumber1 = false;
                        $scope.selected = null;
                    };

                    $scope.addtoFaultCodes = function() {
                        if ($scope.selected && $scope.selected.faultCode) {
                            $scope.activeAudit.serviceInformation.faultCode = $scope.selected.completeCode;
                            $scope.activeAudit.serviceInformation.faultCodeRef = $scope.selected.faultCode;
                            $scope.selected=null;
                        }
                        $scope.showFaultLocationTree = false;
                        $scope.selectCausalPart = false;
                        $scope.showFaultCodeTree = false;
                        $scope.selectSerialNumber = false;
                    };

                    $scope.loadChildren = function(nodeId, callback) {
                        var invItemId = $scope.quote.serviceRequest.forItem.id;
                        $util.httpGet('find_fault_code_tree', {
                            invItemId : invItemId,
                            assemblyId : nodeId
                        }, function(data) {
                            callback(data);
                        });
                    }

                    $scope.$on("nodeSelected", function(event, node) {
                        $scope.selected = node;
                        $scope.$broadcast("selectNode", node);
                    });

                    $scope.closePopup = function() {
                        $scope.showFaultLocationTree = false;
                        $scope.selectCausalPart = false;
                        $scope.showFaultCodeTree = false;
                        $scope.selectSerialNumber = false;
                        $scope.showLaborTree = false;
                        $scope.selectCausalPart1 = false;
                        $scope.showJobCodeTree = false;
                        $scope.selectSerialNumber1 = false;
                        $scope.openEmailWindow = false;
                        $scope.SuccessMessage = "";
                        $scope.customers = [];
                        $scope.displayGoogleMap=false;
                    };

                    $scope.close = function() {
                        $scope.openUploadDocWindow = false;
                        $scope.failedDocuments = [];
                    };

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
                            $scope.uploadCallback.onComplete(doc);
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
                        $scope.uploadCallback = {
                            onComplete : function(doc) {
                                $scope.activeAudit.attachments.push(doc);
                            }
                        }
                        $scope.singleFileUpload = false;
                        uploader.autoUpload = false;
                        $scope.openUploadDocWindow = true;
                    }

                    $scope.deleteDocument = function(index) {
                        $scope.activeAudit.attachments.splice(index, 1);
                    }

                    $scope.uploadInvoice = function(item) {
                        $scope.uploadCallback = {
                            onComplete : function(doc) {
                                $scope.nonOemPart.invoice = doc;
                            }
                        }
                        $scope.singleFileUpload = true;
                        uploader.autoUpload = true;
                        $scope.nonOemPart = item;
                        $scope.openUploadDocWindow = true;
                    }

                    $scope.validatePONumber = function(newVal, customerLocationId, PORegExp,isPONumDuplicateAllowed) {
                    	if(newVal!=null && customerLocationId!=null && $scope.customerPoNumber != newVal) {
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
                            if ($scope.PONumberExits) {
                                $scope.PONumberExits = true;
                            }
                            var matRegExp = data.matchRegExp;
                            $scope.PORegExpValidate(matRegExp, newVal);
                        })
                       }
                    };
                    $scope.PORegExpValidate = function(matRegExp, newVal) {
                        $scope.PONumberDuplicate = false;
                        if (matRegExp) {
                            $scope.PONumberDuplicate = false;
                        } else if (newVal.length <= 0) {
                            $scope.PONumberDuplicate = false;
                        } else {
                            $scope.PONumberDuplicate = true;
                        }

                    };

                    $scope.emailAttach = function() {
                        $scope.subscribedEmailUser = [];
                        $scope.SuccessMessageForemail=false;
                        $scope.invalidEmail=false;
                        $scope.customerEmailIdList="";
                        $util.httpGet('getUsersForQuoteEmailNotification', {customerLocationId:$scope.quote.serviceRequest.customerLocation.id}, function(data) {
                            angular.forEach(data, function(user) {
                                $scope.subscribedEmailUser.push(user);
                            });
                            $scope.customers = new Array();
                            angular.forEach($scope.subscribedEmailUser, function(data) {
                                customer = new Object();
                                customer.data = data.email;
                                customer.name = data.firstName + "," + data.lastName;
                                if (data.checked == null || data.checked == undefined)
                                    customer.checked = false;
                                $scope.customers.push(customer);
                            });
                            $scope.emailUserList = [];
                            $scope.openEmailWindow = true;
                            $scope.SuccessMessageForemail=false;
                            
                        });
                    }

                    $scope.addCustomerToEmailList = function() {
                       
                        
                        angular.forEach($scope.customers, function(customer) {
                            if (customer.checked) {
                                if (($.inArray(customer.data, $scope.emailUserList) < 0))
                                    $scope.emailUserList.push(customer.data);
                            }
                        });                       
                      
                        var emailList = $scope.customerEmailIdList.split(',');
                        $scope.invalidEmail=false;
                        $scope.validateEmail(emailList);                        
                        $util.httpGet('generateQuoteReport', {
                            id : $scope.quote.id,
                            emailUserList : $scope.emailUserList
                        }, function(data) {
                            if (data) {
                                $scope.SuccessMessageForemail = true;
                                $scope.subscribedEmailUser = [];
                                $scope.customers = [];
                            }
                        });                        
                    }
                    
                    $scope.validateEmail=function(emailList){
                        var filter = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;                        
                        
                        angular.forEach(emailList, function(emailId) {
                        if (!filter.test(emailId)) {
                            $scope.invalidEmailIdList=[];
                            $scope.invalidEmail=true;                            
                            $scope.invalidEmailIdList.push(emailId);                           
                        }
                        else
                            $scope.emailUserList.push(emailId);
                        });
                    }

                    $scope.quoteServiceRequestDetail = function() {
                        var thisTabLabel = getMyTabLabel();
                        parent.publishEvent("/tab/open", {
                            label : i18N.serviceRequest,
                            url : "serviceRequestpage.action?serviceRequestId=" + $scope.quote.serviceRequest.id,
                            decendentOf : thisTabLabel,
                            forceNewTab : true
                        });
                    };
                    
                    $scope.equipmentHistoryPageDetail = function() {
                        var thisTabLabel = getMyTabLabel();
                        parent.publishEvent("/tab/open", {
                            label :"Equiment History Details",
                            url : "equipmentHistoryPage.action?equipmentHistoryId=" + $scope.quote.serviceRequest.forItem.id,
                            decendentOf : thisTabLabel,
                            forceNewTab : true
                        });
                    };
                    
                    $scope.refreshPayment = function() {
                    	compressData(); 
                    	appendAudit();
                        $scope.activeAudit.flatRate= $scope.isFlatRate;
                        $http.post('refreshQuotePayment/', JSON.stringify($scope.quote)).success(function(data) {
                        	data.errors = data.quote.errors;
                            data.quote = data.quote.target;
                            if($scope.task && $scope.task.quote){
                            	$scope.task.quote = data.quote;
                            }
                            $scope.quote = data.quote;
                            $scope.activeAudit = data.quote.activeQuoteAudit;
                            $scope.isApproveTransfer = data.isApproveTransfer;
                            $scope.isApprove = data.isApprove;
                            $scope.isApprovedAlready = data.isApprovedAlready;
                            $scope.form.$dirty = false;                           
                            $scope.validation = (data.errors.length > 0) ? false : true;
                            if ($scope.validation) {
                                $scope.activeQuoteAudit = $scope.quote.activeQuoteAudit;
                                $scope.activeAudit = $scope.quote.activeQuoteAudit;
                                $scope.isFlatRate = $scope.quote.activeQuoteAudit.flatRate;
                            }
                        });
                    };

                    $scope.getStandardServiceCodes = function(query) {
                        if ($scope.quote.serviceRequest!=undefined && $scope.quote.serviceRequest.forItem.model != undefined) {
                        	$scope.invalidServiceRequest=false;
                            var modelId = $scope.quote.serviceRequest.forItem.model.id;
                            return $util.httpGetResponse('listStandardServiceCodes', {
                                searchPrefix : query,
                                limit : 10,
                                modelId : modelId
                            });
                        }
                        else
                        	{
                        	$scope.invalidServiceRequest=true;
                        	 $timeout(function(){
                        		 $scope.invalidServiceRequest=false;
                        	      }, 3000);
                        	}
                    };

                    $scope.setServiceCodeDefinition = function(item, index) {
                    	if($scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].serviceCodeDefinition==undefined || $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].serviceCodeDefinition.id!=item.id)
                    		{
                    	 $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].serviceCodeDefinition={};
                        $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].serviceCodeDefinition.id = item.id;
                        $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].serviceCodeDefinition.code = item.code;
                        $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].serviceCodeDefinition.description = item.description;
                        if (item.id != undefined && $scope.quote.serviceRequest.forItem.model !=null) {
                            $util
                                    .httpGet(
                                            'findFlatRateAndStandardHours',
                                            {
                                                serviceCodeDefinitionId : item.id,
                                                itemGroupId : $scope.quote.serviceRequest.forItem.product!=null?$scope.quote.serviceRequest.forItem.product.id:null,
                                                 dealerId:	$scope.quote.forDealer.id,
                                                 date: $scope.quote.filedOnDate,
                                                 customerCurrency:$scope.quote.serviceRequest.forItem.preferredCurrency
                                            },
                                            function(data) {
                                                if (data) {
                                                    $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].flatFeeForDealer = data.flatFeeForDealer;
                                                    $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].flatFeeForCustomer = data.flatFeeForCustomer;
                                                    $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].standardHours = data.standardHours;
                                                    if(data.oemBrandParts!=undefined && data.oemBrandParts!=null)
                                                    	{
                                         			   angular.forEach(data.oemBrandParts, function(oemBrandPart){ 
                                         				  $scope.addInputRow('activeAudit.serviceInformation.serviceDetail.oemPartsInstalled','installedPartSerialNumber','installedBrandItem.id','basePricePerUnitDealer','extendedPricePerUnit');
                                         				 var OEMindex = $scope.activeAudit.serviceInformation.serviceDetail.oemPartsInstalled.length - 1;
                                         				  $scope.activeAudit.serviceInformation.serviceDetail.oemPartsInstalled[OEMindex].installedBrandItem=oemBrandPart.brandItem;   
                                         				 $scope.activeAudit.serviceInformation.serviceDetail.oemPartsInstalled[OEMindex].numberOfUnits=oemBrandPart.numberOfUnits; 
                                         			   });
                                                    	}
                                                    if(data.nonOemParts!=undefined && data.nonOemParts!=null)
                                                    	{
                                                    	 angular.forEach(data.nonOemParts, function(serviceCodeNonOEMPart){ 
                                                        	 $scope.addInputRow('activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled', 'partNumber', 'description', 'numberOfUnits', 'basePricePerUnitDealer', 'extendedPricePerUnit', 'invoice');
                                                        	 var NONOEMindex = $scope.activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled.length - 1;
                                                        	 $scope.activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled[NONOEMindex].partNumber=serviceCodeNonOEMPart.partNumber;
                                                        	 $scope.activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled[NONOEMindex].description=serviceCodeNonOEMPart.description;
                                                        	 $scope.activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled[NONOEMindex].numberOfUnits=serviceCodeNonOEMPart.numberOfUnits;
                                                        	 $scope.activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled[NONOEMindex].pricePerUnit=serviceCodeNonOEMPart.pricePerUnit;
                                                        });
                                                    	}
                                                   
                                                }
                                            });
                        }
                    		}
                    };

                    $scope.clearStandardServices = function(index, value) {
                        if (!value) {
                            $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].serviceCodeDefinition = null;
                            $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].flatFeeForDealer = null;
                            $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].flatFeeForCustomer = null;
                            $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].standardHours = null;
                        }
                    };

                    $scope.calculateExtendedPrice = function(standardHours, additionalLaborHours, amount) {
                        var total;
                        if (standardHours) {
                            total = standardHours * amount;
                        }
                        if (additionalLaborHours) {
                            total += additionalLaborHours * amount;
                        }
                        return total;
                    };

                    $scope.calculateNonOemExtendedPrice = function(amount, numberOfUnits) {
                        return amount * numberOfUnits;
                    };

                    $scope.isRequired=function()
                    {
                        return (document.getElementById('additionalTravelHours').value >0)?true:false;                       
                    }
                    
                    $scope.printQuoteSummary=function()
                    {
                    	 var thisTabLabel = getMyTabLabel();
                         parent.publishEvent("/tab/open", {                        	 
                        	 label : i18N.printQuote,
                             url: "printQuote.action?quoteId=" +$scope.quote.id+"&folderName="+$scope.folderName,
                             decendentOf : thisTabLabel,
                             forceNewTab : true
                         });
                    	
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
                    
                    
                    $scope.openMap = function() {
                        $scope.displayGoogleMap = true;                              
                        if ($scope.travelLocation) {
                            $scope.travelLocation += $scope.travelLocation
                        }
                    };

                    $scope.$watch('travelLocation', function(newVal, oldVal) {
                        if (document.getElementById("formatedAddress")) {
                          var custAddress = $scope.customerAddress;
                          var servicingLoc = $scope.serviceDealerAddress;                         
                            var to;
                            if ((custAddress != null && custAddress != "") || (servicingLoc != null && servicingLoc != "")) {
                                to = servicingLoc;
                                $scope.initialize(to, custAddress);
                            } else {
                                $scope.invalidAddress=true;
                            }
                        }

                    });
                    
                    $scope.$watchCollection('[applicableCostCategoriesList,activeAudit.serviceInformation.serviceDetail.miscLineItems]', function(newVal, oldValue){
                        $scope.showMiscSection=$scope.isTaxSectionVisible=false;
                        angular.forEach($scope.applicableCostCategoriesList, function(applicableCostCatg) {
                           if((applicableCostCatg.categoryGroup=='MAJOR COST CATEGORY' && applicableCostCatg.code=='MISCELLANEOUS' && $scope.activeAudit.serviceInformation.serviceDetail.miscLineItems !=undefined &&  $scope.activeAudit.serviceInformation.serviceDetail.miscLineItems.length>0)||(applicableCostCatg.categoryGroup=='TAXES' && applicableCostCatg.code=='US_TAXES'))
                           {
                               $scope.showMiscSection=true;
                           }
                           if(applicableCostCatg.categoryGroup=='TAXES' || applicableCostCatg.categoryGroup=='CANADIAN TAXES')
                           {
                                $scope.isTaxSectionVisible=true;
                           }
                           
                        });

                    });
           
                    $scope.initialize = function(to, custAddress) {                                 
                        $scope.initializeToAddress(to, custAddress);
                    };

                    $scope.initializeToAddress = function(to, custAddress) {                                
                        if ((to == "" || to == null) && (custAddress == "" || custAddress == null) ) { 
                        } else {
                            var myOptions = {
                                zoom : 8,
                                mapTypeId : google.maps.MapTypeId.ROADMAP
                            };
                            var directionsService = new google.maps.DirectionsService();
                            var directionsDisplay = new google.maps.DirectionsRenderer();
                            var request = {
                                origin : to,
                                destination : custAddress,
                                travelMode : google.maps.DirectionsTravelMode.DRIVING
                            };
                            $scope.map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
                            directionsService.route(request, function(response, status) {
                                if (status == google.maps.DirectionsStatus.OK) {
                                   
                                    
                                    directionsDisplay.setMap($scope.map);
                                    directionsDisplay.setPanel(document.getElementById('panel'));
                                    directionsDisplay.setDirections(response);
                                }
                                else if(status==google.maps.DirectionsStatus.NOT_FOUND)
                                    {
                                    $scope.invalidAddress=true;
                                    $scope.$apply();
                                
                                    }
                            });
                        }
                    };
                    
                    $scope.navigateToCreateContractPage = function(){
                  	  var thisTabLabel = getMyTabLabel();
                        parent.publishEvent("/tab/open", {
                            label : i18N.contractCode,
                            url : "contract_detail_Read_Only?id=" + $scope.quote.serviceRequest.contractId,
                            decendentOf : thisTabLabel,
                            forceNewTab : true
                        });
                    
                    };
                    
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
                    	 var customerId = $scope.quote.serviceRequest.customerLocation.customer.id;
                    	 var customerName = encodeURIComponent($scope.quote.serviceRequest.customerLocation.customerName); 
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
	                  	  if($scope.quote.serviceRequest && $scope.quote.serviceRequest.customerLocation)
	                  		  {
	                  			enabled = true;
	                  		  }
	                  	  return enabled;
                    };
                    
                    $scope.printPGS = function()
                    {
                    	 var thisTabLabel = getMyTabLabel();
                    	 var customerId = $scope.quote.serviceRequest.customerLocation.customer.id;
                    	 var dealerId = $scope.quote.forDealer.id;
                    	 var dealerName = encodeURIComponent($scope.quote.forDealer.name);
                    	 var customerName = encodeURIComponent($scope.quote.serviceRequest.customerLocation.customerName);
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
	                  	  if($scope.quote.serviceRequest && $scope.quote.serviceRequest.customerLocation)
	                  		  {
	                  		  if($scope.quote.forDealer)
	                  			  {
	                  			  	enabled = true;
	                  			  }
	                  		  }
	                  	  return enabled;
                    };
                    
                    appendAudit=function()
                    {
					  if ($scope.task && $scope.task.quote)
					  {
						   $scope.task.quote.activeQuoteAudit = $scope.activeAudit;
						}
					  else
					  {
						$scope.quote.activeQuoteAudit = $scope.activeAudit;
						}
                    };

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
                    
    $scope.$watch('successForm', function(newVal, oldVal) {
    	 if (newVal) {
    	    var summaryTableId = getFrameAttribute("TST_ID");
             if (summaryTableId) {
                 manageTableRefresh(summaryTableId, true);
             }
    	 }
    });
    
    /*$scope.$watch('quote.serviceRequest.activeServiceRequestAudit.callType', function(newVal, oldVal) {
        if (newVal) {
            $scope.getapplicableTravelMatrix();
        }
   });
    */
   
    $scope.fetchCallTypes = function() {
  	  $util.httpGet('findlovs', {
  		  isInternalUserOrOwningDealer : $scope.isInternalUserOrOwningDealer
  	  }, function(data) {
            $scope.callTypes = data;
            $scope.executeCallTypeFunction($scope.quote.serviceRequest.activeServiceRequestAudit.callType.id);
        });
    }
    $scope.populateFailureMessage = function(data){
        $scope.showErrorMessage = (data.failureMessage) ? true : false;
        $scope.quoteForm = false;
    	$scope.form.$dirty = false;
    	$scope.validateForm = false;
    }
        
    $scope.showInclusions= function (index)
    {
    	if($scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].serviceCodeDefinition!=undefined)
    		{
    		 $util
             .httpGet(
                     'findInclusionsById',
                     {
                         serviceCodeDefinitionId : $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].serviceCodeDefinition.id,
                          dealerId:	$scope.quote.forDealer.id
                     },
                     function(data) {
                    	 $scope.oemInclusions=data.oemBrandParts;
                    	 $scope.nonoemInclusions=data.nonOemParts;
                     });
    		 $scope.standardHours=$scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].standardHours;
    	$scope.viewInclusions=true;
    	$scope.showAssociatedInclussions=true;
    		}
    };
    $scope.closeInclusions=function()
    {
    	$scope.viewInclusions=false;	
    };
                }]);