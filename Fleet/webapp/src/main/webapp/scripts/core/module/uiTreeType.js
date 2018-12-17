var uiTreeType = angular.module('uiTreeType',['ng','multiCheckBox']);

uiTreeType.directive('uiTree', function() {
  return {
    template: '<ul class="uiTree"><ui-tree-node ng-repeat="node in tree"></ui-tree-node></ul>',
    replace: true,
    transclude: true,
    restrict: 'E',
    scope: {
      tree: '=ngModel',
      attrNodeId: "@",
      loadFn: '=',
      expandTo: '=',
      selectedId: '='
    },
    controller: ['$scope', '$element', '$attrs', function($scope, $element, $attrs) {
        $scope.loadFnName = $attrs.loadFn;
      // this seems like an egregious hack, but it is necessary for recursively-generated
      // trees to have access to the loader function
      if($scope.$parent.loadFn)
        $scope.loadFn = $scope.$parent.loadFn;

      // TODO expandTo shouldn't be two-way, currently we're copying it
      if($scope.expandTo && $scope.expandTo.length) {
        $scope.expansionNodes = angular.copy($scope.expandTo);
        var arrExpandTo = $scope.expansionNodes.split(",");
        $scope.nextExpandTo = arrExpandTo.shift();
        $scope.expansionNodes = arrExpandTo.join(",");
      }
    }]
  };
})
.directive('uiTreeNode', ['$compile', function($compile) {
  return {
    restrict: 'E',
    replace: true,
    template: '<li>' +
      '<div id="mainDiv" class="node" align="left" data-node-id="{{ nodeId() }}">' +
        '<a class="icon" ng-click="toggleNode(nodeId())"></a>' +
        '<a ng-hide="selectedId" ng-href="#/assets/{{ nodeId() }}">{{ node.definition.label}}</a>' +
        '<span ng-if="node.serviceProcedureId!=null">'+
        '<input Type="checkbox" name="selectedFaultCode" picker-item value="{{node}}" />'+
        '</span>'+
        '<span ng-if="node.faultCode.id!=null">'+
        '<input Type="radio" ng-click="setSelected(node)" name="selectedJobCode" value="{{ nodeId() }}" />'+
        '</span>'+
        '<span ng-show="selectedId" ng-class="css()">' +
            '{{ node.definition.label}}</span>' +
    '</li>',
    link: function(scope, elm, attrs) {
      scope.nodeId = function(node) {
        var localNode = node || scope.node;
        return localNode[scope.attrNodeId];
      };
      scope.toggleNode = function(nodeId) {
        var isVisible = elm.children(".uiTree:visible").length > 0;
        var childrenTree = elm.children(".uiTree");
        if(isVisible) {
          scope.$emit('nodeCollapsed', nodeId);
        } else if(nodeId) {
          scope.$emit('nodeExpanded', nodeId);
        }
        if(!isVisible && scope.loadFn && childrenTree.length === 0) {
          // load the children asynchronously
          var callback = function(arrChildren) {
            scope.node.children = arrChildren;
            scope.appendChildren();
            elm.find("a.icon i").show();
            elm.find("a.icon img").remove();
            scope.toggleNode(); // show it
          };
          var promiseOrNodes = scope.loadFn(nodeId, callback);
          if(promiseOrNodes && promiseOrNodes.then) {
            promiseOrNodes.then(callback);
          }
          elm.find("a.icon i").hide();
          var imgUrl = "http://www.efsa.europa.eu/efsa_rep/repository/images/ajax-loader.gif";
          elm.find("a.icon").append('<img src="' + imgUrl + '" width="18" height="18">');
        } else {
          childrenTree.toggle(!isVisible);
          elm.find("a.icon i").toggleClass("collapsed");
          elm.find("a.icon i").toggleClass("expanded");
        }
      };

      scope.appendChildren = function() {
        // Add children by $compiling and doing a new ui-tree directive
        // We need the load-fn attribute in there if it has been provided
        var childrenHtml = '<ui-tree ng-model="node.children" attr-node-id="' +
            scope.attrNodeId + '"';
        if(scope.loadFn) {
          childrenHtml += ' load-fn="' + scope.loadFnName + '"';
        }
        // pass along all the variables
        if(scope.expansionNodes) {
          childrenHtml += ' expand-to="expansionNodes"';
        }
        if(scope.selectedId) {
          childrenHtml += ' selected-id="selectedId"';
        }
        childrenHtml += ' style="display: none"></ui-tree>';
        return elm.append($compile(childrenHtml)(scope));
      };

      scope.css = function() {
        return {
          nodeLabel: true,
          selected: scope.selectedId && scope.nodeId() === scope.selectedId
        };
      };
      // emit an event up the scope.  Then, from the scope above this tree, a "selectNode"
      // event is expected to be broadcasted downwards to each node in the tree.
      // TODO this needs to be re-thought such that the controller doesn't need to manually
      // broadcast "selectNode" from outside of the directive scope.
      scope.setSelected = function(node) {
        scope.$emit("nodeSelected", node);
      };


      scope.$on("selectNode", function(event, node) {
        scope.selectedId = scope.nodeId(node);
      });

      if(scope.node.nodeType=='node') {
        elm.find("a.icon").append('<i class="collapsed"></i>');
      }
      else
    	  {
    	  elm.find("a.icon").append('<i class="normal"></i>');
    	  }

      if(scope.nextExpandTo && scope.nodeId() == parseInt(scope.nextExpandTo, 10)) {
        scope.toggleNode(scope.nodeId());
      }
    }
  };
}]);
