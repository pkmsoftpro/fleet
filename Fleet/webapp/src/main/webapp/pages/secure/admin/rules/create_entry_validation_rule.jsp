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
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>
<u:stylePicker fileName="adminPayment.css"/>

<html>
<head>
    <meta http-equiv="Context-Type" content="text/html; charset=ISO-8859-1">
    <title><s:text name="title.common.warranty"/></title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="common.css"/>
    <u:stylePicker fileName="form.css"/>
    <script type="text/javascript" src="scripts/ClaimForm.js"></script>
</head>
<script type="text/javascript">
    function onExpressionSelect(expressionName) {
        if (expressionName) {
            if(document.getElementById("ruleName").value=="" && document.getElementById("failureMessage").value==""){
                document.getElementById("ruleName").value = expressionName;
                document.getElementById("failureMessage").value = expressionName;
        }
    }
 }
    dojo.addOnLoad(function() {
        if('<s:property value="ruleApplicable"/>'!='Dealer Owned')
        {
        dojo.html.hide(dojo.byId("dealers"));
        }
    });
</script>
<u:body>
<u:actionResults/>
<form name="baseForm" id="baseForm" method="POST">
<s:hidden name="dealerNumberSelected" id="isDealerNumber"/>
<div class="policyRegn_section_div">
	<div class="admin_section_heading">
    	<s:text name="label.manageBusinessRule.createNewEntryRule"/>
 	</div>
    <table width="98%" border="0" cellspacing="0" cellpadding="0" class="grid">
        <tr>
            <td height="19" colspan="2" nowrap="nowrap" class="labelStyle">
                <s:text name="label.manageBusinessRule.ruleNumber"/>
            </td>
            <td width="28%" height="19" class="labelNormal">
                <s:textfield name="ruleNumber" cssClass="txtField" id="ruleNumber"/>
            </td>
            <td width="70%"></td>
        </tr>
		 <tr>
            <td height="3" colspan="3"></td>
        </tr>
        <tr>
            <td height="19" colspan="2" nowrap="nowrap" class="labelStyle">
                <s:text name="label.manageBusinessRule.ruleName"/>
            </td>
            <td width="70%" height="19" class="labelNormal">
                <s:textfield name="ruleName" cssClass="txtField" id="ruleName"/>
            </td>
            <td width="28%"></td>
        </tr>
        <tr>
            <td height="3" colspan="3"></td>
        </tr>
        <tr>
            <td height="19" colspan="2" nowrap="nowrap" class="labelStyle">
                <s:text name="label.manageBusinessRule.failureMessage"/>
            </td>

            <td width="70%" height="19" class="labelNormal">
                <s:textfield name="failureMessage" cssClass="txtField"
                             id="failureMessage"/>
            </td>
         </tr>
         <tr>
            <td height="3" colspan="3"></td>
        </tr>
          <tr>
            <td height="19" colspan="2" nowrap="nowrap" class="labelStyle">
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
            <td height="19" colspan="2" nowrap="nowrap" class="labelStyle">
                            
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
            <td height="19" colspan="2" nowrap="nowrap" class="labelStyle">
                <s:text name="label.manageBusinessRule.ruleGroup"/>:
            </td>
            <td height="29" class="labelNormal">
                <s:select name="ruleGroups" emptyOption="false" 
                    list="ruleGroupsInContext" listKey="id" listValue="name"/>
             </td>
           			
          </tr>
        </s:if>
         <tr>
            <td height="3" colspan="3"></td>
        </tr>
         <tr>
            <s:if test="searchProcessed">
             <div class="admin_selections">
                <s:if test="!predicates.isEmpty()">
            <td class="label"><s:text name="columnTitle.manageBusinessRule.businessAction"/></td>
            <td width="28%"></td>
            <td style="border-bottom:1px solid #FCF9F3;">
                <select name="selectedAction" id="action">
                    <s:iterator value="actions">
                        <option value="<s:property value="id"/>" selected="selected"><s:property
                                value="name"/></option>
                    </s:iterator>
                </select>
             </td>
               	</s:if>
              </div> 
             </s:if>
        </tr>
        <tr>
            <td height="3" colspan="2"></td>
        </tr>
    </table>
    <div id="separator"></div>
    <div class="admin_section_div" style="width:99%">

        
        <div class="colHeader" style="height: 30px;">
                <s:text name="label.manageBusinessRule.searchBusinessConditions"/>:
                <s:textfield name="name"/>
                <s:submit cssClass="buttonGeneric" action="search_predicates_for_new_entry_validation_rule"
                          value="%{getText('button.common.search')}"/>
            </div>

            <s:if test="searchProcessed">
            <div class="admin_selections">
                <s:if test="!predicates.isEmpty()">
                    <table cellspacing="0" cellpadding="0" class="grid borderForTable">
                        <tr>
                            <td class="colHeader" >&nbsp;</td>
                            <td class="colHeader" ><s:text
                                    name="columnTitle.manageBusinessRule.businessCondition"/></td>
                        </tr>
                        <s:iterator value="predicates">
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
                <s:else>
                    <jsp:include page="emptySearchResultsMessage.jsp"/>
                </s:else>
            </div>
                </s:if>
 
    </div>
</div>
<div class="spacingAtTop" align="center">
            <s:reset cssClass="buttonGeneric"
                     value="%{getText('button.common.reset')}"/>
            <s:submit cssClass="buttonGeneric" action="save_entry_validation_rule"
                      value="%{getText('button.manageBusinessRule.addBusinessRule')}"/>
        </div>
</form>
</u:body>
</html>
