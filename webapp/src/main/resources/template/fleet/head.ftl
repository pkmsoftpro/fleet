${response.setHeader( "Pragma", "no-cache" )}
${response.addHeader( "Cache-Control", "must-revalidate" )}
${response.addHeader( "Cache-Control", "no-cache" )}
${response.addHeader( "Cache-Control", "no-store" )}
${response.setDateHeader("Expires", 0)}

<script language="JavaScript" type="text/javascript">var pageLoadStartTime = (new Date()).getTime();</script>
<script src="../scripts/vendor/angularjs/jquery.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-1.2.13.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-resource-1.2.3.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-ui-0.4.0.min.js"></script>
<script src="../scripts/vendor/angularjs/bootstrap-2.3.2.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-strap-0.7.4.min.js"></script>
<script src="../scripts/vendor/angularjs/ui-bootstrap-tpls-0.10.0.min.js"></script>
<script src="../scripts/vendor/angularjs/ui-bootstrap-custom-0.10.0.min.js"></script>
<script src="../scripts/vendor/angularjs/json2.min.js"></script>
<script src="../scripts/vendor/angularjs/ui-utils.min.js"></script>
<script src="../scripts/ui-ext/common/util.js"></script>
<script src="../scripts/core/module/angular-fleet.js"></script>
<@s.if test="applicationSettings.googleAnalyticsEnabled == 'true'"><script src="../scripts/common/analytics.js"></script></@s.if>

<style type="text/css">
    @import "../css/theme/claro/claro.css";
    @import "../css/base_fleet.css";
    @import "../css/bootstrap.css";
    @import "../css/jquery-ui.css";
    @import "../css/bootstrap-combined.min.css";
    @import "../css/uiTreeType.css";
</style>

<div id="loading-indicator" style="display: none"><img class='loadingCentered' src='../image/loading.gif'/></div>