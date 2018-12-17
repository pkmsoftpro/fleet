<%@page contentType="text/html"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<div id="listOfStatesDiv">
<s:select name="customerSearchCriteria.state" id="state" list="listOfStates" emptyOption="true" headerKey="" headerValue="--Select--" disabled="true" cssClass="selectboxWidth"/>
</div>
