/**
 * @author : janmejay.singh
 */
/**
 * Node object structure is assumed to be this...
 * node = {
 *     code : "AA1",
 *     nodeType: "node",
 *     id : "ietmAA1",
 *     label : "MyLabelTypeOne",
 *     asmChildren : [node | leaf],
 *     spChildren : [leaf]
 * };
 * NOTE : for faultcode thingy... there will be one more attribute called 'faultCode' which will have an 'id'...
 * leaf = {
 *    code : "AA1_replaced",
 *    nodeType : "leaf",
 *    id : "aa1_replacement",
 *    completeCode : "AA1 - AA1_replaced",
 *    suggestedLabourHours : 10,
 *    label : "Replace"
 * };
 * root = {
 *    nodeType : "root",
 *    children : [leaf | node]
 * };
 */
//adding data store to the tree....

dojo.require("dojo.data.ItemFileWriteStore");
dojo.require("twms.widget.ServiceProcedureNode");

dojo.declare("tavant.twms.ServiceProcedureRenderer", null, {

    tBody : null,//tbody's domNode to which all the selected items are to be appended
    treeWidget : null,//ServiceProcedureTreeWidget instance
    template : "<tr/>",
    script : "",
    index : 0,
    _collectionName : "",
    selectedRows : null,
    multipleSelectionAllowed: false,

    constructor : function(/*tBody domNode*/ tBody, /*ServiceProcedureTreeWidget instance*/ treeWidget,
                           /*array of selected nodes [nodeType : "leaf"]*/ alreadySelectedNodes,
                           /*String (template text(tr))*/ template, /*String (template javascript)*/ script,
                           /*String (OGNL collection name)*/ collectionName,/*alreadySelectedNode*/alreadySelectedNode,
                           /*Boolean */ multipleSelectionAllowed) {
        this.tBody = tBody;
        this.treeWidget = treeWidget;
        this.template = unescapeThisHtml(template);
        this.script = script;
        this._collectionName = collectionName;
        this.selectedRows = new Array();
        if(treeWidget){
            this.multipleSelectionAllowed = treeWidget.multipleSelectionAllowed;
            this.treeWidget.treeLoaded = dojo.hitch(this, this._onTreeLoad);
            this.index = alreadySelectedNodes.length;
        }else{
            this.multipleSelectionAllowed = multipleSelectionAllowed;
        }
    },


    _onTreeLoad : function(){
        dojo.query("tr", this.tBody).forEach(function(row){
            dojo.forEach(this.treeWidget.selectedNodesList, function(node){
                if(row.nodeObject.completeCode === node.item.completeCode)
                    row.nodeObject._nodeSelector = node._nodeSelector;
            },this);
        },this);
    },
    addSelectedNodes: function(alreadySelectedNodes){
        if (alreadySelectedNodes && alreadySelectedNodes.length > 0) {
            this.renderSelectedRows(alreadySelectedNodes);
            this.index = alreadySelectedNodes.length;
        }
    },

    renderSelectedRows : function(alreadySelectedNodes) {
     	if (!this.multipleSelectionAllowed ){
     	  if(dijit.byId("jobCodeAtrribute_0"))
        	{
                dijit.byId("jobCodeAtrribute_0").destroyRecursive();
                this._deleteItemForRadio(dojo.byId("delete_link_0"));
                this.index=0;
        	}
        }
        var selectedNodes = null;
        if(alreadySelectedNodes){
            selectedNodes = alreadySelectedNodes;
        }else{
            selectedNodes = this.treeWidget.selectedNodesList;
        }
        dojo.forEach(selectedNodes, function(selectedNode) {
            if(!selectedNode.listed) {// the node needs to displayed only if it is not listed
                this._renderRow(selectedNode);
                if(selectedNode._nodeSelector){
                    this._disableNodeSelection(selectedNode._nodeSelector, true);
                }
            }
        }, this);
    },
    renderSelectedCode : function() {
        var selectedNode = this.treeWidget.selectedNode;
		if (selectedNode) {
			this._renderRow(selectedNode);
		}
    },
    
	_disableNodeSelection :function (nodeWidget, disableEdit){
     	nodeWidget.setChecked(disableEdit);
     	nodeWidget.setDisabled(disableEdit);
   },
   
    _getSubstitutionMap : function(node) {
        return {
            "index" :this.multipleSelectionAllowed ? (node.index == undefined ? this.index++ : node.index ) : 0 ,
            "wrapperId" : node.wrapperId ? node.wrapperId : "",
            "reasonForAdditionalHours" : node.jobReason ? node.jobReason : "",
            "additionalLaborHours" : node.additionalLaborHours ? node.additionalLaborHours : "",
            "suggestedLabourHours" : node.suggestedLabourHours,
            "specifiedHoursInCampaign" : node.specifiedHoursInCampaign ? node.specifiedHoursInCampaign : node.suggestedLabourHours,
            "specifiedLaborHours" : node.specifiedLaborHours ? node.specifiedLaborHours : "",
            "useSuggestedHours" : node.useSuggestedHours ? node.useSuggestedHours : false,
            "id" : node.serviceProcedureId,
            "completeCode" : node.completeCode,
            "emptyAdditionalHours":false,
            "fullNameTooltip" : node.completeName ? node.completeName : "",
            "laborHrsEntered":node.laborHrsEntered ? node.laborHrsEntered : "",
            "hasAdditionalAttributes" : node.hasAdditionalAttributes ? node.hasAdditionalAttributes : false
        };
    },

    _renderRow : function(/*dataStruct element[nodeType : "leaf"]*/ node) {
        var substitutionMap = this._getSubstitutionMap(node.item ? node.item : node);
        var rowMarkup = dojo.string.substitute(this.template, substitutionMap);
        var rowScript = "";
        var row = false;
        try{
        	rowScript = dojo.string.substitute(this.script,  substitutionMap);
        	row = dojo.html.createNodesFromText(rowMarkup, true);
        }
        catch (e) {
        	rowScript = dojo.string.substitute("",  substitutionMap);
		}
        if(row){
	        row.nodeObject = node;
	        row.nodeObject.listed = true;
	        row.nodeObject.selected = false;
	        var deleteButton = dojo.query("div.repeat_del", row)[0];
            deleteButton.id="delete_link_"+this.index;
            dojo.connect(deleteButton, "onclick", dojo.hitch(this, this._deleteItem));
	        this.tBody.appendChild(row);
	        dojo.parser.parse(row);
            this.selectedRows.push(row);
        }
        eval(rowScript);
    },

    _deleteItem : function(event) {
        var row = getExpectedParent(event.target, "tr");
        if(this.multipleSelectionAllowed){
            requestDeletion(row, this._collectionName); 
        }
        var node=row.nodeObject;
        node.listed = false;
        delete node.index;
        if(this.treeWidget)
            this.treeWidget._removeSelectedNode(node);
        if(node._nodeSelector){
            this._disableNodeSelection(node._nodeSelector,false);
        }
        dojo.dom.destroyNode(row);
        if (!this.multipleSelectionAllowed ) {
            dijit.byId("jobCodeAtrribute_0").destroyRecursive();
        }
    },

    deleteSelectedNodes : function() {
        dojo.forEach(this.selectedRows, function(row) {
        requestDeletion(row, this._collectionName);
        var node = row.nodeObject;
        node.listed = false;
        if(this.treeWidget)
            this.treeWidget._removeSelectedNode(node);
        if (node._nodeSelector) {
            this._disableNodeSelection(node._nodeSelector, false);
        }
        dojo.dom.destroyNode(row);  
        }, this);
        this.selectedRows = new Array();
    },

    _deleteItemForRadio : function(target) {
        var row = getExpectedParent(target, "tr");
        if(this.multipleSelectionAllowed)
        {
        requestDeletion(row, this._collectionName);
        }
        var node=row.nodeObject;
        node.listed = false;
        if(this.treeWidget)
            this.treeWidget._removeSelectedNode(node);
        if(node._nodeSelector){
        this._disableNodeSelection(node._nodeSelector,false);
        }
        dojo.dom.destroyNode(row);
    },

     _removeItem : function(node,tBody) {
        var tbody = getExpectedParent(tBody, "tbody");
        dojo.dom.removeChildren(tbody,true);
        //requestDeletion(row, this._collectionName);
       // var node=row.nodeObject;
        node.listed = false;
        if(this.treeWidget)
            this.treeWidget._removeSelectedNode(node);
        if(node._nodeSelector){
            this._disableNodeSelection(node._nodeSelector,false);
        }
        //dojo.dom.destroyNode(row);
    }
    

});

dojo.declare("tavant.twms.FaultCodeRenderer", null, {

    div : null,//span's domNode in which selected items label is to be put
    treeWidget : null,//FaultCodeTreeManager instance
    template : "<span/>",

    constructor : function(/*div domNode*/ div, /*Tree Widget instance*/ treeWidget,
                           /*String(completeCode of node)*/ alreadySelectedValue, /*String (template text(span))*/ template) {
        this.div = div;
        this.treeWidget = treeWidget;
        this.template = unescapeThisHtml(template);
    },

    renderSelectedCode : function() {
        var selectedNode = this.treeWidget.selectedNode;
        if(selectedNode) {
            this._renderRow(selectedNode);
        }
    },

    _getSubstitutionMap : function(nodeObject) {
        return {
            "completeCode" : nodeObject.completeCode,
            "fullNameTooltip" : nodeObject.completeName,
            "faultCodeId" : nodeObject.faultCode.id
        };
    },

    _renderRow : function(/*assoc array*/nodeObject) {
        var substitutionMap = this._getSubstitutionMap(nodeObject.item);
        this._deleteInnerSpan();
        var spanMarkup = dojo.string.substitute(this.template, substitutionMap);
        var span = dojo.html.createNodesFromText(spanMarkup, true);
        if(span){
       		this.div.appendChild(span);
        }
    },

    _deleteInnerSpan : function() {
        var span = dojo.query("span", this.div)[0];
        if(span) {
            dojo.dom.destroyNode(span);
        }
    }
});

dojo.declare("twms.campaignServiceDetail.MergedTreeRenderer", tavant.twms.ServiceProcedureRenderer, {
    _getSubstitutionMap : function(node) {
        return {
            "index" : this.index++,
            "wrapperId" : node.wrapperId ? node.wrapperId : "",
            "reasonForAdditionalHours" : node.jobReason ? node.jobReason : "",
            "additionalLaborHours" : node.additionalLaborHours ? node.additionalLaborHours : "",
            "suggestedLabourHours" : node.suggestedLabourHours ? node.suggestedLabourHours : "",
            "specifiedLaborHours" : node.specifiedLaborHours ? node.specifiedLaborHours : "",
            "useSuggestedHours" : node.useSuggestedHours ? node.useSuggestedHours : false,
            "id" : node.definition ? node.definition.id : node.serviceProcedureId,
            "completeCode" : node.completeCode,
            "fullNameTooltip" : node.completeName ? node.completeName : ""
        };
    }
});
