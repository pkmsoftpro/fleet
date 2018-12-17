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
        <div dojoType="dijit.layout.ContentPane" region="client" class="search-wrapper" id="content">
            <div class="policy_section_div wid-100p">
                <u:actionResults />
                <s:fielderror theme="xhtml" />
                <div id="section_header" class="section_header">
                    <s:text name="label.serviceRequest.quicksearch" />
                </div>

                <form name="form" method="POST" action="validatePreDefineServiceRequestSearchFields">

                    <%--   <s:hidden name="context" />
                    <s:hidden name="queryId" />
                    <s:hidden name="folderName" />
                    <s:hidden name="tableHeadData" /> --%>

                    <%-- <s:hidden name="saveQuery" /> --%>
                    <s:hidden name="queryId" />
                    <s:hidden name="tableHeadData" />
                    <s:hidden id="folderName" name="folderName" value="Search" />
                    <s:hidden id="context" name="context" value="ServiceRequestSearches" />


                    <div class="policy_section_div mar5">
                        <table border="0" cellspacing="0" cellpadding="0" class="grid">
                            <tr>
                                <td class="labelStyle" width="200px" nowrap="nowrap"><s:text name="search.serviceRequest.serviceRequestNumber" />:</td>
                                <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.serviceRequestNumber"
                                        id="serviceRequestNumber" /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.serviceRequestStatus" />:</td>
                                <td class="floatL multiselect"><s:select multiple="true" name="serviceRequestSearchCriteria.selectedStatuses"
                                        list="listStatuses" size="4" /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.quoteNo" />:</td>
                                <td class="floatL"><s:textfield name="serviceRequestSearchCriteria.quoteNumber" id="quoteNumber" /></td>
                            </tr>
                            <%--    <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.startDate" />:
                                </td>
                                <td class="floatL"><s:text type="text" name="serviceRequestSearchCriteria.startDate" id="startDate" /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.endDate" />:
                                </td>
                                <td class="floatL"><s:text type="text" name="serviceRequestSearchCriteria.endDate" id="endDate" /></td>
                            </tr> --%>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.customerbillto" />:</td>
                                <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.customerBillTo" id="customerBillTo" /></td>
                            </tr>                            
                            <s:if test="!isLoggedInUserCustomer()">  
                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.customerName" />:</td>
                                <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.customerName" id="customerName" /></td>
                            </tr>

                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.customerLocation" />:</td>
                                <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.customerLocation" id="customerLocation" /></td>
                            </tr>
                            </s:if>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.serialNumber" />:</td>
                                <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.serialNumber" id="serialNumber" /></td>
                            </tr>

                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.assetNumber" />:</td>
                                <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.assetNumber" id="assetNumber" /></td>
                            </tr>
                            <s:if test="isLoggedInUserAnInternalUser() || isDealerOwned()">
                                <tr>
                                    <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.dealerId" />:</td>
                                    <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.dealerNumber" id="dealerID" /></td>
                                </tr>
                                <tr>
                                    <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.dealerName" />:</td>
                                    <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.dealerName" id="dealerName" /></td>
                                </tr>
                            </s:if>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.brand" />:</td>
                                <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.brand" id="brand" /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.model" />:</td>
                                <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.model" id="model" /></td>
                            </tr>
                            <tr>
                                <td class="searchLabel labelStyle" nowrap="nowrap"><s:text name="label.common.fromDate" />:</td>
                                <td class="searchLabel"><sd:datetimepicker name='serviceRequestSearchCriteria.fromDate'
                                        value='%{serviceRequestSearchCriteria.fromDate}' id='serviceRequestSearchCriteria_fromDate' /></td>
                            </tr>
                            <tr>
                                <td class="searchLabel labelStyle"><s:text name="label.common.toDate" />:</td>
                                <td class="searchLabel"><sd:datetimepicker name='serviceRequestSearchCriteria.toDate'
                                        value='%{serviceRequestSearchCriteria.toDate}' id='serviceRequestSearchCriteria_toDate' /></td>
                            </tr>

                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.series" />:</td>
                                <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.series" id="series" /></td>
                            </tr>
                            <%--
                                  <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.productType" />:
                                </td>
                                <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.productType" id="productType" /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.fuelType" />:
                                </td>
                                <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.fuelType" id="fuelType" /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.capapcity" />:
                                </td>
                                <td class="floatL"><s:textfield type="text" name="serviceRequestSearchCriteria.capacity" id="capacity" /></td>
                            </tr> --%>
                            <%--   <tr>
                                <td class="labelStyle" nowrap="nowrap"><s:text name="search.serviceRequest.productType" />:
                                </td>
                                <td class="floatL"><s:text type="text" name="serviceRequestSearchCriteria.productType" id="productType" /></td>
                            </tr> --%>
                      
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
                                <td></td>
                                <td algin="right"><input type="submit" class="buttonGeneric" value='<s:text name="label.serviceRequest.quicksearch"/>' /></td>
                            </tr>
                           
                        </table>
                    </div>

                </form>
            </div>
        </div>
    </div>
</u:body>
</html>