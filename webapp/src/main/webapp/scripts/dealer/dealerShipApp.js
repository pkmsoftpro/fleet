var dealerShipApp = angular.module('dealerShip',['ui.bootstrap','loadingIndicator']);


//MODEL
dealerShipApp.factory('dealerShipFactory',['$http', function($http) {
	var dealerShipService = {};

	dealerShipService.saveDealer = function(dealerShip){
		$http.post('dealershipcreate', JSON.stringify(dealerShip))
		.success(function(data) {

		}).error(function(data) {

		});
	};

	return dealerShipService;

}]);

//CONTROLLER
dealerShipApp.controller('DealerShipController',['$scope', '$http','dealerShipFactory', function ($scope, $http, dealerShipFactory) {
	$scope.masterdata = {};
	$scope.isForm = true;
	$scope.isError = false;
	
	$scope.populateFormFields = function() {
		$http.get('formfieldsreq/').success(function(data) {
			$scope.masterdata = data;
		});
	};

	$scope.populateDealerShip = function(id) {
		$http.get('dealershipshow/'+ id +'/').success(function(data) {
			$scope.dealerShip = data;
		});
	}
	
	var init = function () {
		$scope.populateFormFields();
		if ($scope.dealerShip.id) {
			$scope.populateDealerShip($scope.dealerShip.id);
		}
	};
	init(); //load all required data for the form


	
	// WATCHES
	$scope.$watch('dealerShip.address.country', function(newVal, oldVal) {
		if (!angular.isUndefined(newVal)) {
			$http({
                method : 'GET',
                url : 'listState/',
                params : {selectedCountry : newVal}
			}).success(function(data) {
				$scope.masterdata.states = data;
			}).error(function(data) {
				
			});
		}
	});
	
	
	
	// METHODS
	$scope.saveDealer = function () {
		$http.post('dealershipcreate', JSON.stringify($scope.dealerShip))
		.success(function(data) {
			$scope.isForm = false;			
			$scope.successMessage= data.successMessage;
			$scope.dealerShip=data.target;
		}).error(function(data) {
			
		});
	}
	
	$scope.cancel = function () {
		closeTab(getTabHavingLabel(getMyTabLabel()));
	}

}]);
