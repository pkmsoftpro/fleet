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

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<html>
  <head>
      <s:head theme="twms"/>
      <title><s:text name="title.newClaim.submitResponse"/></title>
       <u:stylePicker fileName="common.css"/>
  </head>
  <u:body>
    <u:actionResults wipeMessages="false"/>
    <s:form name="internationalizeCampaign" >
    	<s:hidden name="additionalAttributes" value="%{additionalAttributes.id}"></s:hidden>
    <s:if test="!isDeleted() && showI18nButton">
     	<s:submit id = "internationalizeAdditionalAttributes"
      		value="%{getText('label.common.internationalizeAdditionalAttribute')}" 
     		cssClass="buttonGeneric" action="internationalizeAttributeName"/>
     </s:if>
    </s:form> 
  </u:body>
</html>