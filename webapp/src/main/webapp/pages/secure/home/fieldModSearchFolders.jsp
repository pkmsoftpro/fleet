<%--

   Copyright (c)2006 Tavant Technologies
   All Rights Reserved.

   This software is furnished under a license and may be used and copied
   only  in  accordance  with  the  terms  of such  license and with the
   inclusion of the above copyright notice. This software or  any  other
   copies thereof may not be provided or otherwise made available to any
   other person. No title to and ownership of  the  software  is  hereby
   transferred.

   The information in this software is subject to change without  notice
   and  should  not be  construed as a commitment  by Tavant Technologies.

--%>


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
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                       id="showPreDefinedCampaignsSearch" tagType="li" cssClass="inventory_folder folder"
                       tabLabel="%{getText('label.common.preDefinedSearch')}" lazyConnect="false"
                       url="showPreDefinedCampaignsSearch.action" catagory="campaigns" helpCategory="Field_Modifications/Search_Campaigns.htm">
                <s:text name="label.common.preDefinedSearch"/>
            </u:openTab>
            <s:iterator value="preDefinedCampaignSavedQueries" status="savedQueriesIter">
                <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                           id="manage_preDefined_business_search_fieldMod[%{#savedQueriesIter.index}]"
                           tagType="li" cssClass="claims_folder folder" lazyConnect="false"
                           tabLabel="%{getSearchQueryName()}"
                           url="showPreDefinedCampaignsSearchResults.action?savedQueryId=%{preDefinedCampaignSavedQueries[#savedQueriesIter.index].id}&searchQueryName=%{preDefinedCampaignSavedQueries[#savedQueriesIter.index].searchQueryName}&notATemporaryQuery=true"
                           catagory="campaigns" helpCategory="Field_Modifications/Search_Campaigns.htm">
                    <s:text name="%{getSearchQueryName()}"/>
                </u:openTab>
            </s:iterator>
        </ol>		
</u:jsVar>
