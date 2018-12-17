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
		<authz:ifUserNotInRole roles="receiverLimitedView, inspectorLimitedView">
			<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" lazyConnect="false"
				id="CreatePartReturnSearch" tagType="li" cssClass="partReturns_folder folder"
				tabLabel="%{getText('accordion_jsp.accordionPane.myClaims.defineSearch.partReturn')}"
				url="new_search_expression.action?context=PartReturnSearches" catagory="partReturns" helpCategory="Part_Returns/Search_Parts.htm">
				<span style="color:blue">
				<s:text name="accordion_jsp.accordionPane.myClaims.defineSearch" />
				</span>
			</u:openTab>
		</authz:ifUserNotInRole>
		<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" lazyConnect="false"
			id="PreDefinedPartReturnSearch" tagType="li" cssClass="partReturns_folder folder"
			tabLabel="%{getText('label.common.preDefinedSearch.partReturn')}"
			url="preDefined_search_PartReturn.action?context=PartReturnSearches" catagory="partReturns" helpCategory="Part_Returns/Search_Parts.htm">
			<span style="color:blue">
				<s:text name="label.common.preDefinedSearch" />
			</span>	
		</u:openTab>
		
		<authz:ifUserNotInRole roles="receiverLimitedView, inspectorLimitedView">
			<s:iterator value="savedQueriesForPartReturn" status="savedQueriesForPartReturnIter">
				<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" lazyConnect="false"
					id="manage_part_return_business_search_subs[%{#savedQueriesForPartReturnIter.index}]"
					tagType="li" cssClass="partReturns_folder folder"
					tabLabel="%{getDomainPredicate().getName()}"
					url="partReturnSearch.action?domainPredicateId=%{getDomainPredicate().getId()}&savedQueryId=%{getId()}"
					catagory="partReturns" helpCategory="Part_Returns/Search_Parts.htm">
					<s:text name="%{getDomainPredicate().getName()}" />
				</u:openTab>
			</s:iterator>
		</authz:ifUserNotInRole>		
			<s:iterator value="preDefinedPartReturnsSavedQueries" status="savedQueriesForPartReturnIter">
				<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" lazyConnect="false"
					id="manage_part_return_preDefined_business_search_subs[%{#savedQueriesForPartReturnIter.index}]"
					tagType="li" cssClass="claims_folder folder"
					tabLabel="%{getSearchQueryName()}"
					url="preDefined_search_expression_PR.action?
						queryId=%{preDefinedPartReturnsSavedQueries[#savedQueriesForPartReturnIter.index].id}
						&searchQueryName=%{preDefinedPartReturnsSavedQueries[#savedQueriesForPartReturnIter.index].searchQueryName}&notATemporaryQuery=true"
					catagory="partReturns" helpCategory="Part_Returns/Search_Parts.htm">
					<s:text name="%{getSearchQueryName()}" />
				</u:openTab>
			</s:iterator>
		
	</ol>
</u:jsVar>
