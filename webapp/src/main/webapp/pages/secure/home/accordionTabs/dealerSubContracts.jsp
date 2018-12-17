<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="authz" uri="authz"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>

<div dojoType="dijit.layout.ContentPane" id="subContractDetails"
	 iconClass="myclaims contract-icon" title="<s:text name="accordion_jsp.accordionPane.dealerSubContract" />" >
	<div dojoType="dijit.layout.ContentPane">
	<authz:ifPermitted resource="subContractInboxes">
    <authz:ifPermitted resource="unPublishedSubContracts">
        <ol>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="unpublishedContracts" tagType="li"
                cssClass="claims_folder folder"
                tabLabel="label.subContract.unpublished"
                url="getSubContracts.action?folderName=Contracts Unpublished" catagory="subContracts">
                <s:text name="label.subContract.unpublished" />
            </u:openTab>
        </ol>
     </authz:ifPermitted>
        <ol>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="pendingApprovalContracts" tagType="li"
                cssClass="claims_folder folder"
                tabLabel="label.subContract.pendingApproval"
                url="getSubContracts.action?folderName=Contracts Pending Approval" catagory="subContracts">
                <s:text name="label.subContract.pendingApproval" />
            </u:openTab>
		</ol>
        <ol>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="ApprovedContracts" tagType="li"
                cssClass="claims_folder folder"
                tabLabel="label.subContract.contractsApproved"
                url="getSubContracts.action?folderName=Contracts Approved" catagory="subContracts">
                <s:text name="label.subContract.contractsApproved" />
            </u:openTab>
        </ol>
        <ol>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="deniedContracts" tagType="li"
                cssClass="claims_folder folder"
                tabLabel="label.subContract.contractsDenied"
                url="getSubContracts.action?folderName=Contracts Denied" catagory="subContracts">
                <s:text name="label.subContract.contractsDenied" />
            </u:openTab>
        </ol>
    </authz:ifPermitted>
    </div>
</div>