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
		<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" lazyConnect="false"
			id="CreateRecoveryClaimSearch" tagType="li" cssClass="recovery_claims_folder folder"
			tabLabel="%{getText('accordion_jsp.accordionPane.myClaims.defineSearch.recoveryClaim')}"
			url="new_search_expression.action?context=RecoveryClaimSearches" catagory="myRecoveryClaims" helpCategory="Supplier_Recovery/Search_Supplier_Recovery_Claims.htm">
			<span style="color:blue">
				<s:text name="accordion_jsp.accordionPane.myClaims.defineSearch" />
			</span>
		</u:openTab>
		<authz:ifUserInRole roles="sra">			
			<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="predefined_recovery_claims_search" tagType="li"
					tabLabel="%{getText('label.common.preDefinedSearch.recoveryClaim')}"  lazyConnect="false"
					url="showPreDefinedRecoveryClaimsSearch.action" 
					catagory="myRecoveryClaims" cssClass="recovery_claims_folder folder" helpCategory="Supplier_Recovery/Search_Supplier_Recovery_Claims.htm">
				<span style="color:blue">	
					<s:text name="label.common.preDefinedSearch"/>
				</span>	
			</u:openTab>
		</authz:ifUserInRole>	
		
	</ol>
	

	<ol>
		<s:iterator value="savedQueriesForRecoveryClaims" status="savedQueriesIter">
			<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" lazyConnect="false"
				id="manage_business_search_subs[%{#savedQueriesIter.index}]"
				tagType="li" cssClass="recovery_claims_folder folder"
				tabLabel="%{getDomainPredicate().getName()}"
				url="dynamicRecoveryClaimSearchResult.action?domainPredicateId=%{getDomainPredicate().getId()}&savedQueryId=%{getId()}"
				catagory="myRecoveryClaims" helpCategory="Supplier_Recovery/Search_Supplier_Recovery_Claims.htm">
				<s:text name="%{getDomainPredicate().getName()}" />
			</u:openTab>
		</s:iterator>	

		<authz:ifUserInRole roles="sra">						
			<s:iterator value="preDefinedRecClaimSavedQueries" status="savedQueriesIter">
			<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" lazyConnect="false"
				id="manage_business_preDefined_search_subs[%{#savedQueriesIter.index}]"
				tagType="li" cssClass="recovery_claims_folder folder"
				tabLabel="%{getSearchQueryName()}"
				url="showPreDefinedRecoveryClaimSearchResults.action?savedQueryId=%{preDefinedRecClaimSavedQueries[#savedQueriesIter.index].id}&
				searchQueryName=%{preDefinedRecClaimSavedQueries[#savedQueriesIter.index].searchQueryName}&notATemporaryQuery=true"
				catagory="myRecoveryClaims" helpCategory="Supplier_Recovery/Search_Supplier_Recovery_Claims.htm">
				<s:text name="%{getSearchQueryName()}"/>
			</u:openTab>
		</s:iterator>
		</authz:ifUserInRole>
	</ol>	
</u:jsVar>
