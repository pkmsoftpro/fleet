<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<script type="text/javascript">
    <s:url encode="true" var="warrantyUrl" value="/fleet/home.action" includeContext="false">
        <s:param name="app" value="%{token}" />
    </s:url>
window.location.href = '<s:property value="#warrantyUrl" />';
</script>