<#if (parameters.tagWasUsedBefore == false)>
<script type="text/javascript">
var openTabsArray = [];
dojo.addOnLoad(
    function() {
        for(var i = 0; i < openTabsArray.length; i++){
            connectToOpen(openTabsArray[i]);
        }
        delete openTabsArray;
    }
);

function connectToOpen(tabDetail){
    var conElement= dojo.byId(tabDetail.id);
    if(conElement){
        dojo.connect(conElement, "onmousedown", function(eventOld) {
            var event= cloneEvenIfIe(eventOld);	
            event.label = tabDetail.labelQ;
            event.url = tabDetail.url;
            event.forceNewTab = tabDetail.forceNewTab;
            if(tabDetail.decendentOf){
                event.decendentOf = tabDetail.decendentOf;
            }
            if(tabDetail.catagory){
                event.catagory = tabDetail.catagory;
            }
            if(tabDetail.helpCategory){
                event.helpCategory = tabDetail.helpCategory;
            }
            top.requestTab(event);
        });
    }
} 
</script>
</#if>


<script type="text/javascript">
    var decendentOf;
    <#if parameters.decendentOf?exists>
     decendentOf = "${parameters.decendentOf?html}";
    <#elseif parameters.autoPickDecendentOf>
     if(TWMS_UTILITY_JS) {<#-- If this code throws an error, please look at utility.js functions that r used here -->
      var tab = getFrameAttribute("TST_IS_PREVIEW") ? parent.getTabDetailsForIframe() : getTabDetailsForIframe();
      decendentOf = getTabHavingId(tab.tabId).title;
     }
    </#if>
    openTabsArray.push({
        "id" : "${parameters.id?html}",
        "labelQ" : '<@s.text name="${parameters.tabLabel}"/>'.replace(/"/g,"&#34;"),
        "url" : "${parameters.url}",
        "decendentOf" : decendentOf, 
        <#if parameters.catagory?exists>
         "catagory" : "${parameters.catagory?html}",
        </#if>
        <#if parameters.helpCategory?exists>
        "helpCategory" : "${parameters.helpCategory?html}",
        </#if>
        <#if parameters.forceNewTab?exists>
         "forceNewTab" : ${parameters.forceNewTab?string?html}
        <#else>
         "forceNewTab" : false
        </#if>
    });
</script>
<${parameters.tagType} id="${parameters.id?html}"<#rt/>
<#if parameters.cssClass?exists>
 class="${parameters.cssClass}"<#rt/>
</#if>
><#rt/>
