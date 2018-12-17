dojo.declare("tavant.twms.summaryTableExt.HtmlContentRenderer", tavant.twms.summaryTable.DefaultCellRenderer, {
    render : function(/*row data object*/object, /*data(to be rendered)*/value, /*cell*/ td, options) {
    	if(null == value)
    		{return null;}
        var elementMarkup = "<span>" + value + "</span>";
        return dojo.toDom(elementMarkup);
    } 
});

