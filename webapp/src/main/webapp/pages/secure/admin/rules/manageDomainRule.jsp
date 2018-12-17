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
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>
<%@taglib prefix="authz" uri="authz"%>
<%response.setHeader( "Pragma", "no-cache" );
response.addHeader( "Cache-Control", "must-revalidate" );
response.addHeader( "Cache-Control", "no-cache" );
response.addHeader( "Cache-Control", "no-store" );
response.setDateHeader("Expires", 0); %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Context-Type" content="text/html; charset=ISO-8859-1"/>
    <title><s:text name="title.common.warranty"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="adminPayment.css"/>
    <u:stylePicker fileName="base.css"/>
    <u:stylePicker fileName="common.css"/>
    <script type="text/javascript" src="scripts/ClaimForm.js"></script>
    <script type="text/javascript">    
        function deActivateRule() {
          var formObj = dojo.byId("baseForm");
          dojo.byId('activeFlagInd').value="INACTIVE";
          formObj.action = "update_domain_rule.action";
          formObj.submit();
        }
        
        dojo.addOnLoad(function() {
            if('<s:property value="ruleApplicable"/>'!='Dealer Owned')
            {
                dojo.html.hide(dojo.byId("dealers"));
            }
        });
        
    </script>
    <style>
    .bgColor td{
    padding-bottom:10px;
    }
    </style>
</head>
<u:body>
<u:actionResults/>
<s:form name="baseForm" id="baseForm">
<s:hidden name="dealerNumberSelected" id="isDealerNumber"/>

<div class="policyRegn_section_div">
	<div class="admin_section_heading">
    	<s:text name="label.manageBusinessRule.ruleDetails"/>
 	</div>
	<table width="97%" border="0" cellspacing="0" cellpadding="0" class="bgColor">
	   
	    <tr>
	        <td height="19"  class="labelStyle">
	            <s:text name="label.manageBusinessRule.ruleNumber"/>
	        </td>
	        <td  height="19" class="labelNormal" align="left">
	            <s:textfield  name="rule.ruleNumber" cssClass="txtField" readonly = "true" id="ruleNumber"
                              cssStyle="font-weight: normal" size="50"/>
	            <s:hidden name="context" />
	        </td>
	    </tr>
	    <tr>
	        <td height="19"  class="labelStyle">
	            <s:text name="label.manageBusinessRule.version"/>
	        </td>
	        <td  height="19" class="labelNormal" align="left">
	            <s:label  name="ver" value="%{rule.version+1}"  />
	        </td>
	    </tr>

	    <tr >
	        <td height="19" class="labelStyle">
	            <s:text name="label.manageBusinessRule.ruleName"/>
	        </td>
	        <td height="19" class="labelNormal">
	            <s:textfield name="ruleAuditName" cssStyle="font-weight: normal" cssClass="txtField" id="ruleName"
                             value="%{ruleAudit.name}" size="50"/>
	        </td>
	    </tr>

	    <tr>
	        <td height="19"  class="labelStyle">
	            <s:text name="label.manageBusinessRule.failureMessage"/>
	        </td>
	        <td height="19" class="labelNormal">
	            <s:textfield name="ruleAuditFailureMessage" cssClass="txtField" cssStyle="font-weight: normal"
	                         id="failureMessage" value="%{ruleAudit.failureMessage}" size="50"/>
	        </td>
	    </tr>
        <tr>
            <td height="19" nowrap="nowrap" class="labelStyle">
                <s:text name="label.manageBusinessRule.priority"/>:
            </td>
            <td height="19" class="labelNormal">
                <s:property value="rule.priority" />
            </td>
        </tr>
        <s:if test="doesContextUseRuleGroup()">
        <tr>
            <td height="19" nowrap="nowrap" class="labelStyle">
                <s:text name="label.manageBusinessRule.ruleGroup"/>:
            </td>
            <td height="19" class="labelNormal">
                <%-- Do not remove the toString() used in the  value="..". This is to bypass the weird issue that it
                  was formatting the value using comma (i.e. 1400 was getting printed as 1,400)! --%>
                <s:select name="ruleGroup" theme="twms" value="%{rule.ruleGroup.id.toString()}"
                          list="ruleGroupsInContext" listKey="id" listValue="name"/>
            </td>
        </tr>
        </s:if>
        <tr >
	        <td height="19"  class="labelStyle">
	            <s:text name="label.manageBusinessRule.comment"/>
	        </td>
	        <td height="19" class="labelNormal">
	        <s:if test="hasActionErrors()">
	          <s:textfield name="rule.d.internalComments" cssClass="txtField" cssStyle="font-weight: normal"
	                         id="comments"  value="%{rule.d.internalComments}" size="50"/>
	                         </s:if>
	                         <s:else>
	            <s:textfield name="rule.d.internalComments" cssClass="txtField" cssStyle="font-weight: normal"
	                         id="comments"  value="" size="50"/></s:else>
	        </td>
	    </tr>
        
         <tr>
            <td height="19" nowrap="nowrap" class="labelStyle">
                <s:text name="label.manageBusinessRule.ruleApplicable"/>:
            </td>
            <td height="19" class="labelNormal">
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

             
        <tr id='dealers'>
            <td height="19" nowrap="nowrap" class="labelStyle">
                            
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
        
	    <tr >
	    <td height="19"  class="labelStyle">
	            <s:text name="columnTitle.manageBusinessRule.businessAction"/>:
	        </td>
	      <td height="19" class="labelNormal">
	               <s:select theme="twms" name="actionId" id="action1" emptyOption="false" list="actions" listKey="id" listValue="name"  onchange="displayUpdateCriteria()"/>
               
	                 <script type="text/javascript">
	                 dojo.addOnLoad(function(){
               				displayUpdateCriteria();
	                 });
                function displayUpdateCriteria()
                {
                	if(dojo.byId('action1')){
                		var value=dojo.byId('action1').value;
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
	   
	    <tr style="display:none" id="customer">
        	<td  class="labelStyle" width="48%">
        		<s:text name="label.manageBusinessRule.customer">:</s:text>
        	</td>
        	<td class="labelNormal">
        		<sd:autocompleter id='customerNameAutoComplete'  href='manage_list_customers.action' name='rule.fleetCustomer' value='%{rule.fleetCustomer.name}' loadOnTextChange='true' loadMinimumCount='3' keyName="rule.fleetCustomer" key="%{rule.fleetCustomer.id}" keyValue="%{rule.fleetCustomer.id}" showDownArrow='false' indicator='indicator' requiredLabel="false" />
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
        	<td class="labelStyle" width="48%">
        		<s:text name="label.manageBusinessRule.customerLocation">:</s:text>
        	</td>
        	<td class="labelNormal">
        		<sd:autocompleter href="manage_list_customerLocation.action" id='customerLocationAutoComplete'  name='rule.customerLocation' value='%{rule.customerLocation.locationsMapkey}' loadOnTextChange='true' loadMinimumCount='3' keyName="rule.customerLocation" key="%{rule.customerLocation.id}" keyValue="%{rule.customerLocation.id}" showDownArrow='false' indicator='indicator' listenTopics="/customer/modified" requiredLabel="false"/>
         		<img style="display: none;" id="indicator" class="indicator"
             		src="image/indicator.gif" alt="Loading..."/>   
        	</td>
        </tr>
        
	    <tr style="display:none" id="rejectionLabel">
            <td class="labelStyle">
		    	<s:text name="Rejection Reasons"/>:
		     </td>
		      <td height="29" class="labelNormal" id="rejectionList">
                 <s:select emptyOption="true" name="rejectedReason"  list="listOfRejectionReasons" listKey="id" listValue="description" id="rejectedReason"/>
             </td>
            
             </tr>
	</table>
	  <div  class="policy_section_div" style="width:99%; vertical-align: central;display:none" id="updateCriteria">
              <div class="colHeader" style="height: 24px; padding-top: 8px;">
		    	<s:text name="Update Criteria" />
		    	</div>
		    	  <table cellspacing="0" cellpadding="0" class="grid borderForTable" align="center" style="padding-bottom:10px;">
		    	   <s:iterator value="rule.selectedUpdateCriteria" status="staus">
			    	   <s:hidden name="rule.selectedUpdateCriteria[%{#staus.index}].id" value="%{id}"></s:hidden>
			    	   
			    	   <s:if test="updateCriteria.fieldType=='text'">
			    	   	  <tr><td class="labelStyle"><s:text name="updateCriteria.fieldName"/>:</td>
			    	     	 <td><s:textfield name="rule.selectedUpdateCriteria[%{#staus.index}].value" /></td>
			    	     </tr>
			    	    </s:if>
			    	   
			    	  	<s:if test="updateCriteria.fieldType=='object'">
			    	   		<%@include file="manageDropdownType.jsp"%>
			    	    </s:if>
			    	   	<s:if test="updateCriteria.fieldType=='textarea'">
			    	   	 <tr><td class="labelStyle"><s:text name="updateCriteria.fieldName"/>:</td>
			    	          <td><s:textarea name="rule.selectedUpdateCriteria[%{#staus.index}].value" cssStyle="width:60%;"/></td>
			    	     </tr>
			    	    </s:if>
			    	    
			    	    <s:if test="updateCriteria.fieldType=='addrow'">
			    	    	<%@include file="manageAddRowType.jsp"%>
			    	    </s:if>
		    	   
		    		</s:iterator>
		    	  </table>
              </div>
	 <div  class="policy_section_div" style="width:99%; vertical-align: central;display:none" id="updateCriteria">
              <div class="colHeader" style="height: 24px; padding-top: 8px;">
		    	<s:text name="Update Criteria" />
		    	</div>
              </div>
	<div>
	<div id="seperator"></div>
	<div class="admin_section_div">
    	<div class="admin_section_heading">
        	<s:text name="label.manageBusinessRule.businessCondition"/>
    	</div>
    	<table class="grid borderForTable" cellspacing="0" cellpadding="0">
	        <tr align="left">
	            
	            <td width="20%" class="labelStyle"><s:text name="columnTitle.manageBusinessRule.expression"/>:</td>
	            <td class="labelNormal">
	            <s:property value="rule.predicate.name"/></td>
	        </tr>

    	</table>
    	<s:hidden name="id" value="%{rule.id}"/>
    	<s:hidden name="activeFlag" value="ACTIVE" id="activeFlagInd"/>    	
    	<s:hidden name="ruleId" value="%{ruleId}" />
    </div>
	</div>
</div>
<div>
<%@ include file="include_rule_audit_history.jsp" %>
</div>
<div style="width:100%;">
<table width="100%" cellspacing="0" cellpadding="0" bgcolor="white">
<authz:ifPermitted resource="manageBusinessRules"> 
    <tr>
        <td align="center" >        
           	<s:if test='"INACTIVE".equals(rule.status)'>           
            	<s:submit cssClass="buttonGeneric"
                      value="%{getText('button.manageBusinessRule.activate')}"
                      action="update_domain_rule"/>
            </s:if>
            <s:else>
            	<s:submit cssClass="buttonGeneric"
                      value="%{getText('button.manageBusinessRule.updateRule')}"
                      action="update_domain_rule"/>
                 <input type="button" class="buttonGeneric"
                      value="<s:text name="button.manageBusinessRule.deActivate"/>" onclick="deActivateRule()"/>
            </s:else>
           <s:if test='context.equals("ClaimRules")'>
             <s:submit id="i18nFailureMsg" cssClass="buttonGeneric" action="save_i18n_failure_messages"
                      value="%{getText('button.manageBusinessRule.addI18nFailureMessages')}"/>
             <s:submit id="i18nRuleDescrpt" cssClass="buttonGeneric" action="save_i18n_Rule_Description"
                      value="%{getText('button.manageBusinessRule.addI18nRuleDescription')}"/>
           </s:if>
           <s:if test='context.endsWith("EntryValidationRules")'>
             <s:submit id="i18nFailureMsgasd" cssClass="buttonGeneric" action="save_i18n_failure_messages"
                      value="%{getText('button.manageBusinessRule.addI18nFailureMessages')}"/>
             <s:submit id="i18nRuleDescription" cssClass="buttonGeneric" action="save_i18n_Rule_Description"
                      value="%{getText('button.manageBusinessRule.addI18nRuleDescription')}"/>
           </s:if>
           
        </td>
    </tr>
</authz:ifPermitted>
</table>
</div>

</s:form>
</u:body>
</html>