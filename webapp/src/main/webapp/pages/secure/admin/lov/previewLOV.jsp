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
<%response.setHeader( "Pragma", "no-cache" );
response.addHeader( "Cache-Control", "must-revalidate" );
response.addHeader( "Cache-Control", "no-cache" );
response.addHeader( "Cache-Control", "no-store" );
response.setDateHeader("Expires", 0); %>

<html>
<head>
    <meta http-equiv="Context-Type" content="text/html; charset=ISO-8859-1">
    <title><s:text name="title.common.warranty"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="common.css"/>
</head>
	
	<u:body>
		<div class="policy_section_div">
			<div class="section_header">
				<s:property value="capitalisedLOVTypeName"/>
			</div>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="grid">
			<tbody>
				<tr>
			  	<td><s:text name="label.listOfValues.code"/></td>
			  	<td><s:property value="listOfValues.code"/></td>
			  </tr>
			  <tr>
			  	<td><s:text name="label.common.description"/></td>
			  	<td><s:property value="listOfValues.description"/></td>
			  </tr>
			  <tr>
			  	<td><s:text name="label.common.status"/></td>
			  	<td><s:property value="listOfValues.state"/></td>
			  </tr>
			</tbody>
			</table>
		</div>
	</u:body>
</html>