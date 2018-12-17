<!DOCTYPE html>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html id="ng-app" data-ng-app="servicecodeapp">

<head>
<s:head theme="fleet" />
<script src="../scripts/angular/apps/serviceCodeApp.js"></script>
<script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<u:stylePicker fileName="serviceCodes/serviceCodes.css" />
</head>
<u:body theme="fleet">
    <%@include file="i18N_servicecode_javascript_vars.jsp"%>
    <div data-ng-init="servicecodeid='${servicecodeid}'">
    <form data-ng-controller="ServiceCodeController" name="form" novalidate>
        <div>
            <div alert-msg></div>
        </div>
        <div ng-hide="sectionview">

            <div class="accordion-header contentPane">
                <!-- accordion header -->
                <spring:message code="title.common.general" />:
                <span class="expand-collapse collapse-icon"></span>
            </div>
            <div class="overflow-hidden accordion-info">
                <div>
                    <div class="labelStyle floatL">
                        <spring:message code="label.serviceCode.code" />:
                        <span class="red">*</span>
                    </div>
                    <div class="floatL">
                        <input type="text" name="serviceCodeDefinition.code" data-ng-model="serviceCodeDefinition.code"
                            data-ng-readonly="servicecodeid" required />
                    </div>
                    <div class="fieldSpacerWidth floatL">&nbsp;</div>
                    <div class="labelStyle floatL">
                        <spring:message code="label.serviceCode.description" />:
                        <span class="red">*</span>
                    </div>
                    <div class="floatL">
                        <input TYPE="text" name="serviceCodeDefinition.description" data-ng-model="serviceCodeDefinition.description" required>
                    </div>
                    <div class="clear"></div>
                    <div class="labelStyle floatL">
                        <spring:message code="label.serviceCode.status" />:
                        <span class="red">*</span>
                    </div>
                    <div class="floatL" data-ng-init="serviceCodeDefinition.status = serviceCodeDefinition.status ==null? 'ACTIVE':serviceCodeDefinition.status">
                        <select name="serviceCodeDefinition.status" data-ng-model="serviceCodeDefinition.status" required>
                            <option>ACTIVE</option>
                            <option>INACTIVE</option>
                        </select>
                    </div>
                    <div class="fieldSpacerWidth floatL">&nbsp;</div>
                    <div class="labelStyle floatL">
                        <spring:message code="label.serviceCode.category" />:
                        <span class="red">*</span>
                    </div>
                    <div class="floatL" data-ng-init="serviceCodeDefinition.category = serviceCodeDefinition == null ? defaultCategory : serviceCodeDefinition.category">
                        <select name="serviceCodeDefinition.category" data-ng-model="serviceCodeDefinition.category"
                            ng-options="ct for ct in listCategories" required></select>
                    </div>
			</div>
                </div>
            <div class="clear"></div>
            <%@include file="serviceCodeLineItems.jsp"%>
            <div class="clear"></div>
            <!-- Comment Section -->

            <div class="accordion-header contentPane">
                <!-- accordion header -->
                <spring:message code="title.serviceCode.comment" />
                <span class="expand-collapse collapse-icon"></span>
            </div>
            <div class="overflow-hidden accordion-info">
                <div>
                    <div class="labelStyle" style="float: left;">
                        <spring:message code="label.serviceCode.comment" />:
                        <span class="red">*</span>
                    </div>
                    <div class="floatL">
                        <textarea max-length rows="5" cols="600" style="width: 600px" name="serviceCodeDefinition.comments"
                            data-ng-model="serviceCodeDefinition.comments" required></textarea>
                    </div>
                </div>
            </div>
            <!-- End Comment Section -->
            <!--Start action History Section -->
            <div ng-show="servicecodeid">
            <div class="accordion-header contentPane">
                <!-- accordion header -->
                <spring:message code="title.serviceCode.actionHistory" />
                <span class="expand-collapse collapse-icon"></span>
            </div>
            <div class="overflow-hidden accordion-info" style="padding:10.5px!important">
                <div class="gridStyle mar0" data-ng-grid="gridForserviceactionhistory"></div>
            </div>
            </div>
            <!--END action History Section -->

            <!-- Buttons -->
            <div class="fieldSpacerWidth floatL">&nbsp;</div>
            <div style="padding-left: 400px;">
            <authz:ifPermitted resource="manageServiceCodes">
                <button type="button" class="blue-btn btn-primary" data-ng-click="saveServiceCode()" ng-disabled='form.$invalid'>
                    <spring:message code="label.Common.save" />
                </button>
             </authz:ifPermitted>
                <button type="button" class="blue-btn btn-primary" onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                    <spring:message code="label.Common.cancel" />
                </button>
                <!-- ENDButtons -->
            </div>
        </div>
    </form>
</u:body>
</html>