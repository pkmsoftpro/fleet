<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>
<html>
<head>
    <title><s:text name="title.quote.ServicecodeListing"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="SummaryTable.css"/>
    <script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
    <script type="text/javascript" src="../scripts/labels.js"></script>
    <script type="text/javascript">
        dojo.require("dojox.layout.ContentPane");
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("serviceCodeTable"));
        }
        <authz:ifPermitted resource="manageServiceCodes">
        function createServiceCode(event, dataId) {
        	var thisTabLabel = getMyTabLabel();
        	parent.publishEvent("/tab/open", 
        						{label: i18N.new_ServiceCode, 
        						 url: "create_servicecode", 
        						 decendentOf: thisTabLabel ,
        						 forceNewTab: true
        						 });
        }
        </authz:ifPermitted>
        function exportToExcel(){
        	  var folderName='${folderName}';
              exportExcel("/claim/populateCriteria","exportservicecodesListToExcel.action");
        }
        
        var applyActionUrl;
        var removeActionUrl;

        dojo.addOnLoad(function() {
        		removeActionUrl = "../remove_labels_on_ServiceCodes.action?";
        		applyActionUrl = "../apply_labels_on_ServiceCodes.action?";
        		checkActionUrl="../check_labels_on_ServiceCodes.action?"
        });
    </script>
    <u:stylePicker fileName="base.css"/>
    <u:stylePicker fileName="yui/reset.css" common="true"/>
    <u:stylePicker fileName="layout.css" common="true"/>
    <%@include file="/i18N_javascript_vars.jsp"%>
  </head>
  <u:body >
  <div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%">
    <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
		<u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button" summaryTableId="serviceCodeTable" />
		<authz:ifPermitted resource="manageServiceCodes">
		<u:summaryTableButton id="createservicecodeButton" label="title.common.createservicecode" onclick="createServiceCode" summaryTableId="serviceCodeTable"/>
		<u:summaryTableButton id="labelButton" label="button.common.addLabels" onclick="showLabels" summaryTableId="serviceCodeTable" cssClass="addLabels_retailItems_button"/>
        </authz:ifPermitted>
        <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right" cssClass="download_to_excel_button" summaryTableId="serviceCodeTable" />
	</div>
        <u:stylePicker fileName="SummaryTableButton.css" />
         <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="serviceCodeTable"
                        bodyUrl="serviceCodesBody" folderName="${folderName}" detailUrl="servicecode_detail" parentSplitContainerId="" multiSelect="true"
                        populateCriteriaDataOn="/claim/populateCriteria">
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
           <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
        </u:summaryTable>
    </div>
     <s:hidden name="labelType" value="%{@tavant.twms.domain.common.Label@SERVICECODE}" />
    <jsp:include flush="true" page="../../common/ExcelDowloadDialog.jsp"></jsp:include>
     <jsp:include flush="true" page="../../common/labelsDialog.jsp"></jsp:include>
  </u:body>
</html>