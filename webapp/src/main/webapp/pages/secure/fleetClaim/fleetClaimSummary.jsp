
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div title-pane content-pane-title="<spring:message code="label.quote.summary"/>" collapse="false"></div>
<p>
    <spring:message code='label.common.parts' />
</p>
<hr>
<p>
    <spring:message code='label.common.laborDetails' />
</p>
<hr>
<div class="clear"></div>
<p>
    <font color="red"> coming soon.... </font>
<p>
<div class="clear"></div>
<div class="floatL">></div>
<button type="button" class="blue-btn btn-primary" data-ng-click="print()">
    <spring:message code="label.common.print" />
</button>
<button type="button" class="blue-btn btn-primary" ng-click="closeSummary()">
    <spring:message code="label.Common.cancel" />
</button>
