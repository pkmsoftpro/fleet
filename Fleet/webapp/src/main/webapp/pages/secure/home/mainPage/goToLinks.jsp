<%--
  Created by IntelliJ IDEA.
  User: pradyot.rout
  Date: Nov 20, 2008
  Time: 7:24:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="t" uri="twms" %>
<%@ taglib prefix="u" uri="/ui-ext" %>
<%@ taglib prefix="authz" uri="authz" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
    <td class="ItemsHdrGoto"><s:text name="label.common.Goto"/></td>
</tr>
  <authz:ifPermitted resource="createQuote">
        <tr>
            <td class="ItemsLabels"><span class="dash-points-icon"></span> <a id="homeCreateQuote"
                style="padding-left: 5px"><spring:message code="label.quote.createQuote" /> </a>
            </td>
        </tr>
    </authz:ifPermitted> 
    <authz:ifPermitted resource="createServiceRequest">
        <tr>
            <td class="ItemsLabels"><span class="dash-points-icon"></span> <a id="homeCreateServiceRequest"
                style="padding-left: 5px"><spring:message code="label.newServiceRequest.createServiceRequest" /> </a>
            </td>
        </tr>
    </authz:ifPermitted>
     <authz:ifPermitted resource="createClaim">
        <tr>
            <td class="ItemsLabels"><span class="dash-points-icon"></span> <a id="homeCreateClaim"
                style="padding-left: 5px"><spring:message code="label.claim.createClaim" /> </a>
            </td>
        </tr>
    </authz:ifPermitted>

</table>