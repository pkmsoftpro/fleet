var customerquotedashboard = angular.module('customerQuoteDashboardApp', ['ui.bootstrap', 'textArea', 'autoCompleter','titlePane', '$util','loadingIndicator', 'textAngular']);
customerquotedashboard.controller('customerQuoteDashboardController', ['$scope', '$http', '$parse', '$util', function ($scope, $http, $parse, $util) {
	  load = function() {
         if ($scope.customerQuoteDashboardId) {
             $http({
                 method : 'GET',
                 url : 'customerQuoteDashboardInfo',
                 params : {
                     id : $scope.customerQuoteDashboardId
                 }
             }).success(function(data) {
                 $scope.customerQuoteDashboard = data.customerQuoteDashboard;
                 $scope.dateFormat=data.dateFormat;
             });
         } 
     };
	 load();
	 
	 $scope.equipmentHistoryPageDetail = function() {
         var thisTabLabel = getMyTabLabel();
         parent.publishEvent("/tab/open", {
             label :"Equiment History Details",
             url : "equipmentHistoryPage.action?equipmentHistoryId=" + $scope.customerQuoteDashboard.forItemId,
             decendentOf : thisTabLabel,
             forceNewTab : true
         });
     };
     
     $scope.quoteDetail = function() {
         var thisTabLabel = getMyTabLabel();
         parent.publishEvent("/tab/open", {
             label :"Quote Details",
             url : "ServiceRequestQuoteDetail.action?id=" + $scope.customerQuoteDashboard.quoteId,
             decendentOf : thisTabLabel,
             forceNewTab : true
         });
     };
     
     $scope.serviceRequestDetail = function() {
         var thisTabLabel = getMyTabLabel();
         parent.publishEvent("/tab/open", {
             label :"Service Request Details",
             url : "serviceRequestpage.action?serviceRequestId=" + $scope.customerQuoteDashboard.serviceRequestId,
             decendentOf : thisTabLabel,
             forceNewTab : true
         });
     };
     
}]);