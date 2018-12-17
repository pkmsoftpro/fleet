var alertMsg = angular.module('alertMsg', []);
alertMsg.config(['$httpProvider',function($httpProvider){
    $httpProvider.interceptors.push('alertMsgInterceptor');
}]);
alertMsg.factory('alertMsgInterceptor',['$q', '$rootScope', function($q, $rootScope) {
    return {
        response: function (response) {
            if (response.config.method == 'POST') {
            	if (response.data.originalResponse) {
            		response.data=response.data.originalResponse;
                }
            	if(response.data.targetObject){
            		 if(response.data.isApproveTransfer){
            			 response.data.isApproveTransfer = data.isApproveTransfer;
            			 response.data.isApprove = data.isApprove;
                     }
            		response.data = response.data.targetObject;
            	}
                if (response.data.successMessage) {
                    $rootScope.successMessage = response.data.successMessage;
                    $rootScope.alerts = [
                        { type: 'success', msg: response.data.successMessage }
                    ];
                }
                else if (response.data.failureMessage) {
                    $rootScope.failureMessage = response.data.failureMessage;
                    $rootScope.alerts = [
                        { type: 'error', msg: response.data.failureMessage }
                    ];
                }
                else if ((response.data.warnings!=null&&response.data.errors!=null)&&(response.data.warnings.length > 0 || response.data.errors.length > 0)) {
                    $rootScope.alerts = [];
                    if (response.data.errors.length > 0) {
                        angular.forEach(response.data.errors, function(error) {
                            $rootScope.alerts.push({
                                type : 'error',
                                msg : error
                            });
                        });
                    }
                    if (response.data.warnings.length > 0) {
                        angular.forEach(response.data.warnings, function(warning) {
                            $rootScope.alerts.push({
                                type : 'success',
                                msg : warning
                            });
                        });
                    }
                } else {
                    $rootScope.alerts = [];
                }
                window.scrollTo(0, 0);
            }

           if (response.config.method == 'GET') {
            	if (response.data.originalResponse) {
            		response.data=response.data.originalResponse;
                }
            	if(response.data.targetObject){
            		 if(response.data.isApproveTransfer){
            			 response.data.isApproveTransfer = data.isApproveTransfer;
            			 response.data.isApprove = data.isApprove;
                     }
            		response.data = response.data.targetObject;
            	}
            }

            return response || $q.when(response);
        }
    };
}]);

alertMsg.directive('alertMsg', function() {
    return {
        restrict: 'A',
        template: '<div style="width: 100%"><div alert ng-repeat="alert in alerts" type="alert.type" close="closeAlert($index)">{{alert.msg}}</div></div>',
        replace: true
    };
});

var autoCompleter = angular.module('autoCompleter', [ 'ui.bootstrap', '$strap.directives' ]).config(['$locationProvider', function($locationProvider) {
	$locationProvider.hashPrefix('');
}]);
autoCompleter.directive('fbsTypeahead', ['$parse', function ($parse) {
	return {
		restrict: 'A',
		require: '?ngModel',
		link: function postLink(scope, element, attrs, controller) {

			element.on("keyup", function() { // adding key up event and checking required attribute and making invalid.
				var isRequired = attrs.required;
				if(element.val().length > 0) {
					controller.$setValidity('invalid', false);
					scope.$apply();
				} else if(!isRequired) {
					controller.$setValidity('invalid', true);
					scope.$apply();
				}
			});

			var timeout;
			var typeahead = element.typeahead({ // THIS IS THE LINK TO BOOTSTRAP.JS TYPEAHEAD. PLUG-IN
				source: function(query, callback) {
					var makeCall = function() { //function to make a call to back-end
							$.get(attrs.url, { searchPrefix: query, limit: 10 }, function(items) {
							retArray = jQuery.map(items.items, function(item){
								return JSON.stringify({
									label : item.label,
									key:item.key
								})
							})
							callback(retArray);
						});
					};

					if (timeout) {
		                clearTimeout(timeout); //clear time out
		            }
		            timeout = setTimeout(makeCall, 500); //call after 500ms
				},
				highlighter: function(item) {
					return JSON.parse(item).label;
				},
				matcher: function (item) {
					return ~(JSON.parse(item).label.toLowerCase().indexOf(this.query.toLowerCase()))
				},
				minLength: attrs.minLength || 3,
				url:attrs.url,
				items: attrs.items,
				updater: function (item) {
					if(controller) {
						scope.$apply(function () {
							controller.$setValidity('invalid', true);
							controller.$setViewValue(JSON.parse(item).key);
						});
					}
					return JSON.parse(item).label;
				}
			});
		}
	};
}
]);

var loadingIndicator = angular.module('loadingIndicator', []);
loadingIndicator.config(['$httpProvider',
                         function($httpProvider){
                                $httpProvider.interceptors.push('loadingIndicatorInterceptor');
                            }
                           ]
                        );
loadingIndicator.factory('loadingIndicatorInterceptor',['$q', 'loadingIndicatorHandler', function($q, loadingIndicatorHandler) {
    return {
        request: function(config) {
            loadingIndicatorHandler.enable();

            return config || $q.when(config);
        },
        response: function (response) {
            loadingIndicatorHandler.disable();

            return response || $q.when(response);
        },
        responseError: function (response) {
            loadingIndicatorHandler.disable();

            // Reject the response so that angular isn't waiting for a response.
            return $q.reject( response );
        }
    };
}]);

/**
 * loadingIndicatorHandler object to show a loading animation while we load the next page or wait
 * for a request to finish.
 */
loadingIndicator.factory('loadingIndicatorHandler', function() {
    // The element we want to show/hide.
    var $element = $('#loading-indicator');

    return {
        // Counters to keep track of how many requests are sent and to know
        // when to hide the loading element.
        enable_count: 0,
        disable_count: 0,

        /**
         * Fade the blocker in to block the screen.
         *
         * @return {void}
         */
        enable: function() {
            this.enable_count++;

            if ( $element.length ) $element.show();
        },

        /**
         * Fade the blocker out to unblock the screen.
         *
         * @return {void}
         */
        disable: function() {
            this.disable_count++;

            if ( this.enable_count == this.disable_count ) {
                if ( $element.length ) $element.hide();
            }
        }
    }
});

var moneyType = angular.module('moneyType', []);

String.prototype.splice = function(idx, rem, s) {
    return (this.slice(0, idx) + s + this.slice(idx + Math.abs(rem)));
};
moneyType.directive('money', function() {
    return {
        restrict: 'A',
        scope: {
            ngModel: '=',
            ngStyle: '@',
            disable:'=',
            ngRequired:'@',
            name : '@'
        },
        replace: true,
        template: '<span class="moneyLabel"><span class="currency-type">{{ngModel.currency}}</span><input type="text" name="{{name}}" ng-readonly="{{disable}}" ng-required="{{ngRequired}}" ng-model="ngModel.amount" ng-style="{{ngStyle}}" class="currency-amount"></input></span>',
        link: function(scope, element, attrs) {
        	scope.ngReadonly=attrs.ngReadonly;
        	scope.ngStyle=attrs.ngStyle;
            $(element).bind('keyup', function(e) {
                var input = element.find('input');
                var inputVal = input.val();

                //clearing left side zeros
                while (scope.ngModel.amount.charAt(0) == '0') {
                    scope.ngModel.amount = scope.ngModel.amount.substr(1);
                }

                scope.ngModel.amount = scope.ngModel.amount.replace(/[^-?0-9.]/g, '');

                var point = scope.ngModel.amount.indexOf(".");
                if (point >= 0) {
                    scope.ngModel.amount = scope.ngModel.amount.slice(0, point + 3);
                }


                var decimalSplit = scope.ngModel.amount.split(".");
                var intPart = decimalSplit[0];
                var decPart = decimalSplit[1];

                intPart = intPart.replace(/[^-?0-9.]/g, '');
				/*
                if (intPart.length > 3) {
                    var intDiv = Math.floor(intPart.length / 3);
                    while (intDiv > 0) {
                        var lastComma = intPart.indexOf(",");
                        if (lastComma < 0) {
                            lastComma = intPart.length;
                        }

                        if (lastComma - 3 > 0) {
                            intPart = intPart.splice(lastComma - 3, 0, ",");
                        }
                        intDiv--;
                    }
                }
				*/

                if (decPart === undefined) {
                    decPart = "";
                }
                else {
                    decPart = "." + decPart;
                }
                if(angular.equals("JPY",angular.uppercase(scope.ngModel.currency))){
                var res = intPart;
                }
                else{
                var res = intPart + decPart;
                }
                scope.$apply(function() {scope.ngModel.amount = res});

            });
            $(element).bind('focusout', function(e) {
                var decimalSplit = scope.ngModel.amount.split(".");
                var intPart = decimalSplit[0];
                var decPart = decimalSplit[1];

                if (decPart === undefined) {
                    decPart = ".00";
                }
                else {
                    decPart = "." + decPart;
                     if(decPart.length === 1) {
                        decPart = decPart + "00" ;
                      }
                     else if(decPart.length === 2) {
                         decPart = decPart + "0" ;
                      }
                      else {
                    	  decPart = decPart;
                      }

                }
                if(angular.equals("JPY",angular.uppercase(scope.ngModel.currency))){
                var res = intPart;
                }
                else{
                var res = intPart + decPart;
                }
                scope.$apply(function() {scope.ngModel.amount = res});

            });

        }
    };
});

angular.module('numbersOnly', []).directive('numbersOnly', function(){
   return {
     require: 'ngModel',
     link: function(scope, element, attrs, modelCtrl) {
       modelCtrl.$parsers.push(function (inputValue) {
           // this next if is necessary for when using ng-required on your input.
           // In such cases, when a letter is typed first, this parser will be called
           // again, and the 2nd time, the value will be undefined
           if (inputValue == undefined) return ''
           var transformedInput = inputValue.replace(/[^0-9]/g, '');
           if (transformedInput!=inputValue) {
              modelCtrl.$setViewValue(transformedInput);
              modelCtrl.$render();
           }

           return transformedInput;
       });
     }
   };
});

angular.module('isNumber', []).directive('isNumber', function () {
    return {
        require: 'ngModel',
        link: function (scope, element, attrs, modelCtrl) {
        	  modelCtrl.$parsers.push(function (inputValue) {
        		if (inputValue == undefined) return ''
                var arr = String(inputValue).split("");
                if (arr.length === 0) return;
                if (arr.length === 1 && (arr[0] == '-' || arr[0] === '.' )) return;
                if (arr.length === 2 && inputValue === '-.') return;
                if (isNaN(inputValue)) {
                	   var transformedInput = inputValue.replace(/[^0-9]/g, '');
                	   modelCtrl.$setViewValue(transformedInput);
                       modelCtrl.$render();
                }
                return inputValue;
            });
        }
    };
});

angular.module('popup', ['ui.bootstrap.dialog'])
.directive('popup', ['$parse', '$dialog', function($parse, $dialog) {
  return {
    restrict: 'EA',
    terminal: true,
    link: function(scope, elm, attrs) {
      var opts = angular.extend({}, scope.$eval(attrs.uiOptions || attrs.bsOptions || attrs.options));
      var shownExpr = attrs.popup || attrs.show;
      var setClosed;

      // Create a dialog with the template as the contents of the directive
      // Add the current scope as the resolve in order to make the directive scope as a dialog controller scope
      opts = angular.extend(opts, {
        template: elm.html(),
        resolve: { $scope: function() { return scope; } }
      });
      var dialog = $dialog.dialog(opts);

      elm.remove();

      if (attrs.close) {
        setClosed = function() {
          $parse(attrs.close)(scope);
        };
      } else {
        setClosed = function() {
          if (angular.isFunction($parse(shownExpr).assign)) {
            $parse(shownExpr).assign(scope, false);
          }
        };
      }

      scope.$watch(shownExpr, function(isShown, oldShown) {
        if (isShown) {
          dialog.open().then(function(){
            setClosed();
          });
        } else {
          //Make sure it is not opened
          if (dialog.isOpen()){
            dialog.close();
          }
        }
      });
    }
  };
}]);

var repeaterModule = angular.module('repeater', []);

repeaterModule.directive('repeater', function() {
	return {
		require : 'ngModel',
		link : function(scope, element, attrs, ngModelCtrl) {
			scope.addInputRow = function(repeater,newData) {
				JsonObj=[];
				var item={};
				var itemParameters = newData.split(",");
				angular.forEach(itemParameters, function(value){
					item[value]='';
				});
				JsonObj.push(item);
				scope.form[repeater].$modelValue.push(item);
			}

			scope.deleteThis = function(st,repeater) {
				scope.form[repeater].$modelValue.splice(st, 1);
			};
		}
	};
});

var subSectionModule = angular
        .module('subSection', [ 'ui.bootstrap' ]);
subSectionModule
        .directive(
                'subSection',
                function() {
                    return {
                        restrict : "EA", // the Accordion is an element
                        transclude : true, // it has HTML content
                        replace : true, // replace the original markup with our
                        // template
                        scope : {
                            title : '@contentPaneTitle'
                        }, // no scope variables required
                        template : // template assigns class and transclusion
                        // element
                        '<div style="min-width:90%;padding-left:15px"><div style="clear: both;"></div><div class = "divider-line" style="float:left;width:90%"/>'
                                + '<div style="clear: both;"/><div style="float:left;width:90%;font-weight:bold;color: #5577B4;">{{title}}</div>'
                                + '<div class = "divider-line" style="float:left;width:90%"/><div style="height:10px;clear: both;"></div></div>',
                        controller : ['$scope', function ($scope) {
                            $scope.isCollapsed = false;
                        }],
                        link : function(scope, element, attrs, controller) {
                            // Title element
                            var title = angular.element(element), isCollapsed = false;

                        }
                    };
                });

var textAreaModule = angular.module('textArea', [ 'ui.bootstrap','$strap.directives']);

textAreaModule.directive('maxLength', function() {
	  return {
	    require: 'ngModel',
	    link: function (scope, element, attrs, ngModelCtrl) {
	      var maxlength = Number(attrs.maxLength);
	      maxlength = maxlength==0?4000:maxlength;
	      var transformedInput = 4000;
	      var span=document.createElement("span");
	      span.style.color="grey";
	      span.style.fontSize="9px";
	      function fromUser(text) {
			  if (angular.isUndefined(text)) {
					text = "";
				}
	          if (text.length > maxlength) {
	            var transformedInput = text.substring(0, maxlength);
	            ngModelCtrl.$setViewValue(transformedInput);
	            ngModelCtrl.$render();
	            return transformedInput;
	          }
	          else{
	    	      span.innerHTML=maxlength-text.length;
	          }
	          return text;
	      }
	      ngModelCtrl.$parsers.push(fromUser);
	      span.innerHTML=maxlength;
	      element.parent().append(span);
	    }
	  };
	});

var titlePaneModule = angular
		.module('titlePane', [ 'ui.bootstrap' ]);
titlePaneModule
		.directive(
				'titlePane',
				function() {
					return {
						restrict : "EA", // the Accordion is an element
						transclude : true, // it has HTML content
						replace : true, // replace the original markup with our
						// template
						scope : {
							title : '@contentPaneTitle'
						}, // no scope variables required
						template : // template assigns class and transclusion
						// element
						'<div style="min-width:90%;"><div style="height:5px;clear: both;"></div><div style="float:left;width:90%;color: #5577B4;" class="contentPane">'
								+ '{{title}}</div>'
								+ '<div style="height:10px;clear: both;"></div></div>',
						controller : ['$scope', function ($scope) {
							$scope.isCollapsed = false;
						}],
						link : function(scope, element, attrs, controller) {
							// Title element
							var title = angular.element(element), isCollapsed = false;
							// Opened / closed state
							// isCollapsed = false;

							// Clicking on title should open/close the zippy
							title.bind('click', toggle);

							// Toggle the closed/opened state
							function toggle() {
								scope.isCollapsed = !isCollapsed;
							}

							// initialize the zippy
							toggle();
						}
					};
				});

angular.module('$util', [])

.factory('$util', [ '$http', function($http) {
    var $util = {};

    $util.httpGet = function(url, params, callback) {
        $http({
            method : 'GET',
            url : url,
            params : params
        }).success(function(data) {
            callback(data);
        });
    };

    $util.httpGetResponse = function(url, params) {
        return $http({
            method : 'GET',
            url : url,
            params : params
        }).then(function(response) {
           return response.data;
        });
    };

    $util.httpGetWithId = function(url, params, newVal, callback) {
        if (angular.isNumber(newVal)) {
            this.httpGet(url, params, callback);
        }
    };

    $util.openWarrantyTab = function(url, tabLabel, decendentOf, forceNewTab){
        this.httpGet("../getAccessToken.action", {}, function(data){
            var token = encodeURIComponent(data.token);
            if(url.indexOf('?') > -1){
                url += ( '&app=' + token);
            }else{
                url += ( '?app=' + token);
            }
            parent.publishEvent("/tab/open", {
                            label: tabLabel,
                            url: "/"+url,
                            decendentOf: decendentOf,
                            forceNewTab: forceNewTab
                        });
        });
    };

    return $util;
} ]);

// The `$dialogProvider` can be used to configure global defaults for your
// `$dialog` service.
var dialogModule = angular.module('ui.bootstrap.dialog', ['ui.bootstrap.transition']);

dialogModule.controller('MessageBoxController', ['$scope', 'dialog', 'model', function($scope, dialog, model){
  $scope.title = model.title;
  $scope.message = model.message;
  $scope.buttons = model.buttons;
  $scope.close = function(res){
    dialog.close(res);
  };
}]);


dialogModule.provider("$dialog", function(){

  // The default options for all dialogs.
  var defaults = {
    backdrop: true,
    dialogClass: 'modal',
    backdropClass: 'modal-backdrop',
    transitionClass: 'fade',
    triggerClass: 'in',
    resolve:{},
    backdropFade: false,
    dialogFade:false,
    keyboard: true, // close with esc key
    backdropClick: true // only in conjunction with backdrop=true
    /* other options: template, templateUrl, controller */
        };

        var globalOptions = {};

  var activeBackdrops = {value : 0};

  // The `options({})` allows global configuration of all dialogs in the application.
  //
  // var app = angular.module('App', ['ui.bootstrap.dialog'], function($dialogProvider){
  // // don't close dialog when backdrop is clicked by default
  // $dialogProvider.options({backdropClick: false});
  // });
        this.options = function(value){
                globalOptions = value;
        };

  // Returns the actual `$dialog` service that is injected in controllers
        this.$get = ["$http", "$document", "$compile", "$rootScope", "$controller", "$templateCache", "$q", "$transition", "$injector",
  function ($http, $document, $compile, $rootScope, $controller, $templateCache, $q, $transition, $injector) {

                var body = $document.find('body');

                function createElement(clazz) {
                        var el = angular.element("<div>");
                        el.addClass(clazz);
                        return el;
                }

    // The `Dialog` class represents a modal dialog. The dialog class can be invoked by providing an options object
    // containing at lest template or templateUrl and controller:
    //
    // var d = new Dialog({templateUrl: 'foo.html', controller: 'BarController'});
    //
    // Dialogs can also be created using templateUrl and controller as distinct arguments:
    //
    // var d = new Dialog('path/to/dialog.html', MyDialogController);
                function Dialog(opts) {

      var self = this, options = this.options = angular.extend({}, defaults, globalOptions, opts);
      this._open = false;

      this.backdropEl = createElement(options.backdropClass);
      if(options.backdropFade){
        this.backdropEl.addClass(options.transitionClass);
        this.backdropEl.removeClass(options.triggerClass);
      }

      this.modalEl = createElement(options.dialogClass);
      if(options.dialogFade){
        this.modalEl.addClass(options.transitionClass);
        this.modalEl.removeClass(options.triggerClass);
      }

      this.handledEscapeKey = function(e) {
        if (e.which === 27) {
          self.close();
          e.preventDefault();
          self.$scope.$apply();
        }
      };

      this.handleBackDropClick = function(e) {
        self.close();
        e.preventDefault();
        self.$scope.$apply();
      };
    }

    // The `isOpen()` method returns wether the dialog is currently visible.
    Dialog.prototype.isOpen = function(){
      return this._open;
    };

    // The `open(templateUrl, controller)` method opens the dialog.
    // Use the `templateUrl` and `controller` arguments if specifying them at dialog creation time is not desired.
    Dialog.prototype.open = function(templateUrl, controller){
      var self = this, options = this.options;

      if(templateUrl){
        options.templateUrl = templateUrl;
      }
      if(controller){
        options.controller = controller;
      }

      if(!(options.template || options.templateUrl)) {
        throw new Error('Dialog.open expected template or templateUrl, neither found. Use options or open method to specify them.');
      }

      this._loadResolves().then(function(locals) {
        var $scope = locals.$scope = self.$scope = locals.$scope ? locals.$scope : $rootScope.$new();

        self.modalEl.html(locals.$template);

        if (self.options.controller) {
          var ctrl = $controller(self.options.controller, locals);
          self.modalEl.children().data('ngControllerController', ctrl);
        }

        $compile(self.modalEl)($scope);
        self._addElementsToDom();

        // trigger tranisitions
        setTimeout(function(){
          if(self.options.dialogFade){ self.modalEl.addClass(self.options.triggerClass); }
          if(self.options.backdropFade){ self.backdropEl.addClass(self.options.triggerClass); }
        });

        self._bindEvents();
      });

      this.deferred = $q.defer();
      return this.deferred.promise;
    };

    // closes the dialog and resolves the promise returned by the `open` method with the specified result.
    Dialog.prototype.close = function(result){
      var self = this;
      var fadingElements = this._getFadingElements();

      if(fadingElements.length > 0){
        for (var i = fadingElements.length - 1; i >= 0; i--) {
          $transition(fadingElements[i], removeTriggerClass).then(onCloseComplete);
        }
        return;
      }

      this._onCloseComplete(result);

      function removeTriggerClass(el){
        el.removeClass(self.options.triggerClass);
      }

      function onCloseComplete(){
        if(self._open){
          self._onCloseComplete(result);
        }
      }
    };

    Dialog.prototype._getFadingElements = function(){
      var elements = [];
      if(this.options.dialogFade){
        elements.push(this.modalEl);
      }
      if(this.options.backdropFade){
        elements.push(this.backdropEl);
      }

      return elements;
    };

    Dialog.prototype._bindEvents = function() {
      if(this.options.keyboard){ body.bind('keydown', this.handledEscapeKey); }
      if(this.options.backdrop && this.options.backdropClick){ this.backdropEl.bind('click', this.handleBackDropClick); }
    };

    Dialog.prototype._unbindEvents = function() {
      if(this.options.keyboard){ body.unbind('keydown', this.handledEscapeKey); }
      if(this.options.backdrop && this.options.backdropClick){ this.backdropEl.unbind('click', this.handleBackDropClick); }
    };

    Dialog.prototype._onCloseComplete = function(result) {
      this._removeElementsFromDom();
      this._unbindEvents();

      this.deferred.resolve(result);
    };

    Dialog.prototype._addElementsToDom = function(){
      body.append(this.modalEl);

      if(this.options.backdrop) {
        if (activeBackdrops.value === 0) {
          body.append(this.backdropEl);
        }
        activeBackdrops.value++;
      }

      this._open = true;
    };

    Dialog.prototype._removeElementsFromDom = function(){
      this.modalEl.remove();

      if(this.options.backdrop) {
        activeBackdrops.value--;
        if (activeBackdrops.value === 0) {
          this.backdropEl.remove();
        }
      }
      this._open = false;
    };

    // Loads all `options.resolve` members to be used as locals for the controller associated with the dialog.
    Dialog.prototype._loadResolves = function(){
      var values = [], keys = [], templatePromise, self = this;

      if (this.options.template) {
        templatePromise = $q.when(this.options.template);
      } else if (this.options.templateUrl) {
        templatePromise = $http.get(this.options.templateUrl, {cache:$templateCache})
        .then(function(response) { return response.data; });
      }

      angular.forEach(this.options.resolve || [], function(value, key) {
        keys.push(key);
        values.push(angular.isString(value) ? $injector.get(value) : $injector.invoke(value));
      });

      keys.push('$template');
      values.push(templatePromise);

      return $q.all(values).then(function(values) {
        var locals = {};
        angular.forEach(values, function(value, index) {
          locals[keys[index]] = value;
        });
        locals.dialog = self;
        return locals;
      });
    };

    // The actual `$dialog` service that is injected in controllers.
    return {
      // Creates a new `Dialog` with the specified options.
      dialog: function(opts){
        return new Dialog(opts);
      },
      // creates a new `Dialog` tied to the default message box template and controller.
      //
      // Arguments `title` and `message` are rendered in the modal header and body sections respectively.
      // The `buttons` array holds an object with the following members for each button to include in the
      // modal footer section:
      //
      // * `result`: the result to pass to the `close` method of the dialog when the button is clicked
      // * `label`: the label of the button
      // * `cssClass`: additional css class(es) to apply to the button for styling
      messageBox: function(title, message, buttons){
        return new Dialog({templateUrl: 'template/dialog/message.html', controller: 'MessageBoxController', resolve:
          {model: function() {
            return {
              title: title,
              message: message,
              buttons: buttons
            };
          }
        }});
      }
    };
  }];
});

$(document).ready(function() {
    $('.accordion-info').show();
    $('.accordion-header').click(function() {
        var thisElement = $(this);
        thisElement.next().slideToggle(300);
        setTimeout(function() {
            expandCollapse();
        }, 300);
        function expandCollapse() {
            if (thisElement.children('.expand-collapse').hasClass("collapse-icon")) {
                thisElement.children('.expand-collapse').removeClass("collapse-icon");
                thisElement.children('.expand-collapse').addClass("expand-icon");
            } else {
                thisElement.children('.expand-collapse').removeClass("expand-icon");
                thisElement.children('.expand-collapse').addClass("collapse-icon");
            }
        }
    });
});


var focusMe = angular.module('focusMe',['ui.bootstrap']);
focusMe.directive('focusMe',['$timeout', '$parse', function ($timeout, $parse) {
	return {
		restrict: 'A',
		link: function(scope, element, attrs) {
        	 $timeout(function() {
        		 element[0].focus();
        	 });
		}
	};
}]);

