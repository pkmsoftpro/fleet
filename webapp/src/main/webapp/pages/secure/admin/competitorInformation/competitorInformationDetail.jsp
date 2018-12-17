<%--

   Copyright (c)2006 Tavant Technologies
   All Rights Reserved.

   This software is furnished under a license and may be used and copied
   only  in  accordance  with  the  terms  of such  license and with the
   inclusion of the above copyright notice. This software or  any  other
   copies thereof may not be provided or otherwise made available to any
   other person. No title to and ownership of  the  software  is  hereby
   transferred.

   The information in this software is subject to change without  notice
   and  should  not be  construed as a commitment  by Tavant Technologies.

--%>

<%@ taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>
<html>
<head>
 <title><s:text name="title.common.warranty" /></title>    
    <s:head theme="twms" />
	<u:stylePicker fileName="adminPayment.css"/>
	<u:stylePicker fileName="common.css"/>
    <u:stylePicker fileName="form.css"/>
	
	<script type="text/javascript">
        dojo.require("twms.widget.Select");
    </script>
</head>

<u:body>
<u:actionResults/>
<s:form name="baseForm" id="baseForm" method="POST" >
 
	<div class="policyRegn_section_div" style="width:99%;">
		<div class="admin_section_heading">
	    	<s:text name="label.manageCompetitorInfo.updateCompetitorInfo"/>
	 	</div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grid">
		   	<tr>
	            <td height="19" class="label" width="10%">
	                <s:text name="columnTitle.manageCompetitorInfo.competitorBrand"/>:
	            </td>
	            <td class="labelNormal" width="48%">
	                <s:textfield name="competitorBrandModel.brandType"  size="28" />
	            </td>            
           	</tr>
           	<tr>
	            <td height="19" class="label" width="13%">
	                <s:text name="columnTitle.manageCompetitorInfo.competitorModel"/>:
	            </td>
	            <td height="19" class="labelNormal" >
	                <s:textfield name="competitorBrandModel.competitorModelName"  size="28"/>
	            </td>
        	</tr>
        	<tr>
	            <td height="19" class="label" width="20%">
	                <s:text name="columnTitle.manageCompetitorInfo.equivalentNmhgModel"/>:
	            </td>
	            <td  height="19" class="labelNormal" align="left" >
	                <sd:autocompleter  href='list_ItemGroups.action' name='competitorBrandModel.equiNmhgModel' value='%{competitorBrandModel.equiNmhgModel.name}' loadOnTextChange='true' loadMinimumCount='3' keyName="competitorBrandModel.equiNmhgModel" key="%{competitorBrandModel.equiNmhgModel.id}" keyValue="%{competitorBrandModel.equiNmhgModel.id}" showDownArrow='false' indicator='indicator' />
                        <img style="display: none;" id="indicator" class="indicator"
                            src="image/indicator.gif" alt="Loading..."/> 
	            </td>
        	</tr>
		
		</table>
		<s:hidden name="competitorBrandModel.id" value="%{competitorBrandModel.id}"></s:hidden>
	</div>
	<div align="center" style="margin:10px 0; width:58%;"><s:submit
			id="closeTab" value="Cancel" cssClass="buttonGeneric" action="" /> <script
			type="text/javascript">
			    dojo.addOnLoad(function() {
			        dojo.connect(dojo.byId("closeTab"), "onclick", function() {
			            closeMyTab();
			        });
			    });
			</script>
			<s:submit id="modifyCodes" value="Modify" cssClass="buttonGeneric"
						action="modify_Competitor_Information" />
				
	</div>
</s:form>


</u:body>

</html>

 