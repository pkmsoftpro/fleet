<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<div class="centered" id="successMessage">
    <div alert class="alert-success" style="color: green; font-size: 120%; font-weight: bold;">{{successMessage}}</div>
</div>
<div class="fieldSpacerHeight" style="clear: both;"></div>
<div align="center">
    <button type="button" class="blue-btn btn-primary" onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
        <spring:message code="label.Common.close" />
    </button>
</div>
