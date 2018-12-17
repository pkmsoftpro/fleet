var customerprogramguidesummary = angular.module('customerProgramGuideSummaryApp', ['ui.bootstrap', 'textArea', 'autoCompleter','titlePane', '$util','loadingIndicator', 'textAngular']);
customerprogramguidesummary.controller('customerProgramGuideSummaryController', ['$scope', '$http', '$parse', '$util', function ($scope, $http, $parse, $util) {
	  load = function() {
         if ($scope.customerProgramGuideSummaryId) {
             $http({
                 method : 'GET',
                 url : 'customerProgramGuideSummaryInfo',
                 params : {
                     id : $scope.customerProgramGuideSummaryId
                 }
             }).success(function(data) {
                 $scope.customerProgramGuideSummary = data.customerProgramGuideSummary;
             });
         } 
     };
	 load();
	 
	 $scope.getCustomerByName = function(value){ 
		 $scope.locations=null;
		 if (+value && value.toString().length>2) {
	            $util.httpGet('getCustomerByNumber', {
	                id : value
	            }, function(data) {
	                $scope.fleetCustomer = data.fleetCustomer;
	                if($scope.customerProgramGuideSummary == undefined){
	                	$scope.customerProgramGuideSummary = new Object();
	                }
	                $scope.customerProgramGuideSummary.customer = data.fleetCustomer;
	            });	
		   }   
	 	};
	 
	$scope.saveCustomerPGS = function () {
		       $http.post('saveCustomerProgramGuideSummary', JSON.stringify($scope.customerProgramGuideSummary)).success(function(data) {
		           $scope.customerProgramGuideSummary = data.target;
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
		
	$scope.deleteCustomerPGS = function () {
		 $http.post('deleteCustomerProgramGuideSummary', JSON.stringify($scope.customerProgramGuideSummary)).success(function(data) {
	         $scope.customerProgramGuideSummary = data.target;
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