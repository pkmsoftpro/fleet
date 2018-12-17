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
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>



<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Context-Type" content="text/html; charset=ISO-8859-1"/>
        <title>:: <s:text name="title.common.warranty" /> ::</title>
        <s:head theme="twms"/>
        <u:stylePicker fileName="detailDesign.css"/>
        <u:stylePicker fileName="yui/reset.css" common="true"/>
        <u:stylePicker fileName="common.css"/>
        <u:stylePicker fileName="claimForm.css"/>
        <u:stylePicker fileName="base.css"/>
        <u:stylePicker fileName="adminPayment.css"/>
        <style type="text/css">
            .addRow {
                margin-top: -14px;
                height: 14px;
                text-align: right;
                padding-right: 17px;
            }
        </style>
    </head>
    <script type="text/javascript" src="scripts/ui-ext/common/tabs.js"></script>
    <script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dijit.layout.ContentPane");
        function closeCurrentTab() {
            closeTab(getTabHavingId(getTabDetailsForIframe().tabId));
        }
    </script>
    <u:actionResults/>
    <u:body>
        <div dojoType="dijit.layout.LayoutContainer" layoutAlign="client"
             style="overflow-X: auto; overflow-Y: auto; width:100%; height: 100%">
            <div dojoType="dijit.layout.ContentPane" style="overflow-X: auto; overflow-Y: auto; width:99%; height: 99%">
                <s:form action="attributes_create" name="attributeForm" theme="twms" id="attributeForm">
                    <s:hidden name="showI18nButton" value="true"/>
                    <div class="admin_section_div" style="margin:5px;width:99%">
                        <div class="admin_section_heading"><s:text name="title.additionalAtrribute.attributeDetails" /></div>

                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="grid"  style="margin-top:5px;">


                            <s:hidden name="additionalAttributes" value="%{additionalAttributes.id}"></s:hidden>
                           <tr>
                            <s:if test="additionalAttributes == null || additionalAttributes.id == null || additionalAttributes.id == 0">
                                <%-- <tr> --%>
                                    <td  width="10%"  class="label">
                                        <s:text name="label.additionalAttribute.name"/>
                                    </td>
                                    <td  class="labelNormal">
                                        <s:textfield name="localizedFailureMessages_en_US" value="%{additionalAttributesName}"/>     
                                    </td>
                                </s:if>      			
                                <s:else>
                                    <td width="20%" class="label" ><s:text name="label.additionalAttribute.name"/>:</td> 
                                    <td><s:property value="additionalAttributes.attributeName"/>
                                        <s:hidden name="localizedFailureMessages_en_US" value="%{additionalAttributes.name}"/>
                                        <s:hidden name="id" value="%{additionalAttributes.id}" />
                                    </td>
                                    <td>
                                        <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                                                   id="additionalAttributeName" 
                                                   tabLabel="%{getText('label.common.internationalize')}"
                                                   url="../internationalizeAttributeName.action?additionalAttributes=%{additionalAttributes.id}"
                                                   catagory="inventory">
                                            <s:text name="label.common.internationalize" />
                                        </u:openTab>
                                    </td>
                                </s:else>

                            </tr> 
                            <tr>
                                <td width="10%" class="label">
                                    <s:text name="label.additionalAttribute.attributeType"></s:text>:
                                </td>
                                <td width="20%" class="labelNormal">
                                        <s:select  name= "additionalAttributes.attributeType" list="{'Number','Text','Text Area','Date','Single Select'}"  id="attributeTypeId" onchange='showSingleSelectValues();'/>
                                </td>
                            </tr>
                            
                             <tr>
                                 <td width="10%" class="label">
                                        <s:text name="label.additionalAttribute.dropDown"></s:text>:
                                  </td>
                                   <td  class="labelNormal">
                                          <s:textarea name="text"  id="singleSelectOptions"     theme="simple"
                                                name="additionalAttributes.singleSelectValues"
                                                value="%{additionalAttributes.singleSelectValues}" cssStyle="width:250px;" disabled="true" />
                                                 <div class="twmsActionResultsMessages "><s:text name="label.additionalAttribute.selectedValues"/>
                                             </div>
                                    </td>
                                </tr>

                            <tr>
                                <td width="10%"  class="label">
                                    <s:text name="label.additionalAttribute.purpose"></s:text>:
                                </td>
                                <td width="20%" class="labelNormal">
                                    <s:if test="additionalAttributes == null || additionalAttributes.id == null || 
                                          (additionalAttributes.id != null && additionalAttributes.id==0)">
                                        <s:select name= "attributePurpose" list="{'Claim','Inventory Additional Info'}" value="%{additionalAttributes.attributePurpose.purpose}" onchange="showCustomerSection(this.value);"/>
                                    </s:if>
                                     <script type="text/javascript">
                                     dojo.addOnLoad(function() {
                                     if('<s:property value="additionalAttributes.attributePurpose.purpose"/>')
                                    	 {
                                    	 showCustomerSection('<s:property value="additionalAttributes.attributePurpose.purpose"/>');
                                    	 }
                                     });
								                function showCustomerSection(value)
								                {
								                	if(value!='Inventory Additional Info')
								                		{
								                		dojo.html.show(dojo.byId("customer"));
								                		dojo.html.show(dojo.byId("customerLocation"));
								                		dojo.html.show(dojo.byId("product"));
								                		}
								                	else 
								                		{
								                		dojo.html.hide(dojo.byId("customer"));
								                		dojo.html.hide(dojo.byId("customerLocation"));
								                		dojo.html.hide(dojo.byId("product"));
								                		}
								                }
											</script>
                                    <s:else>
                                        <s:property value="additionalAttributes.attributePurpose.purpose"/>
                                    </s:else>
                                </td>
                            </tr>   
                      <tr style="display:none" id="product"> 
			        	<td width="10%"  class="label">
			        		<s:text name="label.attribute.product"></s:text>:
			        	</td>
			        	<td  width="20%" class="labelNormal">
			        	 	<sd:autocompleter href="list_products.action" id='productAutoComplete'  name='additionalAttributes.product' value='%{additionalAttributes.product.name}' loadOnTextChange='true'
			        	 	 loadMinimumCount='3' keyName="additionalAttributes.product" key="%{additionalAttributes.product.id}" keyValue="%{additionalAttributes.product.id}" showDownArrow='false' indicator='indicator'/>
			         		<img style="display: none;" id="indicator" class="indicator"
			             		src="image/indicator.gif" alt="Loading..."/> 
			             </td>
			        </tr>
			               
                    <tr style="display:none" id="customer">
		        	<td  width="10%"  class="label">
		        		<s:text name="label.manageBusinessRule.customer"></s:text>
		        	</td>
		        	<td  width="20%" class="labelNormal">
		        		<sd:autocompleter id='customerNameAutoComplete' href='list_customers.action' name='additionalAttributes.fleetCustomer' value='%{additionalAttributes.fleetCustomer.name}' loadOnTextChange='true' 
		        		loadMinimumCount='3' keyName="additionalAttributes.fleetCustomer" key="%{additionalAttributes.fleetCustomer.id}" keyValue="%{additionalAttributes.fleetCustomer.id}" showDownArrow='false' indicator='indicator' />
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
			        	<td width="10%"  class="label">
			        		<s:text name="label.manageBusinessRule.customerLocation"></s:text>
			        	</td>
			        	<td  width="20%" class="labelNormal">
			        	 	<sd:autocompleter href="list_customerLocation.action" id='customerLocationAutoComplete'  name='additionalAttributes.customerLocation' value='%{additionalAttributes.customerLocation.locationsMapkey}'
			        	 	 loadOnTextChange='true' loadMinimumCount='3' keyName="additionalAttributes.customerLocation" key="%{additionalAttributes.customerLocation.id}" 
			        	 	 keyValue="%{additionalAttributes.customerLocation.id}" showDownArrow='false' indicator='indicator' listenTopics="/customer/modified"/>
			         		<img style="display: none;" id="indicator" class="indicator"
			             		src="image/indicator.gif" alt="Loading..."/> 
			             </td>
			        </tr>

                            <tr>
                                <td  width="10%" class="label">
                                    <s:text name="label.additionalAttribute.mandatory"></s:text>:
                                </td>
                                <td width="5%" class="labelNormal">
                                    <s:radio name= "additionalAttributes.mandatory" list="yesNo" listKey="key" listValue="value" />
                                </td>
                            </tr>

                        </table></div>
                    <div align="center" style="margin-top:10px;">
					<authz:ifPermitted resource="additionalAttributes">
						<s:submit cssClass="buttonGeneric" name="button.common.submit" />&nbsp;
                        <s:if
							test="additionalAttributes != null || additionalAttributes.id != null || additionalAttributes.id != 0">
							<s:submit cssClass="buttonGeneric"
								value="%{getText('button.common.delete')}"
								action="attributes_delete" />&nbsp;	
                        </s:if>
					</authz:ifPermitted>
					<input type="button" value="<s:text name='Cancel' />" class="buttonGeneric" onClick="closeCurrentTab();" />

                    </div>
                    <script type="text/javascript">
                       dojo.addOnLoad(function() {
                    	  if(dojo.byId("attributeTypeId").value == 'Single Select') {
                              dojo.byId("singleSelectOptions").disabled=false;
                          }
                        });
                        function showSingleSelectValues() {
                        if(dojo.byId("attributeTypeId").value == 'Single Select') {
                             dojo.byId("singleSelectOptions").disabled=false;
                         }else{
                        	 dojo.byId("singleSelectOptions").disabled=true; 
                         }
                        }
                   </script>
                </s:form>
            </div>
        </div>
    </u:body>