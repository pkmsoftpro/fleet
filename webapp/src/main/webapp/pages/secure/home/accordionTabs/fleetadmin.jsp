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

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%@taglib prefix="authz" uri="authz"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>
<div dojoType="dijit.layout.ContentPane" id="fleetadminaccordion"
    title="<s:text name="accordion_jsp.accordionPane.fleetadmin" />"
    iconClass="myclaims fleet-admin-icon" <authz:ifUserNotInRole roles="admin">selected="true"</authz:ifUserNotInRole>>
    <div dojoType="dijit.layout.ContentPane">
		<ol>
            <authz:ifPermitted resource="businessConfigReadOnlyView">
                <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="list_bu_config" tagType="li"
                    tabLabel="label.fleetadmin.BuAdminConfig" url="../manageBUConfiguration.action" catagory="admin"
                    cssClass="warrantyAdmin_folder folder" helpCategory="Warranty_Admin/Manage_Business_Configurations.htm">
                    <s:text name="label.fleetadmin.manageBusinessConfigurations" />
                </u:openTab>
            </authz:ifPermitted>
		</ol>
		<ol>
		   <authz:ifPermitted resource="serviceCodesReadOnlyView">
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
				id="servicecodeaccdordian" tagType="li"
				cssClass="fleetAdmin_folder folder"
				tabLabel="label.fleetadmin.manageservicecode"
				url="listServiceCodes?folderName=Manage Service Code" catagory="fleetadmin"
				helpCategory="fleetadmin/manageservicecode.htm">
				<s:text name="label.fleetadmin.manageservicecode" />
			</u:openTab>			
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
				id="inclusivecodeaccordian" tagType="li"
				cssClass="fleetAdmin_folder folder"
				tabLabel="label.fleetadmin.inclusiveservicecodes"
				url="inclusiveservicecodesview" catagory="fleetadmin"
				helpCategory="fleetadmin/manageservicecode.htm">
				<s:text name="label.fleetadmin.inclusiveservicecodes" />
			</u:openTab>
			</authz:ifPermitted>
   	    </ol>
        <ol>
           <authz:ifPermitted resource="errorCodesReadOnlyView">
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="alarm_code_list" tagType="li"
                cssClass="warrantyAdmin_folder folder"
                tabLabel="%{getText('label.alarmCode.ManageAlarmCode')}"
                url="../alarm_code_list.action?folderName=ALARMCODE"
                catagory="admin" helpCategory="Warranty_Admin/Manage_Alarm_Code.htm">
                <s:text name="label.alarmCode.ManageAlarmCode" />
                </u:openTab>
            </authz:ifPermitted>
            
            <!-- Manage Program Guide Summary -->
            
             <authz:ifPermitted resource="manageProgramGuideSummary">
            <u:fold label="%{getText('accordionLabel.fleetAdmin.manageProgramGuideSummary')}"
                id="manage_pgs" tagType="li" cssClass="uFoldStyle folder"
                foldableClass="foldableManageProgramGuideSummary"/>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_cpgs" tagType="li" 
                cssClass="fleetAdmin_folder folder foldableManageProgramGuideSummary sublist"
                tabLabel="%{getText('accordionLabel.programGuideSummary.customer')}"
                url="listCustomerProgramGuideSummaries?folderName=CustomerPGS"
                catagory="fleetadmincustomer" helpCategory="">
                <s:text name="accordionLabel.programGuideSummary.customer" />
            </u:openTab>
            
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_dpgs" tagType="li" 
                cssClass="fleetAdmin_folder folder foldableManageProgramGuideSummary sublist"
                tabLabel="%{getText('accordionLabel.programGuideSummary.dealer')}"
                url="listDealerProgramGuideSummaries?folderName=DealerPGS"
                catagory="fleetadmindealer" helpCategory="">
                <s:text name="accordionLabel.programGuideSummary.dealer" />
            </u:openTab>
            </authz:ifPermitted>
            <!-- Manage Pricing Conditions Accordion -->
            <authz:ifPermitted resource="pricingConditionsReadOnlyView">
            <u:fold label="%{getText('accordionLabel.fleetAdmin.priceConditions')}"
                id="manage_prices" tagType="li" cssClass="uFoldStyle folder"
                foldableClass="foldableManagePrices"/>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_price_CustomerList" tagType="li"
                cssClass="fleetAdmin_folder folder foldableManagePrices sublist"
                tabLabel="%{getText('title.managePrice.customerPrice')}"
                url="listCustomerPrices?folderName=Customer"
                catagory="admin" helpCategory="fleetadmin/managePrice/customerPriceConditions.htm">
                <s:text name="accordionLabel.managePrices.customerPricingConditions" />
            </u:openTab>            
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_price_dealerList" tagType="li"
                cssClass="fleetAdmin_folder folder foldableManagePrices sublist"
                tabLabel="%{getText('title.managePrice.dealerPrice')}"
                url="listDealerPrices?folderName=Dealer"
                catagory="admin" helpCategory="fleetadmin/managePrice/dealerPriceConditions.htm">
                <s:text name="accordionLabel.managePrices.dealerPricingConditions" />
            </u:openTab>
            </authz:ifPermitted>
	    </ol>
        <authz:ifPermitted resource="businessRulesReadOnlyView">
        <ol>
	    <!-- Manage Business Rule Groups Accordion  -->
            <u:fold
                label="%{getText('accordionLabel.manageBusinessRuleGroups')}"
                id="manage_domain_rule_groups_folder" tagType="li" cssClass="uFoldStyle folder"
                foldableClass="foldableDomainRuleGroups" />
             <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_claim_processing_rule_groups" tagType="li"
                cssClass="warrantyAdmin_folder folder foldableDomainRuleGroups sublist"
                tabLabel="%{getText('title.manageBusinessRuleGroup.claimsProcessing')}"
                url="../list_rule_groups.action?context=FleetClaimRules" catagory="admin" helpCategory="Warranty_Admin/Manage_Business_Rule_Groups.htm">
                <s:text name="accordionLabel.manageBusinessRuleGroup.ClaimRules" />
            </u:openTab>
<%--             <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_claim_processor_routing_rule_groups" tagType="li"
                cssClass="warrantyAdmin_folder folder foldableDomainRuleGroups sublist"
                tabLabel="%{getText('title.manageBusinessRuleGroup.claimProcessorRouting')}"
                url="../list_rule_groups.action?context=ClaimProcessorRouting" catagory="admin" helpCategory="Warranty_Admin/Manage_Business_Rule_Groups.htm">
                <s:text name="accordionLabel.manageBusinessRule.ClaimProcessorRouting" />    
            </u:openTab> --%>
	    </ol>

        <ol>
        <!-- Manage Business Rules Accordion  -->
            <u:fold
                label="%{getText('accordionLabel.manageBusinessRules')}"
                id="manage_domain_rules_folder" tagType="li" cssClass="uFoldStyle folder"
                foldableClass="foldableDomainRules" />
             <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
               id="manage_claim_processing_rules" tagType="li"
               cssClass="warrantyAdmin_folder folder foldableDomainRules sublist"
               tabLabel="%{getText('title.manageBusinessRule.claimProcessing')}"
               url="../list_domain_rules.action?context=FleetClaimRules" catagory="admin" helpCategory="Warranty_Admin/Business_Rules.htm">
               <s:text name="accordionLabel.manageBusinessRule.ClaimRules" />
            </u:openTab>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_service_request_entry_validation_rules" tagType="li"
                cssClass="warrantyAdmin_folder folder foldableDomainRules sublist"
                tabLabel="%{getText('title.manageBusinessRule.entryValidationServiceRequest')}"
                url="../list_entry_validation_rules.action?context=ServiceRequestEntryValidationRules" catagory="admin" helpCategory="Warranty_Admin/Business_Rules.htm">
                <s:text name="accordionLabel.manageBusinessRule.ServiceRequestEntryValidationRules" />
            </u:openTab>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_quote_entry_validation_rules" tagType="li"
                cssClass="warrantyAdmin_folder folder foldableDomainRules sublist"
                tabLabel="%{getText('title.manageBusinessRule.entryValidationQuote')}"
                url="../list_entry_validation_rules.action?context=QuoteEntryValidationRules" catagory="admin"
                helpCategory="Warranty_Admin/Business_Rules.htm">
                <s:text name="accordionLabel.manageBusinessRule.quoteEntryValidationRules" />
            </u:openTab>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manage_claim_entry_validation_rules" tagType="li"
                cssClass="warrantyAdmin_folder folder foldableDomainRules sublist"
                tabLabel="%{getText('title.manageBusinessRule.claimEntryValidation')}"
                url="../list_entry_validation_rules.action?context=ClaimEntryValidationRules" catagory="admin"
                helpCategory="Warranty_Admin/Business_Rules.htm">
                <s:text name="accordionLabel.manageBusinessRule.claimEntryValidationRules" />
            </u:openTab>
    <%--         <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
	            id="manage_claim_processor_routing" tagType="li"
	            cssClass="warrantyAdmin_folder folder foldableDomainRules sublist"
	            tabLabel="%{getText('title.manageBusinessRule.claimProcessorRouting')}"
	            url="../list_claim_processor_routing_rules.action?context=ClaimProcessorRouting" catagory="admin" helpCategory="Warranty_Admin/Business_Rules.htm">
	            <s:text name="accordionLabel.manageBusinessRule.ClaimProcessorRouting" />
	        </u:openTab> --%>
        </ol>
        <ol>
            <!-- Manage Business Conditions Accordion -->
            <u:fold label="%{getText('accordionLabel.manageBusinessConditions')}"
                id="manage_business_cond_folder" tagType="li" cssClass="uFoldStyle folder"
                foldableClass="foldableBusinessConditions" />
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_rules" tagType="li"
                cssClass="fleetAdmin_folder folder foldableBusinessConditions sublist"
                tabLabel="%{getText('title.serviceRequest.manageBusinessCondition')}"
                url="../list_expressions.action?context=ServiceRequestEntryValidationRules"
                catagory="admin" helpCategory="Warranty_Admin/Business_Conditions.htm">
                <s:text name="accordionLabel.serviceRequest.manageBusinessCondition" />
            </u:openTab>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_quote_rules" tagType="li"
                cssClass="fleetAdmin_folder folder foldableBusinessConditions sublist"
                tabLabel="%{getText('accordionLabel.quote.manageBusinessCondition')}"
                url="../list_expressions.action?context=QuoteEntryValidationRules"
                catagory="admin" helpCategory="Warranty_Admin/Business_Conditions.htm">
                <s:text name="accordionLabel.quote.manageBusinessCondition" />
            </u:openTab>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_claims_rules" tagType="li"
                cssClass="fleetAdmin_folder folder foldableBusinessConditions sublist"
                tabLabel="%{getText('accordionLabel.manageBusinessCondition.claims')}"
                url="../list_expressions.action?context=FleetClaimRules"
                catagory="admin" helpCategory="Warranty_Admin/Business_Conditions.htm">
                <s:text name="accordionLabel.manageBusinessCondition.claims" />
            </u:openTab>
        </ol>
      </authz:ifPermitted>
        <!-- List Of Values (LOV) Accordion  -->
        <authz:ifPermitted resource="listOfValuesReadOnlyView">
	    <ol>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_lovs" tagType="li" cssClass="warrantyAdmin_folder folder"
                tabLabel="%{getText('title.listOfValues')}"
                url="../list_lov_type.action" catagory="admin" helpCategory="Warranty_Admin/List_of_Values.htm">
                <s:text name="accordionLabel.listOfValues"/>
            </u:openTab>
        </ol>
        </authz:ifPermitted>
           <authz:ifPermitted resource="manageCallType">
        <ol>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_callTypes" tagType="li" cssClass="warrantyAdmin_folder folder"
                tabLabel="%{getText('title.callTypes')}"
                url="../listCallTypes.action" catagory="admin" helpCategory="Warranty_Admin/List_of_Values.htm">
                <s:text name="accordionLabel.manageCallTypes"/>
            </u:openTab>
        </ol>
        </authz:ifPermitted>
        <authz:ifPermitted resource="manageCompetitorInfo">        
	    <ol>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_competitorInfo" tagType="li" cssClass="warrantyAdmin_folder folder"
                tabLabel="%{getText('title.competitorInfo')}"
                url="../listCompetitorInformation.action" catagory="admin" helpCategory="Warranty_Admin/List_of_Values.htm">
                <s:text name="accordionLabel.manageCompetitorInfo"/>
            </u:openTab>
        </ol>
        </authz:ifPermitted>
        
        <authz:ifPermitted resource="additionalAttributesReadOnlyView">
        <ol>
            <!-- Additional Attributes Accordion -->
        	<u:fold label="%{getText('accordionLabel.manageAdditionalAttributes')}"
                id="attribute_management" tagType="li"
                cssClass="uFoldStyle folder" foldableClass="foldableAttributeManagement" />
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_attributes" tagType="li"
                cssClass="warrantyAdmin_folder folder foldableAttributeManagement sublist"
                tabLabel="%{getText('title.manageAdditionalAttributes.manageAttributes')}"
                url="../list_attributes.action"
                catagory="admin" helpCategory="Warranty_Admin/Create_Update_Attributes.htm">
                <s:text name="accordionLabel.manageAttributes.createUpdateAttr" />
            </u:openTab>
        </ol>
        </authz:ifPermitted>
      
        <!-- Manage User Availability -->
        <authz:ifPermitted resource="userAvailabilityReadOnlyView">
        <ol>
            <u:fold
                label="%{getText('title.user.manageAvail')}"
                id="manage_user_availability_folder" tagType="li" cssClass="uFoldStyle folder"
                foldableClass="foldableProcessAvail" />

            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_user_avail_fss" tagType="li" cssClass="warrantyAdmin_folder folder foldableProcessAvail sublist"
                tabLabel="%{getText('title.user.manageAvail.fss')}"
                url="../showUserAvailability.action?role=fleetServiceSpecialist&selectedBusinessUnit=%{warrantyAdminSelectedBusinessUnit}" catagory="admin"
                helpCategory="Warranty_Admin/Manage_User_Availability.htm">
                <s:text name="accordionLabel.user.manageAvailability.fss" />
            </u:openTab>

            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="manage_user_avail_processor" tagType="li" cssClass="warrantyAdmin_folder folder foldableProcessAvail sublist"
                tabLabel="%{getText('title.user.manageAvail.fleetProcessor')}"
                url="../showUserAvailability.action?role=fleetProcessor&selectedBusinessUnit=%{warrantyAdminSelectedBusinessUnit}" catagory="admin"
                helpCategory="Warranty_Admin/Manage_User_Availability.htm">
                <s:text name="accordionLabel.user.manageAvailability.fleetProcessor" />
            </u:openTab>
        </ol>
        </authz:ifPermitted>
    
        <!-- Manage Inventory Labels -->        
        <ol>
        <authz:ifPermitted resource="labels">
        <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="create_label_for_Fleet_Inventory" tagType="li"
            tabLabel="%{getText('title.fleetInventory.createLabel')}" url="../new_search_expression.action?context=InventorySearches&isCreateLabelForInventory=true"
            catagory="admin" cssClass="warrantyAdmin_folder folder" helpCategory="Warranty_Admin/View_Labels.htm">
            <s:text name="title.fleetInventory.createLabel" />
        </u:openTab>
        </authz:ifPermitted>
       <authz:ifPermitted resource="labelsReadOnlyView">       
        <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" id="manageLabels" tagType="li" tabLabel="%{getText('label.common.viewLabels')}"
            url="../manageLabels.action" catagory="admin" cssClass="warrantyAdmin_folder folder" helpCategory="Warranty_Admin/View_Labels.htm">
            <s:text name="label.common.viewLabels" />
        </u:openTab>
        </authz:ifPermitted>    
         </ol>
        <!-- Manage LOA SCHEME -->                          <!-- THIS IS HIDED BECAUSE WE ARE USING LOA-SET UP FROM CUSTOMER PAGE -->
        <%-- <authz:ifPermitted resource="loaSchemesReadOnlyView">
		<ol>
			<u:fold label="%{getText('accordionLabel.manageLoaSchemes')}"
				id="manage_loa_schemes" tagType="li" cssClass="uFoldStyle folder"
				foldableClass="foldableManageLOAScheme" />
			<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
				id="processor_loa_schemes" tagType="li"
				cssClass="warrantyAdmin_folder folder foldableManageLOAScheme sublist"
				tabLabel="%{getText('accordionLabel.processorLoaSchemes')}"
				url="../list_loa_schemes.action" catagory="admin"
				helpCategory="Warranty_Admin/Manage_LOA_Schemes.htm">
				<s:text name="accordionLabel.processorLoaSchemes" />
			</u:openTab>
		</ol>
		</authz:ifPermitted>
         --%>
	</div>   
</div>
