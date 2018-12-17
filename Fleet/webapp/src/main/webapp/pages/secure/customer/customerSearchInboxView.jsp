<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>

<html>
<head>
    <title><s:text name="title.customer.customerInboxView"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="SummaryTable.css"/>
    <script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dojox.layout.ContentPane");
    </script>
    <script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>
    <script type="text/javascript">

        dojo.require("twms.widget.Dialog");
        
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic(
                    "customerTable"));
        }        
        
       function exportToExcel(){
        	exportExcel("/customer/populateCriteria","exportCustomersToExcel.action");
        	} 
       
       function handleShowSearch(event, dataId) {
           var formObj = dojo.byId("showSearchQuerySubmitForm");
           formObj.action = "showPreDefinedCustomerSearchQuery.action";
           formObj.submit(); 
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
       
        <u:summaryTableButton id="refreshButton" label="button.common.refresh"
                    onclick="refreshIt" align="right" cssClass="refresh_button"
                    summaryTableId="customerTable"/>
            <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
                cssClass="download_to_excel_button" summaryTableId="customerTable" />
            <u:summaryTableButton id="searchButton" label="button.view.showSearchQuery" onclick="handleShowSearch" summaryTableId="customerTable"
                cssClass="show_search_query_button" />
        </div>
        
        <form name="showSearchQuerySubmitForm" id="showSearchQuerySubmitForm">
            <s:hidden id="folder" name="folderName" />
            <s:hidden id="context" name="context" value="Customer Search" />
            <s:hidden id="queryId" name="queryId" />
            <s:hidden name="notATemporaryQuery" />
            <s:hidden name="savedQueryName" />
        </form>

        <u:stylePicker fileName="SummaryTableButton.css" />
        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="customerTable"
                        bodyUrl="preDefinedCustomerSearchSummaryBody.action" folderName=""
                        previewPaneId="preview" detailUrl="customer_detail" parentSplitContainerId=""
                        populateCriteriaDataOn="/customer/populateCriteria">
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
        
    </div>
    <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
  </u:body>
</html>