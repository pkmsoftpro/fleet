<%@page contentType="text/html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page pageEncoding="UTF-8"%>
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
<script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>
<script type="text/javascript">

        dojo.require("twms.widget.Dialog"); 
        
        dojo.addOnLoad(function () {
			parent.publishEvent("/accordion/refreshperiodicservicesearchfolders");
	    });
        
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic(
                    "periodicServiceListing"));
        }        
        
       	function exportToExcel(){
            exportExcel("/searchQuotes/populateCriteria","exportPreDefinedPeriodicServiceSearchesToExcel.action");
        }
       	
       	var extraParams = {
				<s:if test="inboxViewId!=null && !inboxViewId.trim().equals('')">
					inboxViewId : '<s:property value="inboxViewId"/>',
				</s:if>
		    	queryId :'<s:property value="queryId" />',
		    	notATemporaryQuery : '<s:property value="notATemporaryQuery"/>',
		    	savedQueryName : '<s:property value="savedQueryName" escapeJavaScript="true"/>'
		};
       	function getPageUrl() {
            <s:url var="theUrl" action="showPreDefinedPeriodicServiceSearchResults.action" escapeAmp="false">
                <s:param name="context" value="context" />
                <s:param name="folderName" value="folderName" />
                <s:param name="queryId" value="queryId" />
                <s:param name="savedQueryName" value="savedQueryName" />
                <s:param name="notATemporaryQuery" value="notATemporaryQuery" />
            </s:url>
	    	return '<s:property value="%{#theUrl}" escapeHtml="false"/>';
	    }
        function closeTabAfterFinishing() {
            var tabDetails = getTabDetailsForIframe();
            var tab = getTabHavingId(tabDetails.tabId);
            parent.publishEvent("/tab/close", {tab:tab});
        }
        function handleShowSearch(event, dataId) {
            var formObj = dojo.byId("showSearchQuerySubmitForm");
            formObj.action = "showPreDefinedPeriodicSerivceSearchQuery.action";
            formObj.submit(); 
  		}
        function deleteQuery(){
	    	var url = 'deletePredefinedSearchQuery.action?queryId=<s:property value="queryId"/>';			
			var param ='<s:property value="queryId"/>';		
			twms.ajax.fireHtmlRequest(url, param,
					function(data){
				parent.publishEvent("/accordion/refreshperiodicservicesearchfolders");
				closeTabAfterFinishing();
				});
		}
    </script>
<u:stylePicker fileName="base.css" />
<u:stylePicker fileName="yui/reset.css" common="true" />
<u:stylePicker fileName="layout.css" common="true" />
<%@include file="../../../i18N_javascript_vars.jsp"%>
	
</head>
<u:body>
    <s:hidden name="periodicServiceSearchCriteria" value="periodicServiceSearchCriteria" />
    <s:set name="periodicServiceSearchCriteria" value="periodicServiceSearchCriteria" />
    <div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">

            <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button"
                summaryTableId="periodicServiceListing" />
            <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
                cssClass="download_to_excel_button" summaryTableId="periodicServiceListing" />
            <u:summaryTableButton id="searchButton" label="button.view.showSearchQuery" onclick="handleShowSearch" summaryTableId="quoteListTable"cssClass="show_search_query_button" />
            <s:if test="savedQueryName!=null">
                <u:summaryTableButton id="deleteQueryButton" label="button.common.delete" onclick="deleteQuery" summaryTableId="quoteListTable" cssClass="show_search_query_button" />
            </s:if>
             <%@ include file="../common/inboxViewForm.jsp"%>

        </div>
        
        <form name="showSearchQuerySubmitForm" id="showSearchQuerySubmitForm">
            <s:hidden id="folder" name="folderName"/>
            <s:hidden id="context" name="context" value="PeriodicServiceSearches" />
            <s:hidden id="queryId" name="queryId" />
            <s:hidden name="notATemporaryQuery" />
            <s:hidden name="savedQueryName" />
        </form>

        <u:stylePicker fileName="SummaryTableButton.css" />
        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="periodicServiceListing" bodyUrl="periodic_service_table_body.action" folderName="Periodic Services Search"
            detailUrl="periodicServiceDetail.action" parentSplitContainerId="" populateCriteriaDataOn="/searchQuotes/populateCriteria" extraParamsVar="extraParams">
             <script type="text/javascript" src="scripts/tst_commonExt/DueDateRenderer.js"></script>
            <c:forEach items="${tableHeadData}" var="column">             
                <c:choose>
                 	<c:when test="${column.id=='dueDate'}">
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
            <script type="text/javascript" src="scripts/SummaryTableTagEventHandler.js"></script>
        </u:summaryTable>

    </div>

    <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
</u:body>
</html>