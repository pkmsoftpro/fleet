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
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="CreateQuoteSearch" tagType="li" cssClass="quote_folder folder"
                tabLabel="label.defineSearch.quote" lazyConnect="false" url="../new_search_expression.action?context=QuoteSearches&folderName=Quotes Search" catagory="myquote"
                helpCategory="quote/Search_Claims.htm">
                <s:text name="accordion_jsp.accordionPane.quote.defineSearch.quote" />
              
            </u:openTab>

            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="quoteQuickSearch" tagType="li" cssClass="claims_folder folder"
                tabLabel="title.quote.quotesSearch" lazyConnect="false" url="../showPreDefinedQuoteSearch" catagory="myQuotes">
                <s:text name="label.quote.preDefinedSearch" />
            </u:openTab>
        </ol>

        <s:iterator value="definedQuoteSearchSavedQueries" status="savedQueriesIter">
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_business_search_subqds_[%{#savedQueriesIter.index}]" tagType="li"
                cssClass="claims_folder folder" tabLabel="%{getDomainPredicate().getName()}"
                url="../dynamicQuoteSearchResult.action?
                    context=QuoteSearches&
                    folderName=Quotes Search&
                    domainPredicateId=%{getDomainPredicate().getId()}&savedQueryId=%{getId()}" lazyConnect="false"
                catagory="myQuotes" helpCategory="Claims/Search_Claims.htm">
                <s:text name="%{getDomainPredicate().getName()}" />
            </u:openTab>
        </s:iterator>



        <s:iterator value="preDefinedQuoteSavedQueries" status="savedQueriesIter">
            <s:url var="theUrl" action="showPreDefinedQuoteSearchResults.action" escapeAmp="false">
                <s:param name="context">QuoteSearches</s:param>
                <s:param name="folderName">Quotes Search</s:param>
                <s:param name="queryId" value="%{preDefinedQuoteSavedQueries[#savedQueriesIter.index].id}" />
                <s:param name="savedQueryName" value="%{preDefinedQuoteSavedQueries[#savedQueriesIter.index].searchQueryName}" />
                <s:param name="notATemporaryQuery">true</s:param>
            </s:url>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_preDefined_business_search_subsquotes_[%{#savedQueriesIter.index}]"
                tagType="li" cssClass="claims_folder folder" tabLabel="%{preDefinedQuoteSavedQueries[#savedQueriesIter.index].searchQueryName}" lazyConnect="false" url="%{#theUrl}"
                catagory="myQuotes" helpCategory="Claims/Search_Claims.htm">
                <s:text name="%{preDefinedQuoteSavedQueries[#savedQueriesIter.index].searchQueryName}" />
            </u:openTab>
        </s:iterator>

    </ol>
</u:jsVar>
