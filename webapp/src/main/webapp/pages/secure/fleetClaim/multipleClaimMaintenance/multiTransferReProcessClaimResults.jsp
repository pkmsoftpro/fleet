<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>

<div id="multiTransferReProcess" dojoType="dojox.layout.ContentPane" layoutAlign="client">
<script type="text/javascript">
		var selectedFleetClaimsId= [];
		var claimSize1='<s:property value="fleetClaims.size"/>'; 
		var idsInString='<s:property value="selectedFleetClaimsId"/>';
		idsInString=idsInString.replace(/\s+/g,''); 
		if(idsInString!=null && !idsInString==""){
			selectedFleetClaimsId=idsInString.split(",");
	    } 
		dojo.addOnLoad(function(){
			dojo.connect(dojo.byId("masterCheckboxForClaims"), "onclick", function(event) {
				if(event.target.checked){
			    	for (var i = 0; i < claimSize1; i++) {
		                var currentElement = dojo.byId("claim_"+i);
		                currentElement.checked=true;
						var indexOf =dojo.indexOf(selectedFleetClaimsId, currentElement.value);		
						if (indexOf == -1) {
							selectedFleetClaimsId.push(currentElement.value);	
						}		
					}
				}else{
					for (var j = 0; j < claimSize1; j++) {
						var currentElement = dojo.byId("claim_"+j);
						currentElement.checked=false;
					}			
					selectedFleetClaimsId=[];
					}
				});
				setSelectedInventories();
		        for (var i=0; i<claimSize1; i++) {		
		        var checkBox = dojo.byId("claim_"+i);        
		        dojo.connect(checkBox, "onclick", function(event) {
		            var indexOfClaim;
		            var targetElement = event.target;
		            if(targetElement.checked) {
						indexOfClaim=dojo.indexOf(selectedFleetClaimsId,targetElement.value);
						if (indexOfClaim == -1) {
							selectedFleetClaimsId.push(targetElement.value);
						}
		            } else {
						indexOfClaim =dojo.indexOf(selectedFleetClaimsId,targetElement.value);
						if (indexOfClaim >= 0) {
							selectedFleetClaimsId.splice(indexOfClaim, 1);
						}
		            }
		            });
    			}
		});
		
		function setSelectedInventories(){
		 for (var i=0; i< claimSize1; i++) {
	        var currentElement = dojo.byId("claim_"+i);
	        var indexOf=dojo.indexOf(selectedFleetClaimsId,currentElement.value);
			if(indexOf >= 0){
				currentElement.checked=true;
			}
		 }
	}
</script>

<s:hidden id="contextName" name="contextName"/>
<s:hidden id="savedQueryId" name="savedQueryId"/>
<s:hidden id="domainPredicateId" name="domainPredicateId"/>
<s:hidden id="isTransferOrReProcess" name="isTransferOrReProcess"/>
<s:hidden id="selectedBusinessUnit" name="selectedBusinessUnit" value="AMER"/>
<table  cellspacing="0" cellpadding="0" id="claim_details_table"  class="grid borderForTable" style="clear: both;">
    <thead>    
        <tr>        
            <th class="warColHeader" width="2%" style="padding: 0" align="center">
                <input type="checkbox" id="masterCheckboxForClaims" style="padding: 0"/>
            </th>        
            <th class="warColHeader" width="8%" class="non_editable"><s:text name="label.common.fleetClaimNumber"/></th>
            <th class="warColHeader" width="10%" class="non_editable"><s:text name="label.common.model"/></th>
            <th class="warColHeader" width="10%"><s:text name="label.fleetClaim.serialNumber"/></th>
            <th class="warColHeader" width="10%"><s:text name="label.fleetClaim.status"/></th>
            <th class="warColHeader" width="10%"><s:text name="label.common.workOrderNumber"/></th>
            <th class="warColHeader" width="10%"><s:text name="label.common.faultCode"/></th>
            <th class="warColHeader" width="10%"><s:text name="label.fleetClaim.forDealer"/></th>                  
        </tr>
    </thead>
    <tbody>
    <s:hidden name="selectedFleetClaimsId" id="selectedFleetClaims"/>
    <s:if test="fleetClaims.empty">
        <td align="center" colspan="13"><s:text name="error.claim.noClaimFound" /></td>
    </s:if>
     <s:else>
     	
        <s:iterator value="fleetClaims" status="fleetClaim"> 
        <s:hidden name="restoreClaimsList[%{#fleetClaim.index}]" value="%{id}"/>       
        <tr>        	
            <td align="center" valign="middle">            
                <s:checkbox id="claim_%{#fleetClaim.index}"
                        name="fleetClaims[%{#fleetClaim.index}].id" value="false"
                       	fieldValue="%{id}"/>            
            </td>
            <td>
                <s:property value="fleetClaimNumber"/>
            </td>
            <td>
                <s:property value="forItem.model.name" />
            </td>
            <td>
                <s:property value="forItem.serialNumber" />
            </td>
            <td>
                <s:property value="activeFleetClaimAudit.fleetClaimState" />
            </td>
            <td>
                <s:property value="activeFleetClaimAudit.workOrderNumber" />
            </td>
             <td>
                <s:property value="activeFleetClaimAudit.serviceInformation.faultCodeRef.definition.code" />
            </td>             
            <td>
                <s:property value="forDealer.name" /> 
            </td>      
        </tr>
       </s:iterator>
   </s:else>
   </tbody>
</table>
<div>
<center><s:iterator value="pageNoList" status="pageCounter">
		&nbsp;
		<s:if test="pageNoList[#pageCounter.index] == (pageNo + 1)">
		<span id="page_<s:property value="%{#pageCounter.index}"/>">
	</s:if>
	<s:else>
		<span id="page_<s:property value="%{#pageCounter.index}"/>"
			style="cursor: pointer; text-decoration: underline">
	</s:else>
	<s:property value="%{intValue()}" />
	<script type="text/javascript">
			dojo.addOnLoad(function(){	
				var index = '<s:property value="%{#pageCounter.index}"/>';
				var pageNo='<s:property value="pageNo"/>';				
				if(index!=pageNo){
					dojo.connect(dojo.byId("page_"+index),"onclick",function(){
						getMatchingClaims(index);  
					});
				}	 
			});
		</script>
	</span>
</s:iterator></center>
</div>
</div>