
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>
<script type="text/javascript">
    dojo.require("dijit.layout.ContentPane");
</script>

<%-- Fleet Admin Accordion --%> 
<authz:ifPermitted resource="fleetAdminTab">
    <jsp:include page="accordionTabs/fleetadmin.jsp"/>
</authz:ifPermitted>

<%--Contracts  Accordion --%>
<authz:ifPermitted resource="contractManagementTab">
    <jsp:include page="accordionTabs/contractDetails.jsp" />
</authz:ifPermitted>

<!-- Dealer Creation Accordian -->
<authz:ifPermitted resource="dealerManagementTab">
	<jsp:include page="accordionTabs/dealermenu.jsp"/>
</authz:ifPermitted>	

<%--Dealer Sub Contract Accordion --%>
<authz:ifPermitted resource="subContractsTab">
    <jsp:include page="accordionTabs/dealerSubContracts.jsp"/>
</authz:ifPermitted>

<%--Customer Management  Accordion --%>
<authz:ifPermitted resource="customerManagementTab">
    <jsp:include page="accordionTabs/customerManagement.jsp"/>
</authz:ifPermitted>

<%--Equipment Management  Accordion --%>

<authz:ifPermitted resource="equipmentManagementTab">
 <jsp:include page="accordionTabs/equipmentManagement.jsp"/>
</authz:ifPermitted>
 
 <%-- <jsp:include page="accordionTabs/equipmentManagement.jsp"/> --%>

<%--Service Request  Accordion --%>
<authz:ifPermitted resource="serviceRequestTab">
    <jsp:include page="accordionTabs/serviceRequest.jsp"/>
</authz:ifPermitted>

<%--Periodic Services Accordion --%>
<authz:ifPermitted resource="periodicServiceTab">
    <jsp:include page="accordionTabs/periodicService.jsp"/>
</authz:ifPermitted> 
<%-- Quote Accordion --%>
<authz:ifPermitted resource="quoteTab">
    <jsp:include page="accordionTabs/quote.jsp"/>
</authz:ifPermitted>

<%-- Claim Accordion --%>
<authz:ifPermitted resource="claimTab">
    <jsp:include page="accordionTabs/fleetClaim.jsp"/>
</authz:ifPermitted>


<%-- Inventory Accordion --%>
<authz:ifPermitted resource="equipmentManagementTab">
<jsp:include page="accordionTabs/fleetInventory.jsp"/>
</authz:ifPermitted>

<%-- Uploads Accordion --%>
<authz:ifPermitted resource="uploadsTab">
    <jsp:include page="accordionTabs/reports.jsp"/>
</authz:ifPermitted>

<authz:ifPermitted resource="messagesAndBulletinsTab">
    <jsp:include page="accordionTabs/messagesAndBulletins.jsp"/>
</authz:ifPermitted>

<%-- Claim Accordion --%>
<authz:ifPermitted resource="invoiceTab">
    <jsp:include page="accordionTabs/fleetInvoice.jsp"/>
</authz:ifPermitted>
<authz:ifPermitted resource="dealerOwnedInvoiceTab">
	<jsp:include page="accordionTabs/invoice.jsp" />
</authz:ifPermitted>
<%-- Settings Accordion Pane --%>
<jsp:include page="accordionTabs/settings.jsp"/> 

<%-- Account Accordion --%>
 <authz:ifPermitted resource="accountsAccountsTab">
	<jsp:include page="accordionTabs/accounts.jsp"/>
 </authz:ifPermitted>