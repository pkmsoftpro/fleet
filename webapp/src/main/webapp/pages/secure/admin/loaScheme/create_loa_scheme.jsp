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

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	 <u:stylePicker fileName="yui/reset.css" common="true"/>
    <s:head theme="twms"/>
    <u:stylePicker fileName="common.css"/>
    <u:stylePicker fileName="form.css"/>
    <u:stylePicker fileName="base.css" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />   
    <style>
	.money_symbol{margin:2px; width:40px; float:left; text-align:right;}
	div.limit{width:140px; text-align:center;}
	div.limit input{width:50px; margin:2px;}
	</style>
	</head>
	 
	<u:body>
	    <u:actionResults/>
	    <s:form action="save_LOA_Scheme">
		    <div class="policy_section_div">
				<s:form action="">
					<table class="grid" width="100%"  border="0" cellspacing="0" cellpadding="0" >
				   		 <tr height="5"/>
				   		 <s:hidden name="limitOfAuthorityScheme"/>
			             <div id="loa_scheme_header" class="section_header" >
			                 <s:text name="title.loa.scheme.details"/>
			             </div>  
			              <tr>
					            <td colspan="2" nowrap="nowrap" class="labelStyle">
					                <s:text name="label.manageLOAScheme.loaSchemeCode"/>
					            </td>
          
					            <td width="30%" class="labelNormal">
					                <s:textfield name="limitOfAuthorityScheme.code" cssClass="txtField" id="loaSchemeCode" value="%{limitOfAuthorityScheme.code}"/>
					            </td>
					            <td width="70%"></td>
					        </tr>
					        <tr>
					            <td colspan="2" nowrap="nowrap" class="labelStyle">
					                <s:text name="label.manageLOAScheme.loaSchemeName"/>
					            </td>
					            <td width="30%" class="labelNormal">
					                <s:textfield name="limitOfAuthorityScheme.name" cssClass="txtField" id="loaSchemeName" value="%{limitOfAuthorityScheme.name}"/>
					            </td>
					            <td width="30%"></td>
					        </tr>
					        <tr>
					            <td colspan="2" nowrap="nowrap" class="labelStyle">
					                <s:text name="label.manageLOAScheme.loaSchemeDescription"/>
					            </td>
					
					            <td width="30%" class="labelNormal">
					                <s:textfield name="limitOfAuthorityScheme.description" cssClass="txtField" id="loaSchemeDesc"
					                value="%{limitOfAuthorityScheme.description}" />
					            </td>
					        </tr>
					        <tr height="9"><td></td></tr> 
				      </table>
				      <u:repeatTable id="loa_scheme_level_table" cssClass="grid borderForTable" width="97%">
						    <thead>
						       <tr class="row_head">
					            <th width="25%"><s:text name="label.manageLOAScheme.level"/></th>
					            <th width="25%"><s:text name="label.manageLOAScheme.levelName"/></th>
					            <th width="21%"><s:text name="label.manageLOAScheme.login"/></th>
					            <th width="21%"><s:text name="label.manageLOAScheme.approvalLimit"/></th>
					            <th width="10%">
                                <u:repeatAdd id="loa_levels_adder"  theme="twms">
                                 <img id="addDealer" src="image/addRow_new.gif" border="0" style="cursor: pointer;" title="<s:text name="label.common.addRow"/>"/>
                                </u:repeatAdd></th>
					          </tr>
						    </thead>
	                        <u:repeatTemplate id="loa_levels_body"  value="limitOfAuthorityScheme.loaLevels" index="index" theme="twms">
	                          <tr index="#index">
	                            <td><s:textfield name="limitOfAuthorityScheme.loaLevels[#index].loaLevel"  style="height: 25px; width: 225px;" cssClass="txtField" id="loa_levels_body_#index"
	                            value="%{limitOfAuthorityScheme.loaLevels[#index].loaLevel}" /></td>
	                            <td><s:textfield name="limitOfAuthorityScheme.loaLevels[#index].name" cssClass="txtField" style="height: 25px; width: 225px;" id="loaSchemeLevelName"
	                            value="%{limitOfAuthorityScheme.loaLevels[#index].name}" /></td>
					          <td><sd:autocompleter id='name_#index' href='list_loa_scheme_users.action' name='limitOfAuthorityScheme.loaLevels[#index].loaUser' 
            keyName='limitOfAuthorityScheme.loaLevels[#index].loaUser' value='%{limitOfAuthorityScheme.loaLevels[#index].loaUser.name}'
             key='%{limitOfAuthorityScheme.loaLevels[#index].loaUser.id}' loadOnTextChange='true' loadMinimumCount='1' showDownArrow='false' indicator='indicator' delay='500' />
            </td> <td valign="top">
				            	<s:iterator value="currencyList" status="currIter">
				            	    <div style="margin-bottom: 2px">
									<t:money id="currIter_%{#currIter.index}_#index" name="limitOfAuthorityScheme.loaLevels[#index].approvalLimits[%{#currIter.index}]"
										value="%{approvalLimits[#currIter.index]}" size="10"  defaultSymbol="%{currencyCode}"/>
									</div>
								</s:iterator>
				              	</td>
					            <td><u:repeatDelete id="loa_levels_deleter_#index" theme="twms">
									<img id="deleteloa_levels" src="image/remove.gif" border="0"
										style="cursor: pointer;"
										title="<s:text name="label.common.deleteRow" />" />
								</u:repeatDelete></td>            
	                         </tr>
	                        </u:repeatTemplate>
	                     </u:repeatTable>
	                     <div class="spacer10"></div>
	                     <div id="submit" align="center">
					<authz:ifPermitted resource="manageLOASchemes">
						<s:if test="limitOfAuthorityScheme.id != null">
							<s:submit cssClass="buttonGeneric"
								value="%{getText('button.common.delete')}"
								action="delete_LOA_Scheme" />&nbsp;
	                       </s:if>
						<input id="submit_btn" class="buttonGeneric" type="submit"
							value="<s:text name='button.common.save'/>" />
					</authz:ifPermitted>
					<input id="cancel_btn" class="buttonGeneric" type="button" 
		                       value="<s:text name='button.common.cancel'/>"
				               onclick="javascript:closeTab(getTabHavingLabel(getMyTabLabel()));" />       
	                    </div>
	                    <div class="spacer10"></div>
				</s:form>
			</div>
		</s:form>		
	</u:body>
</html>
