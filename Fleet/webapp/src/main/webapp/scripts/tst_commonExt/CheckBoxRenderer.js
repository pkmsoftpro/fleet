var childCheckBoxName;
dojo.declare("tavant.twms.summaryTableExt.CheckBoxRenderer", tavant.twms.summaryTable.DefaultCellRenderer, {
    render : function(/*row data object*/object, /*data(to be rendered)*/valueMap, /*cell*/ td, options) {
        if(options.folderName == 'Claims Workbench'){
            var errors=object["fleetClaim.entryValidationErrors"];
            if(errors != "" && errors != null)
                var elementMarkup = "<span title='${toolTip}'></span>";
            else
                var elementMarkup = "<span title='${toolTip}'><input name='${name}' value='${value}' type='checkbox' ${disabled} onclick='childCheckBoxChanged(this)'></span>";
        }else
            var elementMarkup = "<span title='${toolTip}'><input name='${name}' value='${value}' type='checkbox' ${disabled} onclick='childCheckBoxChanged(this)'></span>";
        var element = dojo.string.substitute(elementMarkup, valueMap);
        var dom = dojo.toDom(element);
        if(!childCheckBoxName)childCheckBoxName=valueMap['name'];
        return dom;
    }
});

