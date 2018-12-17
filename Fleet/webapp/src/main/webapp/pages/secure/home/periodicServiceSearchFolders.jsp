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
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="periodicServiceQuickSearch" tagType="li" cssClass="claims_folder folder"
                tabLabel="title.periodicService.searchPeriodicServices" lazyConnect="false" url="../showPreDefinedPeriodicServiceSearch" catagory="myPeriodicService">
                <s:text name="label.periodicService.preDefinedSearch" />
            </u:openTab>
        </ol>

        <s:iterator value="preDefinedPeriodicServiceSavedQueries" status="savedQueriesIter">
            <s:url var="theUrl" action="showPreDefinedPeriodicServiceSearchResults.action" escapeAmp="false">
                <s:param name="context">PeriodicServiceSearches</s:param>
                <s:param name="folderName">Periodic Services Search</s:param>
                <s:param name="queryId" value="%{preDefinedPeriodicServiceSavedQueries[#savedQueriesIter.index].id}" />
                <s:param name="savedQueryName" value="%{preDefinedPeriodicServiceSavedQueries[#savedQueriesIter.index].searchQueryName}" />
                <s:param name="notATemporaryQuery">true</s:param>
            </s:url>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_preDefined_business_search_subsQR_[%{#savedQueriesIter.index}]" tagType="li"
                cssClass="claims_folder folder" tabLabel="%{preDefinedPeriodicServiceSavedQueries[#savedQueriesIter.index].searchQueryName}" lazyConnect="false" url="%{#theUrl}"
                catagory="myPeriodicService" helpCategory="Claims/Search_Claims.htm">
                <s:text name="%{preDefinedPeriodicServiceSavedQueries[#savedQueriesIter.index].searchQueryName}" />
            </u:openTab>
        </s:iterator>

    </ol>
</u:jsVar>
