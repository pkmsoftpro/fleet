var manageservicecode = angular.module('inclusivescapp', ['ui.bootstrap', '$strap.directives','autoCompleter','titlePane','ngGrid','repeater','loadingIndicator', 'alertMsg', '$util','ui.event']);
manageservicecode.controller('InclusiveSCController', ['$scope', '$http', '$parse', '$util', function ($scope, $http, $parse, $util) {
	 $scope.saveInclusiveCode = function () {
		  var actionUrl = 'saveInclusionCodes';
	    	 $http.post(actionUrl, JSON.stringify($scope.serviceCodeDefinition)).success(function (data) {
	         });
	       window.scrollTo(0,0);
	    };
	    $scope.getServiceCodes = function(query) {
	             return $util.httpGetResponse('getServicecodes', {
	                  searchPrefix : query
	                });
	    };
	    $scope.setServiceCodeDefinition = function(item) {
	    	  $scope.form.serviceCodeDefinition.$setValidity('invalidParentCode',true);
	          $scope.serviceCodeDefinition = item;
	          $scope.loading=true;
	          $util.httpGet('getChildServicecodes', { id: item.id}, function (data) {
	        	  $scope.serviceCodeDefinition.inclusivesAudit =data;
			  });
	    };
	    
    	$scope.setChildServiceCode = function(scope,inx,value){
    		scope.subform.code.$setValidity('invalidChildCode',true);
    		$scope.serviceCodeDefinition.childCodes[inx] = value;
		};
		
		$scope.validate = function(){
			$scope.form.serviceCodeDefinition.$setValidity('invalidParentCode',false);
		};
		
		$scope.validateChildCode = function(scope, index){
			scope.subform.code.$setValidity('invalidChildCode',false);
		};
		
}]);