/**
 * This is used by the class tavant.twms.SummaryTable.
 * @author janmejay.singh
 */ 
var CONSTANTS = {
    refreshListingTopic : "/refresh/inboxView#${id}/listing",
    refreshFullTopic : "/refresh/inboxView#${id}/full",
    hideCompletedRowTopic : "/refresh/inboxView#${id}/hideCompletedRow",
    hideCompletedRowsTopic : "/refresh/inboxView#${id}/hideCompletedRows",
    minimizeListingTopic : "/listing/inboxView#${id}/minimize",
    restoreListingTopic : "/listing/inboxView#${id}/restore",
    showHidePreviewButtonId : "showHidePreviewButtonId",
    previewPaneId : "previewPaneId"
};

var SUMMARY_TABLE_UTIL = {
    getRefreshFullTopic : function(/*String(the id of summaryTable)*/ id) {
        return this._getTopic(CONSTANTS.refreshFullTopic, id);
    },
    getRefreshListingTopic : function(/*String(the id of summaryTable)*/ id) {
        return this._getTopic(CONSTANTS.refreshListingTopic, id);
    },
    getHideCompletedRowTopic : function(/*String(the id of summaryTable)*/ id) {
        return this._getTopic(CONSTANTS.hideCompletedRowTopic, id);
    },
    getHideCompletedRowsTopic : function(/*String(the id of summaryTable)*/ id) {
        return this._getTopic(CONSTANTS.hideCompletedRowsTopic, id);
    },
    getMinimizeTopic : function(/*String (the id of SummaryTable)*/ id) {
        return this._getTopic(CONSTANTS.minimizeListingTopic, id);
    },
    getRestoreTopic : function(/*String (the id of SummaryTable)*/ id) {
        return this._getTopic(CONSTANTS.restoreListingTopic, id);
    },
    _getTopic : function(/*String (substitutable name)*/ topicName,/*String(the id of summaryTable)*/ id) {
        if(!id) throw new Error("SUMMARY TABLE UTIL : id is a mandatory parameter");
        return dojo.string.substitute(topicName, {id : id});
    }
};
dojo.declare("tavant.twms.summaryTable.Column", null, {
    _reader : null,

    renderer : null,//renderer instance... which is used to render the column value.

    id : "",
	width : 0,
	label : "",
	alignment : "left",
	headerCell : null,
	bodyCell: null,
	filterInput: null,
	sortImageBox : null,
	labelDiv : null,
	table : null,
	wrapped : false,
	labelText : "",
    sortType : "",//can have value "asc"/"dsc", will be set in the constructor,
    disableSorting: true,

    STATIC_VARS : {
        DEFAULT_SORT_TYPE : "dsc",
        ASC_SORT : "asc",
        DESC_SORT : "dsc"
    },

    constructor : function(colData, table, reader) {
        this._reader = reader;

        this.id = colData.id;
		this.width = colData.width;
		this.label = colData.title;
		this.alignment = colData.alignment;
        this.renderer = new colData.rendererClass(this); 
        this.table = table;
        this.headerCell = dojo.byId(this._reader.getVar(CONSTANTS.prefixForTableHeadId) + this.id);
        this.bodyCell = dojo.byId(this._reader.getVar(CONSTANTS.prefixForTableBodyId) + this.id);
		this.filterInput = dojo.byId(this._reader.getVar(CONSTANTS.prefixForTableFilterId) + this.id);
		this.sortImageBox = dojo.byId(this._reader.getVar(CONSTANTS.prefixForSortImageDiv) + this.id);
		this.labelDiv = this._getLabelDiv();
		this.labelText = dojo.string.trim(new String(this.labelDiv.innerHTML));
		this.disableSorting = colData.disableSorting;
		
        if(!this.disableSorting) {
            dojo.connect(this.headerCell, "onclick", this, "sort");
        }
		
		if(this.filterInput) {
		dojo.connect(this.filterInput,"onkeyup", this, "filter");

        if(dojo.isIE) {//HACK: without this.... it won't render correctly in IE... some margin problems..
            var header = getExpectedParent(this.filterInput, "th");
            dojo.style(header, "paddingTop", 0 + "px");
            dojo.style(header, "paddingLeft", 0 + "px");
            dojo.style(this.filterInput, "marginTop", "-2px");
            dojo.style(this.filterInput, "marginLeft", "-1px");
            dojo.style(this.filterInput, "borderBottom", "none");
            delete header;
			}
        }
        this.sortType = this.STATIC_VARS.DEFAULT_SORT_TYPE;
    },
	
    filter : function(event) {
		if (!isIgnorableKeyStroke(event.keyCode)){
    		this.table.stillTyping();
            this.table.onFilter(event.target.getAttribute("field"), event.target.value);
		} 
	},
	
	sort : function(event) {
		var elem = event.target;
		// The attribute we are looking for is on the TH. The TH contains two DIVs. 
		// If the user had clicked on one of the DIVs we walk up the dom tree to get to the TH.
        var hadSort = this.sortType;
        if(!event.ctrlKey) {
            this.table.resetSort();
        }
        elem = getExpectedParent(elem, "th");
        this.sortType = (hadSort == this.STATIC_VARS.ASC_SORT) ? this.STATIC_VARS.DESC_SORT : this.STATIC_VARS.ASC_SORT;
        this.table.onSort(this, elem.getAttribute("field"), this.sortType);
        (this.sortType == this.STATIC_VARS.ASC_SORT) ? this.markSortedUp() : this.markSortedDown();
        delete elem;
    },
	
	getWidth : function() {
		return this.width;
	},
	
	setWidth : function(width) {
		this.width = width;
	},
	
	setHeaderWidth : function(width) {		
		dojo.style(this.headerCell, "width", width);
	},
	
	setBodyWidth : function(width) {
		dojo.style(this.bodyCell, "width", width);
	},
	
	getHeadX : function() {
		return dojo.marginBox(this.headerCell).l;
	},
	
	getHeadY : function() {
		return dojo.marginBox(this.headerCell).t;
	},
	
	getBodyX : function() {
		return dojo.coords(this.bodyCell).x;
	},
	
	getBodyY : function() {
		return dojo.coords(this.bodyCell).y;
	},
	
	markSortedUp : function() {
		dojo.addClass(this.sortImageBox, "sortedColumnHeadUp");
        dojo.removeClass(this.sortImageBox, "sortedColumnHeadDown");
    },
	
	markSortedDown : function() {
		dojo.addClass(this.sortImageBox, "sortedColumnHeadDown");
        dojo.removeClass(this.sortImageBox, "sortedColumnHeadUp");
    },
	
	getId : function() {
		return this.id;
	},
	
	removeSort : function() {
		dojo.removeClass(this.sortImageBox, "sortedColumnHeadUp");
		dojo.removeClass(this.sortImageBox, "sortedColumnHeadDown");
        this.sortType = this.STATIC_VARS.DEFAULT_SORT_TYPE;
    },
	
	getLabel : function() {
		return this.label;
	},
	
	getAlignment : function() {
		return this.alignment;
	},
	
	getHeaderCell : function() {
		return this.headerCell;
	},

    _getLabelDiv : function() {
        return dojo.query("td:last-child",
                   dojo.query("tr:last-child",
                       dojo.query("tbody",
                           dojo.query("table:last-child", this.headerCell)[0])[0])[0])[0];
    }
});

dojo.declare("tavant.twms.summaryTable.DefaultCellRenderer", null, {

    _column : null,

    constructor : function(/*Object [Column]*/ column) {
        this._column = column;
    },
    render : function(/*row data object*/object, /*data(to be rendered)*/value, /*cell*/ td, options) {
        var elementMarkup = "<span title='" + value + "'>" + value + "</span>";
        return dojo.toDom(elementMarkup);

    }
});