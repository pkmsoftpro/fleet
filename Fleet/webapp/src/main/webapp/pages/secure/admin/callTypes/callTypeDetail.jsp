
<%--
 @author: Naveen Kumar Reddy Nare
--%>


<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<s:head theme="twms" />
<title>Call Type</title>
<u:stylePicker fileName="yui/reset.css" common="true" />
<u:stylePicker fileName="layout.css" common="true" />
<u:stylePicker fileName="common.css" />
<u:stylePicker fileName="form.css" />
<u:stylePicker fileName="adminPayment.css" />
<u:stylePicker fileName="base.css" />
    <script type="text/javascript">
  	  	dojo.require("dijit.layout.ContentPane");
      	dojo.require("dijit.layout.LayoutContainer"); 
	</script>
</head>

<u:body>
	<div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%; background: white; overflow-y: auto;">
		<div dojoType="dijit.layout.ContentPane" layoutAlign="client">
			<u:actionResults />
			<div class="policyRegn_section_div">
				<div class="admin_section_heading">
	   				<s:text name="columnTitle.callType.manageCallType" />
				</div>
				<s:form name="manageCallType" action="updateCallType">
					<s:hidden name="manageCallType.id" />
					<table  width="50%" cellspacing="0" cellpadding="0" class="grid">
						<tr>
						     <td class="labelStyle" nowrap="nowrap" width="15%">
						     	<s:text name="label.lovs.callType" />:
						     </td> 
						     <td>
						     	${manageCallType.listOfValues.description}
						     </td> 
						</tr> 
						<tr>
						     <td class="labelStyle"  nowrap="nowrap" >
						     	<s:text name="columnTitle.callTypes.internal" />:
						     </td> 
						     <td>
							     <input type="radio" name="isInternal" value="true" <s:if test="manageCallType.isInternal">checked="checked"</s:if> onchange="showHideAssociated(this)" /> <s:text name="label.common.yes" /> 
							     <input type="radio" name="isInternal" value="false" <s:if test="!manageCallType.isInternal">checked="checked"</s:if> onchange="showHideAssociated(this)" /> <s:text name="label.common.no"/>
						     </td> 
						</tr>
						<tr>
						     <td class="labelStyle" nowrap="nowrap" >
						     	<s:text name="columnTitle.callTypes.billable" />:
						     </td> 
						     <td>
							     <input type="radio" name="isBillable" value="true" <s:if test="manageCallType.isBillable">checked="checked"</s:if>/> <s:text name="label.common.yes" /> 
							     <input type="radio" name="isBillable" value="false" <s:if test="!manageCallType.isBillable">checked="checked"</s:if>/> <s:text name="label.common.no" />
						     </td> 
						</tr>
						<tr>
						     <td class="labelStyle" nowrap="nowrap" >
						     	<s:text name="columnTitle.callTypes.planned" />:
						     </td> 
						     <td>
							     <input type="radio" name="isPlanned" value="true" <s:if test="manageCallType.isPlanned">checked="checked"</s:if>/> <s:text name="label.common.yes" /> 
							     <input type="radio" name="isPlanned" value="false" <s:if test="!manageCallType.isPlanned">checked="checked"</s:if>/> <s:text name="label.common.no" />
						     </td> 
						</tr>
						<tr>
						     <td class="labelStyle" nowrap="nowrap">
						     	<div id="associateCallTypeLabel">
						     		<s:text name="columnTitle.callType.associatedCallType" /> :
						     	</div>	
						     </td> 
						     <td>
						     	<div id="associateCallType">
								     <s:select list="externalCallTypes" listKey="listOfValues.id" listValue="listOfValues.description" name="associatedCallType" />
						     	</div>
						     </td> 
						</tr>
				        <tr>
				            <td colspan="2">
				                <div class="spacingAtTop" style="text-align: center;">
				                    <s:submit align="middle" cssClass="button" value="%{getText('button.common.save')}" ></s:submit>
				                </div>
				            </td>
				        </tr>
					</table> 
				</s:form>
			</div>
 		</div>
 		<div>
 			<script type="text/javascript">
 				dojo.addOnLoad(function() {
 					var showAssociateCallType = '${manageCallType.isInternal}';
 					var associateCallTypeObj = dojo.byId("associateCallType");
 					var associateCallTypeLabelObj = dojo.byId("associateCallTypeLabel");
 					if (showAssociateCallType == 'true') {
 						associateCallTypeObj.style.display="block";
 						associateCallTypeLabelObj.style.display="block";
 					} else {
 						associateCallTypeObj.style.display="none";
 						associateCallTypeLabelObj.style.display="none";
 					}
 				});
 				
 				function showHideAssociated(radioObj) {
 					var selectedValue = radioObj.value;
 					var associateCallTypeObj = dojo.byId("associateCallType");
 					var associateCallTypeLabelObj = dojo.byId("associateCallTypeLabel");
 					if (associateCallTypeObj) {
	 					if (selectedValue && selectedValue=='true') {
	 						associateCallTypeObj.style.display="block";
	 						associateCallTypeLabelObj.style.display="block";
	 					} else {
	 						associateCallTypeObj.style.display="none";
	 						associateCallTypeLabelObj.style.display="none";
	 					}
 					}
 				}			
 			</script>
 		</div>
	</div>
</u:body>