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

<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%
response.setHeader( "Pragma", "no-cache" );
response.addHeader( "Cache-Control", "must-revalidate" );
response.addHeader( "Cache-Control", "no-cache" );
response.addHeader( "Cache-Control", "no-store" );
response.setDateHeader("Expires", 0);
%>

<html>
<head>
    <meta http-equiv="Context-Type" content="text/html; charset=ISO-8859-1">
    <title><s:text name="title.common.warranty"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="common.css"/>
</head>
	
	<u:body>
		<form name="baseform" id="baseform">
			<u:actionResults/>
			<s:hidden name="lovTypeName"></s:hidden>
			<s:hidden name="id"></s:hidden>
			<div style="margin:5px;width:99%" class="policy_section_div">
				<div class="section_header">
					<s:property value="capitalisedLOVTypeName"/>
				</div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:5px;margin-bottom:5px;">
				<tbody>
				   <tr>
				  	<td height="19" colspan="2" nowrap="nowrap" class="labelStyle"><s:text name="label.listOfValues.code"/>:</td>
				  	<td><s:property value="listOfValues.code"/></td>
				   </tr>
				   <s:iterator value="locales"  status="localeItr" id="localesItr">
			          <tr>
			            <td height="3" colspan="3"></td>
			          </tr>
			          <tr>
			            <td height="19" colspan="2" nowrap="nowrap" class="labelStyle">
			                <s:text name="label.common.description"/> <s:property value='description'/>:
			            </td>
						<td width="70%" height="19" class="labelNormal">
						 <s:set name="selectedDesc" value=""/>
						 <s:iterator value="listOfValues.i18nLovTexts" status="descItr">
						    <s:if test="locales[#localeItr.index].locale == locale">
						       <s:set name="selectedDesc" value="description" />
						    </s:if>
						 </s:iterator>
						  <t:textarea cols="40" rows="3" name="localizedDescriptionMessages_%{locales[#localeItr.index].locale}"
						                              value="%{selectedDesc}"/>
			             </td>
			           </tr>
			       </s:iterator>
				  <tr>
				  	<td height="19" colspan="2" nowrap="nowrap" class="labelStyle"><s:text name="label.common.status"/>:</td>
				  	<td><s:property value="listOfValues.state"/></td>
				  </tr>
				</tbody>
				</table>
				<s:hidden name="code" value="%{listOfValues.code}" />
				
			</div>
			<authz:ifPermitted resource="listOfValues">
			<div align="center" style="margin-top:10px;">
			<s:submit action="update_lov" cssClass="button" align="center" value="%{getText('button.common.update')}"></s:submit>
				<s:if test="listOfValues.state == 'active'">
					<s:submit action="delete_lov" cssClass="button" align="center" value="%{getText('button.listOfValues.deactivate')}"></s:submit>
				</s:if>
				<s:else>
					<s:submit action="activate_lov" cssClass="button" align="center" value="%{getText('button.listOfValues.reactivate')}"></s:submit>
				</s:else>
			</div>
			</authz:ifPermitted>
		</form>
	</u:body>
</html>