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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>

<div dojoType="dijit.layout.ContentPane" id="customerManagement"
	 iconClass="myclaims cust-mgmt-icon" title="<s:text name="accordion_jsp.accordionPane.customerManagement" />" >
	<div dojoType="dijit.layout.ContentPane">
    
      <authz:ifPermitted resource="createDealerOwnedCustomer">
            <ol>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="createCustomer" tagType="li"
                cssClass="claims_folder folder"
                tabLabel="label.customer.createCustomer"
                url="createCustomer.action?folderName='Create Customer'" catagory="myCustomers">
                <spring:message code="label.customer.createCustomer"/>
            </u:openTab>
        </ol>
    </authz:ifPermitted>
    
    <authz:ifPermitted resource="customerListing">
		<ol>
			<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
				id="customerListing" tagType="li"
				cssClass="claims_folder folder"
				tabLabel="label.customer.listing"
				url="listCustomers.action?folderName='List Customers'" catagory="myCustomers">
				<spring:message code="label.customer.listing"/>
			</u:openTab>
		</ol>
        </authz:ifPermitted>

		<authz:ifPermitted resource="customerSearch">
			<t:daSection id="customerSearchFolders"
				fetchFrom="../customerSearchFolders"
				fetchOn="/accordion/refreshsearchfolders"
				title="%{getText('accordionLabel.viewCustomer.searchFolders')}"
				appendMode="false" cssClass="searchFolders" />
		</authz:ifPermitted>
	</div>
</div>