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

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<div dojoType="dijit.layout.ContentPane" id="myQuotes"
    title="<s:text name="accordion_jsp.accordionPane.myQuotes" />"
    iconClass="myclaims quotes-icon">
    <div dojoType="dijit.layout.ContentPane">
    <ol>
           <authz:ifPermitted resource="createQuote">
             <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
				id="createQuoteAccdordian" tagType="li"
				cssClass="claims_folder folder"
				tabLabel="label.quote.createQuote"
				url="createQuote" catagory="myQuotes"
				helpCategory="Quotes/Quote_Submission.htm">
				<s:text name="label.quote.createQuote" />
			  </u:openTab>	
			</authz:ifPermitted>
            <authz:ifPermitted resource="quoteInboxes"> 
			<c:forEach items="${folders.quoteFolders}" var="top" varStatus="status">
             <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
		               id="quotes_${top[0]}" tagType="li" cssClass="claims_folder folder"
		               tabLabel="${top[3]}" url="quotes.action?folderName=${top[1]}"
		               catagory="myQuotes" helpCategory="%{getHtmlFileBasedOnFolderName('Quotes',${top[3]})}">
		               ${top[3]} (<span class="count">${top[2]}</span>)
		         </u:openTab>
		         <script type="text/javascript" language="javascript">
		                      refreshManager.addToRegisterQueue("quotes_${top[0]}",
		                                          "${top[1]}", "quoteFolders.action");
		        </script>
		   </c:forEach>
		   </authz:ifPermitted>
		   <authz:ifPermitted resource="dealerOwnedQuoteInboxes"> 
		   <span style="font-weight: bold;">Dealer Owned Quote Inboxes</span>
		   <c:forEach items="${folders.quoteFoldersForDealerOwnedUsers}" var="top" varStatus="status">
             <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
		               id="quotes_${top[0]}" tagType="li" cssClass="claims_folder folder"
		               tabLabel="${top[3]}" url="quotes.action?folderName=${top[1]}"
		               catagory="myQuotes" helpCategory="%{getHtmlFileBasedOnFolderName('Quotes',${top[3]})}">
		               ${top[3]} (<span class="count">${top[2]}</span>)
		         </u:openTab>
		         <script type="text/javascript" language="javascript">
		                      refreshManager.addToRegisterQueue("quotes_${top[0]}",
		                                          "${top[1]}", "quoteFolders.action");
		        </script>
		   </c:forEach>
          </authz:ifPermitted>
	 </ol>
		<authz:ifPermitted resource="searchQuotes">
			<t:daSection id="quoteSearchFolders"
				fetchFrom="../quoteSearchFolders"
				fetchOn="/accordion/refreshquotesearchfolders"
				title="%{getText('accordionLabel.common.searchFolders')}"
				appendMode="false" cssClass="searchFolders" />
		</authz:ifPermitted>
	</div>    
</div>
