var periodicServiceApp = angular.module('periodicService', [ 'ui.bootstrap', 'textArea', 'autoCompleter', 'titlePane', 'moneyType',
                                                             'ngGrid', 'loadingIndicator', 'alertMsg', '$util', 'ui.event', 'angularFileUpload' ])

periodicServiceApp.controller('PeriodicServiceListingController', ['$scope', '$http', '$util',
        function($scope, $http, $util) {
            load = function() {
            	$scope.todayDate = new Date();
                var serviceCallId = document.getElementById('serviceCallId').value;
                var dateFormat=document.getElementById('dateFormat').value;
                if (serviceCallId) {
                    $util.httpGet('periodicServiceDetails', {
                        serviceCallId : serviceCallId
                    }, function(data) {
                    	if(data){
                        $scope.serviceCall = data.serviceCall;
                        $scope.frequency = data.frequency;
                        $scope.jobCodes = data.jobCodes;
                        $scope.serviceCallAuditHistory=data.serviceCall.serviceCallAudits;
                        $scope.serviceCall.comments='';
                        $scope.serviceCall.associatedServiceCode.lastServiceDate=data.isFirstSC?'':$scope.serviceCall.associatedServiceCode.lastServiceDate;
                        $scope.isReadOnly=data.isReadOnly;
                    	}
                    });                
                }
            };
            load();
            $scope.gridForServiceCallAudits = {
                    data : 'serviceCall.serviceCallAudits',
                    multiSelect : false,
                    sortInfo:{ fields: ['updatedTime'], directions: ['desc']},
                    columnDefs : [ {field : 'updatedTime',displayName : i18N.date, width: 200,cellFilter: "date:dateFormat"}, 
                                   {field : 'lastUpdatedByName',width: 200,displayName : i18N.user},
                                   {field : 'comments',width: 600,displayName : i18N.comments} 
                                 ],
                    plugins : [ new ngGridFlexibleHeightPlugin() ]
           };
            $scope.update = function() {
            	$http.post('updateServiceCall/', JSON.stringify($scope.serviceCall)).success(function(data) {
                    $scope.serviceCall = data.target;
                    $scope.serviceCall.comments='';
                    if (data.successMessage) {
                        $scope.alerts = [{
                            type : 'success', msg : data.successMessage
                        }];
                    } else{
                        $scope.alerts = [{
                            type : 'error',msg : data.errors
                        }];
                    }
                });
           };
           $scope.equipmenttDetail = function() {
               var thisTabLabel = getMyTabLabel();
               parent.publishEvent("/tab/open", {
                   label : $scope.serviceCall.associatedServiceCode.fleetInventoryItem.serialNumber,
                   url : "equipmentDetailsInfo.action?id=" + $scope.serviceCall.associatedServiceCode.fleetInventoryItem.id,
                   decendentOf : thisTabLabel,
                   forceNewTab : true
               });
           };
}]);