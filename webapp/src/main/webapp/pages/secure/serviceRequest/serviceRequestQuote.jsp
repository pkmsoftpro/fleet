<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="accordion-header contentPane">
    <!-- accordion header -->
    <spring:message code="label.serviceRequest.quote.information" />
    <span class="expand-collapse collapse-icon"></span>
</div>
<div class="overflow-hidden accordion-info">
    <div>
        <table border="1" cellspacing="0" cellpadding="0" class="accordion-table">
            <tr class="tableHeader">
                <th class="labelStyle"><spring:message code="label.serviceRequest.quotenumber" /></th>
                <th class="labelStyle"><spring:message code="label.serviceRequest.quote.datecreated" /></th>
                <th class="labelStyle"><spring:message code="label.serviceRequest.quote.status" /></th>
                <th class="labelStyle"><spring:message code="label.serviceRequest.quote.dealer" /></th>
                <th class="labelStyle" ng-show="isCustomerUser"><spring:message code="label.serviceRequest.quote.customeramount" /></th>
                <th class="labelStyle" ng-show="servicingDealer"><spring:message code="label.serviceRequest.quote.dealeramount" /></th>          
                <th class="labelStyle" ng-show="isInternalUserOrOwningDealer"><spring:message code="label.serviceRequest.quote.customeramount" /></th>
                <th class="labelStyle" ng-show="isInternalUserOrOwningDealer"><spring:message code="label.serviceRequest.quote.dealeramount" /></th>          
            </tr>

            <tr class="tableData" ng-show="quotedetail!=null" ng-click="displayQuoteDetails(quotedetail.id)">
                <td>{{quotedetail.quoteNumber}}</td>
                <td>{{quotedetail.filedOnDate}}</td>
                <td>{{quotedetail.state}}</td>
                <td>{{quotedetail.forDealer.name}}</td>
				
                	<td ng-show="isCustomerUser">{{quotedetail.activeQuoteAudit.payment.totalCustomerInvoice.currency}}{{quotedetail.activeQuoteAudit.payment.totalCustomerInvoice.amount}}</td>
                
                	<td ng-show="servicingDealer">{{quotedetail.activeQuoteAudit.payment.totalDealerAmount.currency}}{{quotedetail.activeQuoteAudit.payment.totalDealerAmount.amount}}</td>
               
                    <td  ng-show="isInternalUserOrOwningDealer">{{quotedetail.activeQuoteAudit.payment.totalCustomerInvoice.currency}}{{quotedetail.activeQuoteAudit.payment.totalCustomerInvoice.amount}}</td>
                    <td  ng-show="isInternalUserOrOwningDealer">{{quotedetail.activeQuoteAudit.payment.totalDealerAmount.currency}}{{quotedetail.activeQuoteAudit.payment.totalDealerAmount.amount}}</td>
               
            </tr>
        </table>
    </div>
</div>