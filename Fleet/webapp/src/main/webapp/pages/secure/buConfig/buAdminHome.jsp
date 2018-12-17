<!DOCTYPE html>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="u" uri="/ui-ext"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html id="ng-app" data-ng-app="businessConfigInfo">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />
<u:stylePicker fileName="customer/customer.css" />
<style type="text/css">
.showMessageBox {
	text-decoration: blink;
	color: red;
	margin-top: 10px;
	padding: 2px;
}
</style>
<script>
<!-- move this code snippet to the main file, so that it doesnt have to written in all jsp pages  -->
    $(document).ready(function() {
        $('.accordion-info').show();
        $('.accordion-header').click(function() {
            var thisElement = $(this);
            thisElement.next().slideToggle(300);
            setTimeout(function() {
                expandCollapse();
            }, 300)
            function expandCollapse() {
                if (thisElement.children('.expand-collapse').hasClass("collapse-icon")) {
                    thisElement.children('.expand-collapse').removeClass("collapse-icon");
                    thisElement.children('.expand-collapse').addClass("expand-icon");
                } else {
                    thisElement.children('.expand-collapse').removeClass("expand-icon");
                    thisElement.children('.expand-collapse').addClass("collapse-icon");
                }
            }

        });
    });
</script>
</head>
<u:body theme="fleet">
    <form data-ng-controller="businessConfigInfo" name="form" novalidate>
        <div alert-msg></div>     
        
<%--                 <div ng-click="isCollapsed = !isCollapsed" >
                    <div class="heigthBu" title-pane content-pane-title="<spring:message code="label.bu.ServiceRequest"/>" collapse="false"></div>
                </div>
       <div>       
    <a ng-click="isSrDisclaimer=!isSrDisclaimer" ng-show="isCollapsed"> <spring:message
            code="label.home.disclaimer" /></a>

                <div class="heigthBu" ng-show="isSrDisclaimer && isCollapsed ">
                    <div class="labelStyle" style="float: left;">
                        <spring:message code="label.home.disclaimerSR" />
                    </div>

                    <div class="labelStyle" style="float: left;">
                        <input type="radio" data-ng-model="selectedValue" ng-value="true" ng-boolean-radio>yes &nbsp;<input type="radio"
                            data-ng-model="selectedValue" ng-value="false" ng-boolean-radio>No
                    </div>

                    <div class="labelStyle" style="float: left;">
                        <button type="button" class="btn btn-primary" data-ng-click="save()">
                            <spring:message code="label.Common.save" />
                        </button>
                    </div>
                </div>
    </div> --%>
    <div class="page-container">
        <div class="accordion-header contentPane">  <!-- accordion header -->
        <spring:message code="label.bu.ServiceRequest"/>
        <span class="expand-collapse collapse-icon"></span>
    </div>
        <div class="overflow-hidden accordion-info">    <!-- this div holds all the accordion info, paste all accordeion information inside this-->
        <div>
            <div>
                <div class="labelStyle floatL">
                    <spring:message code="label.home.disclaimerSR" />
                    <span class="red">*</span>
                </div>
                <div class="floatL">
                    <input type="radio" data-ng-model="selectedValue" ng-value="true" ng-boolean-radio>Yes &nbsp;<input type="radio"
                            data-ng-model="selectedValue" ng-value="false" ng-boolean-radio>No
                </div>
                
                <div>
                 <div class="labelStyle floatL">
                  <button type="button" class="blue-btn btn-primary" data-ng-click="save()">
                            <spring:message code="label.Common.save" />
                        </button>
                         <button type="button" class="blue-btn btn-primary" data-ng-click="cancel()" onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));">
                <spring:message code="label.Common.cancel" />
            </button>
                 </div>
                 </div>
            </div>


          
        </div>
    </div>
    </div>
    </form>
</u:body>
<script type="text/javascript" src="../scripts/businessConfig/buConfig.js"></script>
</html>