/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
define("twms/data/SummaryTableReadStore", ["dojo/_base/xhr", "dojo/_base/array", "dojo/_base/declare", "dojo/store/util/QueryResults","dojo/json"
], function(xhr, array, declare, QueryResults,json) {
    return declare("twms.data.SummaryTableReadStore", null, {
        constructor: function(options) {
            declare.safeMixin(this, options);
        },
        // target: String
        //		The target base URL to use for all requests to the server. 
        target: "",
        // idProperty: String
        //		Indicates the property to use as the identity property. The values of this
        //		property should be unique.
        idProperty: "id",
        // Array of filters which needs to be passed to read store on filtering 
        //                
        filters: [],
        
        // Array of sorts used by default        
        // sort object, attribute and descending 
        sort: null,
                
        folderName: null,
        
        get: function(id, options) {
            //	summary:
            //		Retrieves an object by its identity. This will trigger a GET request to the server using
            //		the url `this.target + id`.
            //	id: Number
            //		The identity to use to lookup the object
            //	returns: Object
            //		The object in the store that matches the given id.
            var headers = options || {};
            headers.Accept = this.accepts;
            return xhr("GET", {
                url: this.target + id,
                handleAs: "json",
                headers: headers
            });
        },
        // accepts: String
        //		Defines the Accept header to use on HTTP requests
        accepts: "application/javascript, application/json",
        getIdentity: function(object) {
            // summary:
            //		Returns an object's identity
            // object: Object
            //		The object to get the identity from
            //	returns: Number
            return object[this.idProperty];
        },
        query: function(query, options) {
            // summary:
            //		Queries the store for objects. This will trigger a GET request to the server, with the
            //		query added as a query string.
            // query: Object
            //		The query to use for retrieving objects from the store.
            //	options: dojo.store.api.Store.QueryOptions?
            //		The optional arguments to apply to the resultset.
            //	returns: dojo.store.api.Store.QueryResults
            //		The results of the query, extended with iterative methods.
            var headers = {Accept: this.accepts};
            options = options || {};
            if (query && typeof query == "object") {
                query = xhr.objectToQuery(query);
                query = query ? "?" + query : "";
            }
            if(!query){
                query += "?";
            }
            if (options.start >= 0 || options.count >= 0) {
                var page = options.start / options.count; // start will be the row start num, and count is records per page
                page = page + 1; // Note that page numbers start at 1.
                query = query + '&page=' + page;
            }
            if (options && options.sort) {
                var sort = options.sort[0];
                query += '&sort0=' + encodeURIComponent(sort.attribute);
                query += ('&as0=' + (sort.descending ? 'dsc' : 'asc'));
            }else if(this.sort){
                query += '&sort0=' + encodeURIComponent(this.sort.attribute);
                query += ('&as0=' + (this.sort.descending ? 'dsc' : 'asc'));
            }
            if(this.filters.length > 0){
                dojo.forEach(this.filters, function(item,i){
                    query += ('&column' + i + '=' + encodeURIComponent(item.columnName));
                    query += ('&filter' + i + '=' + encodeURIComponent(item.value));
                });
            }
            if(json.stringify(options) !== '"{}"') {
                for (var i in options) {
                    if(i !== "sort"){
                        query += ('&' + i + '=' + encodeURIComponent(options[i]));
                    }
                }
            }
            var response = this.tracker.track(xhr("GET", {
                url: this.target + (query || ""),
                handleAs: "json",
                headers: headers,
                failOk: true
            })); // response has array of results first one being array of objects and 4th being count
            response.total = response.then(function(results){
                return results[4];
            });
            response["map"] = function(){ // overridng map implimentation of QueryResults.
				var args = arguments;
				return dojo.Deferred.when(response, function(results){
					Array.prototype.unshift.call(args, results[0]);
					return QueryResults(array["map"].apply(array, args));
				});
			};
            return QueryResults(response);
        },
        tracker : function(){
            return {
                _xhr: null,
                track: function(xhr)
                {
                    var obj = this;
                    // If a request was made and still working, kill it.
                    if (this._xhr) {
                        this._xhr.cancel();
                    }
                    // Create new request and return handle on it.
                    return this._xhr = xhr;
                }
            };
        }(),
        addFilter: function(/*String column name on thich filter needs to applied*/filterColumn, /*Value for column*/filterValue) {
            var refereshNeeded = false;
            if(dojo.string.isBlank(filterValue)){
                this.filters = dojo.filter(this.filters, function(item, index){
                    return item.columnName !== filterColumn;
                });
                refereshNeeded = true;
            }
            else if(this.filters.length === 0){
                this.filters.push({columnName:filterColumn,value:filterValue});
                refereshNeeded = true;
            }else{
                var isFound = false;
                dojo.forEach(this.filters, function(item,i){
                    if(item.columnName === filterColumn){
                        isFound = true;
                        item.value = filterValue;
                        refereshNeeded = true;
                    }
                });
                if(!isFound && filterValue !== ''){
                    this.filters.push({columnName:filterColumn,value:filterValue});
                    refereshNeeded = true;
                }
            }
            return refereshNeeded;
        }
    });

});