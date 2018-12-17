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

<div dojoType="dijit.layout.ContentPane" id="preInvoices"
    title="<s:text name="accordion_jsp.accordionPane.preInvoices" />"
    iconClass="myclaims claims-icon">
    <div dojoType="dijit.layout.ContentPane">
    <ol>  
            <authz:ifPermitted resource="invoiceInboxes"> 
			<c:forEach items="${folders.fleetClaimFolders}" var="top" varStatus="status">
				<c:if test="${!(top[3] == 'Claims Submitted' || top[3] == 'Draft Claims')}">
		             <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
			               id="claims_${top[0]}" tagType="li" cssClass="claims_folder folder"
			               tabLabel="${top[3]}" url="fleetClaims.action?folderName=${top[1]}"
			               catagory="myClaims" helpCategory="%{getHtmlFileBasedOnFolderName('Claims',${top[3]})}">
			               ${top[3]} (<span class="count">${top[2]}</span>)
			         </u:openTab>
				</c:if>
		         <script type="text/javascript" language="javascript">
		                      refreshManager.addToRegisterQueue("claims_${top[0]}",
		                                          "${top[1]}", "fleetClaimFolders.action");
		        </script>
		   </c:forEach>
          </authz:ifPermitted>
	 </ol>  
     <%--  <t:daSection id="claimSearchFolders" fetchFrom="../claimSearchFolders" fetchOn="/accordion/refreshsearchfolders"
            title="%{getText('accordionLabel.viewCustomer.searchFolders')}" appendMode="false" cssClass="searchFolders" />               --%>
    </div>    
</div>
