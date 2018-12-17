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
<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="t" uri="twms" %>
<%@ taglib prefix="u" uri="/ui-ext" %>
<%@ taglib prefix="authz" uri="authz" %>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>
<html>
<head>
    <title>
        <s:text name="accordion_jsp.accordionPane.customerUserMgmt"/>
    </title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="form.css"/>
    <u:stylePicker fileName="warrantyForm.css"/>
    <u:stylePicker fileName="common.css"/>
    <u:stylePicker fileName="base.css"/>
    <script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dijit.layout.ContentPane");
	    dojo.require("dijit.Tooltip")
	</script>
	<style type="text/css">
		.dijitTooltipContainer {
		position:absolute;left:0;top:0;
		background-color:#CCD9FF;
		border:1px solid gray;
		font-family:Arial, Helvetica, sans-serif;
		font-size: 9pt;
		display: block;
		}
	</style>
</head>
<u:body>
    <div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%;overflow-y:auto;" id="root">
        <div dojoType="dijit.layout.ContentPane" layoutAlign="client">
            <u:actionResults/>
			<s:form action="search_user" id="searchUserForm"
				theme="twms">
                <s:hidden name="userType" value="%{userType}"></s:hidden>
				<div class="section_div">
					<div class="section_heading">
						<s:text name="label.common.searchUser" />
					</div>

					<table class="grid" cellpadding="0" cellspacing="0">
						<tr style="width: 75%;">
							<td style="width: 20%;" class="labelStyle"><s:text
									name="label.customerUser.login" />
							</td>
							<td><s:textfield maxlength="20" size="30" name="loginName" />
							</td>
						</tr>

					</table>
				</div>
				<div class="spacingAtTop" align="center">
					<input id="submit_btn" class="buttonGeneric" type="submit"
						value="<s:text name='label.common.searchUser'/>" />
					<s:if test="users != null && !users.isEmpty()">
						<div class="mainTitle" style="margin-top: 5px;">
							<s:text name="label.manageCustomerUsers.selectUser" />
						</div>
						<table class="grid borderForTable"
							style="margin: 5px; width: 98%;" cellpadding="0" cellspacing="0">

							<tr class="row_head">
								<th></th>
								<th width="31%"><s:text name="label.customerUser.login" />
								</th>
								<th width="31%"><s:text name="label.common.name" />
								</th>
								<th width="31%"><s:text
										name="label.common.registrationDate" />
								</th>
							</tr>
							<s:iterator value="users" status="status">
								<tr id="user_<s:property value="#status.index"/>">
									<td align="center"><s:if test="#status.index == 0">
											<s:radio name="userId"
												list="#{users[#status.index].id:''}"
												value="users[#status.index].id" />
										</s:if> <s:else>
											<s:radio name="userId"
												list="#{users[#status.index].id:''}" />
										</s:else>
									<td><s:property value="users[#status.index].name" />
									</td>
									</td>
									<td><s:property
											value="users[#status.index].firstName" /> <s:property
											value="users[#status.index].lastName" /></td>
									<td><s:property
											value="users[#status.index].d.createdOn" />
									</td>
								</tr>
							</s:iterator>
						</table>
                <div id="submit" align="center" class="spacingAtTop">
                    <s:submit cssClass="buttonGeneric" value="%{getText('label.manageCustomerUsers.selectUser')}" 
						type="input"  action="forward_to_update_user" />
                </div>
						</div>
					</s:if>
			</s:form>
		</div>
    </div>
</u:body>
</html>