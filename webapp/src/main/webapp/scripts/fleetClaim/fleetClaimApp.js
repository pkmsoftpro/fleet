var fleetClaimApp = angular.module('createFleetClaim', [ 'ui.bootstrap','textArea', 'autoCompleter', 'titlePane', 'repeater','loadingIndicator', 'alertMsg', '$util','numbersOnly','popup','uiTreeType','moneyType','angularFileUpload','subSection','popup','ngGrid','isNumber'])
fleetClaimApp.factory('claimFactory', ['$http', function($http) {
	var fleetClaimService = {};

	fleetClaimService.deleteDraftFleetClaim = function($scope) {
		$http.post('deleteDraftFleetClaim/', JSON.stringify($scope.fleetClaim))
				.success(function(data) {
					$scope.successForm = (data.successMessage) ? true : false;
					if ($scope.successForm) {
						$scope.form.$dirty = false;
						$scope.fleetClaimForm = false;
					} else if(data.failureMessage) {
		                $scope.populateFailureMessage(data);                                
		            } else {
						$scope.fleetClaimForm = true;
					}
				});
	};

	fleetClaimService.saveFleetClaim = function($scope) {
		$http.post('saveFleetClaim/', JSON.stringify($scope.fleetClaim)).success(
				function(data) {
					$scope.form.$dirty = false;
					$scope.fleetClaim = data.target;
					$scope.activeAudit=data.target.activeFleetClaimAudit;
				    $scope.isEntryValidationCheck=false;
				    $scope.isSRAutoBoxEdit();
				});
	};

	return fleetClaimService;
}]);

fleetClaimApp.controller('FleetClaimController', ['$scope', '$http', '$util', 'claimFactory', '$fileUploader','$timeout', function($scope, $http, $util, claimFactory, $fileUploader,$timeout) {

	 $scope.fleetClaimForm = true;
	 $scope.assets = [];
     $scope.jobCodes = [];
     $scope.attachedDocuments = new Array();
     $scope.failedDocuments = [];
     $scope.internalUserName;
     $scope.AdvisorUserName;
     $scope.customerName;
     $scope.customerId;
     $scope.customerNumber;
     $scope.locationsMapkey;
     $scope.selectedId = false;
     $scope.isEntryValidationCheck=false;
     $scope.invalidAddress=false;
     $scope.isInternalUserOrOwningDealer=false;
 	 $scope.isCustomerUser=false;
     $scope.servicingDealer=false;
     $scope.today=new Date();
     $scope.map;
     $scope.geocoder;
     $scope.mapZoom;
     $scope.equipment;
     $scope.module="claim";
     $scope.isQuoteExist=false;
     $scope.isClonedClaim=false;
     $scope.quoteNumber;
     $scope.showSRDropdown = true;
     var emptyDenyReason=[];
     $scope.editSRAutoBox=false;
     $scope.editSerialNumber=false;
     $scope.showErrorMessage=false;
     compressData= function()
     {
    	 var fsrId={};
    	 var fiId={};
    	 var activeServiceRequestAudit={};
    	 if($scope.task && $scope.task.fleetClaim)
    		 {
    		 if($scope.task.fleetClaim.forServiceRequest){
    		     fsrId['id']=$scope.task.fleetClaim.forServiceRequest.id;
    		     if($scope.task.fleetClaim.forServiceRequest.activeServiceRequestAudit && $scope.task.fleetClaim.forServiceRequest.activeServiceRequestAudit.id ){
    		         activeServiceRequestAudit['id']=$scope.task.fleetClaim.forServiceRequest.activeServiceRequestAudit.id;
    		         if( $scope.task.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber)
    		        	 {
    		         activeServiceRequestAudit['customerPoNumber']=$scope.task.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber;
    		        	 }
    		         $scope.task.fleetClaim.forServiceRequest.activeServiceRequestAudit={};
    		         $scope.task.fleetClaim.forServiceRequest.activeServiceRequestAudit=activeServiceRequestAudit;
    		     }
 	 		$scope.task.fleetClaim.forServiceRequest={};
	 		$scope.task.fleetClaim.forServiceRequest=fsrId;
    		 }
    	 		fiId['id']=$scope.task.fleetClaim.forItem.id;
    	 		fiId['serialNumber']=$scope.task.fleetClaim.forItem.serialNumber;
    	 		$scope.task.fleetClaim.forItem={};
    	 		$scope.task.fleetClaim.forItem=fiId;
    	 		
    		 }
    	 else
    		 {

    		 if($scope.fleetClaim.forServiceRequest)
    		 {
    		 fsrId['id']=$scope.fleetClaim.forServiceRequest.id;
    		 if($scope.fleetClaim.forServiceRequest.activeServiceRequestAudit && $scope.fleetClaim.forServiceRequest.activeServiceRequestAudit.id){
    		 activeServiceRequestAudit['id']=$scope.fleetClaim.forServiceRequest.activeServiceRequestAudit.id;
    		 if( $scope.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber)
    			 {
 	 		activeServiceRequestAudit['customerPoNumber']=$scope.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber;
    			 }
 	 		 $scope.fleetClaim.forServiceRequest.activeServiceRequestAudit={};
 	 		$scope.fleetClaim.forServiceRequest.activeServiceRequestAudit=activeServiceRequestAudit;
    		 }
    		 $scope.fleetClaim.forServiceRequest={};
 	 		 $scope.fleetClaim.forServiceRequest=fsrId;
    	 		
    		 }
    	 		fiId['id']=$scope.fleetClaim.forItem.id;
    	 		fiId['serialNumber']=$scope.fleetClaim.forItem.serialNumber;
    	 		$scope.fleetClaim.forItem={};
    	 		$scope.fleetClaim.forItem=fiId;
    	 		
    		  
    		 }
     };
     $scope.isReadOnly = function() {
         return (document.getElementById('readOnly') && document.getElementById('readOnly').value === "true") ? true : false;
     };
     $scope.isDocType = function() {
         return (document.getElementById('isDocType') && document.getElementById('isDocType').value === "true") ? true : false;
     };
     load = function() {
         var taskId = document.getElementById('taskId').value;
         
         if (taskId) {
             $util.httpGet('fleetClaimDetail', {
                 taskId : taskId,
                 folderName:$scope.folderName 
             }, function(data) {
            	 if(data.originalResponse)
            	 {
            	  data=data.originalResponse;
            	   }
                 $scope.task = data.taskView;
                 if (data.fleetClaim) {
                	 $scope.init(data);
                	 $scope.isSRAutoBoxEdit();
                     $scope.task.fleetClaim = data.fleetClaim;
                     $scope.showSRDropdown = data.fleetClaim.forServiceRequest ? false : true; 
                     $scope.serviceDealerAddress=getLocationAddress(data.serviceDealerAddress);                                    
                     $scope.customerAddress=getLocationAddress(data.customerAddress);
                     //to preserve multi selected lov dropdowns
                     $scope.preserveMultiSelectLovValues();
                     $scope.laborMultipliers=data.laborMultipliers;                     
                     $scope.populateLaborDetails();
                     if(data.fleetClaim.forServiceRequest != null){
                    	 if(data.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber != null){
                    		 $scope.activeAudit.customerPoNumber = data.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber;
                    		 $scope.validateCustomerPoNumber=$scope.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber;
                    	 }
                     }
                     $scope.poRegularExpression=data.customerLocation.poRegularExpression;
                     $scope.duplicatePoNumberAllowed=data.customerLocation.duplicatePoNumberAllowed;
                     $scope.customerLocationId=data.customerLocation.id;
                     $scope.defaultPoNumber=data.fleetClaim.activeFleetClaimAudit.customerPoNumber;
                     $scope.validateCustomerPoNumber=data.fleetClaim.activeFleetClaimAudit.customerPoNumber;
                     if($scope.servicingDealer || (!$scope.isInternalUserOrOwningDealer)) {
                       	$scope.findCallTypeAssociated($scope.activeAudit.callType);
                     }
                     
                     if ($scope.activeAudit.fleetClaimState != 'DRAFT') {
                    	 $scope.activeAudit.notesForNMHG ="";
                    	 $scope.activeAudit.internalComment ="";
                    	 $scope.activeAudit.notesForDealer ="";
                    	 $scope.activeAudit.notesForCustomer ="";
                     }
                    
                     
                 }
             });
         }
        
         if(document.getElementById('serviceRequestId') && document.getElementById('serviceRequestId').value!="") {
        	 var serviceRequestId = document.getElementById('serviceRequestId').value;
        	 $scope.fleetClaim={};
        	 $scope.fleetClaim.forServiceRequest={};
        	 $scope.fleetClaim.forServiceRequest.id=Number(serviceRequestId);
        	 $scope.populateServiceRequestDetailsForDraftClaims($scope.fleetClaim.forServiceRequest.id);
         }
         
         var fleetClaimId = document.getElementById('fleetClaimId').value;
         if (fleetClaimId) {
             $util.httpGet('getFleetClaimDetailsReadonly', {
                 fleetClaimId : fleetClaimId
             }, function(data) {
                 $scope.init(data);
                 
                 $scope.laborMultipliers=data.laborMultipliers;
                 $scope.populateLaborDetails();
             });
         }
         
         var searchId = document.getElementById('id').value;
         if (searchId) {
             $util.httpGet('fleetClaimSearchDetail', {
            	 searchId : searchId
             }, function(data) {
            	 if(data.originalResponse)
            	 {
            	  data=data.originalResponse;
            	   }
                 if (data.fleetClaim) {
                	 $scope.init(data);
                     $scope.fleetClaim = data.fleetClaim;
                     if($scope.isInternalUserOrOwningDealer|| (!$scope.servicingDealer)) {
                         if($scope.fleetClaim.activeFleetClaimAudit.callType && angular.uppercase($scope.fleetClaim.activeFleetClaimAudit.callType.code) == 'NORMAL REPAIR') {
                             angular.forEach($scope.callTypes, function(callTypeObj) {
                                 if( angular.uppercase(callTypeObj.listOfValues.code) == 'MNB') {
                                 $scope.fleetClaim.activeFleetClaimAudit.callType.description=callTypeObj.listOfValues.description;
                                 }
                             });
                           }
                      }
                     if(data.fleetClaim.forServiceRequest != null){
                    	 if(data.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber != null){
                    		 $scope.activeAudit.customerPoNumber = data.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber;
                    	 }
                     }
                     $scope.searchfleetClaim=data.isUserActor;
                     $scope.laborMultipliers=data.laborMultipliers;
                     $scope.showClaimReopenButton=data.showClaimReopenButton;
                     $scope.isProcessButtonVisible=data.isProcessButtonVisible;
                     $scope.populateLaborDetails();
                     if($scope.servicingDealer || (!$scope.isInternalUserOrOwningDealer)) {
                        	$scope.findCallTypeAssociated($scope.activeAudit.callType);
                      }
                 }
             });
         }
         var fleetClaimCloneId = document.getElementById('fleetClaimCloneId')!=null?document.getElementById('fleetClaimCloneId').value:null;
         if(fleetClaimCloneId)
        	 {

             $util.httpGet('getClonedFleetClaim', {
            	 fleetClaimCloneId : fleetClaimCloneId
             }, function(data) {
            	 if(data.originalResponse)
            	 {
            	  data=data.originalResponse;
            	   }
                 if (data.fleetClaim) {
                	 $scope.isClonedClaim=data.isClonedClaim;
                	 $scope.init(data); 
                     $scope.serviceDealerAddress=getLocationAddress(data.serviceDealerAddress);                                    
                     $scope.customerAddress=getLocationAddress(data.customerAddress);
                     //to preserve multi selected lov dropdowns
                     $scope.preserveMultiSelectLovValues();
                     $scope.laborMultipliers=data.laborMultipliers;
                     $scope.populateLaborDetails();
                     if($scope.servicingDealer || (!$scope.isInternalUserOrOwningDealer)) {
                       	$scope.findCallTypeAssociated($scope.activeAudit.callType);
                     }
                 }
             });
         
        	 
        	 }
     };
     
     $scope.associatedCallType = {};
     $scope.findCallTypeAssociated = function(selectedCallType) {
     	if(selectedCallType) {
     		$util.httpGet('findAssociatedCallType',{id : selectedCallType.id , isInternalOrOwningDealer : $scope.isInternalUserOrOwningDealer},function(data){
     			$scope.activeAudit.callType = data;
     			$scope.associatedCallType = data;
     		});
     	}
     }
     $scope.populateServiceRequestDetails = function(newVal)
	  {	     
	               
		  if($scope.activeAudit!=undefined && $scope.activeAudit.serviceInformation !=undefined && $scope.activeAudit.serviceInformation.serviceDetail!=undefined && $scope.activeAudit!=null && $scope.activeAudit.serviceInformation !=null && $scope.activeAudit.serviceInformation.serviceDetail!=null)
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
   	
   		}
		  
		  	$util.httpGetWithId('selectedServiceRequestDetailsForClaim', {
             serviceRequestId : newVal
		  	}, newVal, function(data) {
       	  if(data.originalResponse)
       		  {
       		  data=data.originalResponse;
       		  }
             $scope.fleetClaim.forServiceRequest = data.serviceRequest;
             $scope.equipment=new Object();
             $scope.equipment=data.serviceRequest.forItem;
             $scope.preferredCurrency=data.serviceRequest.forItem.preferredCurrency;
             $scope.fleetClaim.forItem=data.serviceRequest.forItem;
             if(data.callTypeId!=null){
           	  if((!$scope.activeAudit.informationOnly)&& $scope.activeAudit.callType){
           		  $scope.activeAudit.callType.id=data.callTypeId;
           	  }
             }
             $scope.applicableTravelMatrix = data.travelMatrix;
             $scope.serviceDealerAddress=getLocationAddress(data.serviceDealerAddress);
             $scope.customerAddress=getLocationAddress(data.customerAddress);
             if($scope.fleetClaim.forServiceRequest.quoteDetail!=null && $scope.fleetClaim.forServiceRequest.quoteDetail.state=='DRAFT')
           	  $scope.fleetClaim.forServiceRequest.quoteDetail.quoteNumber='';
             $scope.customerName=$scope.fleetClaim.forServiceRequest.customerLocation.customerName;
       	  $scope.customerId=$scope.fleetClaim.forServiceRequest.customerLocation.customer.id;
             $scope.customerNumber=$scope.fleetClaim.customerNumber;
             $scope.locationsMapkey=$scope.fleetClaim.forServiceRequest.customerLocation.locationsMapkey;
             $scope.activeAudit.technicianDetails=data.technicianDetails;
             prepareFaultFoundList($scope.fleetClaim.forItem.id);
            /* $scope.applicableCostCategories($scope.fleetClaim.forItem.id);*/
             $scope.laborMultipliers = data.laborMultipliers;
             $scope.PONumberRequiredOrNot($scope.fleetClaim.forServiceRequest.customerLocation.purchaseOrderRequired);
             $scope.populateLaborDetails();
             if(data.serviceInformation!=null)
           	  {
             $scope.isQuoteExist=true;
             $scope.activeAudit.serviceInformation=data.serviceInformation;
             $scope.activeAudit.problemReported=data.problemReported;
             $scope.activeAudit.conditionFound=data.conditionFound;
             $scope.activeAudit.workPerformed=data.workPerformed;
             if (data.serviceInformation.faultFound
                     && data.serviceInformation.faultFound.id) {
                 $scope.listCausedBy($scope.activeAudit.serviceInformation.faultFound.id,
                         $scope.fleetClaim.forItem.id);
             }
            }
             $scope.quoteNumber=data.quoteNumber;
          
             $scope.poRegularExpression=$scope.fleetClaim.forServiceRequest.customerLocation.poRegularExpression;
             $scope.duplicatePoNumberAllowed=$scope.fleetClaim.forServiceRequest.customerLocation.duplicatePoNumberAllowed;
             $scope.customerLocationId=$scope.fleetClaim.forServiceRequest.customerLocation.id;
             if($scope.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber!=null) {
           	  $scope.activeAudit.customerPoNumber=data.customerPONumber;
           	  $scope.validateCustomerPoNumber=$scope.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber;
             }
             else {
           	  $scope.activeAudit.customerPoNumber= $scope.defaultPoNumber;
             }
             
             if($scope.servicingDealer || (!$scope.isInternalUserOrOwningDealer)) {
                	$scope.findCallTypeAssociated($scope.fleetClaim.forServiceRequest.activeServiceRequestAudit.callType);
              }
             $scope.populateStandardServices();
             
             $scope.activeAudit.problemReported=data.problemDescription;
            
             if(data.workOrderNumber!=null && data.workOrderNumber!="")
           	  {
             $scope.activeAudit.workOrderNumber=data.workOrderNumber;
           	  }
             $util.httpGet('numberOfTripsList', {}, function(data) {
                 $scope.noOfTrips = data;

             });
         });
	  };  
     
     $scope.populateServiceRequestDetailsForDraftClaims = function(serviceRequestId)
	  {
		  if($scope.fleetClaim!=null &&($scope.fleetClaim.id == null||$scope.fleetClaim.fleetClaimNumber=='Draft'))
			  {
		  $scope.populateServiceRequestDetails(serviceRequestId);
			  }
	  };
	  
	  
     
     load();
    
     $scope.init = function(data) {
         $scope.fleetClaim = data.fleetClaim;
         $scope.equipment=data.fleetClaim.forItem;
         if(data.fleetClaim.forItem==null && data.fleetClaim.source=='BATCHCLAIM' && data.fleetClaim.fleetClaimNumber=='Draft')
        	 {
        	 $scope.editSerialNumber=true;
        	 }
         
         if(data.fleetClaim.forItem!=null)
        	 {
        	 $scope.preferredCurrency=data.fleetClaim.forItem.preferredCurrency;
        	  prepareFaultFoundList($scope.fleetClaim.forItem.id);
        	  $scope.maintenanceType=$scope.fleetClaim.forItem.maintenanceType;
        	 }
         $scope.activeAudit=data.fleetClaim.activeFleetClaimAudit;
         $scope.isFlatRate = data.fleetClaim.activeFleetClaimAudit.flatRate;
         $scope.audits = data.fleetClaimAudits;
         $scope.hideGridValueBasedOnUserType(data.fleetClaimAudits,data);
       
         $scope.isContractManagement = data.isContractManagement;
         // Temp Fix to show payment section on Claim , THis will have to be modified for dealer owned implementation
         if(data.isInternalUserOrOwningDealer){
        	 $scope.isInternalUserOrOwningDealer = data.isInternalUserOrOwningDealer;
         }
         $scope.isCustomerUser=data.isCustomerUser;
    	 $scope.servicingDealer=data.isServicingDealer;
    	 $scope.isFleetProcesor=data.isFleetProcesor;
    	   $scope.loggedInUserType=data.loggedInUserType;
    	 $scope.hideAuditHistoryColumnsForDealer();
    	 
         if(data.contractId)
         $scope.contractId = data.contractId;
         var customerId=null;
         var customerLocationId=null;
             $scope.quoteNumber=data.quoteNumber;
             if(data.customerLocation!=null)
            	 {
             $scope.customerName=data.customerLocation.customerName;
             $scope.customerNumber=data.fleetClaim.customerNumber;
             $scope.locationsMapkey=data.customerLocation.locationsMapkey;
             customerId=data.customerLocation.customer.id;
             $scope.customerId=data.customerLocation.customer.id;
             customerLocationId=data.customerLocation.id;
             $scope.customerLocationId=data.customerLocation.id;
            	 }
             $scope.applicableTravelMatrix = data.travelMatrix;
             $scope.serviceDealerAddress=getLocationAddress(data.serviceDealerAddress);
             $scope.customerAddress=getLocationAddress(data.customerAddress);
         if(angular.uppercase(data.fleetClaim.fleetClaimNumber)=='DRAFT')
    	 {
        	 if($scope.fleetClaim.id==null && $scope.fleetClaim.clonedClaim)
        		 {
        		 $scope.populateClaimAdditionalAttributes(data.parentClaimId,customerId,customerLocationId,$scope.fleetClaim.forItem.product.id);
        		 }
        	 else
        		 {
    	         $scope.populateClaimAdditionalAttributes($scope.fleetClaim.id,customerId,customerLocationId,$scope.fleetClaim.forItem!=null && $scope.fleetClaim.forItem.product.id!=null?$scope.fleetClaim.forItem.product.id:null);
        		 }
    	 }
         $scope.activeAudit= data.fleetClaim.activeFleetClaimAudit;
         if (data.isUserCustomer) {
             $scope.audits.splice(0, ($scope.audits.length - 1));
         }
         if ($scope.activeAudit.serviceInformation.faultFound
                 && $scope.activeAudit.serviceInformation.faultFound.id) {
             $scope.listCausedBy($scope.activeAudit.serviceInformation.faultFound.id,
                     data.fleetClaim.forItem.id);
         }
         if(data.isInternalUserOrOwningDealer)
          {
         $scope.isCallTypePlanned=data.isCallTypePlanned;
         if($scope.form.callType)
        	 {
         $scope.form.callType.$setValidity('notinternal', data.isInternal);
        	 }
          }
         $scope.applicableCostCategoriesList = data.applicableCostCategoriesList;
		  $scope.isTaxSectionVisible=data.isTaxSectionVisible;
		  $scope.noOfTrips=data.numbeOfTrips;
		  $scope.moduleId = data.moduleId;
     }
	
	  $scope.$watch('dealerId', function(newVal, oldVal) {
          if (newVal) {
              $util.httpGet('populateDealerDetails', {
                  id : $scope.dealerId
              }, function(data) {
                  $scope.fleetClaim.forDealer = data;
                  $scope.moduleId=data.brand;
              });
          }
      });
	  
		  $scope.findDealersWhoseNumberStartingWith = function(query) {
			  $scope.form.serviceProviderNumber.$setValidity("invalid", false); // making field invalid as soon as user type [Making valid when user selects the value from AutoCompleter suggestions] 
			  return $util.httpGetResponse('findDealersWhoseNumberStartingWith', {
				  searchPrefix : query,
				  limit : 10
			  });
		  };
	
		  $scope.findDealersWhoseNameStartingWith = function(query) {
			  $scope.form.serviceProviderName.$setValidity("invalid", false); // making field invalid as soon as user type [Making valid when user selects the value from AutoCompleter suggestions] 
			  return $util.httpGetResponse('findDealersWhoseNameStartingWith', {
				  searchPrefix : query,
				  limit : 10
			  });
		  };
	
		  /**
		   *  This method will be called when user selects value from Auto Completer Suggestions.
		   *  We are making Service Provider Number & Service Provider Name as valid fields as they were made invalid when user typing.
		   */
		  $scope.setDealer = function(item) {
			  $scope.form.serviceProviderNumber.$setValidity("invalid", true); 
			  $scope.form.serviceProviderName.$setValidity("invalid", true);
	
			  $scope.fleetClaim.forDealer=item;
			  if($scope.fleetClaim.forItem && $scope.fleetClaim.forItem.id)
				  {
			  $scope.applicableCostCategories($scope.fleetClaim.forDealer.id,$scope.fleetClaim.forItem.id);
				  }
			  $util.httpGetWithId('populateDealerBrand', {
				  dealerId : item.id
			  }, item.id, function(data) {
				  $scope.moduleId = data;
			  });
	
			  /*  $scope.populateApplicableMiscLineItems($scope.fleetClaim.forDealer.id, $scope.fleetClaim.forItem!=undefined && $scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.customer!=undefined?$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.customer.id:($scope.fleetClaim.forServiceRequest!=undefined?$scope.fleetClaim.forServiceRequest.customerLocation.customer.id:undefined),
		     		$scope.fleetClaim.forItem!=undefined && $scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.id!=undefined?$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.id:($scope.fleetClaim.forServiceRequest!=undefined?$scope.fleetClaim.forServiceRequest.customerLocation.id:undefined));*/
		  };

      $scope.toggleFlatRate = function() {
          $scope.isFlatRate = $scope.isFlatRate === false ? true: false;
      };
      $scope.$watchCollection('[fleetClaim.forDealer,fleetClaim.forItem]', function(newVal, oldValue){
    	  
    	  if( $scope.fleetClaim && $scope.fleetClaim.forDealer && $scope.fleetClaim.forItem && $scope.fleetClaim.forItem.serialNumber)
    		  {
    		  $scope.fetchPendingServiceRequestList($scope.fleetClaim.forItem.id,$scope.fleetClaim.forDealer.id);
    		  }
    	  
      });
	  
	  $scope.$watch('fleetClaim.forItem.id', function(newVal, oldVal) {
	         if (angular.isNumber(newVal) ){
	               $scope.populateRoleInfoAndCallTypes(newVal);
	         }
	       });
	  
	  $scope.$watch('activeAudit.callType.id', function(newVal, oldVal) { 
		  $scope.callTypeInfo(newVal);
	  });
	  
	  $scope.callTypeInfo =function(newVal){  
	      angular.forEach($scope.callTypes, function(callType){
              if (newVal == callType.listOfValues.id) {               
               $scope.isCallTypePlanned=callType.isPlanned?"PLANNED":"UNPLANNED";
              }
          });

    	 if ($scope.isInternalUserOrOwningDealer && newVal && $scope.callTypes) {
              var isInternal = false;
              angular.forEach($scope.callTypes, function(callType){
                    if (newVal == callType.listOfValues.id && callType.isInternal == true) {
                          isInternal = true;
                    }
             });
              if($scope.form.callType) {
            	  if(!isInternal) {
            		  $scope.form.callType.$setValidity('notinternal', false);
            	  } else {
            		  $scope.form.callType.$setValidity('notinternal', true);
            	  }
             }
          }
        
	  };
	  
	  $scope.equipmentHistoryPageDetail = function() {
          var thisTabLabel = getMyTabLabel();
          parent.publishEvent("/tab/open", {
              label :"Equiment History Details",
              url : "equipmentHistoryPage.action?equipmentHistoryId=" + $scope.fleetClaim.forItem.id,
              decendentOf : thisTabLabel,
              forceNewTab : true
          });
      };
	  
	  $scope.findInventoryItemsWhoseSerialNumberStartsWith = function(query) {
		 
          return $util.httpGetResponse('findInventoryItemsWhoseSerialNumberStartsWith', {
              searchPrefix : query,
              limit : 10
          });
			 
	};
      
      $scope.setInventoryItem = function(item) {
    	  if(item)
    		  {
        $scope.fleetClaim.forItem=item;            
        $scope.equipment=item;
        $scope.preferredCurrency=item.preferredCurrency;
        $scope.showWarrantyWarningMessage = item.underWarranty;
        $scope.activeAudit.serviceInformation.causalPart=null;
        $scope.activeAudit.serviceInformation.serviceDetail.laborDetails=[];
        $scope.activeAudit.serviceInformation.serviceDetail.oemPartsReplaced=[];
        $scope.activeAudit.serviceInformation.serviceDetail.oemPartsInstalled=[];
        $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails=[];
        $scope.activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail=[];
        prepareFaultFoundList($scope.fleetClaim.forItem.id);
        prepareLaborMultipliers($scope.fleetClaim.forItem.model,$scope.fleetClaim.forItem.id);
        if($scope.fleetClaim.forDealer && $scope.fleetClaim.forDealer.id)
        	{
        $scope.applicableCostCategories($scope.fleetClaim.forDealer.id,$scope.fleetClaim.forItem.id);
        	}
        $scope.customerName=$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.customerName;
        $scope.customerNumber=$scope.fleetClaim.customerNumber;
        $scope.customerId=$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.customer.id;
        $scope.customerLocationId=$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.id;
        $scope.locationsMapkey=$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.locationsMapkey;
        $scope.poRegularExpression=$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.poRegularExpression;
        $scope.duplicatePoNumberAllowed=$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.duplicatePoNumberAllowed;
        $scope.customerLocationId=$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.id;
        $scope.populateClaimAdditionalAttributes($scope.fleetClaim.id,$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.customer.id,$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.id,$scope.fleetClaim.forItem.product.id);
        $scope.PONumberRequiredOrNot($scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.purchaseOrderRequired);
               if( $scope.fleetClaim && $scope.fleetClaim.forItem && $scope.fleetClaim.forItem.id && $scope.fleetClaim.forServiceRequest && $scope.fleetClaim.forServiceRequest.id && $scope.fleetClaim.repairStartDate && $scope.fleetClaim.repairEndDate ){
                         $scope.PONumberRequiredOrNot($scope.fleetClaim.forServiceRequest.customerLocation.purchaseOrderRequired);
                  }
         $scope.maintenanceType=$scope.fleetClaim.forItem.maintenanceType; 
    		  }
    	  $util.httpGet('numberOfTripsList', {}, function(data) {
              $scope.noOfTrips = data;

          });
       };
       
       $scope.populateRoleInfoAndCallTypes=function(forItemId)
       {           
           $util.httpGet('populateRoleInfo', {
               forItem : forItemId,
               folderName:$scope.folderName
           },function(data) {
               $scope.servicingDealer=data.isServicingDealer;
               $scope.isInternalUserOrOwningDealer=data.isInternalUserOrOwningDealer;             
               $scope.isCustomerUser=data.isCustomerUser;
               $scope.isFleetProcesor=data.isFleetProcesor;
               $scope.loggedInUserType=data.loggedInUserType;
               $scope.callTypes = data.callTypes;
               if($scope.activeAudit.callType.id)
            	   {
               $scope.callTypeInfo($scope.activeAudit.callType.id);
            	   }
           });
       }
	  
	  $scope.fetchPendingServiceRequestList = function(inventoryId,dealerId){
		  if(inventoryId && dealerId && $scope.isReadOnly()==false){
			  $util.httpGet('listPendingServiceRequestsForInventoryItem', {
	                 inventoryId : inventoryId,
	                 dealerId    :dealerId
	             },function(data) {
	                 $scope.serviceRequests = data.items;
	             });
		  }else{
			  $scope.serviceRequests =[];
		  }
		 
	  };
	  
	 
	  $scope.populateStandardServices=function()
	  {
		  if($scope.fleetClaim.repairEndDate!=null && $scope.fleetClaim.forServiceRequest!=null && $scope.fleetClaim.forServiceRequest.forServiceCall!=null && $scope.fleetClaim.forServiceRequest.forServiceCall.associatedServiceCode!=null && $scope.fleetClaim.forServiceRequest.forServiceCall.associatedServiceCode.serviceCode!=null)
  		{
			  if(!$scope.isQuoteExist)
				  {
  		$scope.addInputRow('activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails','serviceCodeDefinition.code','serviceCodeDefinition.description','standardHours','dummyColumn','additionalLaborHours','reasonForAdditionalHours');
  		var standardCodeIndex=$scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails.length-1;
  		 $scope.setServiceCodeDefinition($scope.fleetClaim.forServiceRequest.forServiceCall.associatedServiceCode.serviceCode,standardCodeIndex);
				  }
  		}  	  
	  };
	  $scope.populateClaimAdditionalAttributes=function(id,customerId,locationId,productId)
	  {
		  if(id,customerId,locationId,productId)
			  {
		  var fleetClaimId= id!=null?id:"";
	  $util.httpGet('findClaimAdditionalAttributes/', 
              {
		        fleetClaimId:fleetClaimId,
	            customerId:customerId,
	            locationId:locationId,
	            productId: productId
              }		
				,function(data) {
					
					$scope.fleetClaim.claimAdditionalAttributes=data;		
				});
			  }
		};
      
      $scope.causalPartDescription = function(value) {
          if (value.toString().length == 0) {
              $scope.activeAudit.serviceInformation.causalPart = null;
          } else if (+value && value.toString().length > 2) {
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
          var invItemId = $scope.fleetClaim.forItem.id;
          $util.httpGet('find_serviceProcedure_tree', {
              invItemId : invItemId,
              assemblyId : nodeId
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
          var invItemId = $scope.equipment.id;
          $util.httpGet('find_fault_code_tree', {
              invItemId : invItemId,
              assemblyId : nodeId
          }, function(data) {
              callback(data);
          });
      }
      $scope.cancel = function() {
      	closeTab(getTabHavingLabel(getMyTabLabel()));
      };
      
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

      prepareFaultFoundList = function(invItemId) {
          $util.httpGet('fault_found_list', {
        	  invItemId:invItemId
          }, function(data) {
              $scope.faultFoundList = data.items;
          });	
      };
      
      prepareLaborMultipliers = function(model,invItemId) {
          $util.httpGet('over_time_labor_list', {
        	  invItemId:invItemId
          }, function(data) {
              $scope.laborMultipliers = data.laborMultipliers;
              $scope.populateLaborDetails();
          });
      };
      
      $scope.applicableCostCategories = function(dealerId, invId) {
          $util.httpGet('applicableCostCategories', {
              invId : invId,
              dealerId: dealerId
          }, function(data) {
              $scope.applicableCostCategoriesList = data;
              angular.forEach($scope.applicableCostCategoriesList, function(applicableCostCatg) {
                  if(applicableCostCatg.categoryGroup=='TAXES' || applicableCostCatg.categoryGroup=='CANADIAN TAXES')
                  {
                      $scope.isTaxSectionVisible=true;
                  }
              });
            /*  if($scope.fleetClaim.forDealer)
            	  {
            	  $scope.populateApplicableMiscLineItems($scope.fleetClaim.forDealer.id, $scope.fleetClaim.forItem!=undefined && $scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.customer!=undefined?$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.customer.id:($scope.fleetClaim.forServiceRequest!=undefined?$scope.fleetClaim.forServiceRequest.customerLocation.customer.id:undefined),
                  		$scope.fleetClaim.forItem!=undefined && $scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.id!=undefined?$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.id:($scope.fleetClaim.forServiceRequest!=undefined?$scope.fleetClaim.forServiceRequest.customerLocation.id:undefined));
            	  }*/
          });
      };
      
      $scope.populateApplicableMiscLineItems = function(dealerId,customerId, customerLocationId,repairEndDate) {
    	  if(dealerId!=undefined && customerId!=undefined && customerLocationId!=undefined && repairEndDate!=undefined)
    		  {
    	      var duration = angular.isString(repairEndDate) ? repairEndDate : repairEndDate.getMonth() + 1 + '/' + repairEndDate.getDate() + '/' + repairEndDate.getFullYear();
    	  var isEligibleForSubCostCodes=false;
    	  angular.forEach($scope.applicableCostCategoriesList, function(applicableCostCatg) {
    		  if(applicableCostCatg.code=='MISCELLANEOUS')
    			  {
    			  isEligibleForSubCostCodes=true;
    			  }  
    	  });
    	  if(isEligibleForSubCostCodes)
    		  {
          $util.httpGet('applicableMiscLineItems', {
        	  dealerId:dealerId,
              customerId : customerId,
              customerLocationId : customerLocationId,
              duration:duration
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

            //  for (i = 0; i < $scope.oldMiscLineItems.length; i++) {
                  angular.forEach($scope.activeAudit.serviceInformation.serviceDetail.miscLineItems, function(miscLineItem) {
                      //if ($scope.oldMiscLineItems[i] == miscLineItem.miscSubCostCodes.id) {
                          $scope.newMiscLineItems.push(miscLineItem);
                      //}
                  });
              //}
              
              $scope.activeAudit.serviceInformation.serviceDetail.miscLineItems=[];
              angular.forEach($scope.newMiscLineItems, function(miscLineItem) {
              $scope.activeAudit.serviceInformation.serviceDetail.miscLineItems.push(miscLineItem);
              });

          });
    		  }
    		  }
      };
      
      $scope.listCausedBy = function(faultFoundId, inventoryItemId) {
          $util.httpGet('find_caused_by_list', {
              faultFound : faultFoundId,
              invItemId : inventoryItemId
          }, function(data) {
              $scope.causedByList = data.items;
          });
    		 
      };
      
      $scope.getStandardServiceCodes = function(query) {
          if ($scope.fleetClaim.forItem!= undefined && $scope.fleetClaim.forItem.model != undefined) {
              $scope.invalidSerialNumber=false;
              if($scope.fleetClaim.repairEndDate != undefined)
            	  {
            	  $scope.invalidRepairEndDate=false;
              var modelId = $scope.fleetClaim.forItem.model.id;
              return $util.httpGetResponse('listStandardServiceCodes', {
                  searchPrefix : query,
                  limit : 10,
                  modelId : modelId
              });
            	  }
              else
            	  {
            	  $scope.invalidRepairEndDate=true;
               	 $timeout(function(){
               		 $scope.invalidRepairEndDate=false;
               	      }, 3000);  
            	  }
          }
          else
      	{
      	$scope.invalidSerialNumber=true;
      	 $timeout(function(){
      		 $scope.invalidSerialNumber=false;
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
          if (item.id != undefined && $scope.fleetClaim.forItem !=null) {
        	  var date = angular.isString($scope.fleetClaim.repairEndDate) ? $scope.fleetClaim.repairEndDate : $scope.fleetClaim.repairEndDate.getMonth() + 1 + '/' + $scope.fleetClaim.repairEndDate.getDate() + '/' + $scope.fleetClaim.repairEndDate.getFullYear();
              $util
                      .httpGet(
                              'findFlatRateAndStandardHours',
                              {
                            	  serviceCodeDefinitionId : item.id,
                            	  itemGroupId : $scope.fleetClaim.forItem.product!=null?$scope.fleetClaim.forItem.product.id:null,
                            	  dealerId:	$scope.fleetClaim.forDealer.id,
                            	  date: date,
                            	  customerCurrency:$scope.fleetClaim.forItem.preferredCurrency
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
      
      $scope.populateLaborDetails = function() {
          if($scope.activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail.length == 0){
              angular.forEach($scope.laborMultipliers, function(laborMultiplier) {
               var item={};
                    item['overTimeLaborMultiplier']=laborMultiplier.laborMultiplier;
                    item['overTimeLaborHours']='';
                    item['overTimeMultiplierValue']=laborMultiplier.overTimeMultiplierValue;
                    item['reasonForOverTimeLaborHours']='';
                    $scope.activeAudit.serviceInformation.serviceDetail.laborMultiplierDetail.push(item);
                        });
        }
      }
      
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
      
      $scope.close = function() {
          $scope.openUploadDocWindow = false;
          $scope.failedDocuments = [];
      };
      
      $scope.isReadOnly = function() {
          return (document.getElementById('readOnly') && document.getElementById('readOnly').value === "true") ? true : false;
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
      
      $scope.submit = function() {
    	  asssignCustomerPONumber();
    	  compressData();
    	  appendAudit();
          $http.post('submitFleetClaim/', JSON.stringify($scope.fleetClaim)).success(function(data) {
              $scope.successForm = (data.successMessage) ? true : false;
              if ($scope.successForm) {
            	  $scope.form.$dirty = false;
                  $scope.validateForm = false;
              } else if(data.failureMessage) {
                $scope.populateFailureMessage(data);                                
              } else {
                  $scope.validateForm = true;
              }
          });
      };

      $scope.validateClaim = function(takenTransition) {
    	  asssignCustomerPONumber();
    	  compressData();
    	  appendAudit();
          if (takenTransition) {
              $scope.task.takenTransition = takenTransition;
              $scope.fleetClaim.takenTransition = takenTransition;
          }
          if($scope.task && $scope.task.takenTransition){
        	  $scope.fleetClaim.takenTransition = $scope.task.takenTransition;
          }
          $scope.activeAudit.flatRate= $scope.isFlatRate;
          $http.post('validateFleetClaim/', JSON.stringify($scope.fleetClaim)).success(function(data) {
        	  if(data.failureMessage) {
                $scope.populateFailureMessage(data);                                
              } else{
        	  if($scope.task && $scope.task.fleetClaim){
        	  $scope.task.fleetClaim = data.target;
        	  }
        	  $scope.fleetClaim=data.target;
        	  $scope.activeAudit = data.target.activeFleetClaimAudit;
        	  $scope.showSRDropdown = data.target.forServiceRequest ? false : true; 
        	  $scope.isSRAutoBoxEdit();
        	/*  $scope.isInternalUserOrOwningDealer=data.target.internalUserOrOwningDealer;
        	  $scope.isCustomerUser=data.target.customerUser;
        	  $scope.servicingDealer=data.target.servicingDealer;*/
        	  $scope.isEntryValidationCheck = true;
              $scope.validateForm = true;
              $scope.fleetClaimForm = false;
              $scope.validation = (data.errors.length > 0) ? false : true;
              if ($scope.validation) {
                  $scope.isFlatRate = $scope.activeAudit.flatRate;
              }
            }
          });
      };
      
      $scope.cloneAsFleetClaim = function()
      {
    	  var thisTabLabel = getMyTabLabel();  
    	  parent.publishEvent("/tab/open", {
    		  label : i18N.clonedFleetClaim,
              url : "cloneFleetClaim?fleetClaimCloneId=" + $scope.fleetClaim.id,
              decendentOf : thisTabLabel,
              forceNewTab : true
          });
    	  
      };
      
      $scope.cloneAsWarrantyClaim = function()
      {

    	  
    	  $http.post('generateWarrantyClaim/', JSON.stringify($scope.fleetClaim.id)).success(
  				function(data) {
  					 $scope.isEntryValidationCheck = false;
  				});
    	  
      };
       
      $scope.refreshPayment = function() {
      	compressData();                        
          $scope.activeAudit.flatRate= $scope.isFlatRate;
          $http.post('refreshClaimPayment/', JSON.stringify($scope.fleetClaim)).success(function(data) {
        	 	data.errors = data.fleetClaim.errors;
                data.fleetClaim = data.fleetClaim.target;
              if (data.originalResponse) {
                  data = data.originalResponse;
              }
              if($scope.task && $scope.task.fleetClaim){
              	$scope.task.fleetClaim = data.fleetClaim;
              }
              $scope.fleetClaim = data.fleetClaim;    
              $scope.isApproveTransfer = data.isApproveTransfer;
              $scope.isApprove = data.isApprove;
              $scope.validation = (data.errors.length > 0) ? false : true;
              if ($scope.validation) {
                  $scope.activeAudit = data.fleetClaim.activeFleetClaimAudit;
                  $scope.isFlatRate = $scope.activeAudit.flatRate;
              }
          });
      };
      
      $scope.edit = function() {
          $scope.validateForm = false;
          $scope.fleetClaimForm = true;
          //To preserve multi select values
          $scope.preserveMultiSelectLovValues();
      };
      
      $scope.save = function(form) {
    	  asssignCustomerPONumber();
    	  compressData();
    	  appendAudit();
    	  claimFactory.saveFleetClaim($scope);
      };
      
      $scope.deleteDraftFleetClaim = function(form) {
    	  compressData();
    	  appendAudit();
    	  claimFactory.deleteDraftFleetClaim($scope);
      };
      
      $scope.serviceRequestDetail = function() {
          var thisTabLabel = getMyTabLabel();
          parent.publishEvent("/tab/open", {
              label : i18N.serviceRequest,
              url : "serviceRequestpage.action?serviceRequestId=" + $scope.fleetClaim.forServiceRequest.id,
              decendentOf : thisTabLabel,
              forceNewTab : true
          });
      };
      $scope.removeInternalUser=function(){
    	  $scope.internalUserName="";
      };
      
      $scope.removeAdvisorUser=function(){
    	  $scope.advisorUserName="";
      };
      if($scope.isReadOnly()==false || $scope.isDocType() == true)
    	  {
      $util.httpGet("findAllLovs",{},function(data){
    	  $scope.dealerFailures = data.dealerFailures;
    	  $scope.fleetClaimRejectionReasons=data.fleetClaimRejectionReasons;
    		  $scope.fleetClaimAcceptanceReasons=data.fleetClaimAcceptanceReasons;
    		  $scope.reviewResponsibilities = data.reviewResponsibilities;
    		  $scope.docTypes = data.documentTypes;
    		  $scope.componentCodes = data.componentCodes;
    	  });
    	}
      
      $scope.removeDenyReason=function(){
    	  if($scope.task!=undefined)
    		  {
    	  $scope.activeAudit.fleetClaimRejectionReason=emptyDenyReason;
    		  }
      };
      
      $scope.removeAcceptReason=function(){
    	  if($scope.task!=undefined)
    		  {
    		  $scope.activeAudit.fleetClaimAcceptanceReason=emptyDenyReason;  
    		  }
      };
      
      
      $scope.processClaim = function(takenTransition) {
    	  asssignCustomerPONumber();
    	  compressData();
    	  appendAudit();
          if (takenTransition) {
              $scope.task.takenTransition = takenTransition;
          }
          if ($scope.AdvisorUserName && $scope.task.takenTransition == 'Transfer') {
              $scope.task.transferTo = $scope.AdvisorUserName;
          }
          
          if ($scope.internalUserName && $scope.task.takenTransition == 'Request FSS Advice') {
              $scope.task.transferTo = $scope.internalUserName;
          }
          $http.post('processClaim/', JSON.stringify($scope.task)).success(function(data) {
              $scope.successForm = (data.successMessage) ? true : false;
              if ($scope.successForm) {
            	  $scope.form.$dirty = false;
                  $scope.validateForm = false;
              } else if(data.failureMessage) {
                $scope.populateFailureMessage(data);                                
              } else {
            	  $scope.validateForm = true;
              }
          });
      };
      
      $scope.reopenFleetClaim = function(takenTransition) {
    	  compressData();
    	  appendAudit();
          if (takenTransition) {
              $scope.task.takenTransition = takenTransition;
              $http.post('reopenFleetClaim/', JSON.stringify($scope.task)).success(function(data) {
                  window.location = 'fleetClaim_detail?folderName=In Progress&id=' + data;
              });
          }
      };
          
	  $scope.closeWarrantyWarningMessage = function() {
	      $scope.showWarrantyWarningMessage = false;
	  };
	  
          
          $scope.navigateToCreateContractPage = function(){
        	  var thisTabLabel = getMyTabLabel();
              parent.publishEvent("/tab/open", {
                  label : i18N.contractCode,
                  url : "contract_detail_Read_Only?id=" + $scope.contractId,
                  decendentOf : thisTabLabel,
                  forceNewTab : true
              });
          
          };
          
          
         
          
          $scope.$watch('fleetClaim.forDealer.id', function(newVal, oldVal) {
              if (newVal) {
            	  if($scope.isReadOnly()==false)
            		  {
                      $http({
                          method : 'GET',
                          url : 'findTechniciansForDealer',
                          params : {
                              id : newVal
                          }
                      }).success(function(data) {
                          $scope.technicians = data.items;
                      });
              }
              }
          });
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
          	 }
           }
          });
          }
          
          $scope.gridForFleetClaimAudits = {
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
                      width : '9%'
                  }, {
                      field : 'login',
                      displayName : i18N.user,
                      width : '10%'
                  }, {
                      field : 'userType',
                      displayName : i18N.userType,
                      width : '9%'
                  }, {
                      field : 'NMHG',
                      displayName : i18N.notesForNMHG,
                      width : '10%'
                  }, {
                      field : 'dealer',
                      displayName : i18N.notesForDealer,
                      width : '10%'
                  }, {
                	  field : 'customer',
                      displayName : i18N.notesForCustomer,
                      width : '13%'
                  },{
                      field : 'internalComments',
                      displayName : i18N.internalComments,
                      width : '13%'
                  }, {
                	  field : 'decision',
                      displayName : i18N.decision, 
                      width : '15%'
                  }],
                  plugins : [ new ngGridFlexibleHeightPlugin() ]
              };
          
         
          
          $scope.fleetClaimAudit = function(items) {
              var id = items[0].id;
              var url = "getFleetClaimAudit.action?id="+ id+"&folderName="+$scope.folderName;
              var thisTabLabel = getMyTabLabel();
              parent.publishEvent("/tab/open", {
                  label : i18N.claimHistory,
                  url : url,
                  decendentOf : thisTabLabel,
                  forceNewTab : true
              });
          };

          var selectedAuditId = document.getElementById('selectedAuditId').value;
          if (selectedAuditId) {
              $scope.selectedId = true;
              $util.httpGet('getFleetClaimAuditDetail', {
                  id : selectedAuditId
              }, function(data) {
                  if(data.originalResponse)
                  {
                      data=data.originalResponse;
                  }
                  $scope.initAudit(data);
                  $scope.dealerThreshold = data.dealerThreshold;
                  $scope.laborMultipliers = data.laborMultipliers;
                  if(data.fleetClaim.forServiceRequest != null){
                 	 if(data.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber != null){
                 		 $scope.activeAudit.customerPoNumber = data.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber;
                 	 }
                  }
                  $scope.populateLaborDetails();
                  if($scope.servicingDealer || (!$scope.isInternalUserOrOwningDealer)) {
                  	$scope.findCallTypeAssociated($scope.activeAudit.callType);
                  }
               });
          }
          
          $scope.initAudit = function(data) {
        	  $scope.quoteNumber=data.quoteNumber;
        	  $scope.isInternalUserOrOwningDealer = data.isInternalUserOrOwningDealer;
         	  $scope.isCustomerUser=data.isCustomerUser;
         	  $scope.servicingDealer=data.isServicingDealer;
         	 $scope.loggedInUserType=data.loggedInUserType;
              $scope.fleetClaim = data.fleetClaim;
              $scope.equipment=data.fleetClaim.forItem;
              $scope.preferredCurrency=data.fleetClaim.forItem.preferredCurrency;
              $scope.audits = data.fleetClaimAudits;
              $scope.hideGridValueBasedOnUserType(data.fleetClaimAudits,data);
              $scope.isFlatRate = data.fleetClaimAudit.flatRate;
              $scope.activeAudit = data.fleetClaimAudit;
              $scope.isContractManagement = data.isContractManagement;
              if(data.contractId)
              $scope.contractId = data.contractId;
              $scope.customerName=data.customerLocation.customerName;
              $scope.customerNumber=data.fleetClaim.customerNumber;
              $scope.locationsMapkey=data.customerLocation.locationsMapkey;
              customerId=data.customerLocation.customer.id;
              $scope.customerId=data.customerLocation.customer.id;
              customerLocationId=data.customerLocation.id;
              $scope.customerLocationId=data.customerLocation.id;
              $scope.applicableTravelMatrix = data.travelMatrix;
              prepareFaultFoundList($scope.fleetClaim.forItem.id);
              $scope.applicableCostCategoriesList = data.applicableCostCategoriesList;
    		  $scope.isTaxSectionVisible=data.isTaxSectionVisible;
        
              if (data.isUserCustomer) {
                  $scope.audits.splice(0, ($scope.audits.length - 1));
              }
             
              if (data.fleetClaimAudit.serviceInformation.faultFound
                      && data.fleetClaimAudit.serviceInformation.faultFound.id) {
                  $scope.listCausedBy(data.fleetClaimAudit.serviceInformation.faultFound.id,
                          data.fleetClaim.forItem.id);
              }
              $scope.maintenanceType=$scope.fleetClaim.forItem.maintenanceType; 
              $scope.noOfTrips=data.numbeOfTrips;
              $scope.moduleId = data.moduleId;
    		  $scope.serviceDealerAddress=getLocationAddress(data.serviceDealerAddress);                                    
              $scope.customerAddress=getLocationAddress(data.customerAddress);
              if(data.isInternalUserOrOwningDealer)
              {
             $scope.isCallTypePlanned=data.isCallTypePlanned;
              }
              
              $scope.hideAuditHistoryColumnsForDealer();
              
          }
          
          $scope.PONumberRequiredOrNot = function (purchaseOrderRequired) {
              if (purchaseOrderRequired) {
                  $scope.PONumberrequiredOrNot = true;
              } else {
                  $scope.PONumberrequiredOrNot = false;
              }
          };
          
          function disableEnablePONumber() {
              if ($scope.fleetClaim.forServiceRequest == null || $scope.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber == null) {
                  $scope.readAndEditPO = false;
              } else {
                  $scope.readAndEditPO = true;
              }
          };
          $scope.validatePONumber = function(newVal,customerLocationId,PORegExp,isPONumDuplicateAllowed) {
        	  if(newVal!=null && customerLocationId!=null && $scope.validateCustomerPoNumber !=newVal) {
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

        	 
        	    $scope.$watchCollection('[activeAudit.informationOnly,callTypes]', function(newVal, oldVal) {
                 if (newVal && $scope.activeAudit.callType && $scope.activeAudit.informationOnly==true) {
               	   if($scope.isInternalUserOrOwningDealer){
               			angular.forEach($scope.callTypes, function(callTypeObj) {
   	                         if(angular.uppercase(callTypeObj.listOfValues.code) == 'MNB') {
   	                         	 $scope.activeAudit.callType=callTypeObj.listOfValues;
   	                         }	
                           });
               		}else if($scope.servicingDealer){
               			 angular.forEach($scope.callTypes, function(callTypeObj) {
   	                      	  if(angular.uppercase(callTypeObj.listOfValues.code) == 'NORMAL REPAIR') {
   	                      		$scope.activeAudit.callType=callTypeObj.listOfValues;
   	                      	  }	
                           });
               		 }
               		$scope.isCalltypeDisabled=true;
                 }else{
           		  $scope.isCalltypeDisabled=false;
           	  }
             });
        	 
        	 $scope.preserveMultiSelectLovValues = function(){
        		 angular.forEach($scope.activeAudit.dealerFailure, function(dealerFailureObj) {
                	 angular.forEach($scope.dealerFailures, function(dealerFailureInside) {
                		 if(dealerFailureObj.id == dealerFailureInside.id) {
                			 $scope.activeAudit.dealerFailure.push(dealerFailureInside);
                		 }	
                     });
                 });
                 
                 angular.forEach($scope.activeAudit.fleetClaimRejectionReason, function(fleetClaimRejectionReasonObj) {
                	 angular.forEach($scope.fleetClaimRejectionReasons, function(fleetClaimRejectionReasonInside) {
                		 if(fleetClaimRejectionReasonObj.id == fleetClaimRejectionReasonInside.id) {
                			 $scope.activeAudit.fleetClaimRejectionReason.push(fleetClaimRejectionReasonInside);
                		 }	
                     });
                 });
                 
                 angular.forEach($scope.activeAudit.reviewResponsibility, function(reviewResponsibilityObj) {
                	 angular.forEach($scope.reviewResponsibilities, function(reviewResponsibilityInside) {
                		 if(reviewResponsibilityObj.id == reviewResponsibilityInside.id) {
                			 $scope.activeAudit.reviewResponsibility.push(reviewResponsibilityInside);
                		 }	
                     });
                 });
                 
                 angular.forEach($scope.activeAudit.fleetClaimAcceptanceReason, function(fleetClaimAcceptanceReasonObj) {
                	 angular.forEach($scope.fleetClaimAcceptanceReasons, function(fleetClaimAcceptanceReasonInide) {
                		 if(fleetClaimAcceptanceReasonObj.id == fleetClaimAcceptanceReasonInide.id) {
                			 $scope.activeAudit.fleetClaimAcceptanceReason.push(fleetClaimAcceptanceReasonInide);
                		 }	
                     });
                 });
        	 };
        	 


        	 
        	 $scope.printClaimSummary=function()
             {
             	 var thisTabLabel = getMyTabLabel();
                  parent.publishEvent("/tab/open", {
                 	 label: "Print Fleet Claim",
                      url: "printFleetClaim.action?fleetClaimId=" +$scope.fleetClaim.id,
                      decendentOf : thisTabLabel,
                      forceNewTab : true
                  });          	
             };
             
             $scope.navigateToequipmentHistoryPageDetailPage= function(){
                 if (angular.isUndefined($scope.fleetClaim.forItem.id)) {
                     return;
                 }
                 var url = "equipmentDetailsInfo.action?id=" + $scope.fleetClaim.forItem.id;
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
             
             fetchTravelDetails = function() {
		         if ($scope.fleetClaim.repairEndDate && $scope.fleetClaim.forItem && $scope.fleetClaim.forItem.serialNumber && $scope.fleetClaim.forServiceRequest == undefined) {			         
		        	 var date = angular.isString($scope.fleetClaim.repairEndDate) ? $scope.fleetClaim.repairEndDate : $scope.fleetClaim.repairEndDate.getMonth() + 1 + '/' + $scope.fleetClaim.repairEndDate.getDate() + '/' + $scope.fleetClaim.repairEndDate.getFullYear();
			                    $util.httpGet('findTravelMatrix', {
			                         id : $scope.fleetClaim.forItem.id,
			                         dealerName : $scope.fleetClaim.forDealer.name,
			                         dealerNumber : $scope.fleetClaim.forDealer.serviceProviderNumber,
			                         repairEndDate : date
			                     }, function(data) {
				                     if (data) {
					                    $scope.serviceDealerAddress = getLocationAddress(data.serviceDealerAddress);
					                    $scope.customerAddress = getLocationAddress(data.customerAddress);
					                    $scope.applicableTravelMatrix = data.travelMatrix;
				                      }
			                        })
		                        }
	          }
             
             
             $scope.$watchCollection('[isCallTypePlanned,applicableTravelMatrix]', function(newVal, oldVal) {       
                 if($scope.applicableTravelMatrix!=null && $scope.applicableTravelMatrix!=undefined && $scope.isCallTypePlanned!=null && $scope.isCallTypePlanned!=undefined ){
                    
                 $util
                 .httpGet(
                         'travelMatrixValue',
                         {
                         },
                         function(data) {
                             if ($scope.activeAudit.serviceInformation.serviceDetail.travelDetails === null)
                                 $scope.activeAudit.serviceInformation.serviceDetail.travelDetails = new Object();
                             
                             angular.forEach($scope.applicableTravelMatrix, function(travelMatrix) {
                                 if(travelMatrix.trip==$scope.isCallTypePlanned)
                                  {
                                  $scope.activeAudit.serviceInformation.serviceDetail.travelDetails.travelHours=(travelMatrix.milesPerTrip*data).toFixed(2);
                                  $scope.activeAudit.serviceInformation.serviceDetail.travelDetails.milesPerTrip=travelMatrix.milesPerTrip;                                                             
                                  
                                  }
                             });  

                         });
             }
             });
             
             
             
             $scope.$watchCollection('[fleetClaim.repairEndDate,applicableCostCategoriesList,fleetClaim.forItem]', function(newVal, oldVal) {       
                 if($scope.applicableCostCategoriesList!=null && $scope.applicableCostCategoriesList!=undefined && $scope.fleetClaim.repairEndDate!=null && $scope.fleetClaim.repairEndDate!=undefined && $scope.fleetClaim.forItem!=null && $scope.fleetClaim.forItem!=undefined){                    
                     
                     $scope.populateApplicableMiscLineItems($scope.fleetClaim.forDealer.id, $scope.fleetClaim.forItem!=undefined && $scope.customerId,
                             $scope.customerLocationId,$scope.fleetClaim.repairEndDate);
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

             $scope.$watch('fleetClaim.repairEndDate', function(newValue, oldNames) {
            	 if(newValue)
            		 {
            	 if(!$scope.isQuoteExist && $scope.fleetClaim.id==null && !$scope.isClonedClaim)
            		 {
     			$scope.activeAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled=[];	
     			$scope.activeAudit.serviceInformation.serviceDetail.oemPartsInstalled=[];
            		 }
            	/* $scope.populateApplicableMiscLineItems($scope.fleetClaim.forDealer.id, $scope.fleetClaim.forItem!=undefined && $scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.customer!=undefined?$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.customer.id:($scope.fleetClaim.forServiceRequest!=undefined?$scope.fleetClaim.forServiceRequest.customerLocation.customer.id:undefined),
                         $scope.fleetClaim.forItem!=undefined && $scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.id!=undefined?$scope.fleetClaim.forItem.activeFleetInventoryAudit.shipTo.id:($scope.fleetClaim.forServiceRequest!=undefined?$scope.fleetClaim.forServiceRequest.customerLocation.id:undefined));*/
            	 
            	 $scope.populateStandardServices(); 
            		 }
            	 
            	 
             });
             
            
             
             $scope.$watchCollection('[fleetClaim.repairEndDate,fleetClaim.forDealer]', function(newVal, oldValue){
            	 if($scope.fleetClaim && $scope.fleetClaim.forDealer && $scope.fleetClaim.repairEndDate)
            		 {
            		 fetchTravelDetails();
            		 }
            	 
             })
             
             $scope.isRequired=function()
             {
                 return (document.getElementById('additionalTravelHours').value >0)?true:false;                       
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
             	 var customerId = $scope.customerId;
             	 var customerName = encodeURIComponent($scope.customerName);
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
	           	  if($scope.customerId)
	           		  {
	           			enabled = true;
	           		  }
	           	  return enabled;
             };
             
             $scope.printPGS = function()
             {
             	 var thisTabLabel = getMyTabLabel();
             	 var dealerId = $scope.fleetClaim.forDealer.id;
             	 var dealerName = encodeURIComponent($scope.fleetClaim.forDealer.name);
             	 var customerId = $scope.customerId;
             	 var customerName = encodeURIComponent($scope.customerName);
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
	           	  if($scope.customerId)
	           		  {
	           		  if($scope.fleetClaim.forDealer)
	           			  {
	           			  	enabled = true;
	           			  }
	           		  }
	           	  return enabled;
             };
             
             appendAudit=function() {
            	 // When try to save calltype id is going empty value causinn BAD REQEST              	 
            	 if ($scope.activeAudit && $scope.activeAudit.callType && (!angular.isNumber($scope.activeAudit.callType.id))) {
            		 $scope.activeAudit.callType = null; 
            	 }
            	
				 if ($scope.task && $scope.task.fleetClaim) {
					   $scope.task.fleetClaim.activeFleetClaimAudit = $scope.activeAudit;
				 } else {
					$scope.fleetClaim.activeFleetClaimAudit = $scope.activeAudit;
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
    if(document.getElementById('serialNumberForclaim') && document.getElementById('serialNumberForclaim').value!="") {
   	 var serialNumberForclaim = document.getElementById('serialNumberForclaim').value;

		 $util.httpGet('getFleetInventoryItem', {
                id : serialNumberForclaim
            }, function(data) {                            
                $scope.fleetClaim.forItem=data.forItem;
                $scope.setInventoryItem($scope.fleetClaim.forItem);
            });  
    };
    $scope.showInclusions= function (index)
    {
    	if($scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].serviceCodeDefinition!=undefined)
    		{
    		 $util
             .httpGet(
                     'findInclusionsById',
                     {
                         serviceCodeDefinitionId : $scope.activeAudit.serviceInformation.serviceDetail.standaradServiceCodeDetails[index].serviceCodeDefinition.id,
                          dealerId:	$scope.fleetClaim.forDealer.id
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
    $scope.getSingleSelectOptions = function(index){
 	   return $scope.fleetClaim.claimAdditionalAttributes[index].attributes.singleSelectValues.split(";");
    };
    
    $scope.hideAuditHistoryColumnsForDealer = function (){
    	if($scope.servicingDealer || $scope.isCustomerUser) {
	      	if ( $scope.gridForFleetClaimAudits ) {
	               $scope.gridForFleetClaimAudits.columnDefs[7].visible = false;
	               $scope.gridForFleetClaimAudits.columnDefs[8].visible = false;
	        }
        }
    };
    
    $scope.isSRAutoBoxEdit = function(){
    	 if($scope.fleetClaim.forServiceRequest!=null && $scope.fleetClaim.forServiceRequest.id!=undefined && $scope.fleetClaim.activeFleetClaimAudit.fleetClaimState == 'DRAFT')
		 {
		 $scope.editSRAutoBox=true;
		 }
    	 else
    		 {
    		 $scope.editSRAutoBox=false; 
    		 }
    };
    
    $scope.unMapServiceRequest = function ()
    {
    	 $util.httpGet('removeServiceRequestMap',{claimId : $scope.fleetClaim.id},function(data) {
                	 if(data)
                		 {
                		 $scope.fleetClaim.version=data; 
                     $scope.fetchPendingServiceRequestList($scope.fleetClaim.forItem.id,$scope.fleetClaim.forDealer.id);
                	 $scope.editSRAutoBox=false;
                		 }
                 });
    	
    };
    asssignCustomerPONumber= function()
    {
    	 if($scope.activeAudit.customerPoNumber!=null &&  $scope.fleetClaim.forServiceRequest!=null && $scope.fleetClaim.forServiceRequest.activeServiceRequestAudit!=null)
		  { 
		  $scope.fleetClaim.forServiceRequest.activeServiceRequestAudit.customerPoNumber=$scope.activeAudit.customerPoNumber;
		  }
    	
    };
    $scope.populateFailureMessage = function(data){
        $scope.showErrorMessage = (data.failureMessage) ? true : false;
        $scope.fleetClaimForm = false;
    	$scope.form.$dirty = false;
    	$scope.validateForm = false;
    };
    
    $scope.associatingSR=function (newVal)
    {
    	$util.httpGetWithId('selectedServiceRequestDetailsForClaim', {
            serviceRequestId : newVal
		  	}, newVal, function(data) {
      	  if(data.originalResponse)
      		  {
      		  data=data.originalResponse;
      		  }
            $scope.fleetClaim.forServiceRequest = data.serviceRequest;
		  	 });
    };
    
    $scope.appealFleetClaim = function() {
    	var fleetClaimId=document.getElementById('searchFleetClaimId').value;
    	var notes;
    	if ($scope.isInternalUserOrOwningDealer) {
    		notes = $scope.activeAudit.internalComment;
    	} else {
    		notes = $scope.activeAudit.notesForNMHG;
    	}
    	window.location.href='appealFleetClaim?fleetClaimId='+fleetClaimId+'&notesForNMHG='+notes;
    }
    
    $scope.showQuoteDetail = function() {
    	if ($scope.quoteNumber) {
    		var thisTabLabel = getMyTabLabel();
    		parent.publishEvent("/tab/open", {
    			label : i18N.quoteNumber +" " + $scope.quoteNumber,
    			url : "quoteDetailPage?quoteNumber=" + $scope.quoteNumber,
    			decendentOf : thisTabLabel,
    			forceNewTab : true
    		});
    	}
    }
}]);