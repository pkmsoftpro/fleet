var dealerprogramguidesummary = angular.module('dealerProgramGuideSummaryApp', ['ui.bootstrap', 'textArea', 'autoCompleter','titlePane', '$util','loadingIndicator', 'textAngular']);
dealerprogramguidesummary.controller('dealerProgramGuideSummaryController', ['$scope', '$http', '$parse', '$util', function ($scope, $http, $parse, $util) {
	  load = function() {
         if ($scope.dealerProgramGuideSummaryId) {
             $http({
                 method : 'GET',
                 url : 'dealerProgramGuideSummaryInfo',
                 params : {
                     id : $scope.dealerProgramGuideSummaryId
                 }
             }).success(function(data) {
                 $scope.dealerProgramGuideSummary = data.dealerProgramGuideSummary;
             });
         } 
     };
	 load();
	 
	 $scope.getDealer = function(value){
		 if (+value && value.toString().length>2) {
	            $util.httpGet('getDealerDetails', {
	                id : value
	            }, function(data) {
	            	$scope.dealer=data;
	            	if($scope.dealerProgramGuideSummary == undefined){
	                	$scope.dealerProgramGuideSummary = new Object();
	                }
	            	$scope.dealerProgramGuideSummary.dealer = data;
	            });
	    }
	 };
		 	
  	 $scope.getCustomerByName = function(value){ 
			 $scope.locations=null;
			 if (+value && value.toString().length>2) {
		            $util.httpGet('getCustomerByNumber', {
		                id : value
		            }, function(data) {
		            	$scope.fleetCustomer = data.fleetCustomer;
		            	if($scope.dealerProgramGuideSummary == undefined){
		                	$scope.dealerProgramGuideSummary = new Object();
		                }
		            	$scope.dealerProgramGuideSummary.customer = data.fleetCustomer;
		            });	
			   }   
		 	};
		 	
	$scope.saveDealerPGS = function () {
		       $http.post('saveDealerProgramGuideSummary', JSON.stringify($scope.dealerProgramGuideSummary)).success(function(data) {
		           $scope.dealerProgramGuideSummary = data.target;
		           if (data.successMessage) {
		               $scope.alerts = [ {
		                   type : 'success',
		                   msg : data.successMessage
		               } ];
		               $scope.sectionview = true;
		           } else{
		               $scope.alerts = [ {
		                   type : 'error',
		                   msg : data.errors
		               } ];
		           }   
		       });
		window.scrollTo(0, 0);
		};
		
	$scope.deleteDealerPGS = function () {
				 $http.post('deleteDealerProgramGuideSummary', JSON.stringify($scope.dealerProgramGuideSummary)).success(function(data) {
			           $scope.dealerProgramGuideSummary = data.target;
			           if (data.successMessage) {
			               $scope.alerts = [ {
			                   type : 'success',
			                   msg : data.successMessage
			               } ];
			               $scope.sectionview = true;
			           } else{
			               $scope.alerts = [ {
			                   type : 'error',
			                   msg : data.errors
			               } ];
			           }   
			       });
			window.scrollTo(0, 0);
	};
}]);