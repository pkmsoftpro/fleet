var invoiceApp = angular.module('createFleetClaim', [ 'ui.bootstrap','textArea', 'autoCompleter', 'titlePane', 'repeater','loadingIndicator','$util','numbersOnly' ])
invoiceApp.controller('InvoiceController', ['$scope', '$http', '$util', function($scope, $http, $util) {
	$scope.invoiceForm=true;
	$scope.successForm=false;
	$scope.successMessage;
	  
	  $scope.populateDuration = function(){
		 if($scope.customer.id)
			 {
			populateDurationForSelectedInvoiceType(); 
			 } 
	  };
	  
	  populateDurationForSelectedInvoiceType=function()
	  {
		  $util.httpGet('populateDuration_by_customerId', {
			  customerId : $scope.customer.id,
			  invoiceType: $scope.invoiceType
          }, function(data) {
              $scope.duration = data;
          });
	  }
	  
       $scope.generateInvoice = function(){
    	   $util.httpGet('generateInvoiceForCustomer', {
               customerId : $scope.customer.id,
               startDate : $scope.duration.startDate,
               tillDate : $scope.duration.tillDate,
               invoiceType:$scope.invoiceType
           }, function(data) {
        	
        	   if(data.successMessage)
        		   {
        		   $scope.successMessage=data.successMessage;
        		   $scope.invoiceForm=false;
        			$scope.successForm=true; 
        		   }
           
       });
       };
       
       $scope.cancel = function() {
         	closeTab(getTabHavingLabel(getMyTabLabel()));
         };
         
         load=function()
         {
        	  $util.httpGet('populate_invoice_types',{} ,function(data) {
              $scope.invoiceTypes=data;
          });
        	 
         };
         load();
         
         $scope.findCustomersWhoseNameStartingWith = function(query) {
        	 $scope.customer=null;
             $scope.duration=null;
             return $util.httpGetResponse('listCustomersBelongingToAnOrganization', {
                 searchPrefix : query,
                 limit : 10,
             });
            
     };
	  
	   $scope.setCustomer = function(item) {
       $scope.customer=item;
       if($scope.invoiceType)
    	   {
       populateDurationForSelectedInvoiceType();
    	   }
     };
}]);
