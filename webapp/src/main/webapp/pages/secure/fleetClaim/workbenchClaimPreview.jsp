<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<link rel="stylesheet" type="text/css" href="../css/base_fleet.css" />

<script type="text/javascript">
    dojo.require("dijit.layout.LayoutContainer");
    dojo.require("dijit.layout.ContentPane");
    dojo.require("dijit.layout.TabContainer");
</script>
<style type="text/css">
.cellPaymentHeader {
	border: 1px solid #99BBE8;
	background: #C8DEFB;
	font-family: Arial, Helvetica, sans-serif;
	font-size: 12px;
	text-align: center;
	font-weight: bold;
	height: 24px;
}
</style>

<c:set var="errorsMap" value="${errorsMap}" />
<c:set var="warningsMap" value="${warningsMap}" />
<c:set var="SNError" value="${SNError}"/>
    <script type="text/javascript">
    
	function save() {
        var checkedList = new Array();
        var url = "confirmationOnExpectedAmounts/";
        addInCheckedList(document.getElementsByName("OEM_PARTS"), checkedList);
        addInCheckedList(document.getElementsByName("NON_OEM_PARTS"), checkedList);
        addInCheckedList(document.getElementsByName("LABOR"), checkedList);
        addInCheckedList(document.getElementsByName("TRAVEL"), checkedList);
        if(checkedList.length==0){
            checkedList.push('');
        }
        
        dojo.xhrPost({
			url: url,
			content: {fleetClaimId: document.getElementById("fleetClaimId").value, checkedList: checkedList},
			load: function(result) {
                var data = JSON.parse(result);
                if(data == "FAILURE") {
                    dojo.byId('preview').innerHTML=dojo.byId("saveFailure").innerHTML;
                } else {
                    refreshIt();
                    dojo.byId('preview').innerHTML=dojo.byId("saveSuccess").innerHTML;
                }
            },
            error: function() {
                dojo.byId('preview').innerHTML=dojo.byId("saveFailure").innerHTML;
           }
		});
    }
    
    function addInCheckedList(obj, checkedList){
        for(index  in obj) {
            if(obj[index].checked && (obj[index].value=='true')) {
                checkedList.push(obj[index].name);
            }
        }
    }
    
</script>
    <div class="section_header">
        <spring:message code="title.common.claimWorkbench" />
    </div>
    <c:if test="${ not empty SNError}">
    <div>
    <span class="red"><c:out value="${SNError}" /></span>
    </div>
    </c:if>
     <c:if test="${empty SNError}">
    <div dojoType="dijit.layout.LayoutContainer">
        <div dojoType="dijit.layout.TabContainer" tabPosition="top" layoutAlign="client">
            <div dojoType="dijit.layout.ContentPane" title="Errors/Warnings" class="scrollYNotX">
                <input type="hidden" id='fleetClaimId' value="${fleetClaim.id}" />
                <div>
                    <br/>
                    <c:if test="${not empty errorsMap || not empty warningsMap}">
                        <table class="grid" style="width: 60%;" align="center" border="1px solid #99BBE8" bordercolor="#C8DEFB">
                            <tr>
                                <th class="cellPaymentHeader"><spring:message code="columnTitle.manageBusinessRule.ruleNumber" /></th>
                                <th class="cellPaymentHeader" colspan="3"><spring:message code="columnTitle.manageBusinessRule.history.ruleDescription" />
                                </th>
                            </tr>
                            <c:if test="${not empty errorsMap}">
                                <c:forEach items="${errorsMap}" var="error">
                                    <tr>
                                        <td align="center"><c:out value="${error.key}" /></td>
                                        <td align="left" colspan="3"><c:out value="${error.value}" /></td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                            <c:if test="${not empty warningsMap}">
                                <c:forEach items="${warningsMap}" var="warning">
                                    <tr>
                                        <td align="center"><c:out value="${warning.key}" /></td>
                                        <td align="left" colspan="3"><c:out value="${warning.value}" /></td>
                                    </tr>
                                </c:forEach>
                            </c:if>
                        </table>
                    </c:if>
                </div>

                <div>
                    <br/>
                    <table class="grid wid890" align="center" border="1px solid #99BBE8" bordercolor="#C8DEFB">
                        <tr>
                            <th class="cellPaymentHeader wid190"><spring:message code="columnTitle.workBench.discrepancy" /></th>
                            <th class="cellPaymentHeader wid140"><spring:message code="columnTitle.workBench.partNumber" /></th>
                            <th class="cellPaymentHeader wid140"><spring:message code="columnTitle.workBench.dealerAskedAmount" /></th>
                            <th class="cellPaymentHeader wid140"><spring:message code="columnTitle.workBench.exceptedAskedAmount" /></th>
                            <th class="cellPaymentHeader wid280"><spring:message code="columnTitle.workBench.chooseExceptedAmount" /></th>
                        </tr>
                        <c:set var="count" value="0" scope="page" />
                        <c:forEach items="${fleetClaim.activeFleetClaimAudit.payment.lineItemGroups}" var="lineItemGroup">
                            <c:if test="${lineItemGroup.name == 'OEM_PARTS'}">
                                <c:if test="${lineItemGroup.askedAmount!=lineItemGroup.baseAmountDealer}">
                                <c:set var="count" value="${count + 1}" scope="page" />
                                <tr>
                                    <td class="wid190" align="center"><c:out value="${lineItemGroup.displayName}" /></td>
                                    <td class="wid420" colspan="3">
                                        <table class="tableSpacingBorder0">
                                            <c:forEach items="${fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.oemPartsInstalled}" var="oemPART">
                                                <tr>
                                                    <td class="workbenchPreviewCell wid140"><c:out value="${oemPART.installedBrandItem.itemNumber}" /></td>
                                                    <td class="workbenchPreviewCell wid140"><c:out value="${oemPART.askedPricePerUnit}" /></td>
                                                    <td class="wid140" align="center"><c:out value="${oemPART.pricePerUnit}" /></td>
                                                </tr>
                                            </c:forEach>
                                        </table></td>
                                    <td align="center" class="wid280">
                                        Yes <input type="radio" name="${lineItemGroup.name}" class="action-radio" value="true" ${fleetClaim.activeFleetClaimAudit.exceptedAmountOnOemParts ? 'checked':''}> 
                                        No <input type="radio" name="${lineItemGroup.name}" class="action-radio" value="false" ${not fleetClaim.activeFleetClaimAudit.exceptedAmountOnOemParts ? 'checked':''}>
                                    </td>
                                </tr>
                                </c:if>
                            </c:if>
                            <c:if test="${lineItemGroup.name == 'NON_OEM_PARTS'}">
                                <c:if test="${lineItemGroup.askedAmount!=lineItemGroup.baseAmountDealer}">
                                <c:set var="count" value="${count + 1}" scope="page" />
                                <tr>
                                    <td class="wid190" align="center"><c:out value="${lineItemGroup.displayName}" /></td>
                                    <td class="wid420" colspan="3">
                                        <table class="tableSpacingBorder0">
                                            <c:forEach items="${fleetClaim.activeFleetClaimAudit.serviceInformation.serviceDetail.nonOEMPartsInstalled}" var="nonOEMPART">
                                                <tr>
                                                    <td class="workbenchPreviewCell wid140"><c:out value="${nonOEMPART.partNumber}" /></td>
                                                    <td class="workbenchPreviewCell wid140"><c:out value="${nonOEMPART.askedPricePerUnit}" /></td>
                                                    <td class="wid140" align="center"><c:out value="${nonOEMPART.pricePerUnit}" />
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </table></td>
                                    <td align="center" class="wid280">
                                        Yes <input type="radio" name="${lineItemGroup.name}" class="action-radio" value="true" ${fleetClaim.activeFleetClaimAudit.exceptedAmtOnNonOemParts ? 'checked':''}>
                                        No <input type="radio" name="${lineItemGroup.name}" class="action-radio" value="false" ${not fleetClaim.activeFleetClaimAudit.exceptedAmtOnNonOemParts ? 'checked':''}>
                                    </td>
                                </tr>
                                </c:if>
                            </c:if>
                            <c:if test="${lineItemGroup.name == 'LABOR'}">
                                <c:if test="${lineItemGroup.askedAmount!=lineItemGroup.baseAmountDealer}">
                                <c:set var="count" value="${count + 1}" scope="page" />
                                <tr>
                                    <td class="wid190" align="center"><c:out value="${lineItemGroup.displayName}" /></td>
                                    <td class="wid420" colspan="3">
                                        <table class="tableSpacingBorder0">
                                            <tr>
                                                <td class="workbenchPreviewCell wid140">--</td>
                                                <td class="workbenchPreviewCell wid140"><c:out value="${lineItemGroup.askedAmount}" /></td>
                                                <td class="wid140" align="center"><c:out value="${lineItemGroup.baseAmountDealer}" /></td>
                                            </tr>
                                        </table></td>
                                    <td align="center" class="wid280">
                                        Yes <input type="radio" name="${lineItemGroup.name}" class="action-radio" value="true" ${fleetClaim.activeFleetClaimAudit.exceptedAmountOnLabor ? 'checked':''}>
                                        No <input type="radio" name="${lineItemGroup.name}" class="action-radio" value="false" ${not fleetClaim.activeFleetClaimAudit.exceptedAmountOnLabor ? 'checked':''}>
                                    </td>
                                </tr>
                                </c:if>
                            </c:if>
                            <c:if test="${lineItemGroup.name == 'TRAVEL'}">
                                <c:if test="${lineItemGroup.askedAmount!=lineItemGroup.baseAmountDealer}">
                                <c:set var="count" value="${count + 1}" scope="page" />
                                <tr>
                                    <td class="wid190" align="center"><c:out value="${lineItemGroup.displayName}" /></td>
                                    <td class="wid420" colspan="3">
                                        <table class="tableSpacingBorder0">
                                            <tr>
                                                <td class="workbenchPreviewCell wid140">--</td>
                                                <td class="workbenchPreviewCell wid140"><c:out value="${lineItemGroup.askedAmount}" /></td>
                                                <td class="wid140" align="center"><c:out value="${lineItemGroup.baseAmountDealer}" />
                                                </td>
                                            </tr>
                                        </table></td>
                                    <td align="center" class="wid280">
                                        Yes <input type="radio" name="${lineItemGroup.name}" class="action-radio" value="true" ${fleetClaim.activeFleetClaimAudit.exceptedAmountOnTravel ? 'checked':''}> 
                                        No <input type="radio" name="${lineItemGroup.name}" class="action-radio" value="false" ${not fleetClaim.activeFleetClaimAudit.exceptedAmountOnTravel ? 'checked':''}>
                                    </td>
                                </tr>
                                </c:if>
                            </c:if>
                        </c:forEach>
                    </table>
                </div>
                <c:if test="${count != 0}">
                    <div class="marL650">
                        <a class="button" id="saveButton" onclick="save()"> Save </a>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
    </c:if>
