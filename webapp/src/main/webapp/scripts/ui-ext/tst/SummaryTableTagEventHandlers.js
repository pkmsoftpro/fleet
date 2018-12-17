/**
 * Event handler for SummaryTable... for specific use cases... it can be overridden and the new class can be used.
 * @author janmejay.singh
 * Note: for ppl writing there own event handlers....
 * The preview's iframe has a iframe name usage convention, which allowes the t:openTab to play well with it.
 * in case u override the function's that generate the iframe name, please make sure that u don't break the convention.
 */

dojo.declare("tavant.twms.summaryTable.BasicEventHandler", null, {
    _reader : null,

    selectedRowDataId : null,//holds the dataId of the row that was clicked last time.
	previewPane : null,
    splitContainer : null,
    summaryTable : null,

    _enableTableMinimize : false,

    _minimized : false,

    renderPreview : true,

    constructor : function(summaryTable) {
        dojo.subscribe(summaryTable.rowClickTopic, this, "onRowClick");
		dojo.subscribe(summaryTable.rowDblClickTopic, this, "onRowDblClick");
		dojo.subscribe(summaryTable.clearSelectionTopic, this, "_clearPreview");
        dojo.subscribe(summaryTable.hidePreviewTopic, this, "_hidePreview");
        dojo.subscribe(summaryTable.showPreviewTopic, this, "_showPreview");
        dojo.subscribe(summaryTable.maximizePreview, this, "_maximizePreview");
        dojo.subscribe(summaryTable.restorePreview, this, "_restorePreview");
        this.previewPane = summaryTable.previewPane;
        var previewPane = this.previewPane;

        if(previewPane) {
            var previewPaneClass = previewPane.declaredClass;
            if(previewPaneClass == "dojox.layout.ContentPane") {
                previewPane.renderStyles = true;
            } else {
                throw new Error("Preview panes must be of type dojox.layout.ContentPane! You are using " +
                        previewPaneClass + ".");
            }
        }

        this.splitContainer = summaryTable.parentSplitContainer;
        this.summaryTable = summaryTable;
    },

    _maximizePreview : function() {/*do something here*/},

    _restorePreview : function() {/*do something here*/},

    getSelectedRowDataId : function() {
		return this.selectedRowDataId;
	},
	
	onRowDblClick : function(event) {/*do something here*/},
	
	onRowClick : function(event) {/*do something here*/},
	
	_clearPreview : function() {/*do something here*/},

    _showPreview : function() {/*do something here*/},

    _hidePreview : function() {/*do something here*/}
});


/*
 * Captures a URL and its parameters. One can create one of these, pass it around and add params to it. Then,
 * whenever you need to fire a POST request, you can call the getUrl() and getParams() functions.
 */
dojo.declare("tavant.twms.summaryTable.Url", null, {
    _baseUrl: null,
    _params: {},
    summaryTable : null,

    constructor: function(baseUrl, params, summaryTable) {
        if (!dojo.string.isBlank(baseUrl)) {
            this._baseUrl = baseUrl;
        } else {
            this._baseUrl = "";
        }

        if (params) {
            this._params = params;
        }

        this.summaryTable = summaryTable;
    },

    addParam: function(key, value) {
        this._params[key] = value;
    },

    /**
     * this is something very specific to SummaryTable... it reads the 'extraParamsVar' and 'extraParamsFunctions'
     * and adds all the variables to params.
     */
    handleExtraParams : function() {
        var extraParams = this.summaryTable.extraParamsVar;
        if(extraParams === null) {
            return;
        }
        for(var i in extraParams) {
            this.addParam(i, extraParams[i]);
        }
    },

    handleExtraParamsFunctions : function() {
        var extraParamsFunctions = this.summaryTable.extraParamsFunctions;
        if(extraParamsFunctions === null) {
            return;
        }
        var extraParamsFunctionArgsData = this._getSelectionData();
        if (extraParamsFunctionArgsData) {
            for (var i in extraParamsFunctions) {
                this.addParam(i, extraParamsFunctions[i](extraParamsFunctionArgsData));
            }
        }
    },

    _getSelectionData : function() {
        var table = this.summaryTable;
        var selectionData = table.getSelectedRowIds();
        var data = null;
        if (table.selectionMode === 'single') {
            data = selectionData[0];
        } else {
            data = selectionData;
        }
        return data;
    },

    _processExtraParams: function() {
        this.handleExtraParams();
        this.handleExtraParamsFunctions();
    },

    toPost: function() {
        this._processExtraParams();
        return this;
    },

    toGet: function() {
        this._processExtraParams();
        return this._baseUrl + "?" + dojo.objectToQuery(this._params);
    },

    getBaseUrl: function() {
        return this._baseUrl; //string
    },

    getParams: function() {
        return this._params;
    }
});