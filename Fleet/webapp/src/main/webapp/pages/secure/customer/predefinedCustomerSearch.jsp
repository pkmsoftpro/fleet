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
    dojo.addOnLoad(function() {
        var countrySelectBox = dijit.byId('customerSearchCriteria.country');
        countrySelectBox.fireOnLoadOnChange = true;
        dojo.connect(countrySelectBox, "onChange", function() {
            var countryName = countrySelectBox.value;
            var params = {
                selectedCountry : countryName
            };
            //document.forms[0]["customerSearchCriteria.country"].value = countryName;
            var url = "fetch_states_by_country.action?";
            var statesDivPane = dojo.byId("listOfStatesDiv");
            twms.ajax.fireHtmlRequest(url, params, function(data) {
                statesDivPane.innerHTML = data;
                var statesPane = dojo.byId("state");
                statesPane.disabled = false;
                delete data;
            });

        });
    });
</script>
</head>
<u:body smudgeAlert="false">

    <div dojoType="dijit.layout.BorderContainer" class="border-container" id="root">
        <div dojoType="dijit.layout.ContentPane" region="client" id="content" class="search-wrapper">
            <div class="policy_section_div">
                <div class="section_header">
                    <s:text name="label.customer.customerSearch" />
                </div>
                <s:actionerror theme="xhtml" />
                <s:fielderror theme="xhtml" />
                <form action="validatePreDefinedCustomerSearchFields.action" method="POST" name="searchForm">
                    <s:hidden name="context" />
                    <s:hidden name="folderName" />
                    <s:hidden name="queryId" />
                    <s:hidden name="tableHeadData" />


                    <table cellspacing="0" cellpadding="0" class="grid" class="wid-99p">

                        <tr>
                            <td width="150px" class="searchLabel labelStyle"><s:text name="label.customer.customerName" />:</td>
                            <td class="searchLabel"><s:textfield name="customerSearchCriteria.customerName" id="customerSearchCriteria.name" />
                            </td>
                        </tr>
                        <tr>
                            <td class="searchLabel labelStyle"><s:text name="label.customer.customerBillTo" />:</td>
                            <td class="searchLabel"><s:textfield name="customerSearchCriteria.billTo" id="customerSearchCriteria.billTo" />
                            </td>
                        </tr>
                        <tr>
                            <td class="searchLabel labelStyle"><s:text name="label.common.shipTo" />:</td>
                            <td class="searchLabel"><s:textfield name="customerSearchCriteria.shipTo" id="customerSearchCriteria.shipTo" /></td>
                        </tr>
                        <tr>
                            <td class="searchLabel labelStyle"><s:text name="label.common.city" />:</td>
                            <td class="searchLabel"><s:textfield name="customerSearchCriteria.city" id="customerSearchCriteria.city" />
                            </td>
                        </tr>
                        
                        <tr>
                            <td class="searchLabel labelStyle"><s:text name="label.common.state" />:</td>
                            <td class="searchLabel"><jsp:include flush="true" page="../location/statesSelectList.jsp" /></td>
                            <td colspan="2" />
                        </tr>
                        
                        <tr>
                            <td class="searchLabel labelStyle"><s:text name="label.common.zipCode" />:</td>
                            <td class="searchLabel"><s:textfield name="customerSearchCriteria.zipCode" id="customerSearchCriteria.zipCode" />
                            </td>
                        </tr>
                        <tr>
                            <td class="searchLabel labelStyle"><s:text name="label.common.country" />:</td>
                            <td class="searchLabel"><s:select theme="twms" name="customerSearchCriteria.country" id="customerSearchCriteria.country"
                                    list="listOfCountries" emptyOption="true" headerKey="" headerValue="--Select--" /></td>
                            <td colspan="2" />
                        </tr>
                    
                        <tr>
                            <td ></td>
                            <td class="label" valign="bottom"><input type="submit" class="buttonGeneric"
                                value='<s:text name="label.customer.customerSearch"/>' /></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>


</u:body>
</html>
