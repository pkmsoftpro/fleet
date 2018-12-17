<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="clear"></div>
<div>
	<div class="accordion-header contentPane">
		<spring:message code="title.common.revisions" />
		<span class="expand-collapse collapse-icon"></span>
	</div>
	<div class="overflow-hidden accordion-info"
		style="padding: 10.5px !important">
		<div class="ngGridView" data-ng-grid="gridForServiceCallAudits"></div>
	</div>
	<div class="clear"></div>
</div>