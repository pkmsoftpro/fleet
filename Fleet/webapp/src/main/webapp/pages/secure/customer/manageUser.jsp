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
<%@ page contentType="text/html" %>
<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="t" uri="twms" %>
<%@ taglib prefix="u" uri="/ui-ext" %>
<%@ taglib prefix="authz" uri="authz" %>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>
<html>
<head>
	<u:stylePicker fileName="adminPayment.css" />
    <title>
        <s:text name="accordion_jsp.accordionPane.customerUserMgmt"/>
    </title>
    <s:head theme="twms"/>
    <u:stylePicker fileName="form.css"/>
    <u:stylePicker fileName="warrantyForm.css"/>
    <u:stylePicker fileName="common.css"/>
    <u:stylePicker fileName="base.css"/>
    <script type="text/javascript">
        dojo.require("dijit.layout.LayoutContainer");
        dojo.require("dijit.layout.ContentPane");
        dojo.addOnLoad(function() {
            var validatableStateId = dijit.byId("validatable_state_company_new");
            var freeTextStateId = dojo.byId("free_text_state_company_new");
            var validatableCityId = dijit.byId("validatable_city_company_new");
            var freeTextCityId = dojo.byId("free_text_city_company_new");
            var validatableZipId = dijit.byId("validatable_zip_company_new");
            var freeTextZipId = dojo.byId("free_text_zip_company_new");
            var selectedVar = "<s:property value="checkForValidatableCountry(countryCode)"/>";
            dojo.html.setDisplay(validatableStateId.domNode, selectedVar);
            dojo.html.setDisplay(freeTextStateId, !selectedVar);
            dojo.html.setDisplay(validatableCityId.domNode, selectedVar);
            dojo.html.setDisplay(freeTextCityId, !selectedVar);
            dojo.html.setDisplay(validatableZipId.domNode, selectedVar);
            dojo.html.setDisplay(freeTextZipId, !selectedVar);
         });
    </script>
    <script type="text/javascript" src="scripts/validateAddress.js"></script>
    <script type="text/javascript" src="scripts/manageLists.js"></script>
</head>

<u:body>
<div dojoType="dijit.layout.LayoutContainer" style="width: 100%; height: 100%;overflow-y:auto;" id="root">
<div dojoType="dijit.layout.ContentPane" layoutAlign="client">
<s:form action="create_user" id="createUserForm" theme="twms">
<u:actionResults />
<s:hidden name="userType" value="%{userType}"></s:hidden>

<s:if test="%{userType=='CUSTOMER'}">  

<div class="section_div">
    <div class="section_heading"><s:text name="label.customerUser.createUser"/></div>
    <table class="form" cellspacing="0" cellpadding="0">
    <tr>
       <td id="dealerNameText" class="labelStyle" width="15%" nowrap="nowrap">
           <s:text name="label.common.customerName"/>:*
        </td>
      <td>
     <s:if test="%{userAdmin}">
      <sd:autocompleter id='customerCodeAutoComplete' href='list_fleet_customers.action' name='fleetCustomer' key='%{fleetCustomer.id}' keyName='fleetCustomer.id' 
                     value='%{fleetCustomer.name}' loadOnTextChange='true' loadMinimumCount='3' showDownArrow='false' indicator='indicator' />
                       <img style="display: none;" id="indicator" class="indicator"  src="image/indicator.gif" alt="Loading..."/> 
                <script type="text/javascript">
                        dojo.addOnLoad(function() {
                            dojo.connect(dijit.byId("customerCodeAutoComplete"), "onChange", function(newValue) {                      		
                                 		var fleetCustomer='<s:property value="fleetCustomer"/>'
                                 		if(fleetCustomer!==newValue)
                                 		   dojo.empty("custBody");
                                // 	});                               	
                              });
                            });
                </script>
       </s:if>
       <s:else>
          <span id="fleetCustomerName"><s:property value="%{fleetCustomer.name}"/></span>
       </s:else>
       
       </td>                 
    </tr>
    
    
    <tr >
     <u:repeatTable id="myTable" cssClass="admin_entry_table borderForTable" cellpadding="0" cellspacing="0" width="60%" theme="twms" cssStyle="margin:5px;">
            <thead>
                <tr class="admin_table_header">
                    <th width="25%" class="colHeader"><s:text name="label.common.customerLocationNumber"/></th>
                    <th width="30%" class="colHeader"><s:text name="label.common.LocationName"/></th>
                    <th width="4%" class="colHeader">
                        <u:repeatAdd id="adder" theme="twms">
                            <img id="addLocation" src="image/addRow_new.gif" border="0" style="cursor: pointer; padding-right:4px;" title="<s:text name="label.common.addRow" />" />
                       </u:repeatAdd>
                    </th>
                </tr>
            </thead>
            <u:repeatTemplate id="custBody" value="customerLocations" index="myindex" theme="twms">
                <script type="text/javascript">
                  dojo.addOnLoad(function() {
                                            dojo.subscribe("/locationDescription/show/#myindex", null, function(number, type, request) {
                                                if (type != "valuechanged") {
                                                    return;
                                                }
                                                twms.ajax.fireJavaScriptRequest("getCustomerLocation.action", {
                                                	code: number
                                                }, function(details) {
                                                    dojo.byId("customerLocationMapKey_#myindex").innerHTML = details[0];
                                              });
                                        });
                                        });
                </script>
                <tr index="#myindex">
                    <td  width="25%" style="border:1px solid #EFEBF7;" >
                  <sd:autocompleter id='customerLocationAutoComplete_#myindex'  name='customerLocations[#myindex]' value='%{customerLocations[#myindex].code}' loadOnTextChange='true' loadMinimumCount='3' 
                  keyName="customerLocations[#myindex]" key="%{customerLocations[#myindex].id}" keyValue="%{customerLocations[#myindex].id}" showDownArrow='false' indicator='indicator' notifyTopics='/locationDescription/show/#myindex' />
                  <img style="display: none;" id="indicator" class="indicator"
                        src="image/indicator.gif" alt="Loading..."/>   
                  </td>
                    <td width="30%" style="border:1px solid #EFEBF7;" >
                         <span id="customerLocationMapKey_#myindex"><s:property value="%{customerLocations[#myindex].locationsMapkey}" /></span>
                    </td>
                    <td width="4%" style="border:1px solid #EFEBF7;">
                        <u:repeatDelete id="deleter_#myindex" theme="twms">
                            <img id="deleteLocation" src="image/remove.gif" border="0" style="cursor: pointer;padding-right:4px;" title="<s:text name="button.common.delete" />"/>
                        </u:repeatDelete>
                    </td>
                 </tr>
                <script type="text/javascript">
                	dojo.addOnLoad(function (){
                		var customer = '<s:property value="%{fleetCustomer.id}"/>' ;
                		if(customer !=null)
                		  dijit.byId("customerLocationAutoComplete_#myindex").get("store").url = ("list_locations_by_customercode.action?customerId=<s:property value="%{fleetCustomer.id}"/>");  
                		if(dijit.byId("customerCodeAutoComplete")!=null)
                		 dijit.byId("customerLocationAutoComplete_#myindex").get("store").url = ("list_locations_by_customercode.action?customerId=" + dijit.byId("customerCodeAutoComplete").get("value"));
                	});
                </script>
            </u:repeatTemplate>
        </u:repeatTable>
    </tr>
   </table>
</div>
</s:if>
<s:if test="%{userType=='DEALER'}">  
<div class="section_div">
    <div class="section_heading">
        <s:text name="label.dealerUser.createUser"/>
    </div>
    <div id="technician_company_details" class="mainTitle" style="margin:10px 0px 0px 0px;">

    <div class="section_div">
        <div class="section_heading">
            <s:text name="label.technicianCertification.companiesWorkingFor"/>
        </div>
    </div>
    
<u:repeatTable id="technician_company_table" theme="twms" cellspacing="4" cellpadding="0" cssStyle="margin:5px;" width="99%">
    <thead>
        <tr class="admin_table_header">
            <th class="colHeader"><s:text name="label.technicianCertification.companyName" /></th>
            <th class="colHeader" width="9%"><u:repeatAdd id="companyAdder" theme="twms">
                <img id="addCompanyIcon" src="image/addRow_new.gif" border="0"
                    style="cursor: pointer;"
                    title="<s:text name="label.technician.addCompany" />" />
            </u:repeatAdd></th>
        </tr>
    </thead>
    <u:repeatTemplate id="companyBody" value="companiesWorkingFor" index="index" theme="twms">
         <tr index="#index">
           <td valign="top"> <sd:autocompleter id='dealerNameAutoComplete_#index' cssStyle='width:265px' href='list_dealer_names_dealer_summary.action' name='dealersForUser[#index]' value='%{name}' keyValue="%{id}" loadOnTextChange='true' loadMinimumCount='3' showDownArrow='false' indicator='indicator' listenTopics='/setDealerIdForName/onLoad/#index' /></td>
                            <script type="text/javascript">
                                dojo.addOnLoad(function() {
                                    dojo.publish("/setDealerIdForName/onLoad", [{
                                        addItem: {
                                            key:'<s:property value="%{serviceProvider.id}"/>',
                                            label:'<s:property value="%{serviceProvider.name}"/>'
                                        }
                                    }]);
                                });
                            </script>
            
            </td>
            <td valign="top"><u:repeatDelete id="deleter_#index"
                theme="twms">
                <img id="deleteCompany" src="image/remove.gif" border="0"
                    style="cursor: pointer;"
                    title="<s:text name="label.technician.deleteCompany" />" />
            </u:repeatDelete></td>
         </tr>
    </u:repeatTemplate>
    </u:repeatTable> 
</div>
</s:if>

<div class="section_div">
    <div class="section_heading"><s:text name="User Details"/></div>
    <table class="form">
     <jsp:include page="rolesDetail.jsp" flush="true"/>	            
    <tr>
      <td class="labelStyle"><s:text name="label.customerUser.firstName"/>:*</td>
      <td><s:textfield maxlength="20" size="30" name="user.firstName"/></td>
      <td class="labelStyle"><s:text name="label.common.address.line1"/>:*</td>
      <td><t:textarea name="user.address.addressLine1" id="userAddress1" cssStyle="width: 250px;height: 39px;" rows="1"/></td>
   </tr>
    <tr>
      <td class="labelStyle"><s:text name="label.customerUser.lastName"/>:*</td>
      <td><s:textfield maxlength="20" size="30" name="user.lastName"/></td>
      <td class="labelStyle"><s:text name="label.common.address.line2"/></td>
      <td><t:textarea name="user.address.addressLine2" id="userAddress2" cssStyle="width: 250px;height: 39px;" rows="1"/></td>      
   </tr>
   <tr>
    <td class="labelStyle"><s:text name="label.manageProfile.locale"/></td>
    <td>
        <s:select name="defaultLocale" list="listOfLocale"
                  id="locale" required="true" theme="twms"
                  listValue="description" listKey="locale"
                  cssStyle="width: 130px" value="%{defaultLocale}"/>

    </td>
    <td class="labelStyle"><s:text name="label.country"/></td>
   <td>   <s:select label ="Country" id="country_company_new"
                    name="user.address.country" cssStyle="width: 130px" listKey="code" listValue="name" 
                    list="countries" required="true" theme="twms"/>
               <script type="text/javascript">
			  dojo.addOnLoad(function() {
				   dojo.connect(dijit.byId("country_company_new"),"onChange", function(value) {
				   getStatesByCountry(value, dijit.byId("validatable_state_company_new"),
							  true,
							  -1,
							  [
							     "free_text_state_company_new",
							     "free_text_city_company_new",
							     "free_text_zip_company_new"
						      ],
						      [
							     "validatable_city_company_new",
							     "validatable_zip_company_new"
						      ]
						      );
				})
 			});
		       </script>
	    </td>
   </tr>
    <tr>
    <td class="labelStyle"><s:text name="label.customerUser.email"/>:*</td>
    <td><s:textfield size="30" maxlength="255" name="user.email"/></td>
    <td class="labelStyle"><s:text name="label.state"/>:*</td>
    <td>
	       <sd:autocompleter label='State' id='validatable_state_company_new' listenTopics='topic_state_company_new' name='user.address.state' />
			   <script type="text/javascript">
   				dojo.addOnLoad(function() {
				  dojo.connect(dijit.byId("validatable_state_company_new"),"onChange",function(value) {
				    getCitiesByCountryAndState(value, dijit.byId("validatable_city_company_new"),
								      true,
								      '-1',
								      [
								       "free_text_city_company_new",
								       "free_text_zip_company_new"
								      ],
								      [
								       "validatable_zip_company_new"
								      ]);
				  })
	                    });
		      </script>
	      <s:textfield id="free_text_state_company_new" name="stateCode"  style="width: 131px; margin-left: 0px;" /> 
		</td> 	
    </tr>
    <tr>
    <td class="labelStyle"><s:text name="label.common.phone"/>:*</td>
    <td><s:textfield maxLength="30" size="30" name="user.address.phone"/></td>
    <td class="labelStyle"><s:text name="label.city"/>:*</td>
    <td>
	       <sd:autocompleter label='City' id='validatable_city_company_new' listenTopics='topic_city_company_new' name='user.address.city' />
		     <script type="text/javascript">
   			 dojo.addOnLoad(function() {
			    dojo.connect(dijit.byId("validatable_city_company_new"),"onChange",function(value) {
			    getZipsByCountryStateAndCity(value, dijit.byId("validatable_zip_company_new"),
								true, '-1',
								[
								  "free_text_zip_company_new"
								]); 
			       })
	          });		     
		      </script>           
	      <s:textfield id="free_text_city_company_new" name="cityCode" style="width: 131px; margin-left: 0px;"/>      
		</td>
   </tr>
    <tr>
    <td class="labelStyle"><s:text name="label.common.fax"/>:</td>
    <td ><s:textfield maxLength="30" size="30" name="user.address.fax"/></td>
    <td class="labelStyle"><s:text name="label.zip"/>:*</td>
    <td>
             <sd:autocompleter label='Zip' id='validatable_zip_company_new' listenTopics='topic_zip_company_new' name='user.address.zipCode' />             
		      <s:textfield id="free_text_zip_company_new" name="zipCode" style="width: 131px; margin-left: 0px;"/>      
		</td>
  </tr>
 </table>
</div>


<div class="section_div">
    <div class="section_heading"><s:text name="Login Details"/></div>
    <table class="form">
       <tr>
        <td class="labelStyle"><s:text name="label.customerUser.login"/>:*</td>
        <td colspan="3"><s:textfield maxlength="20" size="30" name="user.name"/></td>
      </tr>
      <tr id="passwordTr">
        <td class="labelStyle"><s:text name="label.customerUser.password"/>:*</td>
        <td colspan="3"><s:password maxlength="20" size="30" name="user.password" value="user.password"/></td>
      </tr>
      <tr id="confirmPasswordTr">
        <td class="labelStyle"><s:text name="label.customerUser.confirmPassword"/>:*</td>
        <td colspan="3"><s:password maxlength="20" size="30" name="confirmPassword" value="confirmPassword"/></td>
      </tr>
   </table>
</div>
<div id="submit" align="center" class="spacingAtTop">
    <s:if test="%{!userCreated}" >
        <input id="submit_btn" class="buttonGeneric" type="submit" value="<s:text name='Add User'/>" onclick="selectAllOptions(this.form['list2'])"/>
    </s:if>
    <input id="cancel_btn" class="buttonGeneric" type="button" value="<s:text name='button.common.cancel'/>"
           onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));"/>
</div>


</s:form>
</div>
</div>
</u:body>
</html>