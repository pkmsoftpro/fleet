<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="authz" uri="authz"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>

<html>
  <head>
      <title><s:text name="title.common.responsePage"/></title>
      <s:head theme="twms"/>
  </head>
  <u:body>
      <u:actionResults wipeMessages="false"/>
      <p />
      <center><jsp:include page="closeTab.jsp" /></center>
      <script type="text/javascript">
          dojo.addOnLoad(function() {
              var summaryTableId = getFrameAttribute("TST_ID");
              if (summaryTableId) {
                  manageTableRefresh(summaryTableId, true);
              }
          });
      </script>
  </u:body>
</html>