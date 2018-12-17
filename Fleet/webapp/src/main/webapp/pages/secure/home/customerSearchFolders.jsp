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
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="customerQuickSearch" tagType="li" cssClass="claims_folder folder"
                tabLabel="label.customer.customerSearch" url="../showPreDefinedCustomerSearch" lazyConnect="false" catagory="myCustomerSearch">
                <s:text name="accordion_jsp.accordionPane.searchCustomer" />
            </u:openTab>
        </ol>
		<ol>
			<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
				id="customerLocationSearch" tagType="li"
				cssClass="claims_folder folder"
				tabLabel="accordion_jsp.accordionPane.searchLocation" lazyConnect="false"
				url="../showPreDefinedCustomerLocationSearch" catagory="myCustomerLocations">
				<s:text name="label.customerLocation.search" />
			</u:openTab>
		</ol>      
          <s:iterator value="preDefinedCustomerLocationSavedQueries" status="savedQueriesIter">
            <s:url var="theUrl" action="showPreDefinedCustomerLocationSearchResults.action" escapeAmp="false">
                <s:param name="context">customerLocationSearches</s:param>
                <s:param name="folderName"></s:param>
                <s:param name="queryId" value="%{preDefinedCustomerLocationSavedQueries[#savedQueriesIter.index].id}" />
                <s:param name="savedQueryName" value="%{preDefinedCustomerLocationSavedQueries[#savedQueriesIter.index].searchQueryName}" />
                <s:param name="notATemporaryQuery">true</s:param>
            </s:url>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_preDefined_business_search_subsQR_[%{#savedQueriesIter.index}]" tagType="li"
                cssClass="claims_folder folder" tabLabel="%{preDefinedCustomerLocationSavedQueries[#savedQueriesIter.index].searchQueryName}" lazyConnect="false" url="%{#theUrl}"
                catagory="myCustomerSearch" helpCategory="Claims/Search_Claims.htm">
                <s:text name="%{preDefinedCustomerLocationSavedQueries[#savedQueriesIter.index].searchQueryName}" />
            </u:openTab>
        </s:iterator>
        
    </ol>
</u:jsVar>
