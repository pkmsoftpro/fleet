<%--
  Created by IntelliJ IDEA.
  User: pradyot.rout
  Date: Nov 20, 2008
  Time: 7:37:42 PM
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
  <!-- This section displays the External Links based on the roles-->
<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
            <tr>
                <td class="ItemsHdrGoto"><spring:message code="label.common.externalLinks"/></td>
            </tr>
            	<authz:ifPermitted resource="materialHandlingCentral">
                <tr>
                    <td class="ItemsLabels">
                    <span class="dash-points-icon"></span>
                      <a href="https://www.materialshandlingcentral.com/nmhg/login/login.jsp" target="_blank"><s:text name="label.externalLink.materialHandlingCentral" /></a>&nbsp;<span class=""></span>
                    </td>
                </tr>
                </authz:ifPermitted>
                <authz:ifPermitted resource="TVHParts">
                <tr>
                    <td class="ItemsLabels">
                    <span class="dash-points-icon"></span>
                      <a href="http://www.tvhamericas.com/" target="_blank"><s:text name="label.externalLink.TVHParts" /></a>&nbsp;<span class=""></span>
                    </td>
                </tr>
                </authz:ifPermitted>
                <authz:ifPermitted resource="equipmentWatch">
                <tr>
                    <td class="ItemsLabels">
                    <span class="dash-points-icon"></span>
                      <a href="http://www.equipmentwatch.com/" target="_blank"><s:text name="label.externalLink.equipmentWatch" /></a>&nbsp;<span class=""></span>
                    </td>
                </tr>
                </authz:ifPermitted>
                <authz:ifPermitted resource="hyster">
                <tr>
                    <td class="ItemsLabels">
                    <span class="dash-points-icon"></span>
                      <a href="http://www.hyster.com/north-america/en-us/" target="_blank"><s:text name="label.externalLink.hyster" /></a>&nbsp;<span class=""></span>
                    </td>
                </tr>
                </authz:ifPermitted>
                <authz:ifPermitted resource="yale">
                <tr>
                    <td class="ItemsLabels">
                    <span class="dash-points-icon"></span>
                      <a href="http://www.yale.com/north-america/en-us/" target="_blank"><s:text name="label.externalLink.yale" /></a>&nbsp;<span class=""></span>
                    </td>
                </tr>
                </authz:ifPermitted>
                <authz:ifPermitted resource="axcessOnline">
                <tr>
                    <td class="ItemsLabels">
                    <span class="dash-points-icon"></span>
                      <a href="http://www.yaleaxcessonline.com/eng/hme/index.cfm" target="_blank"><s:text name="label.externalLink.axcessOnline" /></a>&nbsp;<span class=""></span>
                    </td>
                </tr>
                </authz:ifPermitted>
                <authz:ifPermitted resource="hypassOnline">
                <tr>
                    <td class="ItemsLabels">
                    <span class="dash-points-icon"></span>
                      <a href="http://www.hypassonline.com/index.cfm" target="_blank"><s:text name="label.externalLink.hypassOnline" /></a>&nbsp;<span class=""></span>
                    </td>
                </tr>
                </authz:ifPermitted>                
                <authz:ifPermitted resource="fleetInternal">
                <tr>
                    <td class="ItemsLabels">
                    <span class="dash-points-icon"></span>
                      <a href="http://amerfleet/" target="_blank"><s:text name="label.externalLink.fleetInternal" /></a>&nbsp;<span class=""></span>
                    </td>
                </tr>
                </authz:ifPermitted>
                <authz:ifPermitted resource="trainingVideos">
                <tr>
                    <td class="ItemsLabels">
                    <span class="dash-points-icon"></span>
                      <a href="https://www.google.co.in" target="_blank"><s:text name="label.externalLink.trainingVideos" /></a>&nbsp;<span class=""></span>
                    </td>
                </tr>
                </authz:ifPermitted>             

</table>