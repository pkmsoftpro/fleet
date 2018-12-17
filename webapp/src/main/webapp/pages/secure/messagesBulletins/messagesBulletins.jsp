<!DOCTYPE html>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html id="ng-app" data-ng-app="createMessage">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<s:head theme="fleet" />
<link rel="stylesheet" href="<spring:theme code="css"/>" type="text/css" />

<script src="../scripts/vendor/angularjs/es5-shim.min.js"></script>
<script src="../scripts/vendor/angularjs/angular-file-upload.min.js"></script>

<script type="text/javascript" src="../scripts/vendor/angularjs/ng-grid-2.0.7.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/ng-grid-2.0.7.css" />
<script src="../scripts/vendor/angularjs/ng-grid-flexible-height.js"></script>
 <script src="../scripts/vendor/angularjs/textAngular.js"></script>
<%-- <script src='https://ajax.googleapis.com/ajax/libs/angularjs/1.2.4/angular-sanitize.min.js'></script> --%>
 <script src="../scripts/vendor/angularjs/angular-sanitize.min.js"></script>
<script src="../scripts/messagesBulletin/messagesBulletins.js"></script>


<u:stylePicker fileName="quote/quote.css" />
<u:stylePicker fileName="quote/tableFormat.css" />
<link rel='stylesheet prefetch' href='http://netdna.bootstrapcdn.com/font-awesome/4.0.0/css/font-awesome.min.css'>
</head>
<u:body theme="fleet">
    <form data-ng-controller="messageController" class="container app" name="form" novalidate>
            <jsp:include page="createMessagesAndBulletins.jsp"></jsp:include>
            <div class="clear"></div>
    </form>
</u:body>
</html>