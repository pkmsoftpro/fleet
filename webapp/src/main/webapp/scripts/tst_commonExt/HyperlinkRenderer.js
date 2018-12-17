dojo.declare("tavant.twms.summaryTableExt.HyperlinkRenderer", tavant.twms.summaryTable.DefaultCellRenderer, {
    render : function(/*row data object*/object, /*data(to be rendered)*/value, /*cell*/ td, options) {
    	if(null == value)
    		{return null;}
        var elementMarkup = "<span title='${name}'><a href='#' onclick='openNewTab(${tabName}, ${hyperlink})'>${name}</a></span>";
        var element = dojo.string.substitute(elementMarkup, value);
        return dojo.toDom(element);
    }
});

function openNewTab(tabName,url) {
    parent.publishEvent("/tab/open", {
    	label : tabName,
       url : url,
       decendentOf : '',
       forceNewTab : true
    }); 
}   
