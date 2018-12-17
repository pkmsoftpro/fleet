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
                    <s:text name="label.invoice.searchInvoice" />
                </div>
                <s:actionerror theme="xhtml" />
                <s:fielderror theme="xhtml" />
                <form action="validatePreDefinedInvoiceSearchFields.action" method="POST" name="searchForm">
                    <s:hidden id="context" name="context" value="InvoiceSearch" />
                    <s:hidden id="folderName" name="folderName" value="Invoice Search" />
                    <s:hidden name="queryId" />
                    <s:hidden name="tableHeadData" />


                    <table cellspacing="0" cellpadding="0" class="grid" class="wid-99p">
                        <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.invoice.invoiceNumber" />:</td>
                            <td class="searchLabel"><s:textfield name="invoiceSearchCriteria.invoiceNumber" id="invoiceSearchCriteria.invoiceNumber" />
                            </td>
                        </tr>
                        <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.invoice.invoicingInterval" />:</td>
                            <td class="searchLabel"><s:select name="invoiceSearchCriteria.interval" id="invoiceSearchCriteria.interval"
                                    list="invoiceIntervalList" headerKey="" headerValue="--Select--" />
                            </td>
                        </tr>
                        <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.common.status" />:</td>
                            <td class="searchLabel"><s:textfield name="invoiceSearchCriteria.status" id="invoiceSearchCriteria.status" />
                            </td>
                        </tr>
                        <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.common.invoiceType" />:</td>
                            <td class="searchLabel"><s:select name="invoiceSearchCriteria.type" id="invoiceSearchCriteria.type" list="invoiceTypeList"
                                    headerKey="" headerValue="--Select--" />
                            </td>
                        </tr>
                        <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.invoice.customerName" />:</td>
                            <td class="searchLabel"><s:textfield name="invoiceSearchCriteria.customerName" id="invoiceSearchCriteria.name" /></td>
                        </tr>
                        <tr>
                            <td class="searchLabel labelStyle"><s:text name="label.invoice.customerNumber" />:</td>
                            <td class="searchLabel"><s:textfield name="invoiceSearchCriteria.customerNumber" id="invoiceSearchCriteria.customerNumber" />
                            </td>
                        </tr>
                        <tr>
                            <td class="searchLabel labelStyle"><s:text name="label.common.locationName" />:</td>
                            <td class="searchLabel"><s:textfield name="invoiceSearchCriteria.locationName" id="invoiceSearchCriteria.locationName" />
                            </td>
                        </tr>
                        <tr>
                            <td class="searchLabel labelStyle"><s:text name="label.common.shipTo" />:</td>
                            <td class="searchLabel"><s:textfield name="invoiceSearchCriteria.locationCode" id="invoiceSearchCriteria.locationCode" />
                            </td>
                        </tr>
                        <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.common.serialNumber" />:</td>
                            <td class="searchLabel"><s:textfield name="invoiceSearchCriteria.serialNumber" id="invoiceSearchCriteria.serialNumber" /></td>
                        </tr>
                          <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.common.serviceRequestNumber" />:</td>
                            <td class="searchLabel"><s:textfield name="invoiceSearchCriteria.serviceRequestNumber" id="invoiceSearchCriteria.serviceRequestNumber" /></td>
                        </tr>
                          <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.common.quoteNumber" />:</td>
                            <td class="searchLabel"><s:textfield name="invoiceSearchCriteria.quoteNumber" id="invoiceSearchCriteria.quoteNumber" /></td>
                        </tr>
                         <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.fleetClaim.claimNumber" />:</td>
                            <td class="searchLabel"><s:textfield name="invoiceSearchCriteria.claimNumber" id="invoiceSearchCriteria.claimNumber" /></td>
                        </tr>
                        <tr>
                            <td class="searchLabel labelStyle" nowrap="nowrap"><span style="float: left;"><s:text
                                        name="search.invoice.invoiceStartDate" />:</span> <span style="float: right;"><s:text name="label.common.from" />: </span>
                            </td>
                            <td><sd:datetimepicker name='invoiceSearchCriteria.invoiceStartFrom' value='%{invoiceSearchCriteria.invoiceStartFrom}'
                                    id='invoiceSearchCriteria.invoiceStartFrom' />
                            </td>

                        </tr>
                        <tr>
                            <td class="preDefinedSearchLabel labelStyle" align="right"><s:text name="label.common.to" />:</td>
                            <td><sd:datetimepicker name='invoiceSearchCriteria.invoiceStartTill' value='%{invoiceSearchCriteria.invoiceStartTill}'
                                    id='invoiceSearchCriteria.invoiceStartTill' />
                            </td>

                        </tr>
                        <tr>
                            <td class="searchLabel labelStyle" nowrap="nowrap"><span style="float: left;"><s:text
                                        name="search.invoice.invoiceEndDate" />:</span> <span style="float: right;"><s:text name="label.common.from" />: </span></td>
                            <td><sd:datetimepicker name='invoiceSearchCriteria.invoiceEndFrom' value='%{invoiceSearchCriteria.invoiceEndFrom}'
                                    id='invoiceSearchCriteria.invoiceEndFrom' />
                            </td>

                        </tr>
                        <tr>
                            <td class="preDefinedSearchLabel labelStyle" align="right"><s:text name="label.common.to" />:</td>
                            <td><sd:datetimepicker name='invoiceSearchCriteria.invoiceEndTill' value='%{invoiceSearchCriteria.invoiceEndTill}'
                                    id='invoiceSearchCriteria.invoiceEndTill' />
                            </td>

                        </tr>
                        <tr>
                            <td class="preDefinedSearchLabel labelStyle"><s:text name="button.common.saveSearch" /> <s:checkbox cssClass="buttonGeneric"
                                    name="notATemporaryQuery" id="notATemporaryQuery" value="notATemporaryQuery" onclick="enableText()">
                                </s:checkbox>
                            </td>
                            <td class="searchLabel"><s:if test="savedQueryName!=null">
                                    <s:textfield name="savedQueryName" id="savedQueryName" value="%{savedQueryName}"></s:textfield>
                                </s:if> <s:else>
                                    <s:textfield name="savedQueryName" id="savedQueryName" disabled="true" value="Name of the Query"></s:textfield>
                                </s:else>
                            </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td class="label" valign="bottom"><input type="submit" class="buttonGeneric" value='<s:text name="label.common.search"/>' />
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>


</u:body>
</html>
