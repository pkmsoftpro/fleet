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
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="authz" uri="authz"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>

<div dojoType="dijit.layout.ContentPane" id="serviceRequest"
	 iconClass="myclaims serv-req-icon" title="<s:text name="accordion_jsp.accordionPane.serviceRequest" />" >
	<div dojoType="dijit.layout.ContentPane">
		<ol>
		<authz:ifPermitted resource="createServiceRequest">
			<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
				id="createServiceRequestAccdordian" tagType="li"
				cssClass="claims_folder folder"
				tabLabel="label.newServiceRequest.createServiceRequest"
				url="createServiceRequest" catagory="myClaims"
				helpCategory="Claims/Claim_Submission.htm">
				<s:text name="label.newServiceRequest.createServiceRequest" />
			</u:openTab>
			</authz:ifPermitted>
			<authz:ifPermitted resource="serviceRequestInboxes">
				<c:forEach items="${folders.serviceRequestFolders}" var="top"
					varStatus="status">
					<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
						id="service_${top[0]}" tagType="li"
						cssClass="claims_folder folder" tabLabel="${top[3]}"
						url="serviceRequestFolder.action?folderName=${top[1]}"
						catagory="myClaims"
						helpCategory="%{getHtmlFileBasedOnFolderName('ServiceRequest',${top[3]})}">
		               ${top[3]} (<span class="count">${top[2]}</span>)
		         </u:openTab>
					<script type="text/javascript" language="javascript">
						dojo.addOnLoad(function() {
							refreshManager
									.register("service_${top[0]}", "${top[1]}",
											"serviceRequestFolders.action");
						});
					</script>
				</c:forEach>
			</authz:ifPermitted>
			<authz:ifPermitted resource="dealerOwnedServiceRequestInboxes">
		   <span style="font-weight: bold;">Dealer Owned Service Request Inboxes</span>
		   <c:forEach items="${folders.serviceRequestFoldersForDealerOwnedUsers}" var="top"
					varStatus="status">
					<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
						id="service_${top[0]}" tagType="li"
						cssClass="claims_folder folder" tabLabel="${top[3]}"
						url="serviceRequestFolder.action?folderName=${top[1]}"
						catagory="myClaims"
						helpCategory="%{getHtmlFileBasedOnFolderName('ServiceRequest',${top[3]})}">
		               ${top[3]} (<span class="count">${top[2]}</span>)
		         </u:openTab>
					<script type="text/javascript" language="javascript">
						dojo.addOnLoad(function() {
							refreshManager
									.register("service_${top[0]}", "${top[1]}",
											"serviceRequestFolders.action");
						});
					</script>
		  </c:forEach>
          </authz:ifPermitted>
			<%-- <authz:ifUserNotInRole roles="customer"> 
			<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
				id="serviceRequestQuickSearch" tagType="li"
				cssClass="claims_folder folder"
				tabLabel="label.common.quickSearch"
				url="../showPreDefinedServiceRequestSearch" catagory="myClaims">
				 <s:text name="label.serviceRequest.searchServiceRequest" />
			</u:openTab>
		      </authz:ifUserNotInRole> --%>       
		</ol>
		<authz:ifPermitted resource="searchServiceRequests">
			<t:daSection id="serviceRequestSearchFolders"
				fetchFrom="../serviceRequestSearchFolders"
				fetchOn="/accordion/refreshservicerequestsearchfolders"
				title="%{getText('accordionLabel.common.searchFolders')}"
				appendMode="false" cssClass="searchFolders" />
		</authz:ifPermitted>
	</div>
</div>
