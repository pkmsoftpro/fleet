<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
<head>
    <s:head theme="twms"/>
    <u:stylePicker fileName="SummaryTable.css"/>
    <script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
    <script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dojox.layout.ContentPane");
        dojo.require("twms.widget.Dialog");
       
       function exportToExcel() {
            var folderName='${folderName}';
            exportExcel("/internalDashboardPaidClaims/populateCriteria","internalDashboardClaimsToExcel.action");
       }
      
     </script>
    <u:stylePicker fileName="base.css"/>
    <u:stylePicker fileName="yui/reset.css" common="true"/>
    <u:stylePicker fileName="layout.css" common="true"/>
     <u:stylePicker fileName="ui-ext/actionResult/actionResult.css"/>
    <%@include file="/i18N_javascript_vars.jsp"%>
</head>
<u:body >
<div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
    <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
          <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right" cssClass="download_to_excel_button" summaryTableId="internalDashboardPaidClaims" />
	</div>
        <u:stylePicker fileName="SummaryTableButton.css" />
         <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="internalDashboardPaidClaims" 
                        bodyUrl="internalDashboardClaimsBody" folderName="${folderName}" detailUrl="" parentSplitContainerId="" 
                        populateCriteriaDataOn="/internalDashboardPaidClaims/populateCriteria">
            <c:forEach items="${tableHeadData}" var="column">
               <c:choose>
                  <c:when test="${column.id=='claimNumber'}">
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