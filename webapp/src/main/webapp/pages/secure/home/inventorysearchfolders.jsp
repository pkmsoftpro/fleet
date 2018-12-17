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
        <ol>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="fleetInventorySearch" tagType="li" cssClass="claims_folder folder"
                tabLabel="accordion_jsp.accordionPane.searchInventory" url="../preDefinedFleetInventorySearch" lazyConnect="false" catagory="inventory">
                <s:text name="label.common.preDefinedSearch" />
            </u:openTab>
        </ol>
        <s:iterator value="preDefinedInventoryRetailSavedQueries" status="savedQueriesIter">
            <s:url var="theUrl" action="showPreDefinedInventorySearchResults.action" escapeAmp="false">
                <s:param name="context">InventorySearches</s:param>
                <s:param name="folderName">Inventory Search</s:param>
                <s:param name="queryId" value="%{preDefinedInventoryRetailSavedQueries[#savedQueriesIter.index].id}" />
                <s:param name="savedQueryName" value="%{preDefinedInventoryRetailSavedQueries[#savedQueriesIter.index].searchQueryName}" />
                <s:param name="notATemporaryQuery">true</s:param>
            </s:url>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_preDefined_business_search_subsINV_[%{#savedQueriesIter.index}]" tagType="li"
                cssClass="claims_folder folder" tabLabel="%{preDefinedInventoryRetailSavedQueries[#savedQueriesIter.index].searchQueryName}" lazyConnect="false" url="%{#theUrl}"
                catagory="myInventory" helpCategory="Claims/Search_Claims.htm">
                <s:text name="%{preDefinedInventoryRetailSavedQueries[#savedQueriesIter.index].searchQueryName}" />
            </u:openTab>
        </s:iterator>
    </ol>
</u:jsVar>
