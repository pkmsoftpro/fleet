dojo.declare("tavant.twms.summaryTableExt.DueDateRenderer", tavant.twms.summaryTable.DefaultCellRenderer, {
    render : function(/*row data object*/object, /*data(to be rendered)*/value, /*cell*/ td, options) {
        var elementMarkup = "<span title='" + value + "'>" + value + "</span>";
        var markUpDom = dojo.toDom(elementMarkup);
        td.appendChild(markUpDom);
        var totalDays=object.totalDueDays;
        var backgroundColor;
        
        if (object.status!='Completed' && (totalDays != "" || totalDays != null)) {
                if (totalDays > 30) {
                    backgroundColor = 'red';
                }
                else if (totalDays <= 30 && totalDays >= 1) {
                    backgroundColor = 'orange';
                }
                else if (totalDays  >= -15 && totalDays < 0) {
                    backgroundColor = 'yellow';
                }
                else if(totalDays == ""){}
                else if (totalDays >= 0 && totalDays < 1) {
                    backgroundColor = 'lawngreen';
                }
            dojo.style(td, {
                "backgroundColor" : backgroundColor
            });
            return markUpDom;
        }
    }
});
