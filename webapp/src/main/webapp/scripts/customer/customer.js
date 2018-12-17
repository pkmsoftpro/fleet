var customer = angular.module('customers', [ 'ui.bootstrap', '$strap.directives', 'textArea', 'autoCompleter', 'titlePane', 'subSection', 'ngGrid', 'repeater','moneyType',
        'loadingIndicator', 'alertMsg', '$util','numbersOnly','popup' ])

customer.factory('customerFactory', ['$http', function($http) {
    var customerService = {};

    customerService.saveCustomer = function($scope, url, save) {
        $scope.customer.save = save;
        if ($scope.customer.customerBillTos == undefined || $scope.customer.customerBillTos.length == 0) {
            customerBillTO1 = new Object();
            customerBillTO1.status = "ACTIVE";
            customerBillTO1.primary = 1;
            customerBillTO1.customerNumber = $scope.delaerOwnedbillTo;
            $scope.customer.customerBillTos = [];
            $scope.customer.customerBillTos.push(customerBillTO1);
        }
        if (!save) {
            if ($scope.customer.status == "Active")
                $scope.customer.status = 'Inactive';
            else
                $scope.customer.status = 'Active';
        }
        $http.post(url, JSON.stringify($scope.customer)).success(function(data) {
            $scope.customer = data.target;
        });
    };

    return customerService;
}]);

customer.controller('customerController', ['$scope', '$http', '$parse', 'customerFactory', '$util', function($scope, $http, $parse, customerFactory, $util) {
    var submitForm=false;
    $scope.monthsList = [ "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" ];
    load = function() {
        var customerId = document.getElementById('customerId').value;
        $scope.customerId = customerId;
        if(customerId)
        {
        $http({
            method : 'GET',
            url : 'customerInfo',
            params : {
                id : customerId
            }
        }).success(function(data) {
            $scope.customer = data.customer;        
            $scope.contacts = data.contacts;
            $scope.fleetManagerList = data.fleetManagerList;
            $scope.fleetCoordinatorList = data.fleetCoordinatorList;
            $scope.operationsManagersList = data.operationsManagersList;
            $scope.customerLOAUsersList = data.customerLOAUsersList;            
            
            
            if($scope.customer.customerLoaScheme != null) { //setting the CUSTOMER LOA SCHEME values
            	angular.forEach($scope.customer.customerLoaScheme.loaLevels, function(loaLevelObj, key) {
            		if(loaLevelObj.loaLevel == 1) {
            			$scope.customerLOAUserLevelOne = loaLevelObj.loaUser;
            			$scope.customerLOALevelOneMoney = loaLevelObj.approvalLimits[0]; 
            		} else if(loaLevelObj.loaLevel == 2) {
            			$scope.customerLOAUserLevelTwo = loaLevelObj.loaUser;
            			$scope.customerLOALevelTwoMoney = loaLevelObj.approvalLimits[0];
            		} else if(loaLevelObj.loaLevel == 3) {
            			$scope.customerLOAUserLevelThree = loaLevelObj.loaUser;
            			$scope.customerLOALevelThreeMoney = loaLevelObj.approvalLimits[0];
            		}
            	});
            }
            
            if($scope.customer.nmhgLoaScheme != null) { // setting the NMHG LOA SCHEME values
                angular.forEach($scope.customer.nmhgLoaScheme.loaLevels, function(loaLevelObj, key) {
                    if(loaLevelObj.loaLevel == 1) {
                        $scope.fssMoney = loaLevelObj.approvalLimits[0]; 
                    } else if(loaLevelObj.loaLevel == 2) {
                        $scope.fsmMoney = loaLevelObj.approvalLimits[0];
                    } else if(loaLevelObj.loaLevel == 3) {
                        $scope.omMoney = loaLevelObj.approvalLimits[0];
                    }
                });
            }
                
            if($scope.customer.claimLoaScheme != null) { //setting the CUSTOMER LOA SCHEME values
                angular.forEach($scope.customer.claimLoaScheme.loaLevels, function(loaLevelObj, key) {
                    if(loaLevelObj.loaLevel == 1) {
                        $scope.claimLOAUserLevelOne = loaLevelObj.loaUser;
                        $scope.claimLOALevelOneMoney = loaLevelObj.approvalLimits[0]; 
                    } else if(loaLevelObj.loaLevel == 2) {
                        $scope.claimLOAUserLevelTwo = loaLevelObj.loaUser;
                        $scope.claimLOALevelTwoMoney = loaLevelObj.approvalLimits[0];
                    } else if(loaLevelObj.loaLevel == 3) {
                        $scope.claimLOAUserLevelThree = loaLevelObj.loaUser;
                        $scope.claimLOALevelThreeMoney = loaLevelObj.approvalLimits[0];
                    } else if (loaLevelObj.loaLevel == 4) {
                    	$scope.claimLOAUserLevelFour = loaLevelObj.loaUser;
                    	$scope.claimLOALevelFourMoney = loaLevelObj.approvalLimits[0];
                    } else if (loaLevelObj.loaLevel == 5) {
                    	$scope.claimLOAUserLevelFive = loaLevelObj.loaUser;
                    	$scope.claimLOALevelFiveMoney = loaLevelObj.approvalLimits[0];
                    }
                });
            }
        });
      }
    };
    
    $util.httpGet('customerParams', {}, function(data) {
        $scope.accountTypeList = data.AccountTypes;
        $scope.countries = data.countries;
        $scope.listInvoicingInterval = data.listInvoicingInterval;
        $scope.invoicingCurrenciesList = data.listInvoicingCurrencies;
        $scope.claimLOAUsersList = data.claimLOAUsersList;
        $scope.fleetServiceSpecialistList = data.fleetServiceSpecialistList;
        $scope.status = data.status;
    });
    
    load();

    $scope.$watch('customer.fiscalStartDate', function(newVal, oldVal) {
        if ($scope.customer) {
            if ($scope.customer.fiscalStartDate == $scope.monthsList[0]) {
                $scope.customer.fiscalEndDate = $scope.monthsList[$scope.monthsList.length - 1];
            } else {
                angular.forEach($scope.monthsList, function(month, key) {
                    if ($scope.customer.fiscalStartDate == month) {
                        $scope.customer.fiscalEndDate = $scope.monthsList[key - 1];
                    }
                });
            }
        }
    });

    $scope.$watch('customer.contractContact.completeNameAndLogin', function(newVal, oldVal) {
        if (angular.isNumber(newVal)) {
            $util.httpGet('listContractContactDetails', {
                id : newVal
            }, function(data) {
                $scope.customer.contractContact = data;

            })
        }

    });
    
    //validation for LOA amounts
    $scope.$watchCollection('[fsmMoney.amount,fssMoney.amount,omMoney.amount]', function(newVal, oldValue){
    	if(!($scope.fssMoney && $scope.fsmMoney && $scope.omMoney)) {
    		return;
    	}
    	var fssMoney = $scope.fssMoney.amount+'';
    	var fsmMoney = $scope.fsmMoney.amount+'';
    	var omMoney = $scope.omMoney.amount+'';
		var fssMoneyNum = parseFloat(fssMoney.replace(",",''));
		var fsmMoneyNum = parseFloat(fsmMoney.replace(",",''));
		var omMoneyNum = parseFloat(omMoney.replace(",",'')); 

		var isValid = true;
		if(fsmMoney && fssMoney=='') {
			isValid = false;
			$scope.form.fssMoney.$setValidity('require',false);
		} else if(omMoney && fsmMoney=='') {
			isValid = false;
			$scope.form.fsmMoney.$setValidity('require',false);
		}
    	if(fsmMoneyNum != 0 && fssMoneyNum >= fsmMoneyNum) {
    		isValid = false;
    		$scope.form.fsmMoney.$setValidity('greater',false);
    	} else if(omMoneyNum != 0 && fsmMoneyNum >= omMoneyNum) {
    		isValid = false;
    		$scope.form.omMoney.$setValidity('greater',false);
    	}
    	
    	if(isValid) {
    		$scope.form.fssMoney.$setValidity('require',true);
    		$scope.form.fsmMoney.$setValidity('require',true);
    		$scope.form.fsmMoney.$setValidity('greater',true);
    		$scope.form.omMoney.$setValidity('greater',true);
    	}
  
    });
    
    $scope.$watchCollection('[customerLOALevelTwoMoney.amount,customerLOALevelOneMoney.amount]', function(newVal, oldValue){
    	if($scope.customerLOALevelOneMoney && $scope.customerLOALevelTwoMoney) {
    		var customerLOALevelOneMoney = $scope.customerLOALevelOneMoney.amount;
    		var customerLOALevelTwoMoney = $scope.customerLOALevelTwoMoney.amount;
    		if(customerLOALevelOneMoney && customerLOALevelTwoMoney) {
    			var levelOneMoney = parseFloat(customerLOALevelOneMoney.replace(",",''));
    			var levelTwoMoney = parseFloat(customerLOALevelTwoMoney.replace(",",''));
    			if(levelTwoMoney < levelOneMoney) {
    				$scope.form.customerLOALevelTwoMoney.$setValidity('greater',false);
    			} else {
    				$scope.form.customerLOALevelTwoMoney.$setValidity('greater',true);
    			}
    		}
    	}
    });
    
    $scope.$watchCollection('[customerLOALevelThreeMoney.amount,customerLOALevelTwoMoney.amount]', function(newVal, oldValue){
    	if($scope.customerLOALevelTwoMoney && $scope.customerLOALevelThreeMoney) {
    		var customerLOALevelThreeMoney = $scope.customerLOALevelThreeMoney.amount;
    		var customerLOALevelTwoMoney = $scope.customerLOALevelTwoMoney.amount;
    		if(customerLOALevelThreeMoney && customerLOALevelTwoMoney) {
    			var levelThreeMoney = parseFloat(customerLOALevelThreeMoney.replace(",",''));
    			var levelTwoMoney = parseFloat(customerLOALevelTwoMoney.replace(",",''));
    			if(levelThreeMoney < levelTwoMoney) {
    				$scope.form.customerLOALevelThreeMoney.$setValidity('greater',false);
    			} else {
    				$scope.form.customerLOALevelThreeMoney.$setValidity('greater',true);
    			}
    		}
    	}
    });
        
    $scope.$watchCollection('[claimLOALevelTwoMoney.amount,claimLOALevelOneMoney.amount]', function(newVal, oldValue){
        if($scope.claimLOALevelOneMoney && $scope.claimLOALevelTwoMoney) {
            var claimLOALevelOneMoney = $scope.claimLOALevelOneMoney.amount;
            var claimLOALevelTwoMoney = $scope.claimLOALevelTwoMoney.amount;
            if(claimLOALevelOneMoney && claimLOALevelTwoMoney) {
                var levelOneMoney = parseFloat(claimLOALevelOneMoney.replace(",",''));
                var levelTwoMoney = parseFloat(claimLOALevelTwoMoney.replace(",",''));
                if(levelTwoMoney < levelOneMoney) {
                    $scope.form.claimLOALevelTwoMoney.$setValidity('greater',false);
                } else {
                    $scope.form.claimLOALevelTwoMoney.$setValidity('greater',true);
                }
            }
        }
    });
    
    $scope.$watchCollection('[claimLOALevelThreeMoney.amount,claimLOALevelTwoMoney.amount]', function(newVal, oldValue){
        if($scope.claimLOALevelTwoMoney && $scope.claimLOALevelThreeMoney) {
            var claimLOALevelThreeMoney = $scope.claimLOALevelThreeMoney.amount;
            var claimLOALevelTwoMoney = $scope.claimLOALevelTwoMoney.amount;
            if(claimLOALevelThreeMoney && claimLOALevelTwoMoney) {
                var levelThreeMoney = parseFloat(claimLOALevelThreeMoney.replace(",",''));
                var levelTwoMoney = parseFloat(claimLOALevelTwoMoney.replace(",",''));
                if(levelThreeMoney < levelTwoMoney) {
                    $scope.form.claimLOALevelThreeMoney.$setValidity('greater',false);
                } else {
                    $scope.form.claimLOALevelThreeMoney.$setValidity('greater',true);
                }
            }
        }
    });
    
    $scope.$watchCollection('[claimLOALevelFourMoney.amount,claimLOALevelThreeMoney.amount]', function(newVal, oldValue){
        if($scope.claimLOALevelThreeMoney && $scope.claimLOALevelFourMoney) {
            var claimLOALevelFourMoney = $scope.claimLOALevelFourMoney.amount;
            var claimLOALevelThreeMoney = $scope.claimLOALevelThreeMoney.amount;
            if(claimLOALevelThreeMoney && claimLOALevelFourMoney) {
                var levelFourMoney = parseFloat(claimLOALevelFourMoney.replace(",",''));
                var levelThreeMoney = parseFloat(claimLOALevelThreeMoney.replace(",",''));
                if(levelFourMoney <= levelThreeMoney) {
                    $scope.form.claimLOALevelFourMoney.$setValidity('greater',false);
                } else {
                    $scope.form.claimLOALevelFourMoney.$setValidity('greater',true);
                }
            }
        }
    });
    
    $scope.$watchCollection('[claimLOALevelFiveMoney.amount,claimLOALevelFourMoney.amount]', function(newVal, oldValue){
    	if($scope.claimLOALevelFiveMoney && $scope.claimLOALevelFiveMoney) {
    		var claimLOALevelFourMoney = $scope.claimLOALevelFourMoney.amount;
    		var claimLOALevelFiveMoney = $scope.claimLOALevelFiveMoney.amount;
    		if(claimLOALevelFiveMoney && claimLOALevelFourMoney) {
    			var levelFourMoney = parseFloat(claimLOALevelFourMoney.replace(",",''));
    			var levelFiveMoney = parseFloat(claimLOALevelFiveMoney.replace(",",''));
    			if(levelFiveMoney <= levelFourMoney) {
    				$scope.form.claimLOALevelFiveMoney.$setValidity('greater',false);
    			} else {
    				$scope.form.claimLOALevelFiveMoney.$setValidity('greater',true);
    			}
    		}
    	}
    });
    
    
    
    $scope.submit = function() {
        $scope.populateLOAs();
        $http.post('submitCustomerDetail/', JSON.stringify($scope.customer)).success(function(data) {
            $scope.submitForm = (data.successMessage) ? true : false;
        });
    };
    
    $scope.save = function(save) {
  		$scope.populateLOAs(); //populates the Authorities
        customerFactory.saveCustomer($scope, 'saveCustomer/', save);
    };
    
    
    $scope.populateLOAs = function () {
        if($scope.customerId)
        {
	    	if($scope.customerLOAUserLevelOne ||$scope.customerLOAUserLevelTwo || $scope.customerLOAUserLevelThree) {
	    		$scope.populateCustomerLOAs();
	    	}
        }
        if($scope.claimLOAUserLevelOne ||$scope.claimLOAUserLevelTwo || $scope.claimLOAUserLevelThree || $scope.claimLOAUserLevelFour || $scope.claimLOAUserLevelFive) {
            $scope.populateClaimLOAs();
        }
        $scope.populateNmhgLOAs();
    };
    
    $scope.populateNmhgLOAs = function () {
    	$scope.customer.nmhgLoaScheme = $scope.customer.nmhgLoaScheme == null ? $scope.nmhgLoaScheme : $scope.customer.nmhgLoaScheme;
    	$scope.customer.nmhgLoaScheme.loaLevels = [];
    	$scope.customer.nmhgLoaScheme.name=$scope.customer.name + " - NMHG LOA Scheme"
		if ($scope.customer.primaryFss && $scope.customer.primaryFss.id) {
    		$scope.customer.nmhgLoaScheme.loaLevels.push({name:"LOA-LEVEL",loaLevel:1,loaUser : {id: $scope.customer.primaryFss.id}, approvalLimits : [$scope.fssMoney]});
    	}
		if ($scope.customer.secondaryFss && $scope.customer.secondaryFss.id) {
			$scope.customer.nmhgLoaScheme.loaLevels.push({name:"LOA-LEVEL",loaLevel:1,loaUser : {id: $scope.customer.secondaryFss.id}, approvalLimits : [$scope.fssMoney]});
		}
		if ($scope.customer.tertiaryFss && $scope.customer.tertiaryFss.id) {
			$scope.customer.nmhgLoaScheme.loaLevels.push({name:"LOA-LEVEL",loaLevel:1,loaUser : {id: $scope.customer.tertiaryFss.id}, approvalLimits : [$scope.fssMoney]});
		}
		if ($scope.customer.fleetServiceManager && $scope.customer.fleetServiceManager.id) {
			$scope.customer.nmhgLoaScheme.loaLevels.push({name:"LOA-LEVEL",loaLevel:2,loaUser : {id: $scope.customer.fleetServiceManager.id}, approvalLimits : [$scope.fsmMoney]});
		}		
		if ($scope.customer.operationsManager && $scope.customer.operationsManager.id) {
			$scope.customer.nmhgLoaScheme.loaLevels.push({name:"LOA-LEVEL",loaLevel:3,loaUser : {id: $scope.customer.operationsManager.id}, approvalLimits : [$scope.omMoney]});
		}
    }
    
    $scope.populateCustomerLOAs = function () {
    	$scope.customer.customerLoaScheme = $scope.customer.customerLoaScheme == null ? $scope.customerLoaScheme : $scope.customer.customerLoaScheme;
    	$scope.customer.customerLoaScheme.loaLevels =  [] ;
    	$scope.customer.customerLoaScheme.name=$scope.customer.name + " - Customer LOA Scheme";
		if ($scope.customerLOAUserLevelOne && $scope.customerLOAUserLevelOne.id) {
			$scope.customer.customerLoaScheme.loaLevels.push({name:"LOA-CUST-LEVEL",loaLevel:1, loaUser : {id:$scope.customerLOAUserLevelOne.id}, approvalLimits : [$scope.customerLOALevelOneMoney]});
		}
		if ($scope.customerLOAUserLevelTwo && $scope.customerLOAUserLevelTwo.id) {
			$scope.customer.customerLoaScheme.loaLevels.push({name:"LOA-CUST-LEVEL",loaLevel:2,loaUser : {id:$scope.customerLOAUserLevelTwo.id}, approvalLimits : [$scope.customerLOALevelTwoMoney]});
		}
		if ($scope.customerLOAUserLevelThree && $scope.customerLOAUserLevelThree.id) {
			$scope.customer.customerLoaScheme.loaLevels.push({name:"LOA-CUST-LEVEL",loaLevel:3,loaUser : {id:$scope.customerLOAUserLevelThree.id}, approvalLimits : [$scope.customerLOALevelThreeMoney]});
		}
		
		if ($scope.customer.customerLoaScheme.loaLevels.length == 0) {
			$scope.customer.customerLoaScheme = null;
		}
    }
   
    $scope.filterCustomerLoaLevelOneUser = function() { //filter customers for level Two combo
    	var customerLOAOneUser = $scope.customerLOAUserLevelOne;
    	var cusotmerLOATwoUsers = new Array();
    	angular.forEach($scope.customerLOAUsersList, function(customerObj, key) {
    		if(customerLOAOneUser && customerLOAOneUser.id != customerObj.id) {
    			cusotmerLOATwoUsers.push(customerObj);
    		}
    	});
    	return cusotmerLOATwoUsers;
    }
    
    $scope.filterCustomerLoaLevelOneTwoUser = function() { //filter customers for level Three combo
    	var customerLOAOneUser = $scope.customerLOAUserLevelOne;
    	var customerLOATwoUser = $scope.customerLOAUserLevelTwo;
    	var cusotmerLOATwoUsers = new Array();
    	angular.forEach($scope.customerLOAUsersList, function(customerObj, key) {
    		if(customerLOAOneUser && customerLOATwoUser && !(customerLOAOneUser.id == customerObj.id || customerLOATwoUser.id == customerObj.id)) {
    			cusotmerLOATwoUsers.push(customerObj);
    		}
    	});
    	return cusotmerLOATwoUsers;
    }
    
    $scope.populateClaimLOAs = function () {
        $scope.customer.claimLoaScheme = $scope.customer.claimLoaScheme == null ? $scope.claimLoaScheme : $scope.customer.claimLoaScheme;
        $scope.customer.claimLoaScheme.loaLevels =  [] ;
        $scope.customer.claimLoaScheme.name=$scope.customer.name + " - Claim LOA Scheme"
        if ($scope.claimLOAUserLevelOne) {
            $scope.customer.claimLoaScheme.loaLevels.push({name:"LOA-CLAIM-LEVEL",loaLevel:1, loaUser : {id:$scope.claimLOAUserLevelOne.id}, approvalLimits : [$scope.claimLOALevelOneMoney]});
        }
        if ($scope.claimLOAUserLevelTwo) {
            $scope.customer.claimLoaScheme.loaLevels.push({name:"LOA-CLAIM-LEVEL",loaLevel:2,loaUser : {id:$scope.claimLOAUserLevelTwo.id}, approvalLimits : [$scope.claimLOALevelTwoMoney]});
        }
        if ($scope.claimLOAUserLevelThree) {
            $scope.customer.claimLoaScheme.loaLevels.push({name:"LOA-CLAIM-LEVEL",loaLevel:3,loaUser : {id:$scope.claimLOAUserLevelThree.id}, approvalLimits : [$scope.claimLOALevelThreeMoney]});
        } 
        if ($scope.claimLOAUserLevelFour) {
        	$scope.customer.claimLoaScheme.loaLevels.push({name:"LOA-CLAIM-LEVEL",loaLevel:4,loaUser : {id:$scope.claimLOAUserLevelFour.id}, approvalLimits : [$scope.claimLOALevelFourMoney]});
        }
        if ($scope.claimLOAUserLevelFive) {
        	$scope.customer.claimLoaScheme.loaLevels.push({name:"LOA-CLAIM-LEVEL",loaLevel:5,loaUser : {id:$scope.claimLOAUserLevelFive.id}, approvalLimits : [$scope.claimLOALevelFiveMoney]});
        }
    }
    
    $scope.filterClaimLoaLevelOneUser = function() { //filter service Writers for level Two combo
        var claimLOAOneUser = $scope.claimLOAUserLevelOne;
        var claimLOATwoUsers = new Array();
        angular.forEach($scope.claimLOAUsersList, function(claimObj, key) {
            if(claimLOAOneUser && claimLOAOneUser.id != claimObj.id) {
                claimLOATwoUsers.push(claimObj);
            }
        });
        return claimLOATwoUsers;
    }
    $scope.filterClaimLoaLevelOneTwoUser = function() { //filter service Writers for level Three combo
        var claimLOAOneUser = $scope.claimLOAUserLevelOne;
        var claimLOATwoUser = $scope.claimLOAUserLevelTwo;
        var claimLOATwoUsers = new Array();
        angular.forEach($scope.claimLOAUsersList, function(claimObj, key) {
            if(claimLOAOneUser && claimLOATwoUser && !(claimLOAOneUser.id == claimObj.id || claimLOATwoUser.id == claimObj.id)) {
                claimLOATwoUsers.push(claimObj);
            }
        });
        return claimLOATwoUsers;
    }
    $scope.filterClaimLoaLevelOneTwoThreeUser = function() { //filter service Writers for level four combo
        var claimLOAOneUser = $scope.claimLOAUserLevelOne;
        var claimLOATwoUser = $scope.claimLOAUserLevelTwo;
        var claimLOAThreeUser = $scope.claimLOAUserLevelThree;
        var claimLOAFourUsers = new Array();
        angular.forEach($scope.claimLOAUsersList, function(claimObj, key) {
            if(claimLOAOneUser && claimLOATwoUser && claimLOAThreeUser &&!(claimLOAOneUser.id == claimObj.id || claimLOATwoUser.id == claimObj.id || claimLOAThreeUser.id == claimObj.id)) {
            	claimLOAFourUsers.push(claimObj);
            }
        });
        return claimLOAFourUsers;
    }
    
    $scope.filterClaimLoaLevelOneTwoThreeFourUser = function() { //filter service Writers for level five combo
        var claimLOAOneUser = $scope.claimLOAUserLevelOne;
        var claimLOATwoUser = $scope.claimLOAUserLevelTwo;
        var claimLOAThreeUser = $scope.claimLOAUserLevelThree;
        var claimLOAFourUser = $scope.claimLOAUserLevelFour;
        var claimLOAFiveUsers = new Array();
        angular.forEach($scope.claimLOAUsersList, function(claimObj, key) {
            if(claimLOAOneUser && claimLOATwoUser && claimLOAThreeUser && claimLOAFourUser &&
            		!(claimLOAOneUser.id == claimObj.id || claimLOATwoUser.id == claimObj.id || claimLOAThreeUser.id == claimObj.id || claimLOAFourUser.id == claimObj.id)) {
            	claimLOAFiveUsers.push(claimObj);
            }
        });
        return claimLOAFiveUsers;
    }
    
    $scope.filterServiceManager = function () {
    	var levelOneUser = $scope.customer.primaryFss;
    	var levelTwoUsers = new Array();
    	angular.forEach($scope.fleetServiceSpecialistList, function(userObj, key) {
            if(levelOneUser && levelOneUser.id != userObj.id) {
                if($scope.customer.fleetServiceManager!=null && $scope.customer.fleetServiceManager.id==levelOneUser.id)
                {
                $scope.customer.fleetServiceManager=null;
                }
            	levelTwoUsers.push(userObj);
            }
        });
    	return levelTwoUsers;
    }
    
    $scope.filterOperationalManager = function () {
    	var levelOneUser = $scope.customer.primaryFss;
    	var levelTwoUser = $scope.customer.fleetServiceManager;
    	var levelThreeUsers = new Array();
    	angular.forEach($scope.fleetServiceSpecialistList, function(userObj, key) {
    	 if(levelOneUser!=null && levelTwoUser!=null)
    	     {
    	     if(levelOneUser.id!=userObj.id && levelTwoUser.id!=userObj.id)
    	         {
    	         levelThreeUsers.push(userObj)
    	         }
    	     }else
    	         {
    	         $scope.customer.operationsManager=null;
    	         }
        });
    	return levelThreeUsers;
    }

        $scope.gridForCustomerContacts = {
        data : 'contacts',
        multiSelect : false,
        enableColumnResize : true,
        enableColumnReordering : true,
        columnDefs : [ {
            field : 'firstName',
            displayName : 'First Name'
        }, {
            field : 'lastName',
            displayName : 'Last Name'
        }, {
            field : 'department',
            displayName : 'Department'
        }, {
            field : 'jobTitle',
            displayName : 'Title'
        }, {
            field : 'phone',
            displayName : 'Phone'
        }, {
            field : 'phoneExt',
            displayName : 'Phone Ext'
        }, {
            field : 'fax',
            displayName : 'Fax'
        }, {
            field : 'faxExt',
            displayName : 'Fax Ext'
        }, {
            field : 'email',
            displayName : 'Email'
        } ],
        plugins : [ new ngGridFlexibleHeightPlugin() ]
    };
    
    
    $scope.displaylocationDetails = function(id) {
        if (angular.isUndefined(id[0]) || id.length === 0) {
            return;
        }
        id = id[0].id;    
        var url = "customerLocation.action?id=" + id;
        var thisTabLabel = getMyTabLabel();
        parent.publishEvent("/tab/open", {
            label : "Customer Location",
            url : url,
            decendentOf : thisTabLabel,
            forceNewTab : true
        });
    }
    $scope.displayAllLocationDetails = function(customerId){
        if (angular.isUndefined(customerId) || customerId.length === 0) {
            return;
        }
        var url = "../validatePreDefinedCustomerLocationSearchFields.action?customerSearchCriteria.customer=" + customerId;
        var thisTabLabel = getMyTabLabel();
        parent.publishEvent("/tab/open", {
            label : "Customer Locations",
            url : url,
            decendentOf : thisTabLabel,
            forceNewTab : true
        });
      };

    $scope.closeAlert = function(index) {
        $scope.alerts.splice(index, 1);
    };
    
    $scope.disableValues = function() {
        if ($scope.customer) {
            if ($scope.customer.auditEnabled == false) {
                $scope.customer.auditFrequency = null;
            }
        }
    };

        $scope.totalServerItems = 0;
        $scope.pagingOptions = {
            pageSizes : [10,20,30],
            pageSize : 10,
            currentPage : 1
        };
        

        $scope.getPagedDataAsync = function (pageSize,currentPage) {
            if($scope.customerId)
                {
                    $http({
                        method : 'GET',
                        url : 'listingLocations',
                        params : {
                            pageNumber : currentPage,
                            pageSize : pageSize,
                            id : $scope.customerId
                        }
                    }).success(function(data) {
                       
                        $scope.totalServerItems = data.totalRecords;
                        $scope.locations = data.locations;                    });
                }
        };
        
        $scope.getPagedDataAsync($scope.pagingOptions.pageSize, $scope.pagingOptions.currentPage);
        

        $scope.$watch('pagingOptions', function(newVal, oldVal) {
            if (newVal !== oldVal || newVal.currentPage !== oldVal.currentPage) {
                $scope.getPagedDataAsync($scope.pagingOptions.pageSize, $scope.pagingOptions.currentPage);
            }
        }, true);
        
        $scope.mySelections = [];
        $scope.gridForCustomerLocations = {
                data : 'locations',
                selectedItems : $scope.mySelections,
                afterSelectionChange : function(selectedItems) {
                    $scope.displaylocationDetails($scope.mySelections);
                },
                multiSelect:false,
                enablePaging: true,
                enableColumnResize: true,
                enableColumnReordering : true,
                showFooter: true,
                totalServerItems: 'totalServerItems',
                pagingOptions: $scope.pagingOptions,
                columnDefs : [ {
                    field : 'code',
                    displayName : i18N.shipTo
                }, {
                    field : 'name',
                    displayName : i18N.locationName
                }, {
                    field : 'address.city',
                    displayName : i18N.city
                }, {
                    field : 'address.state',
                    displayName : i18N.state
                }, {
                    field : 'address.zipCode',
                    displayName : i18N.zip
                }, {
                    field : 'address.country',
                    displayName : i18N.country
                }, {
                    field : 'displayStatus',
                    displayName : i18N.status,
                } ]
            };
        

        $scope.$watch('customer.physicalAddress.country', function(newVal, oldVal) {
        if (newVal) {
            if (angular.isUndefined(customer.physicalAddress)) {
                $http({
                    method : 'GET',
                    url : 'listState',
                    params : {
                        selectedCountry : newVal
                    }
                }).success(function(data) {
                    $scope.states = data;
                });
            }
        }
    });
        
        $scope.$watch('customer.address.country', function(newVal, oldVal) {
            if (newVal) {
                if (angular.isUndefined(customer.address)) {
                    $http({
                        method : 'GET',
                        url : 'listState',
                        params : {
                            selectedCountry : newVal
                        }
                    }).success(function(data) {
                        $scope.billingStates = data;
                    });
                }
            }
        });
        
            
        $scope.closeEmergencyMessage = function() {
            $scope.showEmergencyMessage = false;
        };
        
        $scope.isReadOnly = function() {
            return !($scope.isDealerOwned);
        };
        
        $scope.printCustomerPGS = function()
        {
        	 var thisTabLabel = getMyTabLabel();
        	 var customerId = $scope.customer.id;
          	 var customerName = $scope.customer.name;
             parent.publishEvent("/tab/open", {
            	 label: "Customer Program Guide Summary",
                 url: "viewCustomerProgramGuideSummary?customerId="+customerId+"&customerName="+customerName,
                 decendentOf : thisTabLabel,
                 forceNewTab : true
             });  
        };
        
        
        $scope.isMandatory = function() {   
            if($scope.customer.address!=undefined)
            {
                if($scope.customer.address.city!=undefined||$scope.customer.address.state!=undefined||
                        $scope.customer.address.country!=undefined||$scope.customer.address.zipCode!=undefined||$scope.customer.address.addressLine1!=undefined)
                {
                return true
                }
            }
            return false;
        }

        $scope.displayAllCustomerContacts = function(customerId){
            if (angular.isUndefined(customerId) || customerId.length === 0) {
                return;
            }
            var url = "listAllCustomerContacts.action?id="+customerId+"&folderName='List Contacts'";
            var thisTabLabel = getMyTabLabel();
            parent.publishEvent("/tab/open", {
                label : "Customer Contacts",
                url : url,
                decendentOf : thisTabLabel,
                forceNewTab : true
            });
          };
}]);