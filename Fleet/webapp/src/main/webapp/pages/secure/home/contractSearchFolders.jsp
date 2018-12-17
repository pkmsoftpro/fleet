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
			<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="CreateContractSearch" tagType="li" cssClass="contract_folder folder"
                tabLabel="label.defineSearch.contract" lazyConnect="false" url="../new_search_expression.action?context=ContractSearches&folderName=Contracts Search"
                catagory="myContractSearch" helpCategory="contract/Search_Claims.htm">
                 <s:text name="accordion_jsp.accordionPane.contract.defineSearch" />                
            </u:openTab>
        
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="contractQuickSearch" tagType="li" cssClass="claims_folder folder"
                tabLabel="label.contract.contractSearch" lazyConnect="false" url="../showPreDefinedContractSearch" catagory="myContractSearch">
                <s:text name="accordion_jsp.accordionPane.contract.preDefineSearch" />
            </u:openTab>
        </ol>
    
    <s:iterator value="definedContractSearchSavedQueries" status="savedQueriesIter">
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_business_search_subsds_Con_[%{#savedQueriesIter.index}]" tagType="li"
                cssClass="claims_folder folder" tabLabel="%{getDomainPredicate().getName()}" lazyConnect="false"
                url="../dynamicContractSearchResult.action?
                    context=ContractSearches&
                    folderName=Contracts Search&
                    domainPredicateId=%{getDomainPredicate().getId()}&savedQueryId=%{getId()}"
                catagory="myClaims" helpCategory="Claims/Search_Claims.htm">
                <s:text name="%{getDomainPredicate().getName()}" />
            </u:openTab>
     </s:iterator>
      <s:iterator value="preDefinedContractSavedQueries" status="savedQueriesIter">
            <s:url var="theUrl" action="showPreDefinedContractSearchResults.action" escapeAmp="false">
                <s:param name="context">ContractSearches</s:param>
                <s:param name="folderName">Contracts Search</s:param>
                <s:param name="queryId" value="%{preDefinedContractSavedQueries[#savedQueriesIter.index].id}" />
                <s:param name="savedQueryName" value="%{preDefinedContractSavedQueries[#savedQueriesIter.index].searchQueryName}" />
                <s:param name="notATemporaryQuery">true</s:param>
            </s:url>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_preDefined_business_search_subsCon_[%{#savedQueriesIter.index}]" tagType="li"
                cssClass="claims_folder folder" tabLabel="%{preDefinedContractSavedQueries[#savedQueriesIter.index].searchQueryName}" lazyConnect="false" url="%{#theUrl}"
                catagory="myContracts" helpCategory="Claims/Search_Claims.htm">
                <s:text name="%{preDefinedContractSavedQueries[#savedQueriesIter.index].searchQueryName}" />
            </u:openTab>
        </s:iterator>
      </ol>  
</u:jsVar>