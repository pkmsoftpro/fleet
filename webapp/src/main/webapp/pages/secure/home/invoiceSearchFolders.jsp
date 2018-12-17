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

<u:jsVar ajaxMode="true">
    <ol>
        <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="customerInvoiceQuickSearch" tagType="li" cssClass="claims_folder folder"
            tabLabel="label.invoice.searchInvoice" url="../showPreDefinedInvoiceSearch" lazyConnect="false" catagory="customerInvoiceSearch">
            <s:text name="accordion_jsp.accordionPane.searchInvoice" />
        </u:openTab>
    </ol>
    <s:iterator value="preDefinedInvoiceSavedQueries" status="savedQueriesIter">
        <s:url var="theUrl" action="showPreDefinedInvoiceSearchResults.action" escapeAmp="false">
            <s:param name="context">InvoiceSearch</s:param>
            <s:param name="folderName">Invoice Search</s:param>
            <s:param name="queryId" value="%{preDefinedInvoiceSavedQueries[#savedQueriesIter.index].id}" />
            <s:param name="savedQueryName" value="%{preDefinedInvoiceSavedQueries[#savedQueriesIter.index].searchQueryName}" />
            <s:param name="notATemporaryQuery">true</s:param>
        </s:url>
        <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_preDefined_business_search_subsINVO_[%{#savedQueriesIter.index}]" tagType="li"
            cssClass="claims_folder folder" tabLabel="%{preDefinedInvoiceSavedQueries[#savedQueriesIter.index].searchQueryName}" lazyConnect="false" url="%{#theUrl}"
            catagory="myInvoice" helpCategory="Claims/Search_Claims.htm">
            <s:text name="%{preDefinedInvoiceSavedQueries[#savedQueriesIter.index].searchQueryName}" />
        </u:openTab>
    </s:iterator>
</u:jsVar>
