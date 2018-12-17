<script type="text/javascript">
    dojo.require("dijit.layout.ContentPane");
    dojo.require("dijit.layout.LayoutContainer");
    dojo.require("dijit.layout.SplitContainer");
    dojo.require("twms.widget.Select");
</script>
<link rel="stylesheet" type="text/css" href="${parameters.contextPath}/css/theme/official/ui-ext/tst/SummaryTableTagButtons.css"/>
        <div dojoType="dijit.layout.ContentPane" region="center" id="${parameters.id}_summaryTable_headerPane" class="summaryTableHeaderPane <#rt/>
            <#if (parameters.isIE)>
            ie<#rt/>
            </#if>">
                <div id="${parameters.id}"></div>
        </div>
   <script type="text/javascript" src="${parameters.contextPath}/scripts/ui-ext/tst/SummaryTableTagColumn.js"></script>
   <script type="text/javascript" src="${parameters.contextPath}/scripts/ui-ext/tst/SummaryTableTagEventHandlers.js"></script>
        <script>
            dojo.require("dijit.layout.LayoutContainer");
            dojo.require("dijit.layout.SplitContainer");
            var ${parameters.id}_columns = {};
        </script>