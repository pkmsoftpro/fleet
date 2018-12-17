dojo.declare('twms.widget.TreeModel', dijit.tree.ForestStoreModel, {
        treeType:null,
		getChildren: function(parentItem, complete_cb, error_cb) {
			if(parentItem.root){
                complete_cb(this.store.data.asmChildren);
            }
            else{
                if(this.treeType === 'FAULTCODE'){
                    complete_cb(parentItem.asmChildren);
                }else if(this.treeType === 'JOBCODE'){
                    var children = null;
                    var nodes = dojo.filter(parentItem.asmChildren, function(item){
                        return item.nodeType === 'node';
                    });
                    children = nodes;
                    if(parentItem.spChildren && parentItem.spChildren.length > 0)
                        children = children.concat(parentItem.spChildren);
                    complete_cb(children);
                }else{
                    console.error("Invalid tree type : '" + this.treeType + "'");
                    complete_cb([]);
                }
            }
		},

		mayHaveChildren: function(item) {
			if(item.root)
				return true;
            else if(this.treeType === 'FAULTCODE'){
                return item.asmChildren.length > 0;
            }else if(this.treeType === 'JOBCODE'){
                    var children = null;
                    var nodes = dojo.filter(item.asmChildren, function(itemNode){
                        return itemNode.nodeType === 'node';
                    });
                    children = nodes;
                    if(item.spChildren && item.spChildren.length > 0)
                        children = children.concat(item.spChildren);
                    return children.length > 0;
                }else{
                    console.error("Invalid tree type : '" + this.treeType + "'");
                }
            return false;
		}
	});