<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html id="ng-app" data-ng-app="createQuote">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css">
<u:stylePicker fileName="quote/quote.css" />
<u:stylePicker fileName="quote/tableFormat.css" />
<script src="../scripts/quote/quoteApp.js"></script>
<script type="text/javascript"
    src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
</head>
<u:body theme="fleet">
<%@include file="i18N_quote_javascript_vars.jsp"%>
    <input type="hidden" id='taskId' value='${taskId}' />
    <input type="hidden" id='isUserAdmin' value='${isUserAdmin}' />
    <input type="hidden" id='searchQuoteId' value="${searchQuoteId}" />
    <input type="hidden" id='selectedAuditId' value="${selectedAuditId}">    
    <input type="hidden" id='serviceRequestId' value='${serviceRequestId}' />  
    <div ng-init="userType='${userType}'"></div>
    <form data-ng-controller="QuoteController" name="form" novalidate id="quoteForm">    
        <div ng-show="quoteForm==true">
            <jsp:include page="searchQuoteReadonly.jsp"></jsp:include>            
    </form>
</u:body>
<script type="text/javascript">  	
    function processSearch(){
        var quoteId=document.getElementById('searchQuoteId').value;
        window.location.href='process_search_quote?quoteId='+quoteId;
    } 
</script>
</html>