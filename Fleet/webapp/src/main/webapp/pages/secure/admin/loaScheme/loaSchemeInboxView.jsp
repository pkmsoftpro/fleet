<%--

   Copyright (c)2006 Tavant Technologies
   All Rights Reserved.

   This software is furnished under a license and may be used and copied
   only  in  accordance  with  the  terms  of such  license and with the
   inclusion of the above copyright notice. This software or  any  other
   copies thereof may not be provided or otherwise made available to any
   other person. No title to and ownership of  the  software  is  hereby
   transferred.

   The information in this software is subject to change without  notice
   and  should  not be  construed as a commitment  by Tavant Technologies.

--%>

<!-- TODO:  Need to refactor it - seperate out the common parts. -->
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<u:stylePicker fileName="base.css"/>
<u:stylePicker fileName="yui/reset.css" common="true"/>
<u:stylePicker fileName="layout.css" common="true"/>
<u:stylePicker fileName="SummaryTable.css" />
<u:stylePicker fileName="SummaryTableButton.css" />
<%
	response.setHeader("Pragma", "no-cache");
	response.addHeader("Cache-Control", "must-revalidate");
	response.addHeader("Cache-Control", "no-cache");
	response.addHeader("Cache-Control", "no-store");
	response.setDateHeader("Expires", 0);
%>
<html>
<head>
    <title><s:text name="title.manageLOASchemes"/></title>
    <s:head theme="twms" />
    <script type="text/javascript" src="scripts/domainUtility.js"></script>
    <script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>
    <script type="text/javascript">
        dojo.require("dojox.layout.ContentPane");
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic(
                    "loaSchemeTable"));
        }
        <authz:ifPermitted resource="manageLOASchemes">
          function createLOAScheme() {
            parent.publishEvent("/tab/open", {
                label: i18N.new_loaScheme,
                decendentOf: getMyTabLabel(),
                url: "../create_loa_scheme.action?context=" + extraParams.context,
                forceNewTab: true
            });
            }
          </authz:ifPermitted>
		var extraParams = {          
        };

	   function exportToExcel(){
	         	exportExcel("/loaSchemes/populateCriteria","exportLOASchemesToExcel.action");
	        }
    </script>
    <u:stylePicker fileName="base.css"/>
    <u:stylePicker fileName="yui/reset.css" common="true"/>
    <u:stylePicker fileName="layout.css" common="true"/>
    <%@include file="/i18N_javascript_vars.jsp"%>
  </head>
  <u:body>
  <div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%">
    <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
			<authz:ifPermitted resource="manageLOASchemes">
				<u:summaryTableButton id="createLOASchemeButton"
					label="button.manageManageLOAScheme.createLOAScheme"
					onclick="createLOAScheme" summaryTableId="loaSchemeTable"
					cssClass="create_loaScheme_button" />
			</authz:ifPermitted>
			<u:summaryTableButton id="refreshButton" label="button.common.refresh"
                    onclick="refreshIt" align="right" cssClass="refresh_button"
                    summaryTableId="loaSchemeTable"/>
           <u:summaryTableButton id="downloadListing"
        			label="button.common.downloadToExcel" 
        			onclick="exportToExcel"
               		align="right" 
               		cssClass="download_to_excel_button" 
               		summaryTableId="loaSchemeTable"/>                                
        
    </div>
  <div dojoType="dijit.layout.SplitContainer" layoutAlign="client"
         orientation="vertical" sizerWidth="4" activeSizing="false" id="split"
         persist="false">
      <u:stylePicker fileName="SummaryTableButton.css" />
      <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="loaSchemeTable"
                          bodyUrl="get_loa_schemes_body.action"
                          folderName="%{folderName}"
                          detailUrl="../loa_scheme_detail.action"
                          populateCriteriaDataOn="/loaSchemes/populateCriteria"
                          parentSplitContainerId="split">
            <s:iterator value="tableHeadData">
                <u:summaryTableColumn id="%{id}" label="%{title}" width="%{widthPercent}" idColumn="%{idColumn}" labelColumn="%{labelColumn}" hidden="%{hidden}"/>
            </s:iterator>
        <script type="text/javascript" src="scripts/SummaryTableTagEventHandler.js"></script>
     </u:summaryTable>       
    </div>
    </div>
    <jsp:include flush="true" page="../../common/ExcelDowloadDialog.jsp"></jsp:include>
  </u:body>
</html>