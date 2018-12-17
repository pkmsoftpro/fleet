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

<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="t" uri="twms"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%
    response.setHeader("Pragma", "no-cache");
			response.addHeader("Cache-Control", "must-revalidate");
			response.addHeader("Cache-Control", "no-cache");
			response.addHeader("Cache-Control", "no-store");
			response.setDateHeader("Expires", 0);
%>
<html>
<head>
<u:stylePicker fileName="adminPayment.css" />
<u:stylePicker fileName="common.css" />
<u:stylePicker fileName="form.css" />
<s:head theme="twms" />
<script type="text/javascript">
    dojo.require("dijit.layout.LayoutContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.require("twms.widget.TitlePane");
    dojo.require("dijit.Tooltip");
</script>
<style type="text/css">
td {
	width: 25%;
}

.mainTitle {
	cursor: pointer;
}

.admin_data_table {
	font-family: Arial, Helvetica, sans-serif;
	font-size: 9pt;
	font-weight: 700;
	color: #545454;
}
</style>
</head>
<u:body>
    <div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%; overflow-x: hidden; overflow-y: auto;" id="root">
        <div dojoType="dijit.layout.ContentPane" layoutAlign="client">
            <s:form name="buForm" action="saveBUConfiguration">
                <script type="text/javascript" src="scripts/ui-ext/fold/Fold.js"></script>
                 <div dojoType="twms.widget.TitlePane" title="Fleet Claim" labelNodeClass="section_header" open="true">
                    <u:fold id="Fleet_Claim_1" label="Home Page" foldableClass="Fleet_Claim_1" tagType="div" cssClass="mainTitle" />
                    <div class="borderTable"></div>
                    <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="Fleet_Claim_1">
                         <s:iterator value="paramList" status="iter">
                            <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@LOGICAL_GROUP_CLAIMS">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_HOME_PAGE">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                  
                                </s:if>
                         </s:iterator>
                        </tbody>
                    </table>
                </div>

                <div dojoType="twms.widget.TitlePane" title="Service Request" labelNodeClass="section_header" open="true">
                    <u:fold id="Service_request_1" label="Service Request" foldableClass="Service_request_1" tagType="div" cssClass="mainTitle" />
                    <div class="borderTable"></div>
                    <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="Service_request_1">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@SERVICE_REQUEST">
                                    <t:configParam paramName="paramList[#iter.index]" />
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                </div>

                <div dojoType="twms.widget.TitlePane" title="Quote" labelNodeClass="section_header" open="true">
                    <u:fold id="quote_1" label="Quote Input Parameter" foldableClass="quote_1" tagType="div" cssClass="mainTitle" />
                    <div class="borderTable"></div>
                    <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="quote_1">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@QUOTES">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_QUOTES_INPUT">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>

                    <u:fold id="quote_3" label="Fleet Recommendation" foldableClass="quote_3" tagType="div" cssClass="mainTitle" />
                    <div class="borderTable"></div>
                    <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="quote_3">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@QUOTES">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_QUOTES_RECOMMENDATION">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                    
                    <u:fold id="quote_2" label="Quote Processing" foldableClass="quote_2" tagType="div" cssClass="mainTitle" />
                    <div class="borderTable"></div>
                    <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="quote_2">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@QUOTES">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_QUOTES_PROCESSING">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                </div>

                <div dojoType="twms.widget.TitlePane" title="Labor/Travel SetUp" labelNodeClass="section_header" open="true">
                    <u:fold id="labor_1" label="Labor SetUp" foldableClass="labor_1" tagType="div" cssClass="mainTitle" />
                    <div class="borderTable"></div>
                    <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="labor_1">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@TRAVEL_LABOR_SETUP">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_LABOR_SETUP">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                    <u:fold id="travel_1" label="Travel SetUp" foldableClass="travel_1" tagType="div" cssClass="mainTitle" />
                    <div class="borderTable"></div>
                    <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="travel_1">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@TRAVEL_LABOR_SETUP">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_TRAVEL_SETUP">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                </div>
                <div dojoType="twms.widget.TitlePane" title="Customer Invoice" labelNodeClass="section_header" open="true">
                   <u:fold id="invoice_1" label="Customer Invoice Parameters" foldableClass="invoice_1" tagType="div" cssClass="mainTitle" />
                    <div class="borderTable"></div>
                    <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="invoice_1">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup ==@tavant.twms.web.bu.ManageBUConfiguration@CUSTOMER_INVOICE">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_CUSTOMER_INVOICE_PARAMETERS">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                </div>
                
                <div dojoType="twms.widget.TitlePane" title="Dashboard Setup" labelNodeClass="section_header" open="true">
                	<u:fold id="customerdashboard_1" label="Avoidable Damage by Month Chart Setup" foldableClass="customerdashboard_1" tagType="div" cssClass="mainTitle" />
                	<div class="borderTable"></div>
                	 <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="customerdashboard_1">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@DASHBOARD_SETUP">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_ADB_CHART_SETUP">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                    <u:fold id="customerdashboard_2" label="Last 12 Months Spend Chart Setup" foldableClass="customerdashboard_2" tagType="div" cssClass="mainTitle" />
                	<div class="borderTable"></div>
                	 <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="customerdashboard_2">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@DASHBOARD_SETUP">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_LAST_12MONTHS_SPEND_CHART_SETUP">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                    <u:fold id="customerdashboard_3" label="Average Outstanding Quote Age Chart Setup" foldableClass="customerdashboard_3" tagType="div" cssClass="mainTitle" />
                	<div class="borderTable"></div>
                	 <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="customerdashboard_3">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@DASHBOARD_SETUP">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_QUOTE_AGE_CHART_SETUP">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                    <u:fold id="dealerdashboard_4" label="Average Claim Age Chart Setup(Dealer Dashboard)" foldableClass="dealerdashboard_4" tagType="div" cssClass="mainTitle" />
                	<div class="borderTable"></div>
                	 <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="dealerdashboard_4">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@DASHBOARD_SETUP">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_AVG_CLAIM_AGE_CHART_SETUP">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                   <u:fold id="internaldashboard_5" label="Invoiced Dollars(Internal Dashboard)" foldableClass="internaldashboard_5" tagType="div" cssClass="mainTitle" />
                	<div class="borderTable"></div>
                	 <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="internaldashboard_5">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@DASHBOARD_SETUP">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_INVOICED_DOLLARS">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                    <u:fold id="internaldashboard_6" label="Credit Rescind Performance(Internal Dashboard)" foldableClass="internaldashboard_6" tagType="div" cssClass="mainTitle" />
                	<div class="borderTable"></div>
                	 <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="internaldashboard_6">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@DASHBOARD_SETUP">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_CREDIT_RESCIND">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                     <u:fold id="internaldashboard_7" label="Average Outstanding Quote Age Chart Setup(Internal Dashboard)" foldableClass="internaldashboard_7" tagType="div" cssClass="mainTitle" />
                	<div class="borderTable"></div>
                	 <table width="100%" border="0" cellspacing="1" cellpadding="1" class="grid ">
                        <tbody class="internaldashboard_7">
                            <s:iterator value="paramList" status="iter">
                                <s:if test="logicalGroup == @tavant.twms.web.bu.ManageBUConfiguration@DASHBOARD_SETUP">
                                    <s:if test="sections == @tavant.twms.web.bu.ManageBUConfiguration@SECTION_AVG_OUTSTANDING_QUOTE_AGE">
                                        <t:configParam paramName="paramList[#iter.index]" />
                                    </s:if>
                                </s:if>
                            </s:iterator>
                        </tbody>
                    </table>
                </div>

				<authz:ifPermitted resource="manageBusinessConfigurations">
					<div align="center" class="spacingAtTop">
						<s:submit cssClass="buttonGeneric" value="Update" />
					</div>
				</authz:ifPermitted>
			</s:form>
        </div>
    </div>
</u:body>
</html>