<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>

<script type="text/javascript">
	dojo.require("dijit.layout.SplitContainer");
	function masterCheckBoxChecked(masterCheckObj) {
	  	dojo.query("input[name='checkBoxIdList']").forEach(function(child){
	  		child.checked = masterCheckObj.checked; 
	  	});				
	}
	
	function childCheckBoxChanged(checkObj) {
		var allChecked = true;
		dojo.query("input[name='checkBoxIdList']").forEach(function(child){
			if(!child.disabled && child.checked != true){
				allChecked = false;
	  		}
	  	});
	  	if(allChecked){
	  		dojo.byId('masterCheckBox').checked = false;
	  	}else{
	  		dojo.byId('masterCheckBox').checked = false;
	  	}
	}
	
	function accept() {
		var checkBoxList = document.getElementsByName("checkBoxIdList");
		var url = "invoicesAccept/";
		var checkedIdList = new Array();
		
		for (index = 0; index < checkBoxList.length ; index++) {
			if (checkBoxList[index].checked) {
				checkedIdList.push(checkBoxList[index].value);
			}
		}
		
		
		if(checkedIdList.length != 0 ) {
			dojo.xhrGet({
			    url : url + checkedIdList.toString(),
			    load: function(result) {
			    	var data = dojo.fromJson(result);
			    	if(data == "FAILURE") {
			    		dojo.byId('preview').innerHTML=dojo.byId("approveFailure").innerHTML;
			    	} else {
				    	refreshIt();
			    		dojo.byId('preview').innerHTML=dojo.byId("approveSuccess").innerHTML;
			    	}
			    },
			    error: function() {
			    	dojo.byId('preview').innerHTML=dojo.byId("approveFailure").innerHTML;
			   }
			});
		}
	}
	
	
</script>
		<div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-50p">
	        <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
	       <c:if test="${folderName == 'Pre-Invoice Pending Approval'}">
		       <u:summaryTableButton id="acceptButton" label="button.common.accept" onclick="accept" align="left" 
	               summaryTableId="fleetClaimTable" /> 
	       </c:if> 
           <u:summaryTableButton id="refreshButton" label="button.common.refresh" onclick="refreshIt" align="right" cssClass="refresh_button"
               summaryTableId="fleetClaimTable" />
           <u:summaryTableButton id="downloadListing" label="button.common.downloadToExcel" onclick="exportToExcel" align="right"
               cssClass="download_to_excel_button" summaryTableId="fleetClaimTable" />
           <%@ include file="../common/spring/inboxViewForm.jsp"%>
       </div>
        <div dojoType="dijit.layout.SplitContainer" layoutAlign="client" orientation="vertical" sizerWidth="4" activeSizing="false" id="split" persist="false" class="rootSplitContainer homePageMainSection">
	        <u:stylePicker fileName="SummaryTableButton.css" />
	        <u:summaryTable eventHandlerClass="tavant.twms.summaryTable.BasicTwmsEventHandler" 
	        				id="fleetClaimTable" 
	        				extraParamsVar="extraParams"
                       		bodyUrl="fleetClaimsBody.action" 
                       		detailUrl ="fleetClaim_detail.action" 
                       		folderName="${folderName}" 
                       		previewUrl="invoiceDetails"
                       		previewPaneId="preview"
                       		parentSplitContainerId="split"
                       		populateCriteriaDataOn="/claim/populateCriteria">
	            <c:forEach items="${tableHeadData}" var="column">
	            <c:choose>
	            	<c:when test="${column.dataType =='CheckBox'}">
	            		<script type="text/javascript" src="../scripts/tst_commonExt/CheckBoxRenderer.js"></script>
	            		<script type="text/javascript" src="../scripts/tst_commonExt/CheckBoxInHeaderRenderer.js"></script>
	            		<u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
	            			rendererClass="tavant.twms.summaryTableExt.CheckBoxRenderer"	labelColumn="${column.labelColumn}"
	            			hidden="${column.hidden}" disableFiltering="true" disableSorting="true" dataType="${column.dataType}" />
	            	</c:when>
	            	<c:otherwise>
	                	<u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}" labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
	                </c:otherwise>
	            </c:choose>
	            </c:forEach>
	            <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
	        </u:summaryTable>
            <div dojoType="dojox.layout.ContentPane" id="preview">
            
        	</div>
	 	</div>       
   	</div>
   	<div id="approveSuccess" style="display: block;">
		<div class="alert-success">
			<h4><spring:message code="lable.fleetClaim.approve.succes"/></h4>					
		</div>
	</div>
   	<div id="approveFailure" style="display: block;">
		<div class="alert-danger">
			<h4><spring:message code="lable.fleetClaim.error.approve"/></h4>					
		</div>
	</div>
