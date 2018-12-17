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

<div dojoType="dijit.layout.ContentPane" id="myclaims"
    title="<s:text name="accordion_jsp.accordionPane.myClaims" />"
    iconClass="myclaims" <authz:ifUserNotInRole roles="admin">selected="true"</authz:ifUserNotInRole>
 >
    <div dojoType="dijit.layout.ContentPane">
    
    <ol>
	    <authz:ifUserInRole roles="admin,processor,inventoryAdmin">
	      <u:fold label="%{getText('title.claim.multipleClaimMaintenance')}"
	                id="multiple_claim_maintenance" tagType="li" cssClass="uFoldStyle folder"
	                foldableClass="foldableMultipleClaimMaintenance" />
	            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
	                id="multiple_claim_maintenance_attributes" tagType="li" 
	                cssClass="claims_folder folder foldableMultipleClaimMaintenance sublist"
	                tabLabel="%{getText('label.claim.multipleClaimMaintenanceAttribute')}"
	                url="showNewClaimForm.action?context=ClaimSearches&isMultiClaimMaintenance=true" 
	                catagory="myClaims" helpCategory="Claims/Claim_Attributes.htm">
	                <s:text name="label.claim.multipleClaimMaintenanceAttribute" />
	            </u:openTab>
			    <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" 
			    	id="my_multiple_claim_maintenance" tagType="li"
		        	tabLabel="%{getText('label.open.claim.multipleClaimMaintenance')}" 
		        	url="showNewClaimForm.action?context=ClaimSearches&isTransferOrReProcess=true" 
		        	catagory="myClaims" 
		        	cssClass="claims_folder folder foldableMultipleClaimMaintenance sublist" helpCategory="Claims/Transfer_Re-process.htm">
		        	<s:text name="label.open.claim.multipleClaimMaintenance" />
				</u:openTab>
		</authz:ifUserInRole>

		 <authz:ifUserInRole roles="baserole,processor,dsm,dsmAdvisor,recoveryProcessor,admin,cpAdvisor,
		                            dealerWarrantyAdmin">
			<s:iterator value="claimFolders" status="status">
                <s:if test="%{top[1].equals('Claim Failure Reports')}">
                   <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
		               id="claims_%{top[0]}" tagType="li" cssClass="claims_folder folder"
		               tabLabel="%{top[3]}" url="displayClaimFailureReports.action?folderName=%{top[1]}"
		               catagory="myClaims" helpCategory="%{getHtmlFileBasedOnFolderName('Claims',top[3])}">
		               <s:property value="%{top[3]}" /> (<span class="count"><s:property
		                    value="%{top[2]}" /></span>)
		         </u:openTab>
                </s:if>
                <s:else>
                 <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
		               id="claims_%{top[0]}" tagType="li" cssClass="claims_folder folder"
		               tabLabel="%{top[3]}" url="claims.action?folderName=%{top[1]}"
		               catagory="myClaims" helpCategory="%{getHtmlFileBasedOnFolderName('Claims',top[3])}">
		               <s:property value="%{top[3]}" /> (<span class="count"><s:property
		                    value="%{top[2]}" /></span>)
		         </u:openTab>             
		        </s:else>
		         <script type="text/javascript" language="javascript">
                        refreshManager.addToRegisterQueue("claims_<s:property value="%{top[0]}"/>",
                                            "<s:property value="%{top[1]}"/>", "claimFolders.action");
		        </script>
		    </s:iterator>
		 </authz:ifUserInRole>
	 </ol>
	 
	 <ol>
	    <authz:ifUserInRole roles="supplierRecoveryInitiator, processor, sra, recoveryProcessor">	    
			 <u:openTab 
				  id="claims_pendingRecoveryInitiation" tagType="li" cssClass="claims_folder folder"
				  tabLabel="label.viewClaim.pendingRecoveryInitiation" url="pendingRecoveryClaims.action?folderName=Pending Recovery Initiation"
				  catagory="myClaims">
				  <s:text name="label.viewClaim.pendingRecoveryInitiation"/> 
		     </u:openTab> 
	    </authz:ifUserInRole>	
	 </ol>
	 
  <authz:ifUserInRole roles="baserole,processor,dsm,dsmAdvisor,recoveryProcessor,admin,cpAdvisor,
                              dealerWarrantyAdmin,readOnly">	    
	    <t:daSection id="claimSearchFolders"
	      fetchFrom="claimSearchFolders.action"
	      fetchOn="/accordion/refreshsearchfolders"
	      title="%{getText('accordionLabel.viewClaim.searchFolders')}"
	      appendMode="false"
	      cssClass="searchFolders"/>
    </authz:ifUserInRole>	   
                   
    </div>    
</div>
