<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%
    response.setHeader("Pragma", "no-cache");
			response.addHeader("Cache-Control", "must-revalidate");
			response.addHeader("Cache-Control", "no-cache");
			response.addHeader("Cache-Control", "no-store");
			response.setDateHeader("Expires", 0);
%>

<html>
<head>
<meta http-equiv="Context-Type" content="text/html; charset=ISO-8859-1">
<s:head theme="twms" />
<u:stylePicker fileName="common.css" />
<u:stylePicker fileName="base.css" />

</head>
<u:actionResults />
<u:stylePicker fileName="inboxLikeButton.css" />
<script type="text/javascript">
    
</script>

<u:body smudgeAlert="false">
    <s:form name="labelSearchForm" id="labelSearchForm">
        <s:hidden name="labelType" />
        <div class="policy_section_div">
            <div class="section_header">
                <s:text name="label.common.customerLabels" />
            </div>
            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="grid borderForTable" align="center">

                <tr class="row_head">
                    <th><s:text name="label.customer.customerName" /></th>
                </tr>
                <s:iterator value="listfleetCustomers" status="itr" id="localesItr">
                    <tr>
                        <td><u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" cssClass="claims_folder folder" id="customerDetails" tagType="a"
                                tabLabel="%{getText('columnTitle.customer.name')}" url="customer_detail.action?id=%{id}" catagory="customer">
                                <s:property value='name' />
                            </u:openTab></td>
                    </tr>
                </s:iterator>
            </table>
        </div>
    </s:form>
</u:body>