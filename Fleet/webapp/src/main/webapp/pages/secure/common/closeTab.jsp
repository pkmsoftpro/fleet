<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="u" uri="/ui-ext"%>

<u:stylePicker fileName="common.css"/>

<span>
    <button id="closeTab" class="buttonGeneric">
        <s:text name="button.common.close"/>
    </button>
</span>

<script type="text/javascript">
    dojo.addOnLoad(function() {
        dojo.connect(dojo.byId("closeTab"), "onclick", function() {
            closeMyTab();
        });
    });
</script>