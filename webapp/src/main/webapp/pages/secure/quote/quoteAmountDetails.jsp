<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html ng-app="myApp">
    <head lang="en">
    <meta charset="utf-8">
   
    <link rel="stylesheet" type="text/css" href="ng-grid.css" />
    <link rel="stylesheet" type="text/css" href="style.css" />
    <script type="text/javascript" src="jquery-1.8.2.js"></script>
    <script type="text/javascript" src="angular.js"></script>
    <script type="text/javascript" src="ng-grid-1.3.2.js"></script>
    <script type="text/javascript" src="main.js"></script>
    </head>
    <body ng-controller="QuoteController">
    <div class="gridStyle" ng-grid="gridOptions">
    </div>
   
  
	<FIELDSET>
			<table>
				<tr>
					<td class="labelStyle"><spring:message code="label.quote.category"/></td>					
					<td class="labelStyle"><spring:message code="label.quote.partNumber"/></td>					
					<td class="labelStyle"><spring:message code="label.quote.partDescription"/></td>					
					<td class="labelStyle"><spring:message code="label.quote.quantity"/></td>					
					<td class="labelStyle"><spring:message code="label.quote.amountRequested"/></td>					
					<td class="labelStyle"><spring:message code="label.quote.unitPrice"/></td>					
					<td class="labelStyle"><spring:message code="label.quote.extendedPrice"/></td>					
				</tr>
				
				<tr>
					<td class="labelStyle"><spring:message code="label.quote.OEMParts"/></td>						
				</tr>
				<tr>
					<td class="labelStyle"><spring:message code="label.quote.nonOEMParts"/></td>						
				</tr>
				<tr>
					<td class="labelStyle"><spring:message code="label.quote.miscellaneousParts"/></td>						
				</tr>
				<tr>
					<td class="labelStyle"><spring:message code="label.quote.labor"/></td>						
				</tr>
				<tr>
					<td class="labelStyle"><spring:message code="label.quote.additionalTravelHours"/></td>						
				</tr>
				<tr>
					<td class="labelStyle"><spring:message code="label.quote.drayage"/></td>						
				</tr>
				<tr>
					<td class="labelStyle"><spring:message code="label.quote.quoteAmount"/></td>						
				</tr>
				
			</table>
		</FIELDSET>


</body>
</html>