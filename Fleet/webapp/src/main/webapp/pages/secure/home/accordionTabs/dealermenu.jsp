<%@taglib prefix="authz" uri="authz"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="u" uri="/ui-ext"%>

<div dojoType="dijit.layout.ContentPane" id="dealerDetails" iconClass="myclaims cust-mgmt-icon" title="<s:text name="accordion_jsp.accordionPane.dealerManagement" />">
	<div dojoType="dijit.layout.ContentPane">

			<authz:ifPermitted resource="dealerManagementCreate">
				<ol>
					<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
						id="dealership" tagType="li" cssClass="claims_folder folder"
						tabLabel="Create Servicing Dealer" url="dealershipcreate">
						<s:text name="Create Servicing Dealer" />
					</u:openTab>
				</ol>
			</authz:ifPermitted>
		
		<authz:ifPermitted resource="dealerManagementInboxes">
			<ol>
				<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
					id="dealershiplist" tagType="li" cssClass="claims_folder folder"
					tabLabel="List Servicing Dealers" url="dealershiplist?folderName=List Servicing Dealers">
					<s:text name="List Servicing Dealers" />
				</u:openTab>
			</ol>
		</authz:ifPermitted>
	</div>
</div>