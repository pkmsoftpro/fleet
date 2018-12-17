<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
<head>
    <u:stylePicker fileName="ui-ext/actionResult/actionResult.css"/>
    <title><s:text name="title.fleetClaim.fleetClaimInboxView"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="preview.css"/>
    <u:stylePicker fileName="SummaryTable.css"/>
    
    <script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
    <script type="text/javascript">

        dojo.require("dojox.layout.ContentPane");
        dojo.require("twms.widget.Dialog");
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("fleetClaimTable"));
        }  
        
        function exportToExcel() {
            var folderName='${folderName}';
            exportExcel("/claim/populateCriteria","exportFleetClaimDetailsToExcel.action");
        }
        
        var extraParams = {		
  				inboxViewId : ${inboxViewId}				
  	    };
        var pageUrl = "fleetClaims.action";
    	function getPageUrl(){
    		var folderName=document.getElementById("folder").value;
    		pageUrl = "fleetClaims.action?"+"folderName="+folderName;
    		return pageUrl;
    	}
    	
    	
    </script>
    <u:stylePicker fileName="base.css"/>
    <u:stylePicker fileName="yui/reset.css" common="true"/>
    <u:stylePicker fileName="layout.css" common="true"/>
    <script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dojox.layout.ContentPane");
        dojo.require("dijit.layout.BorderContainer");
    </script>
    <%@include file="/i18N_javascript_vars.jsp"%>
    <s:hidden id="context" name="context" value="FleetClaimSearches" />
    <input type="hidden" id='folder' value='${folderName}'/>
    <s:hidden id="context" name="context" value="FleetClaimSearches" />
</head>
<u:body >	
	<c:choose>
		<c:when  test="${(folderName == 'Pre-Invoice Pending Approval') or  (folderName == 'Pre-Invoice Approved') or (folderName == 'Pre-Invoice Disputed') or (folderName == 'Claims Workbench')}">
			<c:choose>
                <c:when test="${folderName == 'Claims Workbench'}">
                    <jsp:include flush="true" page="./fleetClaimsWorkbenchView.jsp"></jsp:include>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${isCustomerUser}">
                            <jsp:include flush="true" page="./fleetClaimInvoicesSummary.jsp"></jsp:include>
                        </c:when>
                        <c:otherwise>
                            <jsp:include flush="true" page="./fleetClaimInvoicesSummaryForInternal.jsp"></jsp:include>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
		</c:when>
		<c:otherwise>
			 <div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
	        	<div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
	            	<u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button"
	                	summaryTableId="fleetClaimTable" />
	            	<u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
		                cssClass="download_to_excel_button" summaryTableId="fleetClaimTable" />
	        	    <%@ include file="../common/spring/inboxViewForm.jsp"%>
	    	    </div>
		        <u:stylePicker fileName="SummaryTableButton.css" />
		        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="fleetClaimTable" extraParamsVar="extraParams"
		                        bodyUrl="fleetClaimsBody.action" folderName="${folderName}" 
		                        detailUrl="fleetClaim_detail.action" parentSplitContainerId=""
		                        populateCriteriaDataOn="/claim/populateCriteria">
		        	<c:forEach items="${tableHeadData}" var="column">
	            		<c:choose>
			                <c:when test="${column.id=='imageCol'}">
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
		</c:otherwise>
	</c:choose>
  	<jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
</u:body>
</html>