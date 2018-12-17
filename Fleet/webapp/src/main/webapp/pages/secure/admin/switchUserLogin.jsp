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
<%--
  @author ravikumar.y
--%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>
<%@ taglib prefix="tda" uri="twmsDomainAware" %>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<script type="text/javascript">
  dojo.addOnLoad(function() {	
 
    dojo.connect(dojo.byId("SwitchUserButton"),"onclick",function() {
    dojo.publish("/attribute/hide"); 
 });
    
    var btnSwitchUser = dojo.byId("SwitchUserButton");
    
    var validationTopicSwitchUser = "/policyDefn/addDealer";
    
    var _switchUserNameAutoComplete=dijit.byId("switchUserNameAutoComplete");
    
    _switchUserNameAutoComplete.setValidationNotificationTopics(validationTopicSwitchUser);
    
    dojo.subscribe(validationTopicSwitchUser, function(message) {
   	 btnSwitchUser.disabled = !message.isValid;
    });
    dojo.connect(dojo.byId("switchuser"), "onclick",
            function() {
   	    
   	    btnSwitchUser.disabled = true;
				 });
 });  
</script>
 <s:form name="buForm" action="../switch_user" method="get">
<table width="100%" border="0" cellspacing="6" cellpadding="6"   class="header">
    <tr style="height: 34px;">
      <td width="20%" class="labelNormal" style="text-align:center"><s:label value="%{getText('label.login')}"/></td>
          <td>
               <sd:autocompleter
				id='switchUserNameAutoComplete' href='../list_switch_users.action'
				name='j_username' loadOnTextChange='true' loadMinimumCount='2'
				showDownArrow='false'/>
         </td>
	</tr>
	<tr></tr>
    <tr>
     <td  width="20%"></td>
     <td>
        <s:submit cssClass="buttonGeneric" value="%{getText('home_jsp.accordionPane.switchUser')}" id="SwitchUserButton"
         style="border-left-width: 1px; margin-left: 38px;"></s:submit>	
     </td>
    </tr>        
  </table>          
</s:form>
