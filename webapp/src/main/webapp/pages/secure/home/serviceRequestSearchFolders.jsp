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

            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="CreateServiceRequestSearch" tagType="li" cssClass="serviceRequest_folder folder"
                tabLabel="label.defineSearch.serviceRequest" lazyConnect="false" url="../new_search_expression.action?context=ServiceRequestSearches&folderName=Search"
                catagory="myServiceRequests" helpCategory="serviceRequest/Search_Claims.htm">
                 <s:text name="accordion_jsp.accordionPane.serviceRequest.defineSearch.serviceRequest" />
                
            </u:openTab>

            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="serviceRequestQuickSearch" tagType="li" cssClass="claims_folder folder"
                tabLabel="label.serviceRequest.SearchServiceRequestTitile" lazyConnect="false" url="../showPreDefinedServiceRequestSearch" catagory="myServiceRequests">
                <s:text name="label.serviceRequest.searchServiceRequest" />
            </u:openTab>
        </ol>
        <s:iterator value="definedServiceRequestSearchSavedQueries" status="savedQueriesIter">
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_business_search_subsds_[%{#savedQueriesIter.index}]" tagType="li"
                cssClass="claims_folder folder" tabLabel="%{getDomainPredicate().getName()}"
                url="../dynamicServiceRequestSearchResult.action?
                    context=ServiceRequestSearches&
                    folderName=Search&
                    domainPredicateId=%{getDomainPredicate().getId()}&savedQueryId=%{getId()}" lazyConnect="false"
                catagory="myClaims" helpCategory="Claims/Search_Claims.htm">
                <s:text name="%{getDomainPredicate().getName()}" />
            </u:openTab>
        </s:iterator>
        <s:iterator value="preDefinedServiceRequestSavedQueries" status="savedQueriesIter">
            <s:url var="theUrl" action="showPreDefinedServiceRequestSearchResults.action" escapeAmp="false">
                <s:param name="context">ServiceRequestSearches</s:param>
                <s:param name="folderName">Search</s:param>
                <s:param name="queryId" value="%{preDefinedServiceRequestSavedQueries[#savedQueriesIter.index].id}" />
                <s:param name="savedQueryName" value="%{preDefinedServiceRequestSavedQueries[#savedQueriesIter.index].searchQueryName}" />
                <s:param name="notATemporaryQuery">true</s:param>
            </s:url>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_preDefined_business_search_subs_[%{#savedQueriesIter.index}]" tagType="li"
                cssClass="claims_folder folder" tabLabel="%{preDefinedServiceRequestSavedQueries[#savedQueriesIter.index].searchQueryName}" lazyConnect="false" url="%{#theUrl}"
                catagory="myServiceRequests" helpCategory="Claims/Search_Claims.htm">
                <s:text name="%{preDefinedServiceRequestSavedQueries[#savedQueriesIter.index].searchQueryName}" />
            </u:openTab>
        </s:iterator>

    </ol>
</u:jsVar>
