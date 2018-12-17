<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="s" uri="/struts-tags" %>

		<s:if test="updateCriteria.fieldName=='Standard Periodic Service Codes'">
		    		<tr><td colspan="2">
			    	     <u:repeatTable id="manage_standard_service_rule_table" cssClass="grid borderForTable" width="97%">
							    <thead>
							       <tr class="row_head">
						            <th width="15%"><s:text name="label.quote.standardServices"/></th>
						            
						            <th width="10%">
	                                <u:repeatAdd id="manage_standard_service_rule_adder"  theme="twms">
	                                 <img id="manage_addStandardService" src="image/addRow_new.gif" border="0" style="cursor: pointer;" title="<s:text name="label.common.addRow"/>"/>
	                                </u:repeatAdd></th>
						          </tr>
							    </thead>
		                     	<u:repeatTemplate id="manage_standard_service_rule_body"  value="standardServiceList" index="index" theme="twms">
		                          <tr index="#index">
		                            <td><sd:autocompleter  href='list_manage_standard_services.action' name='standardServiceList[#index].value' 
							            value='%{standardServiceList[#index].value}' 
							           loadOnTextChange='true' loadMinimumCount='3' showDownArrow='false' indicator='indicator' delay='500' />
							        </td> 
						          	<td><u:repeatDelete id="manage_standard_service_rule_deleter_#index" theme="twms">
										<img id="manage_deletestandard_service_rule" src="image/remove.gif" border="0"
											style="cursor: pointer;"
											title="<s:text name="label.common.deleteRow" />" />
										</u:repeatDelete>
									</td>            
		                         </tr>
		                        </u:repeatTemplate> 
		                     </u:repeatTable>
	                     </td>
	                    </tr>
	    </s:if> 
	    
	   <s:if test="updateCriteria.fieldName=='Labor Job Code'">
		<tr>
			<td colspan="2">
				<u:repeatTable id="manage_Labor_Job_CodeTable" cssClass="grid borderForTable" width="35%">
					<thead>
						<tr class="row_head">
						    <th width="25%"><s:text name="label.quote.laborJobCode"/></th>
						    <th width="10%">
	                           <u:repeatAdd id="labor_Job_rule_adder"  theme="twms">
	                              <img id="manage_AddLaborJob" src="image/addRow_new.gif" border="0" style="cursor: pointer;" title="<s:text name="label.common.addRow"/>"/>
	                           </u:repeatAdd>
	                        </th>
						 </tr>
					</thead>
					<u:repeatTemplate id="manage_Labor_job_body"  value="serviceProcDefList" index="index" theme="twms">
		                          <tr index="#index">
		                            <td><sd:autocompleter id='manage_labor_rule_job_#index' href='list_Manage_Labor_JobCodes.action' name='serviceProcDefList[#index].value' 
							            value='%{serviceProcDefList[#index].value}'
							           loadOnTextChange='true' loadMinimumCount='3' showDownArrow='false' indicator='indicator' delay='500' />
							        </td> 
						          	<td><u:repeatDelete id="manage_labor_Job_Code_deleter_#index" theme="twms">
										<img id="manage_delete_labor_Job_Code" src="image/remove.gif" border="0"
											style="cursor: pointer;"
											title="<s:text name="label.common.deleteRow" />" />
									</u:repeatDelete></td>            
		                         </tr>
		            </u:repeatTemplate>
		         </u:repeatTable>
			</td>
		</tr>
	</s:if>