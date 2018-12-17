var periodicServiceApp = angular.module('createMessage', [ 'ui.bootstrap', 'autoCompleter', 'textArea', 'ngGrid', 'loadingIndicator', 'alertMsg', '$util',
        'ui.event', 'angularFileUpload', 'textAngular', 'popup', 'repeater' ])
 periodicServiceApp.controller('messageController', ['$scope', '$http', '$modal', '$util', '$fileUploader',
                function($scope, $http, $modal, $util, $fileUploader) {
    $scope.emailAttachments = [];
    $scope.attachedIds = []; 
    
    load = function() {
        $scope.orightml = '<p>Please type the message here</p>';
        $scope.htmlcontent = $scope.orightml;        
    };
    $scope.disable=false;
    $scope.required=true;
    load();  
   
    $scope.cancel = function() {
        closeTab(getTabHavingLabel(getMyTabLabel()));
    };

    $scope.getDealerId = function(index,value) {
      if(angular.isNumber(value))
          {
          $scope.dealerArray[index].id=value;
          }
    };
    
    $scope.getCustomerId = function(index,value) {
        if(angular.isNumber(value))
            {
            $scope.customerArray[index].id=value;
            }
      };
    
    
    $scope.closeMessagesAndBulletin=function()
    {
        $scope.successMessage=false;
        closeTab(getTabHavingLabel(getMyTabLabel()));
    }

    $scope.save = function() {
        $scope.customerIds=new Array();
        $scope.dealerShipIds=new Array();
        
        angular.forEach($scope.customerArray, function(customer) {
            $scope.customerIds.push(customer.id);
        });
        angular.forEach($scope.dealerArray, function(dealerShip) {
            $scope.dealerShipIds.push(dealerShip.id);
        });    
        
        $util.httpGet('sendEmail', {
            subject : $scope.messagesBulletin.subject,
            dealerShipIds : $scope.dealerShipIds,
            customerIds : $scope.customerIds,
            attachedIds : $scope.attachedIds,
            message : $scope.htmlcontent        
        }, function(data) {
            if (data) {
                $scope.successMessage = true;
            }
        });

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

    $scope.uploadDocuments = function() {
        $scope.uploadCallback = {
            onComplete : function(doc) {
                $scope.emailAttachments.push(doc);
                $scope.attachedIds.push(doc.id);
            }
        }
        $scope.singleFileUpload = false;
        uploader.autoUpload = false;
        $scope.openUploadDocWindow = true;
    }
    $scope.deleteDocument = function(index) {
        $scope.emailAttachments.splice(index, 1);
    }
    $scope.close = function() {
        $scope.openUploadDocWindow = false;
    }

}]);