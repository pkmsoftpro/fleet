dojo.declare("tavant.twms.summaryTableExt.WorkBenchRenderer", tavant.twms.summaryTable.DefaultCellRenderer, {
    render : function(/*row data object*/object, /*data(to be rendered)*/value, /*cell*/ td, options) {
        var elementMarkup = "<span title='" + value + "'>" + value + "</span>";
        var markUpDom = dojo.toDom(elementMarkup);
        td.appendChild(markUpDom);
        
        var errors=object["fleetClaim.entryValidationErrors"];
        var warns=object["fleetClaim.entryValidationWarns"];
        var backgroundColor;
        
        if (errors != "" && errors != null) {
            backgroundColor = 'red';
        }else if(warns != "" && warns != null){
            backgroundColor = 'yellow';
        }else{
            backgroundColor = 'lawngreen';
        }
        dojo.style(td, {
            "backgroundColor" : backgroundColor
        });
        return markUpDom;
    }
});
