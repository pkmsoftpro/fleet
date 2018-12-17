<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>

<html>
<head>
    <title><s:text name="title.customerLocation.customerLocationSearchView"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="SummaryTable.css"/>
    <script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dojox.layout.ContentPane");
    </script>
    <script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>
    <script type="text/javascript">

        dojo.require("twms.widget.Dialog");
        dojo.addOnLoad(function () {
			parent.publishEvent("/accordion/refreshsearchfolders");
	    });
        
        
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic(
                    "customerLocationTable"));
        }        
        
        function exportToExcel(){
        	exportExcel("/searchLocations/populateCriteria","exportCustomerLocationsToExcel.action");
        }
        function closeTabAfterFinishing() {
            var tabDetails = getTabDetailsForIframe();
            var tab = getTabHavingId(tabDetails.tabId);
            parent.publishEvent("/tab/close", {tab:tab});
        } 
        function handleShowSearch(event, dataId) {
            var formObj = dojo.byId("showSearchQuerySubmitForm");
            formObj.action = "showPreDefinedCustomerLocationSearchQuery.action";
            formObj.submit(); 
  		}
        function deleQuery(){
	    	var url = 'deletePredefinedSearchQuery.action?queryId=<s:property value="queryId"/>';			
			var param ='<s:property value="queryId"/>';		
			twms.ajax.fireHtmlRequest(url, param,
					function(data){
				parent.publishEvent("/accordion/refreshsearchfolders");
				closeTabAfterFinishing();
				});
		}
    </script>
    <u:stylePicker fileName="base.css"/>
    <u:stylePicker fileName="yui/reset.css" common="true"/>
    <u:stylePicker fileName="layout.css" common="true"/>
    <%@include file="../../../i18N_javascript_vars.jsp"%>
	
  </head>
  <u:body >
  <s:hidden name="customerSearchCriteria" value="customerSearchCriteria"/>
  <s:set name="customerSearchCriteria" value="customerSearchCriteria"/>
  <div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
         <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
       <u:summaryTableButton id="searchButton" label="button.view.showSearchQuery" onclick="handleShowSearch" summaryTableId="customerLocationTable"cssClass="show_search_query_button" />
                <s:if test="savedQueryName!=null">
                <u:summaryTableButton id="deleteQueryButton"
                    label="button.common.delete" onclick="deleQuery"
                    summaryTableId="customerLocationTable"
                    cssClass="show_search_query_button" />
         </s:if>
        <u:summaryTableButton id="refreshButton" label="button.common.refresh"
                    onclick="refreshIt" align="right" cssClass="refresh_button"
                    summaryTableId="customerLocationTable"/>
        <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel"
            align="right" cssClass="download_to_excel_button" summaryTableId="customerLocationTable"/>
    </div>
    
      <form name="showSearchQuerySubmitForm" id="showSearchQuerySubmitForm">     
            <s:hidden id="context" name="context" value="customerLocationSearches" />
            <s:hidden id="queryId" name="queryId" />
            <s:hidden name="notATemporaryQuery" />
            <s:hidden name="savedQueryName" />
        </form>
        
        
        
        
        <u:stylePicker fileName="SummaryTableButton.css" />
        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="customerLocationTable"
                        bodyUrl="customerLocation_table_body.action" folderName=""
                        previewPaneId="preview" detailUrl="customerLocation.action" parentSplitContainerId=""
                        populateCriteriaDataOn="/searchLocations/populateCriteria">
            <s:iterator value="tableHeadData">
            <s:if test="imageColumn ">
            		<script type="text/javascript" src="scripts/tst_commonExt/ImageRenderer.js"></script>
            		<u:summaryTableColumn id="%{id}" label="%{title}" width="%{widthPercent}" idColumn="%{idColumn}"
            			rendererClass="tavant.twms.summaryTableExt.ImageRenderer"	labelColumn="%{labelColumn}"
            			hidden="%{hidden}" disableFiltering="%{disableFiltering}" disableSorting="%{disableSorting}"/>
            	</s:if>
            	<s:else>
                <u:summaryTableColumn id="%{id}" label="%{title}" width="%{widthPercent}" idColumn="%{idColumn}" labelColumn="%{labelColumn}" hidden="%{hidden}" disableFiltering="%{disableFiltering}" disableSorting="%{disableSorting}"/>
                </s:else>
            </s:iterator>
        <script type="text/javascript" src="scripts/SummaryTableTagEventHandler.js"></script></u:summaryTable>
    <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
	</div>
  </u:body>
</html>