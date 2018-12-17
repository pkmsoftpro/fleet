<#if (!parameters.hidden && !parameters.cssColumn)>
<script>
${parameters.summaryTableId}_columns.${parameters.summaryTableId}_col_${parameters.label?replace("/","_")?replace(" ","_")?replace("#","")} = {
    label: "${parameters.label}", 
    field: "${parameters.id}",
    sortable: ${parameters.disableSorting?string("false","true")},
    filterable: ${parameters.disableFiltering?string("false","true")}
}
</script>
</#if>