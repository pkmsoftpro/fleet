<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>


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