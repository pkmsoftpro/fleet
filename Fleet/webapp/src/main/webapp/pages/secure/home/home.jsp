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
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
response.setHeader("Pragma", "no-cache");
response.addHeader("Cache-Control", "must-revalidate");
response.addHeader("Cache-Control", "no-cache");
response.addHeader("Cache-Control", "no-store");
response.setDateHeader("Expires", 0);
%>
<html>
<head>
<title><s:text name="title.common.fleet" /></title>
<meta http-equiv="Context-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" type="text/css" href="<spring:theme code='css'/>" />
<u:stylePicker fileName="yui/reset.css" common="true" />
<u:stylePicker fileName="layout.css" common="true" />
<u:stylePicker fileName="base.css" />
<style type="text/css">
.top_Header {
	font-size: 11px;
	font-weight: 700;
	color: #333;
	padding: 0 10px;
}

.ItemsHdrAction {
	color: #324162;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
	background: transparent url(../image/actionFolders.gif) no-repeat scroll
		0 0;
	height: 43px;
	line-height: 20px;
	padding-left: 52px;
	padding-top: 4px;
	font-size: 12px;
	vertical-align: top;
}

.ItemsHdrGoto {
	height: 43px;
	line-height: 20px;
	background: transparent url(../image/goTo.gif) no-repeat;
	color: #324162;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
	height: 43px;
	line-height: 20px;
	padding-left: 52px;
	padding-top: 3px;
	font-size: 12px;
	vertical-align: top;
}

.ItemsHdrQuickSearch {
	color: #324162;
	font-family: Arial, Helvetica, sans-serif;
	background: transparent url(../image/quickSearch.gif) no-repeat scroll 0
		0;
	font-weight: bold;
	height: 43px;
	line-height: 20px;
	padding-left: 52px;
	padding-top: 3px;
	font-size: 12px;
	vertical-align: top;
}

.ItemsHdrCommonAction {
	color: #324162;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
	background: transparent url(../image/commonActions.gif) no-repeat scroll
		0 0;
	height: 43px;
	line-height: 20px;
	padding-left: 52px;
	padding-top: 1px;
	font-size: 12px;
	vertical-align: top;
}

.ItemsHdrCommonCharts {
	color: #324162;
	font-family: Arial, Helvetica, sans-serif;
	font-weight: bold;
	background: transparent url(../image/commonActions.gif) no-repeat scroll
		0 0;
	height: 43px;
	line-height: 20px;
	padding-left: 52px;
	padding-top: 1px;
	font-size: 12px;
	vertical-align: top;
}

.ItemsLabels {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 9pt;
	font-weight: 400;
	color: #111111;
	padding: 2px 0 2px 54px;
}

.ItemsLabels a {
	cursor: pointer;
	padding-left: 5px;
}

.ItemsSubHdr {
	height: 20px;
	line-height: 20px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 8pt;
	font-weight: 700;
	color: #000000;
	background-color: #EBEBEB;
	padding-left: 5px;
}

.accordianLeftArrow {
	float: right;
	background: transparent url(../image/left_Arrow.gif) no-repeat right
		center;
	cursor: pointer;
	margin: 4px 5px 0 0;
	width: 8px;
	height: 8px;
}

.calendarText {
	float: left;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 8pt;
	font-weight: 700;
	margin-left: 4px;
}

 .claro .dijitDialogTitleBar {
	background: none repeat scroll 0 0 #CCE5FF!important;	
	padding: 5px 7px 4px;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight: 700;
	margin-left: 4px;
	color:#000000!important;
	margin-left:0;
}
 .claro .dijitDialogPaneContent {
    background: #000000 repeat scroll 0 0 #FFFFFF!important;
    border-top: 1px solid #759DC0;
    padding: 0 0 0 8px;
    position: relative;
    font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	font-weight: 700;
	margin-left: 4px;
	padding:3px !important;
	margin:0;
}
.claro .dijitValidationContainer .dijitValidationIcon{height:14px !important;}
</style>

<s:head theme="twms" />
<script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
<script type="text/javascript" src="../scripts/ui-ext/common/RefreshManager.js"></script>
<script type="text/javascript">
    dojo.require("dijit.layout.ContentPane");
    dojo.require("dijit.layout.BorderContainer");
    dojo.require("twms.net.SessionTimeoutNotifier");
    dojo.require("dijit.Dialog");    
    <s:if test="allowSessionTimeOut">
    // Session Timeout Notifier.
    dojo.addOnLoad(function() {
        window.sessionTimeoutNotifier = new twms.net.SessionTimeoutNotifier({
            sessionTimeOutInterval : <s:property value="sessionTimeOutInterval" />
        });
    });
    </s:if>
</script>
<script type="text/javascript" src="../scripts/navigator.js"></script>
<script type="text/javascript" src="../scripts/testingScripts/testHome_jsp.js"></script>
<script type="text/javascript" src="../scripts/Home.js"></script>
<link rel="stylesheet" type="text/css" href="../css/base_fleet.css" />
<script type="text/javascript" src="../scripts/jstz-1.0.4.min.js"></script>
<script language="javascript" type="text/javascript">
</script>
<%@include file="/i18N_javascript_vars.jsp"%>
</head>
<u:body>  
    <input type="hidden" id='islocationChanged' value="${islocationChanged}">
		<authz:ifPermitted resource="afterBusinessHours">
			<div style="font-size: 12px;background:#000000;">
				<div id="businessHourMessage" dojoId="businessHourMessage" title="<spring:message code="label.home.businessHour.title" />" dojoType="dijit.Dialog">
					<div dojoType="dijit.layout.ContentPane" style="padding:1%!important;width:98%!important">
						<spring:message code="label.home.businessHour" />
					</div>
					<br/>
                    <div dojoType="dijit.layout.ContentPane" style="text-align: center;">
						<button dojoType="dijit.form.Button" type="submit" dojoProps="onClick:function(){businessHourMessage.hide();}">
							<spring:message code="label.home.businessHour.ok" />
						</button>
                     </div>
				</div>
			</div>
		</authz:ifPermitted>
		<table cellspacing="0" cellpadding="0" border="0" width="100%">
			<tbody>
                <tr>
                    <td>
                        <table border="0" style="width: 100%" class="headerBackGround">
                            <tbody>
                                <tr>                                
                                      <td class="top_Header" nowrap="nowrap" width="225" ><img style='width: 225px; height: 50px;' src="logo.action?url=${pageContext.request.serverName}" onError="this.src='../image/logo_NMHG.gif';"/></td>
                                    <td style="padding-left:200px">
                                        <c:if
                                        test="${fn:length(availableOrganizations)>1}">
                                        <jsp:include page="mainPage/active_customerLocations.jsp" />
                                        </c:if>
                                    </td><c:if
                                        test="${applicationSettings.appSSOEnabled && appSSOEnabledForLoggedInUser}">
                                    	<td class="top_Header" nowrap="nowrap"><a href="../goToWarranty.action">Go to Warranty</a></td>
                                    </c:if>
                                    <td class="right">
                                        <spring:message code="home_jsp.accordionPane.welcome" /> ${userForDisplay}
                                    </td>
                                    <authz:ifPermitted resource="switchUser">
									<td class="top_Header" nowrap="nowrap" id='switchUserLink'>
										<a class="removeUnderline"
										title='<s:text name="home_jsp.accordionPane.switchUser" />'
										style="color: #C11B17; cursor: pointer;" id="switchuser"><s:text
												name="home_jsp.accordionPane.switchUser" /> </a>
										<div dojoType="twms.widget.Dialog" id="switchuser1"
											bgColor="#FFF" bgOpacity="0.5" toggle="fade"
											toggleDuration="250" style="width: 400px; height: 100px;"
											title="<s:text name="home_jsp.accordionPane.switchUser"/>">
											<div style="background: #F3FBFE; border: 1px solid #EFEBF7;height:0;">
												<div dojoType="dijit.layout.ContentPane" layoutAlign="top">
													<jsp:include flush="true"
														page="/pages/secure/admin/switchUserLogin.jsp" />
												</div>
											</div>
										</div> &nbsp; <script type="text/javascript">
  								 dojo.addOnLoad(function(){
  								 dojo.connect(dojo.byId("switchuser"),"onclick",function(){
  								 dojo.publish("/attribute/show");
   										 });
   								 dojo.subscribe("/attribute/show", null, function()
   								     {
     							 dijit.byId("switchuser1").show();
     									 }); 
     							 dojo.subscribe("/attribute/hide", null, function(){
    							 dijit.byId("switchuser1").hide();
    									 }); 
									 });
						                </script></td>
						            </authz:ifPermitted>
									<authz:authorize ifAllGranted="ROLE_PREVIOUS_ADMINISTRATOR">
									<s:hidden value ="%{#session['ACEGI_SECURITY_LAST_USERNAME']}" name ="actualLoggedInUser" id ="actualLoggedInUser"/>
										<td class="top_Header" nowrap="nowrap"><a
											href="../switchback_user" class="removeUnderline"
											title='<s:text name="home_jsp.accordionPane.switchBackUser"/>'
											id="switchBackUser" style="color: #C11B17;"><s:text
													name="home_jsp.accordionPane.switchBackUser" /><span id ="actualLogin"></span>
										</a> &nbsp;</td>
									</authz:authorize>
									<td width="30px" class="padL10">
                                        <a href="../j_acegi_logout">
                                            <img border="0" align="absmiddle" alt=<spring:message code="home_jsp.fileMenu.logout" />title=<spring:message code="home_jsp.fileMenu.logout" /> src="../image/logout.png" />
                                        </a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </td>
                </tr>
			</tbody>
		</table>
            <div dojoType="dijit.layout.BorderContainer" id="rootLayoutContainer" gutters="false" liveSplitters="false" style="height: 95%">
                <div dojoType="dijit.layout.ContentPane" region="top"></div>

                <div dojoType="dijit.layout.ContentPane" region="bottom" id="footer">
                    <a href="http://www.tavant.com" id="tavantLogoHolder"><img src="../image/tavant.png" alt="Tavant" /></a>
                    <div class="footerData">${revision}<s:text name="common.copyrightNotice" />
                        <a href="javascript:void(0);"><s:text name="common.privacyPolicy" /></a>
                    </div>
                </div>

                <div dojoType="dijit.layout.BorderContainer" id="split" orientation="horizontal" splitter="true" gutters="false" liveSplitters="false" persist="true"
                    live="true" activeSizing="false" region="left" class="rootSplitContainer homePageMainSection" persist="false" style="width: 18%">
                    <div class="startupLid" id="changingDealershipLid" style="display: none">
                        <div class="startupLidIndication">
                            <div class="startupLidMessage">Please Wait...</div>
                        </div>
                    </div>
                    <div dojoType="dijit.layout.BorderContainer" id="navigator" sizeMin="0" sizeShare="100" gutters="false" liveSplitters="false" region="center">
                        <div dojoType="dijit.layout.ContentPane" id="dockNavigator" layoutAlign="top" class="welcomeBGForTabContainer">
                            <div class="calendarText">
                                <c:out value="${date}" />
                            </div>
                            <div class="accordianLeftArrow"></div>
                        </div>
                        <div dojoType="dijit.layout.AccordionContainer" id="accordion" containerNodeClass="accordionBody" allowCollapse="false" sizeShare="28" sizeMin="10"
                            region="center">
                            <%@include file="accordion.jsp"%>
                        </div>
                        <script type="text/javascript">
                    dojo.addOnLoad(function() {
                        <%--HACK : This function here ensures that the last accordion pane's body doesn't cut through the bottom pane
                                of the page in FF--%>
                        if (dojo.isFF) {
                            var footer = dijit.byId("footer");
                            dijit.byId("accordion").onSlideEnd = function() {
                                footer.hide();
                                setTimeout(function() {
                                    footer.show();
                                }, 0);
                            };
                        }
                    });
                </script>
                    </div>
                </div>
                <jsp:include page="tabContainer.jsp" />
            </div>
</u:body>
</html>