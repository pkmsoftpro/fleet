var flatrates = angular.module('priceConditionsApp', ['ui.bootstrap', 'textArea', 'autoCompleter','titlePane','moneyType','$util','loadingIndicator','isNumber','alertMsg']);
flatrates.controller('priceConditionController', ['$scope', '$http', '$parse', '$util', function ($scope, $http, $parse, $util) {
	load = function(){
		$scope.viewPriceModifier=false;
		 $http({
             method : 'GET',
             url : 'prepareDropDownListForPricing'
         }).success(function(data) {
         	    $scope.listOfConditionType=data.listConditionType;
				$scope.listSalesAreaCodes=data.listSalesAreaCodes;
				$scope.listMake=data.listMake;
				$scope.listMaterialCode=data.listMaterialCode;
				$scope.listUOM=data.listUOM;
				$scope.miscSubCodesList=data.miscSubCodesList;
				$scope.dateFormat=data.dateFormat;
         });
		 
		 $http({
             method : 'GET',
             url : 'listCallTypes'
         }).success(function(data) {
				$scope.listCallTypes=data;
         });

		if($scope.isCustomer){
		   $util.httpGet('customerPriceInfo', { id: $scope.customerPriceId }, function (data) {
				$scope.priceCondition = data;
				$scope.setSubCostCode($scope.priceCondition);
				$scope.lstViewChange($scope.priceCondition.materialCode);
		    });
		}else{
			if( $scope.dealerPriceId)
				{
			 $util.httpGet('dealerPriceInfo', { id: $scope.dealerPriceId }, function (data) {
					$scope.priceCondition = data.priceCondition;
					$scope.setSubCostCode($scope.priceCondition);
					$scope.setPriceModifier($scope.priceCondition.conditionType.modifier);
					$scope.lstViewChange($scope.priceCondition.materialCode);
					$scope.getCustomerLocation($scope.priceCondition.customerBillto.id);
			    });
		}
		}
	};
	load();
	$scope.setSubCostCode = function (value){
		if(value.materialCode=='PARTS' && value.subCodeItem.nonOemPart !=null)
			$scope.priceCondition.subCodeItem.subCostCode=$scope.priceCondition.subCodeItem.nonOemPart;
		else if(value.materialCode=='PARTS' && value.subCodeItem.itemReference !=null)	
			$scope.priceCondition.subCodeItem.subCostCode=$scope.priceCondition.subCodeItem.itemReference.number;
	};
	
	$scope.savePrice = function () {
    	$scope.priceCondition.type="DEALER";
    	 var conditionType = {};
    	 var customerLocation = {};
		 if ($scope.priceCondition && $scope.priceCondition.conditionType) {
			 conditionType['id'] = $scope.priceCondition.conditionType.id;
			 $scope.priceCondition.conditionType.id = {};
			 $scope.priceCondition.conditionType = conditionType;
 		}
		 if ($scope.priceCondition.customerLocation && $scope.priceCondition.customerLocation.id!=null) {
			 customerLocation['id'] = $scope.priceCondition.customerLocation.id;
			 $scope.priceCondition.customerLocation.id = {};
			 $scope.priceCondition.customerLocation = customerLocation;
 		}
    	if($scope.priceCondition.customerLocation!=null && $scope.priceCondition.customerLocation.id==null){
    	 	$scope.priceCondition.customerLocation=null;
    	}
    	if($scope.viewPriceModifier)
    		$scope.priceCondition.rate=null;
    	else
    		$scope.priceCondition.modifier=null;
    	var actionUrl = 'saveDealerPrice';
		 $http.post(actionUrl, JSON.stringify($scope.priceCondition)).success(function (data) {			
	        	if(data.successMessage){
	        		 $scope.alerts = [{ type: 'success', msg: data.successMessage}];
	        		 $scope.successPage=true;
	        	}
	        	else
	        		 $scope.alerts = [{ type: 'error', msg: data.errors}];
	         });
	        window.scrollTo(0,0);
	 };
	 
	 $scope.saveCustomerPrice = function () {
	    	$scope.priceCondition.type="CUSTOMER";
	    	 var conditionType = {};
	    	 var customerLocation = {};
			 if ($scope.priceCondition && $scope.priceCondition.conditionType) {
				 conditionType['id'] = $scope.priceCondition.conditionType.id;
				 $scope.priceCondition.conditionType.id = {};
				 $scope.priceCondition.conditionType = conditionType;
	 		}
			 if ($scope.priceCondition.customerLocation && $scope.priceCondition.customerLocation.id!=null) {
				 customerLocation['id'] = $scope.priceCondition.customerLocation.id;
				 $scope.priceCondition.customerLocation.id = {};
				 $scope.priceCondition.customerLocation = customerLocation;
	 		}
	    	if($scope.priceCondition.customerLocation!=null && $scope.priceCondition.customerLocation.id==null){
	    	 	$scope.priceCondition.customerLocation=null;
	    	}
	    	if($scope.viewPriceModifier)
	    		$scope.priceCondition.rate=null;
	    	else
	    		$scope.priceCondition.modifier=null;
	    	var actionUrl = 'saveCustomerPrice';
			 $http.post(actionUrl, JSON.stringify($scope.priceCondition)).success(function (data) {			
		        	if(data.successMessage){
		        		 $scope.alerts = [{ type: 'success', msg: data.successMessage}];
		        		 $scope.successPage=true;
		        	}
		        	else
		        		 $scope.alerts = [{ type: 'error', msg: data.errors}];
		         });
		        window.scrollTo(0,0);
		 };
	 
	 $scope.lstViewChange = function (value) {
		 $scope.showPartView=false;
		 $scope.showMiscView=false;
		 $scope.showNonOEMView=false;
		 $scope.showLaborView=false;
		 if(value.toString()=='PARTS'){
			 $scope.showPartView=true;
		     $scope.priceCondition.uom='EA';
		 }    
		 else if(value.toString()=='MISC'){
			 $scope.showMiscView=true;
		     $scope.priceCondition.uom='EA';
		 }else if(value.toString()=='LABOR'){
		     $scope.priceCondition.uom='HR';
		 }else if(value.toString()=='TRAVEL'){
			 $scope.priceCondition.uom='HR';
		 } 
	 };
	 $scope.setPriceType = function (value){
		 angular.forEach($scope.listOfConditionType, function(conditionType) {
        		 if(conditionType.id == value) {
        			 $scope.setPriceModifier(conditionType.modifier);
        		 }	
         });
	 };
	 $scope.setPriceModifier = function (value){
				$scope.viewPriceModifier=value;
	 };
	 $scope.getCustomerLocation = function(value){
		 $scope.locations=null;
		 if (+value && value.toString().length>2) {
	            $util.httpGet('getCustomerLocations', {
	                id : value
	            }, function(data) {
	            	if(data.customerBillTo!=null){
					  if ($scope.priceCondition.rate) {
						$scope.priceCondition.rate.currency = data.preferredCurrency;
					  }
	                $scope.locations = data.locations;
	                $scope.priceCondition.customerBillto=data.customerBillTo;
	            	}
	            });
	        } 
	 };
	 $scope.getModel = function(value){
		 if (+value && value.toString().length>2) {
	            $util.httpGet('generatModelDescription', {
	                id : value
	            }, function(data) {
	            	if(data){
	            	$scope.priceCondition.model.id=data.id;
	            	$scope.priceCondition.model.name=data.name;
	            	$scope.priceCondition.model.description = data.description;
	            	}
	            });
	    }
	 };
	 $scope.getDealer = function(value){
		 if (+value && value.toString().length>2) {
	            $util.httpGet('getDealerDetails', {
	                id : value
	            }, function(data) {
	            	if(data){
	            	$scope.priceCondition.dealer.id=data.id;
	            	$scope.priceCondition.dealer.name=data.name;
	            	}
	            });
	    }
	 };
	 
	 $scope.getCompetitorModel = function(value) {
             return $util.httpGetResponse('listCompetitorModels', {
                 searchPrefix : value
             });
     };

     $scope.setCompetitorModel = function(item) {
    	 $scope.priceCondition.competitorBrandModel = item;
     };
     
    /* $scope.isReadOnly = function() {
         return !($scope.isDealerOwned);
     };*/
}]);