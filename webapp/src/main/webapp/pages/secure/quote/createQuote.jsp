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
    <input type="hidden" id='searchQuoteId' value="${searchQuoteId}" />
    <input type="hidden" id='selectedAuditId' value="${selectedAuditId}">
    <input type="hidden" id='readOnly' value='${readOnly}' /> 
    <input type="hidden" id='isUserAdmin' value='${isUserAdmin}' />  
    <input type="hidden" id='serviceRequestId' value='${serviceRequestId}' />  
     <input type="hidden" id='serialNumberForQuotes' value='${serialNumberForQuotes}' />       
     <div ng-init="forItem='${forItem}'"/>
    <div ng-init="folderName='${folderName}'"></div>   
    <div ng-init="dealerId='${dealerId}'"></div> 
    <div ng-init="filedOnDate='${filedOnDate}'"></div>
    <div ng-init="dateFormat='${dateFormat}'"></div>
    <div ng-init="userType='${userType}'"></div>
      <form data-ng-controller="QuoteController" name=form novalidate id="form">  
        <div ng-show="quoteForm==true && !showErrorMessage">
            <jsp:include page="quote.jsp"></jsp:include>
            <div class="clear"></div>
             <div data-ng-if="selectedId==false && searchQuote==false">
                <jsp:include page="actions.jsp"></jsp:include>
            </div>  
        </div>
        <div ng-show="successForm==true && !showErrorMessage">
            <jsp:include page="../common/success.jsp"></jsp:include>
        </div>
       <div ng-show="validateForm==true && !showErrorMessage">
          <%@include file="validateQuote.jsp"%>
       </div>
       <div ng-show="summaryForm==true">
          <%@include file="quoteSummary.jsp"%>
       </div>
       <div ng-show="showErrorMessage">      
          <jsp:include page="../commonError.jsp"></jsp:include>
       </div> 
    </form>
</u:body>
</html>