<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
<head>
    <u:stylePicker fileName="ui-ext/actionResult/actionResult.css"/>
    <s:head theme="twms"/>
    <u:stylePicker fileName="SummaryTable.css"/>
    <script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
    <script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dojox.layout.ContentPane");
        dojo.require("twms.widget.Dialog");
        /* function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("dealerSRListing"));
        }  */

        var extraParams = {
				missedPM :'${missedPM}',
				days : '${days}',
				dealerDashboardId :'${dealerDashboardId}',
				hasAllChecked :'${hasAllChecked}',
				inboxViewId : '${inboxViewId}'	
	    };
        
       function exportToExcel() {
            var folderName='${folderName}';
            exportExcel("/dashboardSR/populateCriteria","dealerSRListingToExcel.action");
       }
       
       var pageUrl = "dealerDashbardSR";
       function getPageUrl(){
   		var folderName=document.getElementById("folder").value;
   		var type=document.getElementById("type").value;
   		var dealerDashboardId=document.getElementById("dealerDashboardId").value;
   		var checked=document.getElementById("hasAllChecked").value;
   		var missedPM=document.getElementById("missedPM").value;
   		var days=document.getElementById("days").value;
   		pageUrl = "dealerDashbardSR?"+"folderName="+folderName+"&type="+type+"&dealerDashboardId="+dealerDashboardId+"&hasAllChecked="+checked+"&missedPM="+missedPM+"&days="+days;
   		return pageUrl;
     	}
     </script>
    <u:stylePicker fileName="base.css"/>
    <u:stylePicker fileName="yui/reset.css" common="true"/>
    <u:stylePicker fileName="layout.css" common="true"/>
    <%@include file="/i18N_javascript_vars.jsp"%>
    <s:hidden id="context" name="context" value="DealerDashboardSRSearch" />
</head>
<u:body >
    <input type="hidden" id='folder' value='${folderName}'></input>
    <input type="hidden" id='type' value='${type}'></input>
    <input type="hidden" id='dealerDashboardId' value='${dealerDashboardId}'></input>
    <input type="hidden" id='hasAllChecked' value='${hasAllChecked}'></input>
    <input type="hidden" id='missedPM' value='${missedPM}'></input>
    <input type="hidden" id='days' value='${days}'></input>
<div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
    <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
		  <%-- <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button" summaryTableId="dealerSRListing" /> --%>
          <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right" cssClass="download_to_excel_button" summaryTableId="dealerSRListing" />
           <%@ include file="../../../common/spring/inboxViewForm.jsp"%>
	</div>
        <u:stylePicker fileName="SummaryTableButton.css" />
         <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="dealerSRListing" extraParamsVar="extraParams"
                        bodyUrl="dealerSRListingBody" folderName="${folderName}" detailUrl="dashboardSRdetails" parentSplitContainerId="" 
                        populateCriteriaDataOn="/dashboardSR/populateCriteria">
            <c:forEach items="${tableHeadData}" var="column">
               <c:choose>
                  <c:when test="${column.id=='locationShipTo' || column.id=='serialNumber' || column.id=='serviceRequestNumber'}">
                	<script type="text/javascript" src="../scripts/tst_commonExt/HyperlinkRenderer.js"></script>
            		<u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
            			rendererClass="tavant.twms.summaryTableExt.HyperlinkRenderer"	labelColumn="${column.labelColumn}"
            			hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
            	  </c:when>
            	  <c:otherwise>
                   <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}" labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
                </c:otherwise>
               </c:choose>
           </c:forEach>
           <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
        </u:summaryTable>
 </div>
 <jsp:include flush="true" page="../../../common/ExcelDowloadDialog.jsp"></jsp:include>
</u:body>
</html>