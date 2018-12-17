<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<html>
<head>

    <u:stylePicker fileName="ui-ext/actionResult/actionResult.css"/>
    <title><s:text name="title.common.invoiceInboxView"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="SummaryTable.css"/>
    <script type="text/javascript" src="../scripts/ui-ext/common/tabs.js"></script>
    <script type="text/javascript">

        dojo.require("dojox.layout.ContentPane");
        dojo.require("twms.widget.Dialog");
        function refreshIt() {
            publishEvent(SUMMARY_TABLE_UTIL.getRefreshFullTopic("invoiceTable"));
        }  
        
        function exportToExcel() {
            var folderName=${folderName};
            exportExcel("/claim/populateCriteria","exportInvoiceDetailsToExcel.action");
        }
 
        function exportToPDF(event, dataId) {
        		var thisTabLabel = getMyTabLabel();
        		var url = "printInvoiceDetails.action?&";
        		  if(dataId.length > 0){
        		url += "id=" + dataId;
        		parent.publishEvent("/tab/open", {label: "Print Invoice Details",
					  url: url,
					  decendentOf: thisTabLabel,
					  forceNewTab: true});
        		 }
        }

        var extraParams = {		
  				inboxViewId : ${inboxViewId}				
  	    };
        
        function deleteInvoice(event, dataId) {
            var url = 'deleteInvoice.action?id=' + dataId;			
			var param = dataId;		
			var thisTabLabel = getMyTabLabel();
			dojo.byId("displayContent").style.display='none';
			dojo.byId("displayLoadingLid").style.display='block';
			twms.ajax.fireHtmlRequest(url, param,
					function(data){
				dojo.byId("displayContent").style.display='block';
				dojo.byId("displayLoadingLid").style.display='none';
			    if(data=="true")
			    {
			        dijit.byId("cannotDeleteExistingInvoice").show();
			    }
			    else
			     {
			        refreshIt();
			     }
				});
        }
       
        function regenerateInvoice(event, dataId) {
            var url = 'regenerateInvoice.action?id=' + dataId;			
	 	    var param = dataId;	
	 	   dojo.byId("displayContent").style.display='none';
			dojo.byId("displayLoadingLid").style.display='block';
			 twms.ajax.fireHtmlRequest(url, param,
					function(data){
				 dojo.byId("displayContent").style.display='block';
				 dojo.byId("displayLoadingLid").style.display='none';
			     if(data=="true")
				    {
				        dijit.byId("cannotRegenerateExistingInvoice").show();
				    }
				    else
				     {
				        refreshIt();
				     }
				}); 
        }
        
        dojo.addOnLoad( function() {
        	dojo.connect(dojo.byId("hideDeleteInvoiceDialog"), "onclick", function() {
        	    dijit.byId("cannotDeleteExistingInvoice").hide();
        	});
        	dojo.connect(dojo.byId("hideRegenerateInvoiceDialog"), "onclick", function() {
        	    dijit.byId("cannotRegenerateExistingInvoice").hide();
        	});
        });
        
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
<!-- <div  style="display: none; padding-top: 3px; overflow:hidden; " id="displayLoadingLid" dojoType="dijit.layout.ContentPane"  executeScripts="true" >
 <div class='loadingLidThrobber'><div class='loadingLidThrobberContent'></div></div>
     </div> -->
     <div id="displayLoadingLid" style=" display:none; middle;margin-top: 25%; margin-left: 50%; height: 50%; width: 50%;">
   <img class="loadingCentered" src="../image/indicator.gif">
</div>
    <div style="display: none;">
        <div dojoType="twms.widget.Dialog" id="cannotDeleteExistingInvoice" title="Invoice" style="width: 400px" closable="false" class="cust-loc-popup">
            <div dojoType="dijit.layout.LayoutContainer" style="background: #F3FBFE; overflow: auto;">
                <div style="padding: 10px 10px 0 110px">
                    <s:text name="label.common.invoiceNotToBeDeleted" />
                </div>
                <div style="padding: 10px 0 10px 0;">
                    <center>
                        <button class="btn border-rad0"  style="padding: 1px 1 1px 1;" id="hideDeleteInvoiceDialog">
                         <s:text name="button.common.ok" />
                        </button>
                    </center>
                </div>
            </div>
        </div>
    </div>
     <div dojoType="twms.widget.Dialog" id="cannotRegenerateExistingInvoice" title="Invoice" style="width: 400px" closable="false" class="cust-loc-popup">
            <div dojoType="dijit.layout.LayoutContainer" style="background: #F3FBFE; overflow: auto;">
                <div style="padding: 10px 10px 0 10px">
                    <s:text name="label.common.invoiceNotToBeRegenerated" />
                </div>
                <div style="padding: 10px 0 10px 0;">
                    <center>
                        <button class="btn border-rad0" style="padding: 1px 1 1px 1;" id="hideRegenerateInvoiceDialog">
                        <s:text name="button.common.ok" />
                        </button>
                    </center>
                </div>
            </div>
        </div>
    </div>
    <div id="displayContent" dojoType="dijit.layout.ContentPane"  executeScripts="true">
    <div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-100p">
        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
            <u:summaryTableButton id="deleteInvoice" label="label.common.delete" align="left" onclick="deleteInvoice"
                    summaryTableId="invoiceTable" />
            <u:summaryTableButton id="regenerateInvoice" label="label.common.regenerateInvoice" align="left" onclick="regenerateInvoice"
                    summaryTableId="invoiceTable" />
            <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button"
                summaryTableId="invoiceTable" />
            <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
                cssClass="download_to_excel_button" summaryTableId="invoiceTable" />
            <u:summaryTableButton id="printInvoiceDetails" label="label.common.print" onclick="exportToPDF" align="right"
                cssClass="download_to_excel_button" summaryTableId="invoiceTable" />
        </div>
        <u:stylePicker fileName="SummaryTableButton.css" />
        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" id="invoiceTable" extraParamsVar="extraParams"
                        bodyUrl="invoiceBody.action" folderName="invoice"  parentSplitContainerId=""
                        populateCriteriaDataOn="/claim/populateCriteria" detailUrl="">
            <c:forEach items="${tableHeadData}" var="column">
                <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}" labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
            </c:forEach>
            <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
        </u:summaryTable>
    </div>
    </div> 
    <jsp:include flush="true" page="../common/ExcelDowloadDialog.jsp"></jsp:include>
</u:body>
</html>