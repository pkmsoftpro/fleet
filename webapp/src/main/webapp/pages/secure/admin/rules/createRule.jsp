<%--

   Copyright (c)2006 Tavant Technologies
   All Rights Reserved.

   This software is furnished under a license and may be used and copied
   only  in  accordance  with  the  terms  of such  license and with the
   inclusion of the above copyright notice. This software or  any  other
   copies thereof may not be provided or otherwise made available to any
   other person. No title to and ownership of  the  software  is  hereby
   transferred.

   The information in this software is subject to change without  notice
   and  should  not be  construed as a commitment  by Tavant Technologies.

--%>

<%@ taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>

 

<html>
<head>
    <title><s:text name="title.common.warranty" /></title>    
    <s:head theme="twms" />
	<u:stylePicker fileName="adminPayment.css"/>
	<script type="text/javascript">
        dojo.require("twms.widget.Select");
  </script>
	
<script type="text/javascript">
    function onExpressionSelect(expressionName) {
        if (expressionName) {
            document.getElementById("ruleName").value = expressionName;
            document.getElementById("failureMessage").value = expressionName;
        }
    }
    dojo.addOnLoad(function() {
        if('<s:property value="ruleApplicable"/>'!='Dealer Owned')
        {
        dojo.html.hide(dojo.byId("dealers"));
        }
    });
</script>
    <u:stylePicker fileName="common.css"/>
    <u:stylePicker fileName="form.css"/>
    <script type="text/javascript" src="scripts/ClaimForm.js"></script>
</head>
<u:body>
<u:actionResults/>
<s:form name="baseForm" id="baseForm" method="POST" >
<s:hidden name="context" />
<s:hidden name="dealerNumberSelected" id="isDealerNumber"/>
<div class="policyRegn_section_div" style="width:99%;">
	<div class="admin_section_heading">
    	<s:text name="label.manageBusinessRule.createNewProcessingRule"/>
 	</div>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="grid">
         <tr>
            <td height="19" class="label" width="48%">
                <s:text name="label.manageBusinessRule.ruleNumber"/>
            </td>
            <td class="labelNormal" width="48%">
                <s:textfield name="ruleNumber" id="ruleNumber" size="30" />
            </td>            
        </tr>
        <tr>
            <td height="19" class="label" width="48%">
                <s:text name="label.manageBusinessRule.ruleName"/>
            </td>
            <td height="19" class="labelNormal" >
                <s:textfield name="ruleName" id="ruleName" size="50"/>
            </td>
        </tr>
        <tr>
            <td height="19" class="label" width="48%">
                <s:text name="label.manageBusinessRule.failureMessage"/>
            </td>
            <td  height="19" class="labelNormal" align="left" >
                <s:textfield name="failureMessage" id="failureMessage" size="50"/>
            </td>
        </tr>
        <tr>
            <td height="3" colspan="3"></td>
        </tr>
          <tr>
            <td class="label" width="48%" height="19">
                <s:text name="label.manageBusinessRule.ruleApplicable"/>:
            </td>
            <td height="29" class="labelNormal">
                <s:select id="fleetUserType" name="ruleApplicable" emptyOption="false" 
                    list="listFleetUsers" listKey="fleetUserType" listValue="displayFleetUserType" onchange="displayDealers()"/>
                    <script type="text/javascript">
            function displayDealers()
            {
                if(dojo.byId('fleetUserType')){
                    var value=dojo.byId('fleetUserType').value;
                    if(value=='Dealer Owned')
                     {
                        dojo.byId('dealerNameAutoComplete').value=null;
                        dojo.byId('dealerNumberAutoComplete').value=null;
                        dojo.html.show(dojo.byId("dealers"));
                     }
                    else
                     {
                        dojo.html.hide(dojo.byId("dealers"));
                     }
                }
            }
             </script> 
             </td>
                    
          </tr>
        <tr>
            <td height="3" colspan="3"></td>
        </tr>
        <tr id='dealers'>
            <td class="label" width="48%" height="19">
                            
                <div id="dealerNameLabel" class="labelStyle">
                    <s:text name="label.common.dealerName"/>
                 </div>
                  <div id="dealerNumberLabel" class="labelStyle">
                     <s:text name="label.common.dealerNumber"/>:
                 </div> 
                 <div id="toggle" style="cursor:pointer;">
                     <div id="toggleToDealerNumber" class="clickable">
                         <s:text name="toggle.common.toDealerNumber" />
                     </div>
                     <div id="toggleToDealerName" class="clickable">
                         <s:text name="toggle.common.toDealerName"/>
                     </div>
                 </div>
            </td>
              <td height="19" colspan="2" nowrap="nowrap" class="labelStyle"> 
                <div id="dealerName">
                        <sd:autocompleter id='dealerNameAutoComplete' href='listServiceProviders_for_rules.action?' name='chosenDealer' value='%{chosenDealer.name}' loadOnTextChange='true' loadMinimumCount='1' keyName="chosenDealer" key="%{chosenDealer.id}" keyValue="%{chosenDealer.id}" showDownArrow='false' indicator='indicator' />
                        <img style="display: none;" id="indicator" class="indicator"
                            src="image/indicator.gif" alt="Loading..."/>                                                
                        <script type="text/javascript">
                                dojo.addOnLoad(function() {
                                    dojo.connect(dijit.byId("dealerNameAutoComplete"), "onChange", function(newValue) {
                                        dojo.publish("/dealer/modified", [{
                                            params: {
                                                "dealerName" : newValue
                                            }
                                        }]);
                                    });
                                });
                            </script> 
                    </div>
                    <div id="dealerNumber">
                        <sd:autocompleter id='dealerNumberAutoComplete' href='listServiceProviderByNumber_for_rules.action?' name='chosenDealer' value='%{chosenDealer.serviceProviderNumber}' keyName="chosenDealer" key="%{chosenDealer.id}" keyValue="%{chosenDealer.id}" loadOnTextChange='true' loadMinimumCount='1' showDownArrow='false' indicator='indicator' />
                        <img style="display: none;" id="indicator" class="indicator"
                            src="image/indicator.gif" alt="Loading..."/>
                            
                        <script type="text/javascript">
                                dojo.addOnLoad(function() {
                                    dojo.connect(dijit.byId("dealerNumberAutoComplete"), "onChange", function(newValue) {
                                        dojo.publish("/dealer/modified", [{
                                            params: {
                                                "dealerName" : newValue
                                            }
                                        }]);
                                    });
                                });
                            </script>  
                        <script type="text/javascript">
                        dojo.addOnLoad(function() {
                            <s:if test="dealerNumberSelected">
                             showDealerNumber();
                          </s:if>
                          <s:else>
                              showDealerName();
                          </s:else>
                    
                            dojo.connect(dojo.byId("toggleToDealerName"), "onclick", function() {
                                dijit.byId('dealerNumberAutoComplete').setValue("");
                                showDealerName();
                            });
                            dojo.connect(dojo.byId("toggleToDealerNumber"), "onclick", function() {
                                dijit.byId('dealerNameAutoComplete').setValue("");
                               showDealerNumber();
                            });                          
                        });
                    </script>
                </div></td>
        </tr>
            <tr>
            <td height="3" colspan="3"></td>
        </tr>
        <s:if test="doesContextUseRuleGroup()">
        <tr>
            <td height="19" nowrap="nowrap" class="label" width="48%">
                <s:text name="label.manageBusinessRule.ruleGroup"/>:
            </td>
            <td height="29" class="labelNormal">
                <%-- Do not remove the toString() used in the  value="..". This is to bypass the weird issue that it
                  was formatting the value using comma (i.e. 1400 was getting printed as 1,400)! --%>
                <s:select theme="twms" name="ruleGroup" emptyOption="false" value="%{ruleGroup.id.toString()}" 
                    list="ruleGroupsInContext" listKey="id" listValue="name"/>
            </td>
        </tr>
        </s:if>
        <s:if test="actions.size>1">
        <tr>
        	<td class="label" width="48%"><s:text name="columnTitle.manageBusinessRule.businessAction"/>:</td>
            <td style="border-bottom:1px solid #FCF9F3;">
             
                 <s:select id="action" theme="twms" name="selectedAction" emptyOption="false" list="actions" listKey="id" listValue="name"  onchange="displayUpdateCriteria()"/>
                <script type="text/javascript"> 
                function displayUpdateCriteria()
                {
                	if(dojo.byId('action')){
                		var value=dojo.byId('action').value;
                    	if(value=='Accept Claim')
                    		{
                    		dojo.html.show(dojo.byId("updateCriteria"));
                    		dojo.html.hide(dojo.byId("rejectionLabel"));
                    		dojo.html.show(dojo.byId("customer"));
                    		dojo.html.show(dojo.byId("customerLocation"));
                    		}
                    	else if(value=='Reject Claim')
                    		{
                    		dojo.html.hide(dojo.byId("updateCriteria"));
                    		dojo.html.show(dojo.byId("rejectionLabel"));
                    		dojo.html.hide(dojo.byId("customer"));
                    		dojo.html.hide(dojo.byId("customerLocation"));
                    		}
                    	else{
                    		dojo.html.hide(dojo.byId("customer"));
                    		dojo.html.hide(dojo.byId("customerLocation"));
                    		dojo.html.hide(dojo.byId("updateCriteria"));
                    		dojo.html.hide(dojo.byId("rejectionLabel"));
                    	}
                	}
                	
                }
				</script>
            </td>
         </tr>
         </s:if>
         
         <tr style="display:none" id="customer">
        	<td  class="label" width="48%">
        		<s:text name="label.manageBusinessRule.customer">:</s:text>
        	</td>
        	<td>
        		<sd:autocompleter id='customerNameAutoComplete' href='list_customers.action' name='fleetCustomer' value='%{fleetCustomer.name}' loadOnTextChange='true' loadMinimumCount='3' keyName="fleetCustomer" key="%{fleetCustomer.id}" keyValue="%{fleetCustomer.id}" showDownArrow='false' indicator='indicator' requiredLabel='false' />
                        <img style="display: none;" id="indicator" class="indicator"
                            src="image/indicator.gif" alt="Loading..."/>                            					
    				<script type="text/javascript">
		                    dojo.addOnLoad(function() {
		                        dojo.connect(dijit.byId("customerNameAutoComplete"), "onChange", function(newValue) {
		                            dojo.publish("/customer/modified", [{
		                                params: {
		                                    "fleetCustomer" : newValue
		                                }
		                            }]);
		                        });
		                    });
                      </script>  
        	</td>
        </tr>
        <tr style="display:none" id="customerLocation"> 
        	<td class="label" width="48%">
        		<s:text name="label.manageBusinessRule.customerLocation">:</s:text>
        	</td>
        	<td>
        		<sd:autocompleter href="list_customerLocation.action" id='customerLocationAutoComplete'  name='customerLocation' value='%{customerLocation.locationsMapkey}' loadOnTextChange='true' loadMinimumCount='3' keyName="customerLocation" key="%{customerLocation.id}" keyValue="%{customerLocation.id}" showDownArrow='false' indicator='indicator' listenTopics="/customer/modified" requiredLabel='false' />
         		<img style="display: none;" id="indicator" class="indicator"
             		src="image/indicator.gif" alt="Loading..."/>   
        	</td>
        </tr>
         
          <tr style="display:none" id="rejectionLabel">
            <td class="label">
		    	<s:text name="Rejection Reasons"/>:
		     </td>
		      <td height="29" class="labelNormal" id="rejectionList">
                 <s:select id="rejectionReason" emptyOption="true" name="rejectedReason"  list="listOfRejectionReasons" listKey="id" listValue="description"/>
             </td>
             </tr>
             </table>
              <div  class="policy_section_div" style="width:99%; vertical-align: central;display:none" id="updateCriteria">
              <div class="colHeader" style="height: 24px; padding-top: 8px;">
		    	<s:text name="Update Criteria" />
		    	</div>
		    	  <table cellspacing="0" id ="updateCriteria_Table" cellpadding="0" class="grid borderForTable" align="center" style="padding-bottom:10px;">
		    	   <s:iterator value="updateCriteria" status="staus" >
		    	   
		    	   	 <s:hidden name="selectedUpdateCriteria[%{#staus.index}].updateCriteria.id" value="%{id}"></s:hidden>
		    	   	 <s:hidden name="selectedUpdateCriteria[%{#staus.index}].updateCriteria.fieldName" value="%{fieldName}"></s:hidden>
		    	   	 <s:hidden name="selectedUpdateCriteria[%{#staus.index}].updateCriteria.fieldType" value="%{fieldType}"></s:hidden>
		    	   
		    	    <s:if test="fieldType=='text'">
		    	   	 <tr><td class="label"><s:text name="fieldName"/>:</td>
		    	          <td><s:textfield name="selectedUpdateCriteria[%{#staus.index}].value"  id="text_#staus.index"/></td>
		    	     </tr>
		    	    </s:if>
		    	    <s:if test="fieldType=='textarea'">
		    	   	 <tr><td class="label"><s:text name="fieldName"/>:</td>
		    	          <td><s:textarea name="selectedUpdateCriteria[%{#staus.index}].value" cssStyle="width:60%;"/></td>
		    	     </tr>
		    	    </s:if>
		    	    <s:if test="fieldType=='object'">
		    	   		<%@include file="createDropDownType.jsp"%>
		    	    </s:if>
		    	    <s:if test="fieldType=='addrow'">
		    	    	<%@include file="createAddRowType.jsp"%>
		    	    </s:if>
		    	    
	               
		    	</s:iterator>
		    </table>
      </div>

    <div class="policy_section_div" style="width:99%;vertical-align: central">
        <div class="colHeader" style="height: 30px;">
                <s:text name="label.manageBusinessRule.searchBusinessConditions"/>:
                <s:textfield name="name"/>
                <s:submit cssClass="buttonGeneric" action="search_predicates_for_new_rule"
                          value="%{getText('button.common.search')}"/>
            </div>

            
                <s:if test="!predicates.empty">
                    <table cellspacing="0" cellpadding="0" class="grid borderForTable" align="center" style="padding-bottom:10px;">
                       
                        <tr>
                        	<th class="colHeader" >&nbsp;</th>
                            <th class="colHeader" ><s:text
                                    name="columnTitle.manageBusinessRule.businessCondition"/></th>                                                        
                        </tr>
                        <tr><td style="padding:0">&nbsp;</td></tr>
                      <s:iterator value="predicates" status="status">
                            <tr>
                                <td class="admin_selections" style="border-bottom:1px solid #FCF9F3;">
                                    <s:if test= "predicateid==id" >
                                    <input type="radio" name="id"
                                           value="<s:property value="id"/>"
                                           alt="<s:property value="name"/>"
                                           onclick="onExpressionSelect(this.alt)" checked/>
                                </s:if>
                                <s:else>
                                    <input type="radio" name="id"
                                           value="<s:property value="id"/>"
                                           alt="<s:property value="name"/>"
                                           onclick="onExpressionSelect(this.alt)"/>
                                </s:else>
                                </td>
                                <td class="admin_selections" style="border-bottom:1px solid #FCF9F3;">
                                    <s:property value="name"/>
                                </td>
                                
                          </tr>
                          
                        </s:iterator> 
                       
                    </table>
                </s:if>
              <s:if test="searchProcessed && predicates.empty">
                    <jsp:include page="emptySearchResultsMessage.jsp"/>
                </s:if> 
    </div>
</div>  
<div align="center" class="spacingAtTop">
     <s:reset cssClass="buttonGeneric"
                 value="%{getText('button.common.reset')}"  />
	 <s:submit cssClass="buttonGeneric" action="save_domain_rule"
                  value="%{getText('button.manageBusinessRule.addBusinessRule')}"/>
</div>
</s:form>
</u:body>
</html>
