<%--
   User: ramalakshmi.p (Formatted the jsp)
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
<%response.setHeader( "Pragma", "no-cache" );
response.addHeader( "Cache-Control", "must-revalidate" );
response.addHeader( "Cache-Control", "no-cache" );
response.addHeader( "Cache-Control", "no-store" );
response.setDateHeader("Expires", 0); %><head>
<style type="text/css">
.CloseIcon {
	background: url("/css/theme/official/dojo/official/images/tabClose.gif")
		no-repeat center;
	width: 15%;
}
</style>
</head>
<script type="text/javascript" src="../scripts/main.js"></script>
<script type="text/javascript">
        dojo.require("twms.widget.Select");
        dojo.addOnLoad (function() {
            if(dojo.byId("homeCreateServiceRequest"))
        	dojo.connect(dojo.byId("homeCreateServiceRequest"), "onclick", "createServiceRequest");
        	if(dojo.byId("homeCreateQuote"))
     			dojo.connect(dojo.byId("homeCreateQuote"), "onclick", "createQuote");
        	 if(dojo.byId("homeCreateClaim"))
             	dojo.connect(dojo.byId("homeCreateClaim"), "onclick", "createFleetClaim");
     		if(dojo.byId("homeLogout"))
     		   dojo.connect(dojo.byId("homeLogout"), "onclick", "logout");
	    });
</script>
<div class="outterBg">
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="header">
		<tr>
			<%-- <td><authz:ifAdmin>
					<div id="bu" align="center" style="width: 60%; display: none">
						<table width="100%">
							<tr>
								<td style="padding-left: 5px; padding-bottom: 2px"><s:select
										id="buNames" label="Business Unit" list="businessUnits"
										listKey="name" listValue="name" name="Business Unit"
										value="%{warrantyAdminSelectedBusinessUnit}"
										emptyOption="false" /></td>
								<td id="close" class="CloseIcon" style="padding-top: 5px"></td>
							</tr>
						</table>
					</div>
					<script type="text/javascript">
                dojo.require("twms.widget.Select");
                dojo.addOnLoad(function() {
                    dojo.connect(dojo.byId("buNames"), "onchange", function() {
                        var bu = dojo.byId("buNames");
                        <s:if test="warrantyAdminSelectedBusinessUnit==null">
                        location.href = "bu.action?warrantyAdminSelectedBusinessUnit=" + bu.options[bu.selectedIndex].text;
                        </s:if>
                    });
                    dojo.connect(dojo.byId("close"), "onclick", function() {
                        dojo.html.hide(dojo.byId("bu"));
                    });
                });
            </script>
				</authz:ifAdmin></td> --%>
		</tr>
		<tr>
			<td width="30%" valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<!-- Action Folders Listing For Users based on Roles -->
					<authz:ifUserInRole
						roles="cevaProcessor,admin,inventoryAdmin,supplier,
                baserole,processor,dsm,dsmAdvisor,recoveryProcessor,cpAdvisor,dealerWarrantyAdmin,fleetServiceSpecialist,fleetProcessor">
						<jsp:include flush="true" page="mainPage/actionFolders.jsp" />
						<tr>
							<td>&nbsp;</td>
						</tr>
					</authz:ifUserInRole>
					<!-- Common Actions Listing For Users based on Roles -->
					<s:if test="!hasOnlyCevaRole()">
						<jsp:include flush="true" page="mainPage/commonAction.jsp" />
					</s:if>
				</table>
			</td>

			<%-- <td width="1%">&nbsp;</td> --%>
			<td width="30%" valign="top">
				<!-- Action Folders Listing For Users based on Roles -->
                 <jsp:include flush="true" page="mainPage/goToLinks.jsp" />
                  <authz:ifUserNotInRole roles="receiverLimitedView, inspectorLimitedView, partShipperLimitedView">
					<s:if test="!hasOnlyCevaRole()">
						<jsp:include flush="true" page="mainPage/quickSearchLinks.jsp" />
					</s:if>
				</authz:ifUserNotInRole>
			</td>
			
			
			<td width="30%" valign="top">
				<!-- Action Folders Listing For Users based on Roles -->
                 <jsp:include flush="true" page="mainPage/externalLinks.jsp" />                  
			</td>
		</tr>
		
	</table>
	
	<div width="100%" valign="top">
                 <jsp:include flush="true" page="mainPage/dashboard/dashboard.jsp" />  
	</div>
	
</div>
