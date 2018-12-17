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
		<s:if test="isInternalUser()">	
		   <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" lazyConnect="false"
			  id="PreDefinedPartRecoverySearch" tagType="li" cssClass="claims_folder folder"
			  tabLabel="%{getText('label.common.preDefinedSearch')}"
			  url="preDefined_search_PartRecovery.action" catagory="partRecovery" helpCategory="Parts_Recovery/Search_Parts.htm">
			  <span style="color:blue">
			  	<s:text name="label.common.preDefinedSearch" />
			  </span>
		  </u:openTab>
		  <s:iterator value="preDefinedPartRecoverySavedQueries" status="savedQueriesForPartRecoveryIter">
			<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" lazyConnect="false"
				id="manage_part_recovery_preDefined_business_search_subs[%{#savedQueriesForPartRecoveryIter.index}]"
				tagType="li" cssClass="claims_folder folder"
				tabLabel="%{getSearchQueryName()}"
				url="preDefined_search_expression_PREC.action?
					savedQueryId=%{preDefinedPartRecoverySavedQueries[#savedQueriesForPartRecoveryIter.index].id}&
					searchQueryName=%{preDefinedPartRecoverySavedQueries[#savedQueriesForPartRecoveryIter.index].searchQueryName}&notATemporaryQuery=true"
				catagory="partRecovery" helpCategory="Parts_Recovery/Search_Parts.htm">
				<s:text name="%{getSearchQueryName()}" />
			</u:openTab>
		</s:iterator>		  
		</s:if>
	</ol>
</u:jsVar>
