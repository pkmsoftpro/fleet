dojo.declare("tavant.twms.summaryTableExt.ImageRenderer", tavant.twms.summaryTable.DefaultCellRenderer, {
    render : function(/*row data object*/object, /*data(to be rendered)*/valueMap, /*cell*/ td, options) {
        var elementMarkup = "<span title='${title}'><img src='${url}'/></span>";
        var element = dojo.string.substitute(elementMarkup, valueMap);
        return dojo.toDom(element);
    }
});