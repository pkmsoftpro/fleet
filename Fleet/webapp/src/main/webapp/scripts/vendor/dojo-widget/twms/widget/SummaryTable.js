define("twms/widget/SummaryTable", ["dojo/_base/declare","dojo/has","dojo/has!touch?dgrid/util/touch", "dojo/_base/Deferred","dojo/query","dojo/json", "dojo/on",
    "dojo/_base/lang", "dgrid/extensions/Pagination", "dgrid/Grid", "dgrid/Selection", "dgrid/extensions/ColumnHider", "dgrid/extensions/ColumnResizer", 
    "put-selector/put", "dojo/domReady!"], function(declare, has, touchUtil, Deferred, query, json,listen, lang, Pagination, Grid, Selection, ColumnHider, ColumnResizer, put) {
            return declare("twms.widget.SummaryTable",[Grid, Selection, ColumnHider, ColumnResizer, Pagination], {
                firstLastArrows:true,
                rowsPerPage:20,
                pagingLinks:0,
                pagingTextBox:true,
                loadingMessage: "Loading ....",
                noDataMessage: "No Results Found.",
                filterRequest: null,
                filterTimeOut: 500, // default filtering time out
                selectionMode: "single", // pass 'extended' if you want to enable multiple row selection
                parentSplitContainer: null,
                previewPane: null,
                _previewAble: false,
                previewVisible: false,
                previewUrl: null,
                detailUrl: null,
                selectedDataId: null,
                folderName: null,
                extraParamsVar: null,
                extraParamsFunctions: null,
                labelColumnTitle: null,
                labelColumnField: null,
                idColumnField: null,
                idColumnTitle: null,
                rowClickTopic : "/summaryTable/rowClick",
                rowDblClickTopic: "/summaryTable/rowDblClicked",
                rowCtrlClickTopic: "/summaryTable/rowCtrlClick",
                clearSelectionTopic: "/summaryTable/clearSelection",
                hidePreviewTopic: "/inbox/hidePreview",
                showPreviewTopic: "/inbox/showPreview",
                maximizePreview: "/inbox/maximzePreview",
                restorePreview: "/inbox/restorePreview",
                postCreate: function(){ // need to hook up few event handlers
                    this.inherited(arguments);
                    var selector = this.selectionDelegate, grid = this;
                    listen(this, "dgrid-select",function(event){
                        if(event.grid.selectionMode === 'single'){ // we will load the preview pane if the select mode is single for now :)  
                            var dataId = event.rows[0].id;
                            event.grid.selectedDataId =  dataId;
                            event.dataId = dataId;
                            dojo.publish(this.rowClickTopic,[event]);
                        }
                    });
                    listen(this.domNode, "dgrid-refresh-complete",function(event){
                        Deferred.when(event.results.total, function(total){
                            if(total !== 0){ // select first row by default
                               // event.grid.select(query(".dgrid-row",event.grid.domNode)[0]);
                            }
                        });
                    });
                    if(has("touch")){
                        // listen for touch taps if available
                        listen(this.contentNode, touchUtil.selector(selector, touchUtil.dbltap), function(evt){
                            grid.openDetailPage(this, evt);
                        });
                    }else{
                        // listen for actions that should cause selections
                    	if(this.previewPane) {
                    		listen(this.contentNode, listen.selector(selector, "click"), function(event){
                    			grid._loadPreviewPaneContent(this);
                    		});
                    	}
                    	
                        listen(this.contentNode, listen.selector(selector, "dblclick"), function(event){
                        	grid.openDetailPage(this,event);
                        });
                    }                    
                },
                _loadPreviewPaneContent: function(rowId){
                	var selectedRow= this.row(rowId);
                	var selectedDataId  = selectedRow.id;
                    this.previewPane.setHref(this.previewUrl + "?" + dojo.objectToQuery(this._processExtraParams(selectedDataId)));
                },
                _handleExtraParams : function(params) {
                    if(json.stringify(this.extraParamsVar) === '"{}"') {
                        return;
                    }
                    for(var i in this.extraParamsVar) {
                        params[i] = this.extraParamsVar[i];
                    }
                },
                _handleExtraParamsFunctions: function(params, rowId) {
                    if (json.stringify(this.extraParamsFunctions) === '"{}"') {
                        return;
                    }
                    for (var j in this.extraParamsFunctions) {
                        params[j] = this.extraParamsFunctions[j](rowId);
                    }
                },
                _processExtraParams: function(rowId) {
                    var params = {};
                    if(rowId){
                        params.id = rowId;
                    }
                    if(this.folderName){
                        params.folderName = this.folderName;
                    }
                    this._handleExtraParams(params);
                    this._handleExtraParamsFunctions(params, rowId);
                    return params;
                },
                openDetailPage: function(row,event){
                    if(this.detailUrl){
                        var targetRow = row;
                        if (!row.element) {
                            targetRow = this.row(row);
                        }
                        this.selectedDataId  = targetRow.id;
                        event.dataId = this.selectedDataId;
                        if(this.labelColumnField){
                            event.labelPrefix = this.labelColumnTitle;
                            event.labelSuffix = targetRow.data[this.labelColumnField];
                        }
                        else if(this.idColumnField){ // this should never be false, but we never know :)
                            event.labelPrefix = this.idColumnTitle;
                            event.labelSuffix = targetRow.data[this.idColumnField];
                        }
                        dojo.publish(this.rowDblClickTopic,[event]);
                    }
                },        
                _getQueryOptions: function(){
                    return lang.mixin(this.inherited(arguments),this._processExtraParams());
                },
                _setSummaryTableDetailsOnFrame : function(/*domNode (iframe)*/ frame, /*boolean*/ isPreview) {
                    frame.TST_ID = this.id;
                    frame.TST_IS_PREVIEW = isPreview;
                },
                getSelectedRowIds: function(){ // returns an array of selected row ID's
                    var selectedIds = new Array();
                    for(var rowId in this.selection){
                        selectedIds.push(rowId);
                    }
                    return selectedIds;
                },
                buildRendering: function() { // to add preview button to footer
                    this._previewAble = (typeof(this.parentSplitContainer) != 'undefined' && this.parentSplitContainer !== null);
                    this.inherited(arguments);
                    if(this._previewAble){
                       /* var grid = this;
                        this.showHideButton = put(this.paginationNode, "input.previewButtonClass#address[type=button]");
                        this.showHideButton.value = "Show";
                        if(this.previewPane)
                        this.parentSplitContainer.removeChild(this.previewPane);
                        listen(this.showHideButton, "click", function(event){
                            grid._togglePreviewVisibility();
                        });*/
                    }else if(this.parentSplitContainer){ // if split container is specified, just remove the preview pane so that we don't show the split container
                    	this.parentSplitContainer.removeChild(this.previewPane);
                    }
                },
                _togglePreviewVisibility : function(){
                    var classToBeAdded, classToBeRemoved, label;
                    if(!this.previewVisible) {
                        classToBeRemoved = "previewHidden";
                        classToBeAdded = "previewShown";
                        label = i18N.summary_table_hide;
                        dojo.publish(this.showPreviewTopic);
                    } else {
                        classToBeRemoved = "previewShown";
                        classToBeAdded = "previewHidden";
                        label = i18N.summary_table_show;
                        dojo.publish(this.hidePreviewTopic);
                    }
                    this.parentSplitContainer.resize();
                    this.showHideButton.value = label;
                    this.previewVisible = !this.previewVisible;
                    this.refreshTableAndPreview();
                },                        
                renderHeader: function() {
                    var grid = this;
                    this.inherited(arguments);
                    var hasFilterColumns = false;
                    var row = this.createRowCells("th", function(th, column) {
                        var contentNode = th;
                        if(this.contentBoxSizing){
                            // we're interested in the th, but we're passed the inner div
                            th = th.parentNode;
                        }
                        var field = column.field;
                        if (field) {
                            th.field = field;
                        }
                        // allow for custom header content manipulation
                        if ((column.renderHeaderCell || column.label || column.field) && column.filterable === true) {
                            var i = document.createElement("INPUT");
                            listen(i, "keyup", function(event) { // we will listen to key press events and emit on evnt object with all the info
                                if(grid.filterRequest){
                                    clearTimeout(grid.filterRequest);
                                }
                                grid.filterRequest = setTimeout(function(){
                                    var eventObj = {
                                        bubbles: true,
                                        cancelable: true,
                                        grid: grid,
//                                        parentType: event.type,
                                        field: event.target.parentNode.field,
                                        value: event.target.value
                                    };
                                    listen.emit(event.target.parentNode, "dgrid-filter", eventObj);
                                },grid.filterTimeOut);
                                listen(event.target.parentNode, "dgrid-filter", function(event){
                                    var isRefreshNeeded = grid.store.addFilter(event.field, event.value);
                                    if(isRefreshNeeded){
                                        grid.gotoPage(1);
                                    }
                                });
                            });
                            contentNode.appendChild(i);
                            hasFilterColumns = true;
                        }
                        if (column.filterable === true && field && field !== "_item") {
                            th.filterable = true;
                            th.className += " dgrid-filterable";
                        }
                    }, this.subRows && this.subRows.headerRows);
                    if (hasFilterColumns) {
                        put("div[role=filter]>", row);
                        this.headerNode.appendChild(row);
                    }
                },
                fetchCriteriaUrl: function(baseUrl){
                    var params = this._processExtraParams();
                    var filters = this.store.filters;
                    if(filters.length > 0){
                        dojo.forEach(filters, function(item,i){
                            params['column' + i]= encodeURIComponent(item.columnName);
                            params['filter' + i]= encodeURIComponent(item.value);
                        });
                    }
                    var sorts = this._sort;
                    if(sorts.length > 0){
                        dojo.forEach(sorts, function(item,i){
                            params['sort' + i]= encodeURIComponent(item.attribute);
                            params['as' + i]= (item.descending ? 'dsc' : 'asc');
                        });
                    }else{ // look for any default sorts defined
                        var sort = this.store.sort;
                        if(sort){
                            params['sort0']= encodeURIComponent(sort.attribute);
                            params['as0']= (sort.descending ? 'dsc' : 'asc');
                        }
                    }
                    return (baseUrl + "?" + dojo.objectToQuery(params));
                },
                hideCompletedRow : function(event) {
                    var dataId = event.dataId;
                    var row = this._rowIdToObject(dataId);
                    this.removeRow(row);
                    var tabId = getTabDetailsForIframe().tabId;
                    var tab = getTabHavingId(tabId);
                        parent.publishEvent("/refresh/folderCount", {folderName: tab.label});
                        delete tabId, tab;
                },

                /*
                 * Hides rows; provides a visual fading effect, and re-renders the table data.
                 */
                hideCompletedRows : function(event) {
                    var dataIds = event.dataIds;
                    dojo.forEach(dataIds, function(item, i){
                        var row = this._rowIdToObject(dataId);
                        this.removeRow(row);
                    });
                    var tabId = getTabDetailsForIframe().tabId;
                    var tab = getTabHavingId(tabId);
                    parent.publishEvent("/refresh/folderCount", {folderName: tab.label});
                    delete tabId, tab;
                },

                /**
                 * This function is called when the tab is focused... 
                 * NOT a HACK : this function is ditching the thread that is executing the functions listing to the event...
                 * that thread is screwed-up(because iframe spawning it gets killed after firing a async ajax call....
                 * and no one listens to the response...)
                 * so we spawn a new thread and fire our functions from that....
                 */

                manageGridRefresh : function(event){
                    var refreshList = dojo.hitch(this, this.refreshTable);
                    var refreshFull = dojo.hitch(this, this.refreshTableAndPreview);
                    setTimeout(function() {//please read the doc above
                        if(event.needsRefresh) {
                            event.needsRefresh.fullRefresh ? refreshFull() : refreshList();
                        }
                    }, 0);
                },
                /*
                 * Refreshes the SummaryTable. The current state of pagination, filtering, sorting, and column width adjustments
                 * are not disturbed.
                 */
                refreshTable : function() {
                    this.refresh();
                },

                refreshTableAndPreview : function() {
                    if(this.previewVisible) {
                        this._togglePreviewVisibility()
                    }
                    this.clearSelection();
                    this.refresh();
                },
                minimize : function() {
                    publishEvent(this.maximizePreview);
                },

                restore : function() {
                    publishEvent(this.restorePreview);
                }
            });
        }
);