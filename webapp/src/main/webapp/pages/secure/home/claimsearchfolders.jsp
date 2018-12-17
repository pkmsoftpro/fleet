<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	response.setHeader("Pragma", "no-cache");
	response.addHeader("Cache-Control", "must-revalidate");
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 0);
%>

<u:jsVar ajaxMode="true">
    <ol>
        <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="CreateClaimSearch" tagType="li" cssClass="claims_folder folder"
            tabLabel="%{getText('accordion_jsp.accordionPane.serviceRequest.defineSearch.claim')}" lazyConnect="false"
            url="../new_search_expression.action?context=FleetClaimSearches&folderName=FleetClaims Search" catagory="myFleetClaims"
            helpCategory="Claims/Search_Claims.htm">
          <s:text name="accordion_jsp.accordionPane.serviceRequest.defineSearch.claim"/>           
        </u:openTab>
        <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="fleetClaimSearch" tagType="li" cssClass="claims_folder folder"
            tabLabel="label.common.fleetClaimSearch" url="../showPreDefinedFleetClaimSearch" lazyConnect="false" catagory="myFleetClaims" helpCategory="Claims/Claim_Submission.htm">
            <spring:message code="label.fleetClaim.searchFleetClaim" />
        </u:openTab>
        <s:iterator value="definedFleetClaimSearchSavedQueries" status="savedQueriesIter">
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_business_search_subscds_[%{#savedQueriesIter.index}]" tagType="li"
                cssClass="claims_folder folder" tabLabel="%{getDomainPredicate().getName()}" lazyConnect="false"
                url="../dynamicFleetClaimSearchResult.action?
                    context=FleetClaimSearches&
                    folderName=FleetClaims Search&
                    domainPredicateId=%{getDomainPredicate().getId()}&savedQueryId=%{getId()}"
                catagory="myClaims" helpCategory="Claims/Search_Claims.htm">
                <s:text name="%{getDomainPredicate().getName()}" />
            </u:openTab>
        </s:iterator>
        <s:iterator value="preDefinedFleetCliamSavedQueries" status="savedQueriesIter">
            <s:url var="theUrl" action="showPreDefinedClaimSearchResults.action" escapeAmp="false">
                <s:param name="context">FleetClaimSearches</s:param>
                <s:param name="folderName">FleetClaims Search</s:param>
                <s:param name="queryId" value="%{preDefinedFleetCliamSavedQueries[#savedQueriesIter.index].id}" />
                <s:param name="savedQueryName" value="%{preDefinedFleetCliamSavedQueries[#savedQueriesIter.index].searchQueryName}" />
                <s:param name="notATemporaryQuery">true</s:param>
            </s:url>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_preDefined_business_search_subsclaim_[%{#savedQueriesIter.index}]" tagType="li"
                cssClass="claims_folder folder" tabLabel="%{preDefinedFleetCliamSavedQueries[#savedQueriesIter.index].searchQueryName}" lazyConnect="false" url="%{#theUrl}"
                catagory="myClaims" helpCategory="Claims/Search_Claims.htm">
                <s:text name="%{preDefinedFleetCliamSavedQueries[#savedQueriesIter.index].searchQueryName}" />
            </u:openTab>
        </s:iterator>
    </ol>

</u:jsVar>
