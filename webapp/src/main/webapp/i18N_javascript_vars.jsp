<%--This jsp is meant to hold the internationalized values of all javascript variables, which are to be used as
	TabLabels and other things like that, where the value can't be internationalized otherwise. This will act as
	a common place for such variables(used as keys).
	The file will have to be included in all the jsps, where the value for these keys are required.--%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%-- IMPORTANT : Please make sure that the i18N variables are added in the list in alphabetical order. --%>
<script type="text/javascript">
    var i18N = {
    common_by :						"<s:text name="label.common.by"/>",
    create_lov :                    "<s:text name="title.listOfValues.createLov"/>",
    create_lr_configuration :       "<s:text name="title.manageRates.createLabourRate"/>",
    create_tr_configuration :       "<s:text name="title.manageRates.createTravelRate"/>",
    delete_item_price_modifier:     "<s:text name="button.common.delete"/>",
    delete_lr_configuration :       "<s:text name="button.common.delete"/>",
    delete_partDefinition :         "<s:text name="button.common.delete"/>",
    delete_payment_modifier :       "<s:text name="button.common.delete"/>",
    delete_tr_configuration :       "<s:text name="button.common.delete"/>",
    duplicateClaimCheck_rhsPrefix : "<s:text name="label.manageBusinessCondition.rhsPrefix"/>",
    expressionEditor_operator_all : "<s:text name="dropdown.manageBusinessCondition.all"/>",
    expressionEditor_operator_any : "<s:text name="dropdown.manageBusinessCondition.any"/>",
    home_tab_label :                "<s:text name="home_jsp.tabs.home"/>",
    new_domainrule :                "<s:text name="title.manageBusinessRule.newBusinessRule"/>",
    new_competitorInformation :		"<s:text name="title.manageBusinessRule.newCompetitorInformation"/>",
    new_expression:                 "<s:text name="title.manageBusinessCondition.newBusinessCondition"/>",
    invalidConditionsWhileSaving:   "<s:text name="error.manageBusinessCondition.invalidConditionsWhileSaving"/>",
    saveFailed:                     "<s:text name="error.manageBusinessCondition.saveFailed"/>",
    new_ServiceCode : 			    "<s:text name="title.common.createservicecode"/>",
    new_loaScheme : 			    "<s:text name="title.common.createloaScheme"/>",
    new_createServiceRequest : 		"<s:text name="label.newServiceRequest.createServiceRequest"/>",
    numbers :	{
        "0" : "<s:text name="label.common.numberZero"/>",
        "1" : "<s:text name="label.common.numberOne"/>",
        "2" : "<s:text name="label.common.numberTwo"/>",
        "3" : "<s:text name="label.common.numberThree"/>",
        "4" : "<s:text name="label.common.numberFour"/>",
        "5" : "<s:text name="label.common.numberFive"/>",
        "6" : "<s:text name="label.common.numberSix"/>",
        "7" : "<s:text name="label.common.numberSeven"/>",
        "8" : "<s:text name="label.common.numberEight"/>",
        "9" : "<s:text name="label.common.numberNine"/>"
    },
    summary_table_hide :            "<s:text name="label.common.hide"/>",
    summary_table_show :            "<s:text name="label.common.show"/>",
    new_policy :		            "Create Policy",
    create_attribute:				"<s:text name="button.manageAttributes.create"/>",
    create_alarm_code :             "<s:text name="label.alarmcode.createAlarmCode"/>",
    serial_number : 			    "<s:text name="label.common.serialNumber"/>",
    part_number : 			        "<s:text name="label.common.partNumber"/>",
    quantity : 		            	"<s:text name="label.common.quantity"/>",
    description :        			"<s:text name="label.common.description"/>",
    unitPrice : 			        "<s:text name="label.inventory.unitPrice" />",
    common_yes     :                "<s:text name="label.common.yes" />",
    common_no     :                 "<s:text name="label.common.no" />",
    common_confirm :                "<s:text name="label.common.confirm" />",
    common_confirmMsg :             "<s:text name="label.common.confirmMessage" />"
};

function getI18NNumber(/*int*/ number) {
    var returnNumber = "";
    number = ("" + number);
    for(var i = 0; i < ("" + number).length; i++) {
        returnNumber += i18N.numbers[number.charAt(i)];
    }
    return new String(returnNumber);
}
</script>
