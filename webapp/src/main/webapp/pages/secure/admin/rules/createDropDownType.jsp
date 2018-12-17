 
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>
 			<s:if test="fieldName=='Call Type'">
		    	     <tr><td class="label"><s:text name="fieldName"/>:</td>
		    	     <td><s:select  name="selectedUpdateCriteria[%{#staus.index}].value" emptyOption="true" 
                          list="manageCallTypesList" listKey="listOfValues.id" listValue="listOfValues.description"/></td>
		    	     </tr>
		    </s:if>
		    <s:if test="fieldName=='Component Code'">
		    	     <tr><td class="label"><s:text name="fieldName"/>:</td>
		    	     <td><s:select  name="selectedUpdateCriteria[%{#staus.index}].value" emptyOption="true" 
                          list="componentcodesList" listKey="id" listValue="description"/></td>
		    	     </tr>
			</s:if>
			
		    <s:if test="fieldName=='Approved number of travel trips'">
		    	   	 <tr><td class="label"><s:text name="fieldName"/>:</td>
		    	     <td><s:select  name="selectedUpdateCriteria[%{#staus.index}].value" emptyOption="true" 
                          list="numberOfTravelTrips" cssStyle="width:55px"/></td>
		    	     </tr>
		    </s:if>
		    <s:if test="fieldName=='Dealer Failure'">
		    	   	 <tr><td class="label"><s:text name="fieldName"/>:</td>
		    	     <td><s:select theme="simple" name="selectedDealerFailureCodes" 
                          cssStyle="width:200px;" list="dealerFailureCodesList" listKey="id" listValue="description"  multiple="true" value="selectedDealerFailureCodes" /></td>
		    	     </tr>
		    </s:if>
		    <s:if test="fieldName=='Fault Found'">
		    	   	 <tr><td class="label"><s:text name="fieldName"/>:</td>
		    	     <td><s:select theme="twms"  name="selectedUpdateCriteria[%{#staus.index}].value" 
                         list="faultFoundCodes" listKey="id" listValue="name"  emptyOption="true" id="faultFound" requiredLabel='false'/>
                        <script type="text/javascript">
		                    dojo.addOnLoad(function() {	
		                    	var faultFound = dijit.byId("faultFound");
		                        faultFound.fireOnLoadOnChange=true;
		                        dojo.connect(faultFound, "onChange", function(newValue) {
		                            dojo.publish("/causedBy/modified", [{
		                            	 url: "list_caused_by_using_faultFound.action",
		                                 params: {
		                                	 "faultFoundId" : newValue
		                                 },
		                                 makeLocal: true
		                            }]);
		                        });
		                    });
                      </script>  
                         
                     </td>
                         
		    	     </tr>
		    </s:if>
		    <s:if test="fieldName=='Caused By'">
		    	   	 <tr><td class="label"><s:text name="fieldName"/>:</td>
		    	     <td><sd:autocompleter id="causedByAutoCompleter"  
                          emptyOption="true" name='causedBy' value='%{causedBy.name}' keyName="causedBy" key="%{causedBy.id}" listenTopics="/causedBy/modified" requiredLabel='false'  />
                          <img style="display: none;" id="indicator" class="indicator"
                            src="image/indicator.gif" alt="Loading..."/> 
                            
                      </td>
                         
		    	     </tr>
		    </s:if>
		    <s:if test="fieldName=='Causal Part Number'">
		    	   	 <tr><td class="label"><s:text name="fieldName"/>:</td>
		    	     <td><sd:autocompleter   href='list_casualPartNumbers.action' name='causalPart' value='%{causalPart.itemNumber}' keyName="causalPart" key="%{causalPart.id}" loadOnTextChange='true' loadMinimumCount='3' showDownArrow='false' indicator='indicator' 
		    	     requiredLabel='false' />
                        <img style="display: none;" id="indicator" class="indicator"
                            src="image/indicator.gif" alt="Loading..."/> </td>
		    	     </tr>
		    </s:if>
		                        					
    			
		    
		  
		   