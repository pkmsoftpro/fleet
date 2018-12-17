<%@page contentType="text/html"%>
<%@taglib prefix="sd" uri="/struts-dojo-tags"%>
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
	            function enableText()
	        	{
	        		document.getElementById("savedQueryName").disabled=!document.getElementById("notATemporaryQuery").checked;
	        		if(document.getElementById("notATemporaryQuery").checked){
	        			document.getElementById("savedQueryName").value='';
	        		}
	        		return true;
	        	}
	    </script>

</head>


<u:body smudgeAlert="false">

    <div dojoType="dijit.layout.BorderContainer" class="border-container" id="root">
        <div dojoType="dijit.layout.ContentPane" region="client" class="search-wrapper" id="content">
            <div class="policy_section_div" class="wid-100p">
                <u:actionResults />
                <s:fielderror theme="xhtml" />
                <div id="section_header" class="section_header">
                    <s:text name="label.quote.searchQuotes" />
                </div>

                <form name="form" method="POST" action="validatePreDefineQuoteSearchFields">
                    <s:hidden name="tableHeadData" />
                    <s:hidden id="folderName" name="folderName" value="Quotes Search" />
                    <s:hidden id="context" name="context" value="QuoteSearches" />
                    <s:hidden name="queryId" />

                    <div class="policy_section_div mar5">
                        <table border="0" cellspacing="0" cellpadding="0" class="grid">
                            <tr>
                                <td class="labelStyle" width="200px" nowrap="nowrap">&nbsp;<s:text name="label.common.quoteNumber" />:
                                </td>
                                <td class="floatL"><s:textfield name="quoteSearchCriteria.quoteNumber" id="quoteNumber" /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.common.quoteStatus" />:
                                </td>
                                <td class="floatL multiselect"><s:select multiple="true" name="quoteSearchCriteria.selectedStatuses" list="listStatuses"
                                        size="4" /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.common.serviceRequestNumber" />:
                                </td>
                                <td class="floatL"><s:textfield name="quoteSearchCriteria.serviceRequestNumber" id="serviceRequestNumber" /></td>
                            </tr>
                           <s:if test="!isLoggedInUserCustomer()">  
                                <tr>
                                    <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.common.customerName" />
                                    </td>
                                    <td class="floatL"><s:textfield name="quoteSearchCriteria.customersName" id="customersName" /></td>
                                </tr>
                                <tr>
                                    <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.common.customerLocation" />:
                                    </td>
                                    <td class="floatL"><s:textfield name="quoteSearchCriteria.customerLocation" id="customerLocation" /></td>
                                </tr>
                          </s:if>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.common.serialNumber" />:
                                </td>
                                <td class="floatL"><s:textfield name="quoteSearchCriteria.serialNumber" id="serialNumber" /></td>
                            </tr>
                             <s:if test="isLoggedInUserAnInternalUser() || isDealerOwned()">       
                                <tr>
                                    <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.common.dealerNumber" />
                                    </td>
                                    <td class="floatL"><s:textfield name="quoteSearchCriteria.dealerNumber" id="dealerNumber" /></td>
                                </tr>
                                <tr>
                                    <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.common.dealerName" />
                                    </td>
                                    <td class="floatL"><s:textfield name="quoteSearchCriteria.dealerName" id="dealerName" /></td>
                                </tr>
                            </s:if>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.common.productType" />:
                                </td>
                                <td class="floatL"><s:textfield name="quoteSearchCriteria.productType" id="productType" /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.commom.modelNumber" />:
                                </td>
                                <td class="floatL"><s:textfield name="quoteSearchCriteria.modelNumber" id="modelNumber" /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.commom.claimNumber" />:
                                </td>
                                <td class="floatL"><s:textfield name="quoteSearchCriteria.claimNumber" id="claimNumber" /></td>
                            </tr>
                            <tr>
                                <td class="searchLabel labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.common.fromDate" />:
                                </td>
                                <td class="searchLabel"><sd:datetimepicker name='quoteSearchCriteria.fromDate' value='%{quoteSearchCriteria.fromDate}'
                                        id='quoteSearchCriteria_fromDate' /></td>
                            </tr>
                            <tr>
                                <td class="searchLabel labelStyle">&nbsp;<s:text name="label.common.toDate" />:
                                </td>
                                <td class="searchLabel"><sd:datetimepicker name='quoteSearchCriteria.toDate' value='%{quoteSearchCriteria.toDate}'
                                        id='quoteSearchCriteria_toDate' /></td>
                            </tr>
                            <tr>
                                <td class="labelStyle" nowrap="nowrap">&nbsp;<s:text name="label.commom.assetNumber" />:
                                </td>
                                <td class="floatL"><s:textfield name="quoteSearchCriteria.assetNumber" id="assetNumber" /></td>
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


                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td></td>
                                <td class="label" valign="bottom"><s:submit id="savedButton" cssClass="buttonGeneric"
                                        value="%{getText('button.common.search')}" /></td>
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