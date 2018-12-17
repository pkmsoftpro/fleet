<div class="clear"></div>
<div  class="containerDiv">

        <div>
        <div class="equipmentRowDivHeader cell-bottom-border">
           <div  class="cellDivHeader" style='width:100px'><spring:message code="label.manageBusinessRule.ruleNumber" /></div>
            <div class="cellDivHeader"  style='width:900px'><spring:message code="label.manageBusinessRule.ruleDescription" /></div>
        </div>
        </div>              
     <div class="rowDiv cell-bottom-border" ng-repeat="ruleFailure in activeAudit.ruleFailures" >
     <div  ng-repeat="failedRule in ruleFailure.failedRules">
     <div ng-if="fleetClaim.autoAccepted==false">
            <div class="cellDiv" style='width:100px; word-break: break-all;'><span class="red">{{failedRule.ruleNumber}}</span></div>
            <div class="cellDiv" style='width:900px; word-break: break-all;'><span class="red">{{failedRule.ruleMsg}}</span></div>
     </div>
      <div ng-if="fleetClaim.autoAccepted==true">
            <div class="cellDiv" style='width:100px; word-break: break-all;'><span class="green">{{failedRule.ruleNumber}}</span></div>
            <div class="cellDiv" style='width:900px; word-break: break-all;'><span class="green" >{{failedRule.ruleMsg}}</span></div>
     </div>
     </div>
   </div> 
  
</div>
<div class="clear"></div>