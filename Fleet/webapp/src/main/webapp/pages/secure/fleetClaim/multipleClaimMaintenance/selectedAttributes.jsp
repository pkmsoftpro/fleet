<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="tda" uri="twmsDomainAware"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>


<html>
<head>
    <meta http-equiv="Context-Type" content="text/html; charset=ISO-8859-1">    
    <s:head theme="twms"/>
    <u:stylePicker fileName="common.css"/>
    <u:stylePicker fileName="form.css"/>
    <u:stylePicker fileName="warrantyForm.css"/> 
    <u:stylePicker fileName="base.css"/>  
</head>
<u:body>
<u:actionResults/>
<s:if test="attributeMapper.fleetClaimRejectionReason.selected && attributeMapper.fleetClaimAcceptanceReason.selected">
<div class="twmsActionResultsSectionWrapper twmsActionResultsWarnings">
	<h4 class="twmsActionResultActionHead"><s:text name="label.common.warnings" /></h4>
		<ol>
			<s:text name="warning.MultiClaimMaintainance.reason"></s:text>				
		</ol>
		<hr/>
</div>
</s:if>

<div>
<script type="text/javascript">
dojo.require("dijit.layout.ContentPane");
</script>
<s:form method="post" theme="twms" id="updateClaimsForMaintenance" name="updateClaimsForMaintenanceForm"
            		action="updateClaimsForMaintenance.action">
            	<s:hidden id="selectedBusinessUnit" name="selectedBusinessUnit" value="AMER"/>	
<input type="hidden" name="attributeSelected" value="<s:property value="attributeSelected"/>"/>

<s:iterator value="fleetClaims" status="fleetClaim"> 
    <s:hidden name="fleetClaims[%{#fleetClaim.index}].id" value="%{id}"/>
    <s:hidden name="restoreClaimsList[%{#fleetClaim.index}].id" value="%{id}"/>
</s:iterator>
<div class=bgColor>
<div class="sectionTitle"  style="color:#FFFFFF">
<s:text name="title.attributes.attributeValue"/>
</div>

<table  cellspacing="0" cellpadding="0" id="selected_attributes" width="100%" class="grid borderForTable" style="clear: both;">  
	<thead>
        <tr>        
            <th class="warColHeader" width="40%" class="non_editable"><s:text name="title.attributes.attributeName"/></th>        
            <th class="warColHeader" width="60%" class="non_editable"><s:text name="title.attributes.newValue"/></th>
        </tr>
    </thead>  
    <tbody>         
         <tr> 
        	<s:if test="attributeMapper.fleetClaimRejectionReason.selected">    	
            <td>
            	<s:property value="attributeMapper.fleetClaimRejectionReason.name"/>        	         
            </td>
            <td>
            <s:hidden name="attributeMapper.fleetClaimRejectionReason.selected"/>
            <s:select name="attributeMapper.fleetClaimRejectionReason.attribute.code"  list="attributeMapper.getListOfValues('FleetClaimRejectionReason')"/>             
            </td>
            </s:if>   
         </tr>
         <tr> 
        	<s:if test="attributeMapper.fleetClaimAcceptanceReason.selected">    	
            <td>
            	<s:property value="attributeMapper.fleetClaimAcceptanceReason.name"/>
            </td>
            <td>
            <s:hidden name="attributeMapper.fleetClaimAcceptanceReason.selected"/>
            <s:select name="attributeMapper.fleetClaimAcceptanceReason.attribute.code" list="attributeMapper.getListOfValues('FleetClaimAcceptanceReason')"/>                           
            </td>
            </s:if>   
         </tr>
         <tr> 
        	<s:if test="attributeMapper.callType.selected">    	
            <td>
            	<s:property value="attributeMapper.callType.name"/>
            </td>
            <td>
            <s:hidden name="attributeMapper.callType.selected"/>
            <s:select name="attributeMapper.callType.attribute.code" list="attributeMapper.getListOfValues('CallType')"/>                           
            </td>
            </s:if>   
         </tr>
         <tr> 
        	<s:if test="attributeMapper.processingNotes.selected">    	
            <td>
            	<s:property value="attributeMapper.processingNotes.name"/>           	        
            </td>
            <td align="center">
            <s:hidden name="attributeMapper.processingNotes.selected"/>
            <t:textarea rows="2" cols="55" name="attributeMapper.processingNotes.attribute"
                wrap="physical" cssClass="bodyText" value=""/>               
            <s:checkbox id="appendOrEditProcessingNotes" name="appendOrEditProcessingNotes"/>
            <s:text name="%{getText('label.common.append')}"/>
            </td>
            </s:if>
         </tr>        
   </tbody>
</table>
</div>
<div dojoType="dijit.layout.ContentPane" layoutAlign="client" style="padding-bottom: 10px">
	<table class="buttons">
		<tr>
		<td>
		<center>
			 <s:submit value="%{getText('button.common.cancel')}" type="input" id="cancelButton"/>
                    <script type="text/javascript">
                        dojo.addOnLoad(function() {
                            dojo.connect(dojo.byId("cancelButton"), "onclick", closeMyTab);
                        });
                    </script>
			<s:submit id="Submit"  value="%{getText('button.common.submit')}" />
		</center>
		</td>
		</tr>
	</table>	
</div>
</s:form>
</div>
</u:body>

