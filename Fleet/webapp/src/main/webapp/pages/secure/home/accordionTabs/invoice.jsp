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

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>

<div dojoType="dijit.layout.ContentPane" id="invoices" title="<s:text name="accordion_jsp.accordionPane.invoices" />" iconClass="myclaims claims-icon">
    <div dojoType="dijit.layout.ContentPane">
        <ol>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="generateInvoiceAccdordian" tagType="li" cssClass="claims_folder folder"
                tabLabel="label.invoice.generateInvoice" url="generateInvoice" catagory="myFleetClaims" helpCategory="Claims/Claim_Submission.htm">
                <s:text name="label.invoice.generateInvoice" />
            </u:openTab>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="invoiceAccdordian" tagType="li" cssClass="claims_folder folder"
                tabLabel="label.common.invoices" url="invoices?folderName='invoice'" catagory="invoice" helpCategory="invoice/invoice.htm">
                <s:text name="label.common.invoices" />
            </u:openTab>
        </ol>
        <t:daSection id="customerInvoiceSearchFolders" fetchFrom="../invoiceSearchFolders" fetchOn="/accordion/refreshinvoicesearchfolders"
            title="%{getText('accordionLabel.common.searchFolders')}" appendMode="false" cssClass="searchFolders" />
    </div>
</div>
