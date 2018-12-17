	<%@ taglib prefix="s" uri="/struts-tags" %>
	<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>
	<s:if test="updateCriteria.fieldName=='Call Type'">
		    	     <tr><td class="labelStyle"><s:text name="updateCriteria.fieldName"/>:</td>
		    	     <td><s:select  name="rule.selectedUpdateCriteria[%{#staus.index}].value" emptyOption="true" 
                          list="manageCallTypesList" listKey="listOfValues.id" listValue="listOfValues.description"/></td>
		    	     </tr>
	</s:if>
	<s:if test="updateCriteria.fieldName=='Component Code'">
		    	     <tr><td class="labelStyle"><s:text name="updateCriteria.fieldName"/>:</td>
		    	     <td><s:select  name="rule.selectedUpdateCriteria[%{#staus.index}].value" emptyOption="true" 
                          list="componentcodesList" listKey="id" listValue="description"/></td>
		    	     </tr>
    </s:if>
  
    <s:if test="updateCriteria.fieldName=='Approved number of travel trips'">
		    	   	 <tr><td class="labelStyle"><s:text name="updateCriteria.fieldName"/>:</td>
		    	     <td><s:select  name="rule.selectedUpdateCriteria[%{#staus.index}].value" emptyOption="true" 
                          list="numberOfTravelTrips" cssStyle="width:55px"/></td>
		    	     </tr>
	</s:if>
	<s:if test="updateCriteria.fieldName=='Dealer Failure'">
		    	   	 <tr><td class="labelStyle"><s:text name="updateCriteria.fieldName"/>:</td>
		    	     <td><s:select name="selectedDealerFailureCodes" 
                          cssStyle="width:200px;" list="dealerFailureCodesList" listKey="id" listValue="description"  multiple="true" value="selectedDealerFailureCodes" /></td>
		    	     </tr>
    </s:if>
	<s:if test="updateCriteria.fieldName=='Fault Found'">
		    	 	<tr><td class="labelStyle"><s:text name="updateCriteria.fieldName"/>:</td>
		    	     <td><s:select theme="twms" name="rule.selectedUpdateCriteria[%{#staus.index}].value" 
                         list="faultFoundCodes" listKey="id" listValue="name"  emptyOption="true" id="faultFound" requiredLabel="false"/>
                        <script type="text/javascript">
		                    dojo.addOnLoad(function() {	
		                    	var faultFound = dijit.byId("faultFound");
		                        faultFound.fireOnLoadOnChange=true;
		                        dojo.connect(faultFound, "onChange", function(newValue) {
		                            dojo.publish("/causedBy/modified", [{
		                            	 url: "manage_list_caused_by_using_faultFound.action",
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
	<s:if test="updateCriteria.fieldName=='Caused By'">
		    	   	 <tr><td class="labelStyle"><s:text name="updateCriteria.fieldName"/>:</td>
		    	     <td><sd:autocompleter  id="causedBy"  name='causedBy' value='%{causedBy.name}' keyName="causedBy" key="%{causedBy.id}" 
                          emptyOption="true" listenTopics="/causedBy/modified"  requiredLabel="false"/></td>
		    	     </tr>
	</s:if>
	<s:if test="updateCriteria.fieldName=='Causal Part Number'">
		    	   	 <tr><td class="labelStyle"><s:text name="updateCriteria.fieldName"/>:</td>
		    	     <td><sd:autocompleter  id='casualPartNumber' href='list_casualPartNumbers.action' name='causalPart' value='%{causalPart.itemNumber}' keyName="causalPart" key="%{causalPart.id}"    loadOnTextChange='true' loadMinimumCount='3' showDownArrow='false' indicator='indicator' requiredLabel="false"/>
                        <img style="display: none;" id="indicator" class="indicator"
                            src="image/indicator.gif" alt="Loading..."/> </td>
		    	     </tr>
	</s:if>
		     
		  
		   			
 					