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
  <!-- This section displays the quick search Links based on the roles-->
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr><td>&nbsp;</td></tr>
			<tr><td>&nbsp;</td></tr>
            <tr>
                <td class="ItemsHdrQuickSearch"><spring:message code="label.common.quickSearch"/></td>
            </tr>
            <authz:ifPermitted resource="searchQuotes">
                <tr>
                    <td class="ItemsLabels">
                    <span class="dash-points-icon"></span>
                    <u:openTab decendentOf="home_jsp.tabs.home"
                        id="quoteSearch" tagType="a"
                        cssClass="claims_folder folder"
                        tabLabel="label.quote.searchQuotes"
                        url="../showPreDefinedQuoteSearch" catagory="myQuotesSearch"
                        helpCategory="Claims/Claim_Submission.htm">
                         <spring:message code="label.quote.quickSearch"/>
                      </u:openTab>
                    </td>
                </tr>
               </authz:ifPermitted>
<%--     <authz:ifUserInRole roles="customer">
        <tr>
            <td class="ItemsLabels"><span class="dash-points-icon"></span> <u:openTab decendentOf="home_jsp.tabs.home"
                    id="customerLocationQuickSearch" tagType="a" cssClass="claims_folder folder" tabLabel="label.common.quickSearch"
                    url="../showPreDefinedCustomerLocationSearch" catagory="myClaims" helpCategory="Claims/Claim_Submission.htm">
                    <spring:message code="label.customerLocation.search" />
                </u:openTab></td>
        </tr>
      </authz:ifUserInRole>   --%>
	<authz:ifPermitted resource="searchServiceRequests">
		<tr>
			<td class="ItemsLabels"><span class="dash-points-icon"></span> <u:openTab
					decendentOf="home_jsp.tabs.home" id="serviceRequestSearch"
					tagType="a" cssClass="claims_folder folder"
					tabLabel="label.serviceRequest.SearchServiceRequestTitile"
					url="../showPreDefinedServiceRequestSearch"
					catagory="myServiceRequestSearch"
					helpCategory="Claims/Claim_Submission.htm">
					<spring:message code="label.serviceRequest.quickSearch" />
				</u:openTab></td>
		</tr>
	</authz:ifPermitted>

	<authz:ifPermitted resource="customerSearch">
        <tr>
            <td class="ItemsLabels"><span class="dash-points-icon"></span> <u:openTab decendentOf="home_jsp.tabs.home"
                    id="customerQuickSearch" tagType="a" cssClass="claims_folder folder" tabLabel="label.customer.customerSearch"
                    url="../showPreDefinedCustomerSearch" catagory="myCustomerSearch" helpCategory="Claims/Claim_Submission.htm">
                    <spring:message code="label.customer.customerSearch" />
                </u:openTab>
            </td>
        </tr>
    </authz:ifPermitted>

<%--                     <tr>
                    <td class="ItemsLabels">
                    <span class="dash-points-icon"></span>
                    <u:openTab decendentOf="home_jsp.tabs.home"
                        id="inventorySearch" tagType="a"
                        cssClass="claims_folder folder"
                        tabLabel="label.common.quickSearch"
                        url="showManageInventorySearch" catagory="myCustomers"
                        helpCategory="Claims/Claim_Submission.htm">
                         <spring:message code="label.inventory.quickSearch"/>
                      </u:openTab>
                    </td>
                </tr>
 --%>
	<authz:ifPermitted resource="searchEquipment">
		<tr>
			<td class="ItemsLabels"><span class="dash-points-icon"></span> <u:openTab
					decendentOf="home_jsp.tabs.home" id="inventoryPreDefinedSearch"
					tagType="a" cssClass="claims_folder folder"
					tabLabel="label.inventory.searchInventory"
					url="../preDefinedFleetInventorySearch" catagory="myInvSearch">
					<spring:message code="label.inventory.quickSearch" />
				</u:openTab></td>
		</tr>
	</authz:ifPermitted>
  <authz:ifPermitted resource="searchPeriodicServices">
	<tr>
        <td class="ItemsLabels">
            <span class="dash-points-icon"></span>
            <u:openTab decendentOf="home_jsp.tabs.home"
                id="periodicServiceSearch" tagType="a"
                cssClass="claims_folder folder"
                tabLabel="title.periodicService.searchPeriodicServices"
                url="../showPreDefinedPeriodicServiceSearch" catagory="myPeriodicServiceSearch"
                helpCategory="Claims/Claim_Submission.htm">
                <spring:message code="label.periodicService.quickSearch"/>
            </u:openTab>
        </td>
   </tr>
  </authz:ifPermitted>
	<authz:ifPermitted resource="searchClaims">
		<tr>
			<td class="ItemsLabels"><span class="dash-points-icon"></span> <u:openTab
					decendentOf="home_jsp.tabs.home" id="fleetClaimSearch" tagType="a"
					cssClass="claims_folder folder" tabLabel="title.claim.claimSearch"
					url="../showPreDefinedFleetClaimSearch"
					catagory="myFleetClaimsSearch"
					helpCategory="Claims/Claim_Submission.htm">
					<spring:message code="label.fleetClaim.fleetClaims" />
				</u:openTab>
			</td>
		</tr>
	</authz:ifPermitted>
	<authz:ifPermitted resource="contractSearch">
		<tr>
			<td class="ItemsLabels"><span class="dash-points-icon"></span> <u:openTab
					decendentOf="home_jsp.tabs.home" id="contractSearch" tagType="a"
					cssClass="claims_folder folder" tabLabel="label.contract.contractSearch"
					url="../showPreDefinedContractSearch"
					catagory="myContractSearch"
					helpCategory="Claims/Claim_Submission.htm">
					<spring:message code="label.contract.contract" />
				</u:openTab>
			</td>
		</tr>
	</authz:ifPermitted>


</table>