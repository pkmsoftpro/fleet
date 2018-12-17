<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%response.setHeader( "Pragma", "no-cache" );
response.addHeader( "Cache-Control", "must-revalidate" );
response.addHeader( "Cache-Control", "no-cache" );
response.addHeader( "Cache-Control", "no-store" );
response.setDateHeader("Expires", 0); %>

<html>
<head>
    <meta http-equiv="Context-Type" content="text/html; charset=ISO-8859-1">
    <s:head theme="twms"/>
    <u:stylePicker fileName="common.css"/>
    <u:stylePicker fileName="base.css"/>
     
 </head>
 <u:actionResults/>
 <u:stylePicker fileName="inboxLikeButton.css"/>
  <script type="text/javascript">  	  	
      	dojo.require("dijit.layout.LayoutContainer"); 
      	dojo.require("dijit.layout.ContentPane");
      	
      	function openLabels() {
      		var labelType;
      		var thisTabLabel = getMyTabLabel();
    		var labelName;
      		dojo.query("input[name=labelType]").forEach(function(node){
     		   if(node.checked)
     			  labelType= node.value;
            });      
      		if(labelType=='CONTRACT'){
      			labelName='<s:text name="label.common.contractLabels"/>';
      		}else if(labelType=='FLEET_INVENTORY'){
      			labelName='<s:text name="label.common.inventoryLabels"/>';
      		}
      		else if(labelType=='FLEETCUSTOMER'){
      			labelName='<s:text name="label.common.customerLabels"/>';
      		}
      		parent.publishEvent("/tab/open", {
    			label : labelName,
    			url : "../listLabelNames.action?labelType="+labelType,
    			decendentOf : thisTabLabel,
    			forceNewTab : true
    		}); 
    	}
      	
   </script>
   
<u:body smudgeAlert="false">
	 <s:form name="labelSearchForm" id="labelSearchForm" action="">
	 	<div class="section" style="width:99%">
	 	<table  width="100%" border="0" cellspacing="0" cellpadding="0" class="bgColor" colspan="6">
			<tr><div  class="section_header">        
        	  		<s:text name="label.common.labelSearch"/>
       			</div>	
      		 </tr>
      		 <tr>
				<td class="labelStyle" style="padding-top:5px;">
	        		<s:text name="button.common.addLabel"/>
	        	</td>
	        </tr>
      		<tr>
				<td class="labelStyle">
	        		<input type="radio" name="labelType" id="labelType" checked="checked" value="FLEET_INVENTORY"/><s:text name="accordion_jsp.accordionPane.fleetInventory"/>
	        	</td>
	        </tr>
	        <tr>
         	<td class="labelStyle">
	        		<input type="radio" name="labelType" id="contracLabelType"  value="CONTRACT"/><s:text name="label.common.contract"/>
	        </td>
	        </tr>
            <tr>
            <td class="labelStyle">
                    <input type="radio" name="labelType" id="customerLabelType"  value="FLEETCUSTOMER"/><s:text name="label.common.customer"/>
            </td>
            </tr>
	      </table>
	      </div>
	        <div align="center" style="margin-top:10px">
	        		 <button type="button" class="buttonGeneric" onclick="openLabels()">
                       <s:text name="button.common.continue" />
                     </button>
	        	</div>
	  </s:form>
</u:body>      