/**
 * 
 */
dojo.declare("tavant.twms.summaryTableExt.AttachmentRenderer", tavant.twms.summaryTable.DefaultCellRenderer, {
    render : function(/*cell*/ td, /*data(to be rendered)*/ valueMap) {
    	
        var elementMarkup = "<span title='${title}'><a name='${name}' href='#'  onclick='downloadAttachment(${value})'>${name}</a></span>";
        var element = dojo.string.substitute(elementMarkup, valueMap);
        return dojo.toDom(element);
    }
});

function downloadAttachment(id)
{
getFileDownloader().download("downloadDocument.action?docId="+id); 
}