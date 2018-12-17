<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="authz" uri="authz"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>

<html>
<head>
<s:head theme="twms" />
<u:stylePicker fileName="SummaryTable.css" />
<script type="text/javascript">
    dojo.require("dijit.layout.LayoutContainer");
    dojo.require("dojox.layout.ContentPane");
</script>
<script type="text/javascript">
    dojo.require("twms.widget.Dialog");
    
    function refreshIt() {
        publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("inventoryTable"));
    }

    function exportToExcel() {
        exportExcel("/inventory/populateCriteria", "exportInventoryToExcel.action");
    }
    
   <authz:ifPermitted resource="createServiceRequest">  
    function createSR(event, dataId) {
        var url = "createServiceRequestFromSearch.action?&";
    	var thisTabLabel = getMyTabLabel();
    	if(dataId.length > 0){
    		url += "id=" + dataId;
    		 	}
    	else {
    		url = "createServiceRequest.action?&";
    	}
        parent.publishEvent("/tab/open", {label: "Create Service Request",
        								  url: url,
        								  decendentOf: thisTabLabel,
        								  forceNewTab: true});
    }
   </authz:ifPermitted>
    
  <authz:ifPermitted resource="createQuote">  
    function createQuoteButton(event, dataId) {
        var url = "createquoteFromInventoryPage.action?&";
    	var thisTabLabel = getMyTabLabel();
    	if(dataId.length>0){
    		url += "id=" + dataId;
    		 	}	
    	else
    	    {
    	    url = "createQuote.action?&";
    	    }
        parent.publishEvent("/tab/open", {label: "Create Quote",
        								  url: url,
        								  decendentOf: thisTabLabel,
        								  forceNewTab: true});
    }
   </authz:ifPermitted>
    
   <authz:ifPermitted resource="createClaim">  
    function createClaimButton(event, dataId) {
        var url = "getServiceRequestId.action?&";
    	var thisTabLabel = getMyTabLabel();
    	if(dataId.length>0){
    		url += "taskId=" + dataId+"&createType=fromInventory";
    		 	}
    	else
	    {
	    url = "createFleetClaim.action?&";
	    }
        parent.publishEvent("/tab/open", {label: "Create Claim",
        								  url: url,
        								  decendentOf: thisTabLabel,
        								  forceNewTab: true});
    }
    </authz:ifPermitted>
    
    var extraParams = {		
	    		"hasAllChecked" : '${hasAllChecked}',
		   		"origin" : '${origin}',
				inboxViewId : ${inboxViewId}				
	    };
    var pageUrl = "fleetInventoryListing.action";
	function getPageUrl(){
		var folderName=document.getElementById("folder").value;
		pageUrl = "fleetInventoryListing.action?"+"folderName="+folderName;
		return pageUrl;
	}
</script>
<u:stylePicker fileName="base.css" />
<u:stylePicker fileName="yui/reset.css" common="true" />
<u:stylePicker fileName="layout.css" common="true" />
<%@include file="../../../i18N_javascript_vars.jsp"%>
  <s:hidden id="context" name="context" value="InventorySearches" />
    <input type="hidden" id='folder' value='${folderName}'/>
</head>
<u:body>
    <div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%">

        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
            <authz:ifPermitted resource="createServiceRequest">  
            <u:summaryTableButton id="createServiceRequests" label="label.newServiceRequest.createServiceRequest" align="left" onclick="createSR"
                summaryTableId="inventoryTable" cssClass="create_claim_button" />
            </authz:ifPermitted>
             <authz:ifPermitted resource="createQuote">  
                <u:summaryTableButton id="createQuote" label="label.quote.createQuote" align="left" onclick="createQuoteButton"
                    summaryTableId="inventoryTable" cssClass="create_claim_button" />
            </authz:ifPermitted>
             <authz:ifPermitted resource="createClaim">
                <u:summaryTableButton id="createClaim" label="label.claim.createClaim" align="left" onclick="createClaimButton" 
                summaryTableId="inventoryTable" cssClass="create_claim_button" />
            </authz:ifPermitted>

            <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button"
                summaryTableId="inventoryTable" />
            <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
                cssClass="download_to_excel_button" summaryTableId="inventoryTable" />
            <%@ include file="../common/spring/inboxViewForm.jsp"%>
        </div>

            <u:stylePicker fileName="SummaryTableButton.css" />
            <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="inventoryTable" extraParamsVar="extraParams"
            bodyUrl="inventoryListingTableBody.action" folderName="${folderName}" detailUrl="equipmentDetailsInfo.action" parentSplitContainerId=""
                populateCriteriaDataOn="/inventory/populateCriteria" >
                 <c:forEach items="${tableHeadData}" var="column">
	                 <c:choose>
	                 	<c:when test="${column.id=='serialNumber' || column.id=='activeFleetInventoryAudit.shipTo.code'}">
	                 		<script type="text/javascript" src="../scripts/tst_commonExt/HyperlinkRenderer.js"></script>
			               	<u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}" labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}" rendererClass="tavant.twms.summaryTableExt.HyperlinkRenderer"/>
	                 	</c:when>
	                 	<c:otherwise>
		                 	 <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
		                    labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}"
		                    disableSorting="${column.disableSorting}" />
	                 	</c:otherwise>
	                 </c:choose>
                 </c:forEach>
                  <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
            </u:summaryTable>
    </div>
    <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
    <script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
</u:body>
</html>