<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="centered" id="failureMessage">
    <div alert class="alert-error" style="color: red; font-size: 120%; font-weight: bold;">{{failureMessage}}</div>
</div>
<div class="fieldSpacerHeight" style="clear: both;"></div>
<div align="center">
    <button type="button" class="blue-btn btn-primary" onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
        <spring:message code="label.Common.close" />
    </button>
</div>
