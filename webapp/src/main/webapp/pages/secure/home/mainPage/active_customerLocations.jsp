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
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>

<div style="padding: 0pt; color: black;">
	<span id="customer"><spring:message code="label.home.selectLocation" /></span> <span id="dealer"><spring:message code="label.home.selectDealerShip" /></span><select style="width:300px;" id="selectedOrganization">
		<c:forEach var="organization" items="${availableOrganizations}">
			<option value="${organization.id}"  <c:if test="${organization.id == loginUser.currentlyActiveOrganization.id}">selected="selected"</c:if>>${organization.name}</option>
		</c:forEach>
	</select>
</div>

<div style="display: none;">
	<div dojoType="twms.widget.Dialog" id="confirmCustomerLocation"
		title="Confirm CustomerLocation" style="width: 400px" closable="false" class="cust-loc-popup">
		<div dojoType="dijit.layout.LayoutContainer"
			style="background: #F3FBFE; overflow: auto;">
			<div id="confirmCustomerLocationContent" style="padding: 10px 10px 0 10px">
				<span id='dealerContent'><spring:message code="label.home.dealerContent" /></span>
				<span id='customerContent'><spring:message code="label.home.customerContent" /></span>
			</div>
			<div style="padding: 10px 0 10px 0;">
				<center>
					<button class="btn border-rad0" id="changeCustomerLocation"><spring:message code="label.common.yes"/></button>
					<button class="btn border-rad0" id="resetCustomerLocation"><spring:message code="label.common.no"/></button>
				</center>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
var isCustomer='<c:out value="${isLoggedInUserACustomer}"/>';
console.info(isCustomer);
if(isCustomer=='true')
	{
	dojo.html.hide(dojo.byId("dealer"));
	dojo.html.show(dojo.byId("customer"));
	dojo.html.hide(dojo.byId("dealerContent"));
	dojo.html.show(dojo.byId("customerContent"));
	document.getElementById("confirmCustomerLocation").title = "Confirm CustomerLocation";
	
	}
else
	{
	dojo.html.hide(dojo.byId("customer"));
	dojo.html.show(dojo.byId("dealer"));
	dojo.html.hide(dojo.byId("customerContent"));
	dojo.html.show(dojo.byId("dealerContent"));
	document.getElementById("confirmCustomerLocation").title = "Confirm dealership";

	}
var org = dojo.byId("selectedOrganization");
var activeOrg = '<c:out value="${loginUser.currentlyActiveOrganization.id}"/>';
var selectedOrg;
dojo.connect(org, "onchange", function() {
	dijit.byId("confirmCustomerLocation").show();
});

dojo.addOnLoad( function() {
	dojo.connect(dojo.byId("changeCustomerLocation"), "onclick", function() {
		changeCustomerLocation();
	});
	dojo.connect(dojo.byId("resetCustomerLocation"), "onclick", function() {
		resetCustomerLocation();
	});
	dojo.html.hide(dojo.byId("changingCustomerLocationLid"));
});

function changeCustomerLocation() {
	dijit.byId("confirmCustomerLocation").hide();
	dojo.html.show(dojo.byId("changingCustomerLocationLid"));
	dojo.byId("selectedOrganization").disabled = true;
	var optionsList = org.options;
	var i = optionsList.length;
	while (i--) {
		var optionNode = optionsList[i];
		if (optionNode.selected) {
			selectedOrg = optionNode.value;
			twms.ajax.fireHtmlRequest("activateSelectedOrganization.action",{
				selectedOrganization : selectedOrg
	        },function(data) {	          
	        	location.href = "homeAction.action";
			});
			break;
		}
	}
}

function resetCustomerLocation() {
	dijit.byId("confirmCustomerLocation").hide();
	org.value = activeOrg;
}

</script>