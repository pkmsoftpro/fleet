<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%--
  @author vikas.sasidharan
--%>
<html>
<head>
 <title><s:text name="title.competitorInfo"/></title>
    <s:head theme="twms" />
    <u:stylePicker fileName="yui/reset.css" common="true"/>
    <u:stylePicker fileName="layout.css" common="true"/>
    <u:stylePicker fileName="base.css"/>
    <u:stylePicker fileName="SummaryTable.css"/>
    <script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>
    <script type="text/javascript">
	    dojo.require("dijit.layout.LayoutContainer");
	    dojo.require("dojox.layout.ContentPane");
 		var extraParams = {};
		function refreshIt() {
	        publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("competitorInformationTable"));
	    }
		function exportToExcel(){
         	exportExcel("/manageCompetitorInfo/populateCriteria","export_competitor_information_to_excel.action");
        }
		
		 function createCompetitorInformation() {
	            parent.publishEvent("/tab/open", {
	                label: i18N.new_competitorInformation,
	                decendentOf: getMyTabLabel(),
	                url: "../create_competitor_information.action",
	                forceNewTab: true
	            });
	     }

    </script>
     <%@include file="/i18N_javascript_vars.jsp"%>
     
</head>
<u:body>
	<div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%">
		<div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
			<u:summaryTableButton id="refreshButton" label="button.common.refresh"
	                    onclick="refreshIt" align="right" cssClass="refresh_button"
	                    summaryTableId="competitorInformationTable"/>
	        <u:summaryTableButton id="createCompetitorButton"
	                    label="button.manageCompetitorInfo.createCompetitorInfo"
	                    onclick="createCompetitorInformation"
	                    summaryTableId="competitorInformationTable"
	                    cssClass="create_domainrule_button"/>
	       <u:summaryTableButton id="downloadListing"
	        			label="button.common.downloadToExcel" 
	        			onclick="exportToExcel"
	               		align="right" 
	               		cssClass="download_to_excel_button" 
	               		summaryTableId="competitorInformationTable"/>            
			
		</div>
	
		<div dojoType="dijit.layout.SplitContainer" layoutAlign="client"
	         orientation="vertical" sizerWidth="4" activeSizing="false" id="split"
	         persist="false">
	         <u:stylePicker fileName="SummaryTableButton.css" />
	         <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="competitorInformationTable"
	                          bodyUrl="get_competitor_information_body.action"
	                          extraParamsVar="extraParams"
	                          folderName="Manage Competitor Information"
	                          detailUrl="../competitorInformationDetail"
	                          populateCriteriaDataOn="/manageCompetitorInfo/populateCriteria"
	                          parentSplitContainerId="" >
	                  <s:iterator value="tableHeadData">
		               	<u:summaryTableColumn id="%{id}" label="%{title}" width="%{widthPercent}" idColumn="%{idColumn}" 
		               		labelColumn="%{labelColumn}" hidden="%{hidden}" 
		               		disableFiltering="%{disableFiltering}" disableSorting="%{disableSorting}" />
	                </s:iterator>
	                <script type="text/javascript" src="scripts/SummaryTableTagEventHandler.js"></script></u:summaryTable>        
	       </div>
       </div>
       <jsp:include flush="true" page="../../common/ExcelDowloadDialog.jsp"></jsp:include>
</u:body>

</html>