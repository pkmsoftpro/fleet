<%@page contentType="text/html"%>
<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>

<html>
<head>
<s:head theme="twms" />
<u:stylePicker fileName="commonPrintReport.css" />
<u:stylePicker fileName="form.css" />
<u:stylePicker fileName="base.css" />
<u:stylePicker fileName="ui-ext/actionResult/actionResult.css" />
<link rel="stylesheet" type="text/css" href="css/search_pages.css" />
<script type="text/javascript" src="scripts/jscalendar/calendar.js"></script>
<script type="text/javascript" src="scripts/jscalendar/lang/calendar-en.js"></script>
<script type="text/javascript" src="scripts/jscalendar/calendar-setup.js"></script>
<script type="text/javascript" src="scripts/admin.js"></script>
<script type="text/javascript">
    dojo.require("dijit.layout.ContentPane");
    dojo.require("dijit.layout.BorderContainer");
    function enableText() {
        document.getElementById("savedQueryName").disabled = !document.getElementById("notATemporaryQuery").checked;
        if (document.getElementById("notATemporaryQuery").checked) {
            document.getElementById("savedQueryName").value = '';
        }
        return true;
    }
</script>
</head>
<u:body smudgeAlert="false">

    <div dojoType="dijit.layout.BorderContainer" class="border-container" id="root">
        <div dojoType="dijit.layout.ContentPane" region="client" id="content" class="search-wrapper">
            <div class="policy_section_div">
                <div class="section_header">
                    <s:text name="label.contract.contractSearch" />
                </div>
                <s:actionerror theme="xhtml" />
                <s:fielderror theme="xhtml" />
                <form name="form" method="POST" action="validatePreDefinedContractSearchFields">
                    <s:hidden name="context" name="context" value="ContractSearches" />
                    <s:hidden name="folderName" name="folderName" value="Contracts Search" />
                    <s:hidden name="queryId" />
                    <s:hidden name="tableHeadData" />

                    <table cellspacing="0" cellpadding="0" class="grid" class="wid-99p">

                        <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.contract.code" />:
                            <td class="floatL"><s:textfield name="contractSearchCriteria.code" id="code" /></td>
                        </tr>
                        <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.customer.customerName" />:</td>
                            <td class="searchLabel"><s:textfield name="contractSearchCriteria.customerName" id="contractSearchCriteria.name" />
                            </td>
                        </tr>
                        <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.contract.customerLocation" />:</td>
                            <td class="searchLabel"><s:textfield name="contractSearchCriteria.customerLocation" id="contractSearchCriteria.location" />
                            </td>
                        </tr>
                        
<%--                         <tr>
                             <td class="searchLabel labelStyle" nowrap="nowrap"><s:text name="columnTitle.contract.startDate" />:</td>
                             <td class="searchLabel"><sd:datetimepicker name='contractSearchCriteria.startDate'
                                        value='%{contractSearchCriteria.startDate}' id='contractSearchCriteria_startDate' /></td>
                        </tr>
                        <tr>
                             <td class="searchLabel labelStyle"><s:text name="columnTitle.contract.endDate" />:</td>
                             <td class="searchLabel"><sd:datetimepicker name='contractSearchCriteria.endDate'
                                        value='%{contractSearchCriteria.endDate}' id='contractSearchCriteria_endDate' /></td>
                        </tr> --%>                        
                       
                        <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.customer.customerBillTo" />:</td>
                            <td class="searchLabel"><s:textfield name="contractSearchCriteria.billTo" id="contractSearchCriteria.billTo" />
                            </td>
                        </tr>
                        
                        <!-- contract date -->

						<tr>
							<td class="searchLabel labelStyle" nowrap="nowrap"><span
								style="float: left;"><s:text
										name="search.inventory.contractStartDate" />:</span> <span
								style="float: right;"><s:text name="label.common.from" />:
							</span></td>
							<td><sd:datetimepicker
									name='contractSearchCriteria.contractStartFrom'
									value='%{contractSearchCriteria.contractStartFrom}'
									id='contractSearchCriteria.contractStartFrom' /></td>

						</tr>
						<tr>
							<td class="preDefinedSearchLabel labelStyle" align="right"><s:text
									name="label.common.to" />:</td>
							<td><sd:datetimepicker
									name='contractSearchCriteria.contractStartTill'
									value='%{contractSearchCriteria.contractStartTill}'
									id='contractSearchCriteria.contractStartTill' /></td>

						</tr>
						<tr>
							<td class="searchLabel labelStyle" nowrap="nowrap"><span
								style="float: left;"><s:text
										name="search.inventory.contractEndDate" />:</span> <span
								style="float: right;"><s:text name="label.common.from" />:
							</span>
							</td>
							<td><sd:datetimepicker
									name='contractSearchCriteria.contractEndFrom'
									value='%{contractSearchCriteria.contractEndFrom}'
									id='contractSearchCriteria.contractEndFrom' /></td>

						</tr>
						<tr>
							<td class="preDefinedSearchLabel labelStyle" align="right"><s:text
									name="label.common.to" />:</td>
							<td><sd:datetimepicker
									name='contractSearchCriteria.contractEndTill'
									value='%{contractSearchCriteria.contractEndTill}'
									id='contractSearchCriteria.contractEndTill' /></td>

						</tr>


						<tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.contract.serialNumber" />:</td>
                            <td class="searchLabel"><s:textfield name="contractSearchCriteria.serialNumber" id="serialNumber" />
                            </td>
                        </tr>
                        <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.contract.assetNumber" />:</td>
                            <td class="searchLabel"><s:textfield name="contractSearchCriteria.assetNumber" id="assetNumber" />
                            </td>
                        </tr>
                        
                        <tr>
                                <td class="searchLabel labelStyle"><s:text name="button.common.saveSearch" />
                                    <s:checkbox cssClass="buttonGeneric" name="notATemporaryQuery" id="notATemporaryQuery" value="notATemporaryQuery"
                                        onclick="enableText()">
                                    </s:checkbox></td>
                                <td class="labelStyle"><s:if test="savedQueryName!=null">
                                        <s:textfield name="savedQueryName" id="savedQueryName" value="%{savedQueryName}"></s:textfield>
                                    </s:if> <s:else>
                                        <s:textfield name="savedQueryName" id="savedQueryName" disabled="true" value="Name of the Query"></s:textfield>
                                    </s:else></td>
                        </tr>
                        
                        <tr>
                            <td ></td>
                            <td class="label" valign="bottom"><input type="submit" class="buttonGeneric"
                                value='<s:text name="label.contract.contractSearch"/>' /></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>


</u:body>
</html>
