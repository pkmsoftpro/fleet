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
                    <s:text name="label.inventory.searchInventory" />
                </div>
                <u:actionResults />
                <s:fielderror theme="xhtml" />
                <form action="validatePredefinedInventorySearchFields" method="POST" name="searchForm">
                    <s:hidden id="context" name="context" value="InventorySearches" />
                    <s:hidden id="folderName" name="folderName" value="Inventory Search" />
                    <s:hidden name="queryId" />
                    <s:hidden name="tableHeadData" />


                    <div class="policy_section_div mar5">
                        <table border="0" cellspacing="0" cellpadding="0" class="grid">

                            <s:if test="isLoggedInUserAnInternalUser() || isLoggedInUserCustomer()"> 
                                <%@ include file="customerAndInternalUserInventorySearch.jsp"%>
                            </s:if>
                            <s:if test="!isLoggedInUserAnInternalUser() && !isLoggedInUserCustomer()">                        
                                <%@ include file="dealerInventorySearch.jsp"%>
                            </s:if>
                            <tr>
                                <td class="preDefinedSearchLabel labelStyle"><s:text name="button.common.saveSearch" /> <s:checkbox
                                        cssClass="buttonGeneric" name="notATemporaryQuery" id="notATemporaryQuery" value="notATemporaryQuery"
                                        onclick="enableText()">
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
                                <td class="label" valign="bottom"><input type="submit" class="buttonGeneric"
                                    value='<s:text name="label.inventory.search"/>' />
                                </td>
                            </tr>

                        </table>
                    </div>
                </form>
            </div>
        </div>
    </div>


</u:body>
</html>
