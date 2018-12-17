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
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>

<div dojoType="dijit.layout.ContentPane" id="myclaims"
    title="<s:text name="accordion_jsp.accordionPane.myclaims" />"
    iconClass="myclaims claims-icon">
    <div dojoType="dijit.layout.ContentPane">
    <ol>  
     <authz:ifPermitted resource="multiClaimMaintenance"> 	  	 	  	
	       <u:fold label="%{getText('label.claim.multiClaimMaintenance')}"
                id="multiClaimMaintenance" tagType="li"
                cssClass="uFoldStyle folder" foldableClass="foldableAttributeManagement" />

				<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
					id="claimAttributes" tagType="li"
					cssClass="warrantyAdmin_folder folder foldableAttributeManagement sublist"
					tabLabel="%{getText('label.claim.claimAttributes')}"
					url="../showNewClaimForm.action?context=FleetClaimSearches&isMultiClaimMaintenance=true"
					catagory="myFleetClaims" helpCategory="Claims/Search_Claims.htm">
					<s:text name="label.claim.claimAttributes" />
				</u:openTab>

				<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
					id="transferOrReProcess" tagType="li"
					cssClass="warrantyAdmin_folder folder foldableAttributeManagement sublist"
					tabLabel="%{getText('label.claim.transferOrReProcess')}"
					url="../showNewClaimForm.action?context=FleetClaimSearches&isTransferOrReProcess=true"
					catagory="myFleetClaims" helpCategory="Claims/Search_Claims.htm">
					<s:text name="label.claim.transferOrReProcess" />
				</u:openTab>
		</authz:ifPermitted>	
    
           <authz:ifPermitted resource="createClaim">
             <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
				id="createClaimAccdordian" tagType="li"
				cssClass="claims_folder folder"
				tabLabel="label.claim.createClaim"
				url="createFleetClaim" catagory="myFleetClaims"
				helpCategory="Claims/Claim_Submission.htm">
				<s:text name="label.claim.createClaim" />
			  </u:openTab>	
			</authz:ifPermitted>
           <authz:ifPermitted resource="claimInboxes"> 
			<c:forEach items="${folders.fleetClaimFolders}" var="top" varStatus="status">
             <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
		               id="claims_${top[0]}" tagType="li" cssClass="claims_folder folder"
		               tabLabel="${top[3]}" url="fleetClaims.action?folderName=${top[1]}"
		               catagory="myFleetClaims" helpCategory="%{getHtmlFileBasedOnFolderName('Claims',${top[3]})}">
		               ${top[3]} (<span class="count">${top[2]}</span>)
		         </u:openTab>
		         <script type="text/javascript" language="javascript">
		                      refreshManager.addToRegisterQueue("claims_${top[0]}",
		                                          "${top[1]}", "fleetClaimFolders.action");
		        </script>
		   </c:forEach>
          </authz:ifPermitted>
          
          
           <authz:ifPermitted resource="dealerOwnedclaimInboxes">
               <span style="font-weight: bold;">Dealer Owned Claim Inboxes</span>
           
            </authz:ifPermitted>
            <authz:ifPermitted resource="dealerOwnedclaimInboxes"> 
          
            <c:forEach items="${folders.fleetClaimFoldersForDealerOwnedUsers}" var="top" varStatus="status">
             <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                       id="claims_${top[0]}" tagType="li" cssClass="claims_folder folder"
                       tabLabel="${top[3]}" url="fleetClaims.action?folderName=${top[1]}"
                       catagory="myFleetClaims" helpCategory="%{getHtmlFileBasedOnFolderName('Claims',${top[3]})}">
                       ${top[3]} (<span class="count">${top[2]}</span>)
                 </u:openTab>
                 <script type="text/javascript" language="javascript">
                              refreshManager.addToRegisterQueue("claims_${top[0]}",
                                                  "${top[1]}", "fleetClaimFolders.action");
                </script>
           </c:forEach>
          </authz:ifPermitted>
	 </ol>
		<authz:ifPermitted resource="searchClaims">
			<t:daSection id="claimSearchFolders"
				fetchFrom="../claimSearchFolders"
				fetchOn="/accordion/refreshclaimsearchfolders"
				title="%{getText('accordionLabel.viewCustomer.searchFolders')}"
				appendMode="false" cssClass="searchFolders" />
		</authz:ifPermitted>
	</div>    
</div>
