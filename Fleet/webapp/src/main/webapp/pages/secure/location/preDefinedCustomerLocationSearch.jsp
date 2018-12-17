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
    dojo.addOnLoad(function() {
        var countrySelectBox = dijit.byId("country");
        countrySelectBox.fireOnLoadOnChange = true;
        dojo.connect(countrySelectBox, "onChange", function() {
            var selectedCountryValue = document.getElementById('country').value;
            var params = {
                selectedCountry : selectedCountryValue
            };
            document.forms[0]["country"].value = selectedCountryValue;
            var url = "getStatesForCountry.action?";
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
        <div dojoType="dijit.layout.ContentPane" region="client" class="search-wrapper" id="content">
            <div class="policy_section_div wid-100p">
                <u:actionResults />
                <s:fielderror theme="xhtml" />
                <div id="section_header" class="section_header">
                    <s:text name="label.common.customerLocationSearch" />
                </div>

                <form name="form" method="POST" action="validatePreDefinedCustomerLocationSearchFields.action">

                    <s:hidden name="context" name="context" value="customerLocationSearches" />
                    <s:hidden name="queryId" />
                    <s:hidden name="folderName" />
                    <s:hidden name="tableHeadData" />

                    <div class="policy_section_div mar5">
                        <table cellspacing="0" cellpadding="0" class="grid wid-99p">
                            <tr>
                                <td class="labelStyle" width="150px" nowrap="nowrap">&nbsp;<s:text name="search.customerLocation.locationName" />:
                                </td>
                                <td class="floatL"><s:textfield name="customerSearchCriteria.locationName" id="locationName" /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="search.customerLocation.shipTo" />:
                                </td>
                                <td class="floatL"><s:textfield name="customerSearchCriteria.shipTo" id="shipTo" /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.common.city" />:
                                </td>
                                <td class="floatL"><s:textfield name="customerSearchCriteria.city" id="city" /></td>
                            </tr>
                            
                            <tr>
                                <td class="searchLabel labelStyle"><s:text name="label.common.state" />:</td>
                                <td class="searchLabel"><jsp:include flush="true" page="statesSelectList.jsp" /></td>
                                <td colspan="2" />
                            </tr>
                            
                            <tr>
                                <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.common.zipCode" />:
                                </td>
                                <td class="floatL"><s:textfield name="customerSearchCriteria.zipCode" id="zipCode" /></td>
                            </tr>
                            <tr>
                                <td class="searchLabel labelStyle"><s:text name="label.common.country" />:</td>
                                <td class="searchLabel"><s:select theme="twms" name="customerSearchCriteria.country" id="country" list="listOfCountries"
                                        emptyOption="true" headerKey="" headerValue="--Select--" /></td>
                                <td colspan="2" />
                            </tr>
                        
                            <tr>
                                <td class="searchLabel labelStyle"><s:text name="button.common.saveSearch" /> <s:checkbox cssClass="buttonGeneric"
                                        name="notATemporaryQuery" id="notATemporaryQuery" value="notATemporaryQuery" onclick="enableText()">
                                    </s:checkbox></td>
                                <td class="labelStyle"><s:if test="savedQueryName!=null">
                                        <s:textfield name="savedQueryName" id="savedQueryName" value="%{savedQueryName}"></s:textfield>
                                    </s:if> <s:else>
                                        <s:textfield name="savedQueryName" id="savedQueryName" disabled="true" value="Name of the Query"></s:textfield>
                                    </s:else></td>
                            </tr>
                            <tr>
                                <td class="searchLabel labelStyle"></td>
                                <td class="searchLabel"><input type="submit" class="buttonGeneric" value='<s:text name="label.customerLocation.search"/>' />
                                </td>
                                <td colspan="2" />
                            </tr>
                            <tr class="hgt4">
                                <td></td>
                            </tr>
                        </table>
                    </div>

                </form>
            </div>
        </div>
    </div>
</u:body>
</html>