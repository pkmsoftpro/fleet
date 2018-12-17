<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="authz" uri="authz"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%
    response.setHeader("Pragma", "no-cache");
			response.addHeader("Cache-Control", "must-revalidate");
			response.addHeader("Cache-Control", "no-cache");
			response.addHeader("Cache-Control", "no-store");
			response.setDateHeader("Expires", 0);
%>
<html>
<head>
<u:stylePicker fileName="ui-ext/actionResult/actionResult.css" />
<title><s:text name="title.serviceRequest.serviceRequestInboxView" /></title>
<s:head theme="twms" />
<u:stylePicker fileName="SummaryTable.css" />

<script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
<script type="text/javascript" src="../scripts/ui-ext/tst/SummaryTableTag.js"></script>

<script type="text/javascript">
    dojo.require("dojox.layout.ContentPane");
    dojo.require("twms.widget.Dialog");
    function refreshIt() {
        publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("serviceRequestTable"));
    }
    
    
    function validateDataSelected(dataId){
        dijit.byId("alertMessage").show();
        dojo.connect(dojo.byId("closeAlertMessage"), "onclick", function() {
        	 dijit.byId("alertMessage").hide();
		});
    }
   
   function createQuote(event, dataId) {
       if (dataId=='') {
                      validateDataSelected(dataId);
       } else {
           var url = "getServiceRequestId.action";
           var tabLabel = "Quote For ServiceRequest ";

           if (dataId) {
               url += "?taskId=" + dataId+"&createType=quote";
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
  
  function createFleetClaim(event, dataId) {
      if (dataId=='') {
                     validateDataSelected(dataId);
      } else {
          var url = "getServiceRequestId.action";
          var tabLabel = "Fleet Claim For ServiceRequest ";

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
  
    function exportToExcel() {
        var folderName = '${folderName}';
        exportExcel("/serviceRequestSearch/populateCriteria", "exportServiceRequestDetailsToExcel.action");
    }

            var extraParams = {		
      				inboxViewId : ${inboxViewId}				
      	    }; 
	
   var pageUrl = "serviceRequestFolder.action";
	function getPageUrl(){
		var folderName=document.getElementById("folder").value;
		pageUrl = "serviceRequestFolder.action?"+"folderName="+folderName;
		return pageUrl;
	} 
	
</script>
<u:stylePicker fileName="base.css" />
<u:stylePicker fileName="yui/reset.css" common="true" />
<u:stylePicker fileName="layout.css" common="true" />
<script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dojox.layout.ContentPane");
    </script>
<%@include file="/i18N_javascript_vars.jsp"%>
<input type="hidden" id='folder' value='${folderName}' />
<s:hidden id="context" name="context" value="ServiceRequestSearches" />
</head>
<u:body>
    <div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
        <c:if test="${folderName=='Assigned Service Request'||folderName=='Service Requests Completed'||folderName=='Service Request Dispatched' || folderName=='Service Request Submitted'}">
        <authz:ifPermitted resource="createQuote">
        <u:summaryTableButton id="quoteButton" label="label.quote.createQuote" onclick="createQuote" summaryTableId="notificationTable" cssClass="create_claim_button"/>
        </authz:ifPermitted>
         <authz:ifPermitted resource="createClaim">
        <u:summaryTableButton id="claimButton" label="label.claim.createClaim" onclick="createFleetClaim" summaryTableId="notificationTable" cssClass="create_claim_button"/>
        </authz:ifPermitted>
        </c:if>
            <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button"
                summaryTableId="serviceRequestTable" />
            <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
                cssClass="download_to_excel_button" summaryTableId="serviceRequestTable" />
            <%@ include file="../common/spring/inboxViewForm.jsp"%>
        </div>
        <u:stylePicker fileName="SummaryTableButton.css" />
        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="serviceRequestTable" extraParamsVar="extraParams" bodyUrl="serviceRequestBody.action"
            folderName="${folderName}" detailUrl="serviceRequestDetail.action" parentSplitContainerId=""
            populateCriteriaDataOn="/serviceRequestSearch/populateCriteria">
            <c:forEach items="${tableHeadData}" var="column">
                <c:choose>
                    <c:when test="${column.id=='imageCol'||column.id=='imageAgeCol'}">
                    	<c:if test="${column.id=='imageAgeCol'}">
                        	<script type="text/javascript" src="../scripts/tst_commonExt/ImageRenderer.js"></script>
                       		<u:summaryTableColumn id="${column.id}" label="${column.title}"  width="${column.widthPercent}" idColumn="${column.idColumn}"
                            	rendererClass="tavant.twms.summaryTableExt.ImageRenderer" labelColumn="${column.labelColumn}" hidden="${column.hidden}"
                            	disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}" />
                        </c:if>
                        <c:if test="${column.id=='imageCol'}">
                        	<script type="text/javascript" src="../scripts/tst_commonExt/ImageRenderer.js"></script>
                        	<u:summaryTableColumn id="${column.id}" label="${column.title}"  width="${column.widthPercent}" idColumn="${column.idColumn}"
                            	rendererClass="tavant.twms.summaryTableExt.ImageRenderer" labelColumn="${column.labelColumn}" hidden="${column.hidden}"
                            	disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}" />
                        </c:if>
                    </c:when>
                    <c:otherwise>
                        <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
                            labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}"
                            disableSorting="${column.disableSorting}" />
                    </c:otherwise>
                </c:choose>
            </c:forEach>
            <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
        </u:summaryTable>
    </div>
    <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
    
    <div style="display: none;">
	<div dojoType="twms.widget.Dialog" id="alertMessage"
		title="Select Service Request Number" style="width: 586px" closable="false">
		<div dojoType="dijit.layout.LayoutContainer"
			style="background: #F3FBFE; overflow: auto;">
			<div id="confirmDealershipContent" style="padding: 0 10px 0 10px">
				 <s:text name="error.serviceRequest.selectServiceRequest" />
			</div>
			<div style="padding: 10px 0 10px 0;">
				<center>
					<button class="buttonGeneric" id="closeAlertMessage"
						style="padding: 0 10px 0 10px; margin-left: 10px"><s:text name="label.common.ok"/></button>
				</center>
			</div>
		</div>
	</div>
</div>
</u:body>
</html>