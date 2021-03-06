<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>

<html>
<head> 
    <title><s:text name="title.contract.contractInboxView"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="SummaryTable.css"/>
    <script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dojox.layout.ContentPane");
    </script>
    <script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
    <script type="text/javascript" src="../scripts/labels.js"></script>
    <script type="text/javascript">
        dojo.require("twms.widget.Dialog");
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic(
                    "contractTable"));
        }        
        function exportToExcel(){
        	exportExcel("/contracts/populateCriteria", "exportContractsToExcel.action");
       	}
        var applyActionUrl;
        var removeActionUrl;
        dojo.addOnLoad(function() {
        		removeActionUrl = "../remove_labels_on_Contracts.action?";
        		applyActionUrl = "../apply_labels_on_Contracts.action?";
        		checkActionUrl="../check_labels_on_Contracts.action?"
        });
    </script>
    <u:stylePicker fileName="base.css"/>
    <u:stylePicker fileName="yui/reset.css" common="true"/>
    <u:stylePicker fileName="layout.css" common="true"/>
    <%@include file="../../../i18N_javascript_vars.jsp"%>
  </head>
  <u:body >
  <div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
    <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
          <c:if test="${isDealerOwned==false}">
    	  <u:summaryTableButton id="labelButton" label="button.common.addLabels" onclick="showLabels" summaryTableId="contractTable" cssClass="addLabels_retailItems_button"/>
          </c:if>
          <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button" summaryTableId="contractTable"/>
          <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right" cssClass="download_to_excel_button" summaryTableId="contractTable"/>          
    </div>
        <%-- We don't need folder name info. Hence just setting some junk value
        here --%>
        <u:stylePicker fileName="SummaryTableButton.css" />
        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="contractTable"
                        bodyUrl="contractListingTableBody.action" folderName="Contract" multiSelect="true"
                        previewPaneId="preview" detailUrl="contract_detail.action" parentSplitContainerId=""
                        populateCriteriaDataOn="/contracts/populateCriteria">
             <c:forEach items="${tableHeadData}" var="column">
               <c:choose>
                <c:when test="${column.dataType == 'Image'}">
            		<script type="text/javascript" src="../scripts/tst_commonExt/ImageRenderer.js"></script>
            		<u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
            			rendererClass="tavant.twms.summaryTableExt.ImageRenderer"	labelColumn="${column.labelColumn}"
            			hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
            	</c:when>
            	<c:otherwise>
                 <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}" labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
                </c:otherwise>
              </c:choose>
           </c:forEach>
        <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script></u:summaryTable>
        </div>
     <s:hidden name="labelType" value="%{@tavant.twms.domain.common.Label@CONTRACT}" />    
    <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
    <jsp:include flush="true" page="../common/labelsDialog.jsp"></jsp:include>
  </u:body>
</html>