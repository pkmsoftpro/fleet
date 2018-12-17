var customerclaimdashboard = angular.module('customerClaimDashboardApp', ['ui.bootstrap', 'textArea', 'autoCompleter','titlePane', '$util','loadingIndicator', 'textAngular']);
customerclaimdashboard.controller('customerClaimDashboardController', ['$scope', '$http', '$parse', '$util', function ($scope, $http, $parse, $util) {
	  load = function() {
         if ($scope.customerClaimDashboardId) {
             $http({
                 method : 'GET',
                 url : 'customerClaimDashboardInfo',
                 params : {
                     id : $scope.customerClaimDashboardId
                 }
             }).success(function(data) {
                 $scope.customerClaimDashboard = data.customerClaimDashboard;
                 $scope.dateFormat=data.dateFormat;
             });
         } 
     };
	 load();
	 
	 $scope.equipmentHistoryPageDetail = function() {
         var thisTabLabel = getMyTabLabel();
         parent.publishEvent("/tab/open", {
             label :"Equiment History Details",
             url : "equipmentHistoryPage.action?equipmentHistoryId=" + $scope.customerClaimDashboard.forItemId,
             decendentOf : thisTabLabel,
             forceNewTab : true
         });
     };
     
     $scope.quoteDetail = function() {
         var thisTabLabel = getMyTabLabel();
         parent.publishEvent("/tab/open", {
             label :"Quote Details",
             url : "ServiceRequestQuoteDetail.action?id=" + $scope.customerClaimDashboard.quoteId,
             decendentOf : thisTabLabel,
             forceNewTab : true
         });
     };
     
     $scope.serviceRequestDetail = function() {
         var thisTabLabel = getMyTabLabel();
         parent.publishEvent("/tab/open", {
             label :"Service Request Details",
             url : "serviceRequestpage.action?serviceRequestId=" + $scope.customerClaimDashboard.serviceRequestId,
             decendentOf : thisTabLabel,
             forceNewTab : true
         });
     };
     
     $scope.claimDetail = function() {
         var thisTabLabel = getMyTabLabel();
         parent.publishEvent("/tab/open", {
             label :"Fleet Claim Details",
             url : "fleetClaimsDetail.action?id=" + $scope.customerClaimDashboard.claimId,
             decendentOf : thisTabLabel,
             forceNewTab : true
         });
     };
     
}]);