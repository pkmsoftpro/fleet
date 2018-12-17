        <style>
            #${parameters.id} {
                position: absolute;
                top: 0;
                bottom: 0;
                left: 0;
                right: 0;
                height: auto;
            }
        </style>
        <script>
            dojo.require("twms.widget.SummaryTable");
            dojo.require("twms.data.SummaryTableReadStore");
            var deafultSort_${parameters.id};
            var labelColumnTitle_${parameters.id};
            var labelColumnField_${parameters.id};
            var idColumnField_${parameters.id};
            var idColumnTitle_${parameters.id};
            
            <#list parameters.columns as col>
              <#if !col.cssColumn>
                    <#if col.labelColumn && !col.hidden>
                     deafultSort_${parameters.id} = {attribute:"${col.id}",descending:false};
                     labelColumnTitle_${parameters.id} = "${col.label}";
                     labelColumnField_${parameters.id} = "${col.id}";
                    </#if>
                    <#if col.idColumn>
                         idColumnField_${parameters.id} = "${col.id}";
                         idColumnTitle_${parameters.id} = "${col.label}";
                    </#if>
                    
                ${parameters.id}_columns.${parameters.id}_col_${col.label?replace(".","_")?replace("/","_")?replace(" ","_")?replace("#","")} = {
                    label: "${col.label}", 
                    field: "${col.id}",
                    sortable: ${col.disableSorting?string("false","true")},
                    filterable: ${col.disableFiltering?string("false","true")}
                    <#if col.rendererClass?? >
                        ,renderCell: dojo.hitch( new ${col.rendererClass}(), "render")
                    </#if>
                    <#if col.dataType == "CheckBox" && !col.hidden>
                  		,hidden: false,
                        unhidable: true
                        ,renderHeaderCell: dojo.hitch( new tavant.twms.summaryTableExt.CheckBoxInHeaderRenderer(), "render")	
                    </#if>
                    <#if col.hidden && col.dataType != "CheckBox">
                        ,hidden: true,
                        unhidable: false
                    </#if>
                }
              </#if>
             </#list>
            var grid_${parameters.id}; 
            function plugEventHandler() {
              var eventHandler = new ${parameters.eventHandlerClass}(grid_${parameters.id});
            } 
            dojo.addOnLoad(function(){
                var sortField = deafultSort_${parameters.id};
                if ((document.getElementById("inboxViewSortField")) && (document.getElementById("inboxViewSortField").value != '')) {
                    sortField = {attribute:document.getElementById("inboxViewSortField").value,descending:("false" === document.getElementById("inboxViewSortOrder").value)};
                }

                grid_${parameters.id} = new twms.widget.SummaryTable({
                    columns: ${parameters.id}_columns,
                    store: new twms.data.SummaryTableReadStore({target:"${parameters.bodyUrl}", 
                                requestMethod:"get", 
                                sort: sortField,
                                folderName:"${parameters.folderName}",
                                idProperty: (idColumnField_${parameters.id} ? idColumnField_${parameters.id} : "id")
                            }),
                    parentSplitContainer: dijit.byId("${parameters.parentSplitContainerId}"),
                    selectionMode : "${parameters.multiSelect?string("extended","single")}",
                    detailUrl : "${parameters.detailUrl}",
                    <#if parameters.previewPaneId?exists>
  					previewPaneId : "${parameters.previewPaneId}",
  					previewPane : dijit.byId("${parameters.previewPaneId}"),
					</#if>
                    <#if parameters.previewUrl?exists>
  					previewUrl : "${parameters.previewUrl}",
					</#if>
                    labelColumnTitle : (labelColumnTitle_${parameters.id} ? labelColumnTitle_${parameters.id} : null),
                    labelColumnField: (labelColumnField_${parameters.id} ?labelColumnField_${parameters.id} : null),
                    folderName:"${parameters.folderName}",
                    extraParamsVar:${parameters.extraParamsVar},
                    extraParamsFunctions:${parameters.extraParamsFunctions},
                    idColumnField: (idColumnField_${parameters.id} ? idColumnField_${parameters.id} : null),
                    idColumnTitle: (idColumnTitle_${parameters.id} ? idColumnTitle_${parameters.id} : null)
                },"${parameters.id}");
                grid_${parameters.id}.updateSortArrow([sortField]);
                plugEventHandler();
                dojo.subscribe("/refresh/inboxView#${parameters.id}/listing", grid_${parameters.id}, "refreshTable");
                dojo.subscribe("/refresh/inboxView#${parameters.id}/full", grid_${parameters.id}, "refreshTableAndPreview");
                dojo.subscribe("/refresh/inboxView#${parameters.id}/hideCompletedRow", grid_${parameters.id}, "hideCompletedRow");
                dojo.subscribe("/refresh/inboxView#${parameters.id}/hideCompletedRows", grid_${parameters.id}, "hideCompletedRows");
                dojo.subscribe("/listing/inboxView#${parameters.id}/minimize", grid_${parameters.id}, "minimize");
                dojo.subscribe("/listing/inboxView#${parameters.id}/restore", grid_${parameters.id}, "restore");
                dojo.subscribe("/tab/focused", grid_${parameters.id}, "manageGridRefresh");

                <#if parameters.populateCriteriaDataOn?exists>
                    <#--
                        the listner needs a map... which has : {url : "a string", returnTo: javascriptFunction(will recive url as 1st arg)}
                    -->
                    dojo.subscribe("${parameters.populateCriteriaDataOn}", null, function(message) {
                        message.returnTo(grid_${parameters.id}.fetchCriteriaUrl(message.url));
                    });
                  </#if>
            });
            function connectSummaryTableButtonCallback(/*String*/ summaryTableId,
                                                       /*dijit.form.Button widget*/ button, /*Function obj*/ callback) {
                button.onClick = function(event) {
                    var currentSelection = grid_${parameters.id}.getSelectedRowIds()    ;
                    callback(event, currentSelection);
                };
            }            
    </script>
