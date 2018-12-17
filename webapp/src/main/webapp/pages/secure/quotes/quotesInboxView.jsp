<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="authz" uri="authz"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
<head>

    <u:stylePicker fileName="ui-ext/actionResult/actionResult.css"/>
    <title><s:text name="title.quote.quoteInboxView"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="SummaryTable.css"/>
    
    <script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
    <script type="text/javascript">

        dojo.require("dojox.layout.ContentPane");
        dojo.require("twms.widget.Dialog");
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("quoteTable"));
        }  
        
        function exportToExcel() {
            var folderName='${folderName}';
            exportExcel("/claim/populateCriteria","exportQuoteDetailsToExcel.action");
        }
        
        var extraParams = {		
  				inboxViewId : ${inboxViewId}				
  	    };
        var pageUrl = "quotes.action";
    	function getPageUrl(){
    		var folderName=document.getElementById("folder").value;
    		pageUrl = "quotes.action?"+"folderName="+folderName;
    		return pageUrl;
    	}
    	
    	 function createFleetClaim(event, dataId) {
    	      if (dataId=='') {
    	                     validateDataSelected(dataId);
    	      } else {
    	          var url = "getServiceRequestId.action";
    	          var tabLabel = "Fleet Claim For Quote ";

    	          if (dataId) {
    	              url += "?taskId=" + dataId+"&createType=fleetClaim";
    	              tabLabel += " " + dataId;

    	              parent.publishEvent("/tab/open", {
    	                  label: tabLabel,
    	                  url: url,
    	                  decendentOf : "<s:text name="label.quote.assignedServiceRequest"/>",
    	                  forceNewTab: true
    	                  });
    	          }
    	      }
    	  }
    </script>
    <u:stylePicker fileName="base.css"/>
    <u:stylePicker fileName="yui/reset.css" common="true"/>
    <u:stylePicker fileName="layout.css" common="true"/>
    <script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dojox.layout.ContentPane");
    </script>
    <%@include file="/i18N_javascript_vars.jsp"%>
    <s:hidden id="context" name="context" value="QuoteSearches" />
    <input type="hidden" id='folder' value='${folderName}'/>
</head>
<u:body >
    <div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
         <c:if test="${folderName=='Quotes Submitted' || folderName=='Quotes Received' || folderName=='Quotes Accepted' ||folderName=='Quotes Accepted Internal' || folderName=='Quotes Accepted Dealer Owned' || folderName=='Quotes Rejected' ||folderName=='Quotes Rejected Internal' || folderName=='Quotes Rejected Dealer Owned'|| folderName=='Quotes Received For Revision from Owner' || folderName=='Quotes Received For Revision from Customer'}">
	         <authz:ifPermitted resource="createClaim">
	        	<u:summaryTableButton id="claimButton" label="label.claim.createClaim" onclick="createFleetClaim" summaryTableId="notificationTable" cssClass="create_claim_button"/>
	        </authz:ifPermitted>
        </c:if>
            <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button"
                summaryTableId="quoteTable" />
            <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
                cssClass="download_to_excel_button" summaryTableId="quoteTable" />
            <%@ include file="../common/spring/inboxViewForm.jsp"%>
        </div>
        <u:stylePicker fileName="SummaryTableButton.css" />
        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="quoteTable" extraParamsVar="extraParams"
                        bodyUrl="quotesBody.action" folderName="${folderName}" 
                        detailUrl="quote_detail.action" parentSplitContainerId=""
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
    <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
</u:body>
</html>