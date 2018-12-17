<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>

<script type="text/javascript">

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
	
	function submit() {
	    var checkBoxList = document.getElementsByName("checkBoxIdList");
		var url = "workBenchClaimsSubmission/";
		var checkedIdList = new Array();
		for (index = 0; index < checkBoxList.length ; index++) {
			if (checkBoxList[index].checked) {
				checkedIdList.push(checkBoxList[index].value);
			}
		}
		dojo.byId("displayContent").style.display='none';
		dojo.byId("displayLoadingLid").style.display='block';
		if(checkedIdList.length != 0 ) {
			dojo.xhrGet({
			    url : url + checkedIdList.toString(),
			    load: function(result) {
					dojo.byId("displayContent").style.display='block';
					dojo.byId("displayLoadingLid").style.display='none';
			    	var data = JSON.parse(result);
			    	if(data == "FAILURE") {
			    		dojo.byId('preview').innerHTML=dojo.byId("submissionFailure").innerHTML;
			    	} else {
				    	refreshIt();
			    		dojo.byId('preview').innerHTML=dojo.byId("submissionSuccess").innerHTML;
			    	}
			    },
			    error: function() {
			    	dojo.byId('preview').innerHTML=dojo.byId("submissionFailure").innerHTML;
			   }
			});
		}
	}
	
</script>

<script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dojox.layout.ContentPane");
        dojo.require("dijit.layout.BorderContainer");
    </script>
        <div id="displayLoadingLid" style="display: none; margin-left:50% ; margin-top:25% ;   height: 50%; width: 50%;">
           <img  src="../image/indicator.gif">
        </div>
        <div id="displayContent" dojoType="dijit.layout.ContentPane"  executeScripts="true" style="width: 100%!important; height:100%!important;">
		<div dojoType="dijit.layout.LayoutContainer" class="wid-100p hgt-50p">
	    <div dojoType="dijit.layout.ContentPane" layoutAlign="top" class="buttonContainer">
		   <u:summaryTableButton id="submitButton" label="button.common.submit" onclick="submit" align="left" 
	               summaryTableId="fleetClaimTable" />
        <table align="left">
            <tr>
                <td style="padding-top:7px;">
                        <div style="width:15px;height:15px;background-color:red;margin-left:10px;"></div>
                </td>
                <td style="padding-top:7px;padding-left:5px;">Error(s)</td>
                <td style="padding-top:7px;">
                        <div style="width:15px;height:15px;margin-left:5px;background-color:yellow;"></div>
                </td>
                <td style="padding-top:7px;padding-left:5px;">Warning(s)</td>
            </tr>
        </table>
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
                       		previewUrl="workbenchClaimDetails"
                       		previewPaneId="preview"
                       		parentSplitContainerId="split"
                       		populateCriteriaDataOn="/claim/populateCriteria">
                <script type="text/javascript" src="../scripts/tst_commonExt/WorkBenchRenderer.js"></script>
	            <c:forEach items="${tableHeadData}" var="column">
	            <c:choose>
	            	<c:when test="${column.dataType =='CheckBox'}">
	            		<script type="text/javascript" src="../scripts/tst_commonExt/CheckBoxRenderer.js"></script>
	            		<script type="text/javascript" src="../scripts/tst_commonExt/CheckBoxInHeaderRenderer.js"></script>
    	            		<u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
    	            			rendererClass="tavant.twms.summaryTableExt.CheckBoxRenderer"	labelColumn="${column.labelColumn}"
    	            			hidden="${column.hidden}" disableFiltering="true" disableSorting="true" dataType="${column.dataType}" cssColumn="${column.cssColumn}" />
	            	</c:when>
	            	<c:otherwise>
                        <c:choose>
                        <c:when test="${column.id=='fleetClaim.activeFleetClaimAudit.workOrderNumber'}">
                            <c:if test="${column.id=='fleetClaim.activeFleetClaimAudit.workOrderNumber'}">
                                 <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}"
                                    rendererClass="tavant.twms.summaryTableExt.WorkBenchRenderer" labelColumn="${column.labelColumn}" hidden="${column.hidden}" 
                                    disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
                            </c:if>             
                        </c:when>
                        <c:otherwise>
	                	  <u:summaryTableColumn id="${column.id}" label="${column.title}" width="${column.widthPercent}" idColumn="${column.idColumn}" labelColumn="${column.labelColumn}" hidden="${column.hidden}" disableFiltering="${column.disableFiltering}" disableSorting="${column.disableSorting}"/>
                        </c:otherwise>
                        </c:choose>
	                </c:otherwise>
	            </c:choose>
	            </c:forEach>
	            <script type="text/javascript" src="../scripts/SummaryTableTagEventHandler.js"></script>
	        </u:summaryTable>
            <div dojoType="dojox.layout.ContentPane" id="preview">
            
        	</div>
	 	</div>       
   	</div>
    <div id="submissionSuccess" style="display: block;">
        <div class="alert-success">
            <h4><spring:message code="lable.fleetClaim.submission.succes"/></h4>                   
        </div>
    </div>
    <div id="submissionFailure" style="display: block;">
        <div class="alert-danger">
            <h4><spring:message code="lable.fleetClaim.submission.failure"/></h4>                    
        </div>
    </div>
    <div id="saveSuccess" style="display: block;">
        <div class="alert-success">
            <h4><spring:message code="lable.fleetClaim.save.succes"/></h4>                   
        </div>
    </div>
    <div id="saveFailure" style="display: block;">
        <div class="alert-danger">
            <h4><spring:message code="lable.fleetClaim.save.failure"/></h4>                    
        </div>
    </div>
    </div> 
