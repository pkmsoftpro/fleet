<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html id="ng-app" data-ng-app="createServiceRequest">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />

<script src="../scripts/vendor/angularjs/es5-shim.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-file-upload.min.js"></script>

<script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>

<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
<script src="../scripts/serviceRequest/serviceRequestApp.js"></script>
<u:stylePicker fileName="quote/quote.css" />
<u:stylePicker fileName="quote/tableFormat.css" />
</head>
<u:body theme="fleet">
    <%@include file="i18N_serviceRequest_javascript_vars.jsp"%>
    <div ng-init="isUserAdmin='${isUserAdmin}'"></div>
    <form data-ng-controller="ServiceRequestController" name="form" novalidate>
        <input type="hidden" id='taskId' value="${taskId}"> <input type="hidden" id='id' value='${id}' /> <input type="hidden" id='selectedAuditId'
            value="${selectedAuditId}"> <input type="hidden" id='serviceRequestId' value="${serviceRequestId}">
         <input type="hidden" id="serviceRequestIDforSerialnumber" value=${serviceRequestIDforSerialnumber}>
        <input type="hidden" id="folderName" value='${folderName}'><input type="hidden" id="fleetInventoryIdForServiceCall" value='${fleetInventoryIdForServiceCall}'>
        <input type="hidden" id="serviceCallId" value='${serviceCallId}'>
        <div ng-init="dateFormat='${dateFormat}'"></div>
        <div ng-init="dealerId='${dealerId}'"></div>
        <div ng-show="submitted==false && !showErrorMessage">
            <c:choose>
                <c:when test="${folderName== null}">
                    <jsp:include page="serviceRequestDetail.jsp"></jsp:include>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${folderName=='Draft Service Request' || folderName=='Dealer Owned Draft Service Request' || folderName=='Workbench Service Request'}">
                            <jsp:include page="serviceRequestDetail.jsp"></jsp:include>
                        </c:when>
                        <c:otherwise>
                            <jsp:include page="serviceRequestReadonly.jsp" />
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
        </div>
        <div ng-show="submitted==true && !showErrorMessage"">
            <jsp:include page="../common/success.jsp"></jsp:include>
        </div>

        <div ng-show="showErrorMessage">
              <jsp:include page="../commonError.jsp"></jsp:include>
        </div>

    </form>
</u:body>
<script type="text/javascript">
	function attachmentLink() {
		var serialNumber = document.getElementById('serialNumber').value;
		var thisTabLabel = getMyTabLabel();
		parent.publishEvent("/tab/open", {
			label : "Attachments",
			url : "show.action",
			decendentOf : thisTabLabel,
			forceNewTab : true
		});
	}
	function processSearch(){
        var serviceRequestId=document.getElementById('id').value;
        window.location.href='processSearchServiceRequest?serviceRequestId='+serviceRequestId;
    }

</script>
</html>