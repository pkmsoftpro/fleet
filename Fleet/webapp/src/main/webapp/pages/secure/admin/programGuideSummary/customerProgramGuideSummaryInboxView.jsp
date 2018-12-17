<%@page contentType="text/html" %>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>
<html>
	<head>
	    <title><s:text name="accordionLabel.programGuideSummary.customer"/></title>
	    <s:head theme="twms"/>
	    <u:stylePicker fileName="SummaryTable.css"/>
	    <script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
	    <script type="text/javascript">
	        dojo.require("dojox.layout.ContentPane");
	        dojo.require("twms.widget.Dialog");
	        function refreshIt() { 
	            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("customerProgramGuideSummaryTable"));
	        }  
	        function createCustomerProgramGuideSummary(event, dataId) {
	        	var thisTabLabel = getMyTabLabel();
	        	parent.publishEvent("/tab/open", 
	        						{label: '<spring:message code="title.common.createCustomerProgramGuideSummary"/>', 
	        						 url: "createCustomerProgramGuideSummary", 
	        						 decendentOf: thisTabLabel ,
	        						 forceNewTab: true
	        						 });
	        }
     	</script>
	    <u:stylePicker fileName="base.css"/>
	    <u:stylePicker fileName="yui/reset.css" common="true"/>
	    <u:stylePicker fileName="layout.css" common="true"/>
	    <%@include file="/i18N_javascript_vars.jsp"%>
	</head>
	<u:body >
	    <div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%">
	        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
	          <u:summaryTableButton id="createCustomerProgramGuideSummary" label="title.common.createCustomerProgramGuideSummary" onclick="createCustomerProgramGuideSummary" summaryTableId="customerProgramGuideSummaryTable" cssClass="create_button"/>
	          <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button" summaryTableId="customerProgramGuideSummaryTable" />
	        </div>
	        <u:stylePicker fileName="SummaryTableButton.css" />
	       	<u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="customerProgramGuideSummaryTable"
                        bodyUrl="customerProgramGuideSummariesBody" folderName="${folderName}"
                        detailUrl="customerProgramGuideSummaryDetail" parentSplitContainerId="split">
		            <c:forEach items="${tableHeadData}" var="column">
		            	<c:choose>
		            		<c:when test="${!(column.id=='id' || column.id=='customer.name')}">
		            			<script type="text/javascript" src="../scripts/tst_commonExt/HtmlContentRenderer.js"></script>
		            			<u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}" labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}" rendererClass="tavant.twms.summaryTableExt.HtmlContentRenderer"/>
		            		</c:when>
		            		<c:otherwise>
		            			<u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}" labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
		            		</c:otherwise>
		            	</c:choose>
		           </c:forEach>        
	            <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
        	</u:summaryTable>
	    </div>
	</u:body>
</html>