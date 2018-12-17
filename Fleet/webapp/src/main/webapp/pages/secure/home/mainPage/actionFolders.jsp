<%--
  Created by IntelliJ IDEA.
  User: pradyot.rout
  Date: Nov 20, 2008
  Time: 7:42:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="t" uri="twms"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="authz" uri="authz"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>
<html>
<head>
<title>Action Folders Page</title>
</head>
<tr>
    <td>&nbsp;</td>
</tr>
<tr>
    <td>&nbsp;</td>
</tr>
<tr>
    <td class="ItemsHdrAction"><spring:message code="label.common.actionFolders" /></td>
</tr>
<authz:ifPermitted resource="serviceRequestInboxes">
<tr>
<td><b style='margin-left: 46px;font-size:11px;'><spring:message code="label.common.serviceRequests" /></b></td>
</tr>
    <c:forEach items="${folders.serviceRequestFolders}" var="top" varStatus="status">
       <c:set var="serviceRequestFolderInboxCounter" value="${top[2]}" />
        <c:if test="${serviceRequestFolderInboxCounter>0}">
            <tr>
                <td class="ItemsLabels"><span class="dash-points-icon"></span>
                <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                       id="inside_serviceRequest_${top[0]}" tagType="a" 
                       tabLabel="${top[3]}" url="serviceRequestFolder.action?folderName=${top[1]}"
                       catagory="myServiceRequests" helpCategory="%{getHtmlFileBasedOnFolderName('Claims',${top[3]})}">
                       ${top[3]} (<span class="count">${top[2]}</span>)
                 </u:openTab>
                  <script type="text/javascript" language="javascript">
                        dojo.addOnLoad(function() {
                             dojo.connect(dojo.byId("inside_serviceRequest_${top[0]}"), "onmousedown", function(event) {
                              event.folderName = "${top[1]}";
                              autoRefreshFolderCount(event);
                              refreshManager.register("inside_serviceRequest_${top[0]}",
                                    "${top[1]}", "serviceRequestFolders.action");
                          });
                        });
                    </script>
                </td>
            </tr>
        </c:if>
    </c:forEach>
</authz:ifPermitted>
<authz:ifPermitted resource="dealerOwnedServiceRequestInboxes">
<tr>
<td><b style='margin-left: 46px;font-size:11px;'><spring:message code="label.common.dealerOwnedServiceRequests" /></b></td>
</tr>
    <c:forEach items="${folders.serviceRequestFoldersForDealerOwnedUsers}" var="top" varStatus="status">
       <c:set var="serviceRequestFolderInboxCounter" value="${top[2]}" />
        <c:if test="${serviceRequestFolderInboxCounter>0}">
            <tr>
                <td class="ItemsLabels"><span class="dash-points-icon"></span>
                <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                       id="inside_serviceRequest_${top[0]}" tagType="a" 
                       tabLabel="${top[3]}" url="serviceRequestFolder.action?folderName=${top[1]}"
                       catagory="myServiceRequests" helpCategory="%{getHtmlFileBasedOnFolderName('Claims',${top[3]})}">
                       ${top[3]} (<span class="count">${top[2]}</span>)
                 </u:openTab>
                  <script type="text/javascript" language="javascript">
                        dojo.addOnLoad(function() {
                             dojo.connect(dojo.byId("inside_serviceRequest_${top[0]}"), "onmousedown", function(event) {
                              event.folderName = "${top[1]}";
                              autoRefreshFolderCount(event);
                              refreshManager.register("inside_serviceRequest_${top[0]}",
                                    "${top[1]}", "serviceRequestFolders.action");
                          });
                        });
                    </script>
                </td>
            </tr>
        </c:if>
    </c:forEach>
</authz:ifPermitted>
<authz:ifPermitted resource="quoteInboxes">
<tr>
<td><b style='margin-left: 46px;font-size:11px'><spring:message code="label.common.quotes" /></b></td>
</tr>
    <c:forEach items="${folders.quoteFolders}" var="top" varStatus="status">
       <c:set var="quoteFolderInboxCounter" value="${top[2]}" />
        <c:if test="${quoteFolderInboxCounter>0}">
            <tr>
                <td class="ItemsLabels"><span class="dash-points-icon"></span>
                <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
		               id="inside_quotes_${top[0]}" tagType="a" 
		               tabLabel="${top[3]}" url="quotes.action?folderName=${top[1]}"
		               catagory="myQuotes" helpCategory="%{getHtmlFileBasedOnFolderName('Claims',${top[3]})}">
		               ${top[3]} (<span class="count">${top[2]}</span>)
		         </u:openTab>
                  <script type="text/javascript" language="javascript">
                        dojo.addOnLoad(function() {
                             dojo.connect(dojo.byId("inside_quotes_${top[0]}"), "onmousedown", function(event) {
                              event.folderName = "${top[1]}";
                              autoRefreshFolderCount(event);
                              refreshManager.register("inside_quotes_${top[0]}",
                                    "${top[1]}", "quoteFolders.action");
                          });
                        });
                    </script>
                </td>
            </tr>
        </c:if>
    </c:forEach>
    
</authz:ifPermitted>
    
<authz:ifPermitted resource="dealerOwnedQuoteInboxes"> 
<tr>
<td><b style='margin-left: 46px;font-size:11px'><spring:message code="label.common.dealerOwnedquotes" /></b></td>
</tr>   
    <c:forEach items="${folders.quoteFoldersForDealerOwnedUsers}" var="top" varStatus="status">
       <c:set var="quoteFolderInboxCounter" value="${top[2]}" />
        <c:if test="${quoteFolderInboxCounter>0}">
            <tr>
                <td class="ItemsLabels"><span class="dash-points-icon"></span>
                <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
		               id="inside_quotes_${top[0]}" tagType="a" 
		               tabLabel="${top[3]}" url="quotes.action?folderName=${top[1]}"
		               catagory="myQuotes" helpCategory="%{getHtmlFileBasedOnFolderName('Claims',${top[3]})}">
		               ${top[3]} (<span class="count">${top[2]}</span>)
		         </u:openTab>
                  <script type="text/javascript" language="javascript">
                        dojo.addOnLoad(function() {
                             dojo.connect(dojo.byId("inside_quotes_${top[0]}"), "onmousedown", function(event) {
                              event.folderName = "${top[1]}";
                              autoRefreshFolderCount(event);
                              refreshManager.register("inside_quotes_${top[0]}",
                                    "${top[1]}", "quoteFolders.action");
                          });
                        });
                    </script>
                </td>
            </tr>
        </c:if>
    </c:forEach>
</authz:ifPermitted>
<authz:ifPermitted resource="claimInboxes">
<tr>
<td><b style='margin-left: 46px;font-size:11px;'><spring:message code="accordion_jsp.accordionPane.myclaims" /></b></td>
</tr>
    <c:forEach items="${folders.fleetClaimFolders}" var="top" varStatus="status">
       <c:set var="fleetClaimFolderInboxCounter" value="${top[2]}" />
        <c:if test="${fleetClaimFolderInboxCounter>0}">
            <tr>
                <td class="ItemsLabels"><span class="dash-points-icon"></span>
                <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                       id="inside_fleetClaim_${top[0]}" tagType="a" 
                       tabLabel="${top[3]}" url="fleetClaims.action?folderName=${top[1]}"
                       catagory="myFleetClaims" helpCategory="%{getHtmlFileBasedOnFolderName('Claims',${top[3]})}">
                       ${top[3]} (<span class="count">${top[2]}</span>)
                 </u:openTab>
                  <script type="text/javascript" language="javascript">
                        dojo.addOnLoad(function() {
                             dojo.connect(dojo.byId("inside_fleetClaim_${top[0]}"), "onmousedown", function(event) {
                              event.folderName = "${top[1]}";
                              autoRefreshFolderCount(event);
                              refreshManager.register("inside_fleetClaim_${top[0]}",
                                    "${top[1]}", "fleetClaimFolders.action");
                          });
                        });
                    </script>
                </td>
            </tr>
        </c:if>
    </c:forEach>
</authz:ifPermitted>
<authz:ifPermitted resource="dealerOwnedclaimInboxes">
<tr>
<td><b style='margin-left: 46px;font-size:11px;'><spring:message code="label.common.dealerOwnedFleetClaims" /></b></td>
</tr>
    <c:forEach items="${folders.fleetClaimFoldersForDealerOwnedUsers}" var="top" varStatus="status">
       <c:set var="fleetClaimFolderInboxCounter" value="${top[2]}" />
        <c:if test="${fleetClaimFolderInboxCounter>0}">
            <tr>
                <td class="ItemsLabels"><span class="dash-points-icon"></span>
                <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                       id="inside_fleetClaim_${top[0]}" tagType="a" 
                       tabLabel="${top[3]}" url="fleetClaims.action?folderName=${top[1]}"
                       catagory="myFleetClaims" helpCategory="%{getHtmlFileBasedOnFolderName('Claims',${top[3]})}">
                       ${top[3]} (<span class="count">${top[2]}</span>)
                 </u:openTab>
                  <script type="text/javascript" language="javascript">
                        dojo.addOnLoad(function() {
                             dojo.connect(dojo.byId("inside_fleetClaim_${top[0]}"), "onmousedown", function(event) {
                              event.folderName = "${top[1]}";
                              autoRefreshFolderCount(event);
                              refreshManager.register("inside_fleetClaim_${top[0]}",
                                    "${top[1]}", "fleetClaimFolders.action");
                          });
                        });
                    </script>
                </td>
            </tr>
        </c:if>
    </c:forEach>
</authz:ifPermitted>
<authz:ifPermitted resource="invoiceInboxes">
<tr>
<td><b style='margin-left: 46px;font-size:11px;'><spring:message code="accordion_jsp.accordionPane.preInvoices" /></b></td>
</tr>
    <c:forEach items="${folders.fleetClaimFolders}" var="top" varStatus="status">
       <c:set var="fleetClaimFolderInboxCounter" value="${top[2]}" />
        <c:if test="${fleetClaimFolderInboxCounter>0}">
            <tr>
                <td class="ItemsLabels"><span class="dash-points-icon"></span>
                <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                       id="inside_fleetClaim_${top[0]}" tagType="a" 
                       tabLabel="${top[3]}" url="fleetClaims.action?folderName=${top[1]}"
                       catagory="myFleetClaims" helpCategory="%{getHtmlFileBasedOnFolderName('Claims',${top[3]})}">
                       ${top[3]} (<span class="count">${top[2]}</span>)
                 </u:openTab>
                  <script type="text/javascript" language="javascript">
                        dojo.addOnLoad(function() {
                             dojo.connect(dojo.byId("inside_fleetClaim_${top[0]}"), "onmousedown", function(event) {
                              event.folderName = "${top[1]}";
                              autoRefreshFolderCount(event);
                              refreshManager.register("inside_fleetClaim_${top[0]}",
                                    "${top[1]}", "fleetClaimFolders.action");
                          });
                        });
                    </script>
                </td>
            </tr>
        </c:if>
    </c:forEach>
</authz:ifPermitted>

</html>