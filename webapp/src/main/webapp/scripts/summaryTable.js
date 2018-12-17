/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


define("twms.widget.SummaryTable",["dgrid/List","dgrid/OnDemandGrid","dgrid/Selection","dgrid/Keyboard","dgrid/extensions/ColumnHider","dojo/_base/declare","dojo/_base/array","dgrid/extensions/Pagination","dgrid/extensions/ColumnResizer","dojo/domReady!"],
        function(List, Grid, Selection, Keyboard, Hider, declare, arrayUtil,Pagination,ColumnResizer) {
            // Create the main grid.
            var SummaryTable = new (declare([Grid, Selection, Keyboard, Hider, Pagination, ColumnResizer]))({
                store: null,
                columns: null
                
            });
            return SummaryTable;
        }	//	end "main" function
);	//	end require