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
        dojo.require("dojox.layout.ContentPane");
        dojo.require("twms.widget.Dialog");
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("periodicServiceListing"));
        }  
        
        function exportToExcel() {
            var folderName='${folderName}';
            exportExcel("/claim/populateCriteria","exportPeriodicServicesToExcel.action");
        }
        
        var pageUrl = "getScheduleServices.action";
    	function getPageUrl(){
    		var folderName=document.getElementById("folder").value;
    		pageUrl = "getScheduleServices.action?"+"folderName="+folderName;
    		return pageUrl;
    	}
        
        var extraParams = {		
  				inboxViewId : ${inboxViewId}				
  	    };
     </script>
    <u:stylePicker fileName="base.css"/>
    <u:stylePicker fileName="yui/reset.css" common="true"/>
    <u:stylePicker fileName="layout.css" common="true"/>
    <script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dojox.layout.ContentPane");
    </script>
    <%@include file="/i18N_javascript_vars.jsp"%>
    <s:hidden id="context" name="context" value="PeriodicServiceSearches" />
    <input type="hidden" id='folder' value='${folderName}'/>
</head>
<u:body >
    <div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
            <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button"
                summaryTableId="periodicServiceListing" />
            <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
                cssClass="download_to_excel_button" summaryTableId="periodicServiceListing" />
            <%@ include file="../common/spring/inboxViewForm.jsp"%>
        </div>
        <u:stylePicker fileName="SummaryTableButton.css" />
        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="periodicServiceListing" extraParamsVar="extraParams"
                        bodyUrl="periodicServiceListingBody.action" folderName="${folderName}" 
                        detailUrl="periodicServiceDetail.action" parentSplitContainerId=""
                        populateCriteriaDataOn="/claim/populateCriteria">
        <script type="text/javascript" src="../scripts/tst_commonExt/DueDateRenderer.js"></script>
            <c:forEach items="${tableHeadData}" var="column">             
                <c:choose>
                 	<c:when test="${column.id=='imageCol'||column.id=='dueDate'}">
                 	 <script type="text/javascript" src="../scripts/tst_commonExt/ImageRenderer.js"></script>
                 	 <c:if test="${column.id=='imageCol'}">
                 	 <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
                		rendererClass="tavant.twms.summaryTableExt.ImageRenderer" labelColumn="${column.labelColumn}" hidden="${column.hidden}" 
                		disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
                	</c:if>
                	<c:if test="${column.id=='dueDate'}">
                 	 <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
                		rendererClass="tavant.twms.summaryTableExt.DueDateRenderer" labelColumn="${column.labelColumn}" hidden="${column.hidden}" 
                		disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
                		</c:if>        		
                 	</c:when>
                 	<c:otherwise>
                 	<u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
            			labelColumn="${column.labelColumn}"
            			hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
                 	</c:otherwise>
                 </c:choose>
            </c:forEach>
            <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
        </u:summaryTable>
    </div>
    <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
</u:body>
</html>