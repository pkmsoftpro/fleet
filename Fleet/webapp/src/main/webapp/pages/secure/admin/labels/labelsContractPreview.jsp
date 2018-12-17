<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>
<%response.setHeader( "Pragma", "no-cache" );
response.addHeader( "Cache-Control", "must-revalidate" );
response.addHeader( "Cache-Control", "no-cache" );
response.addHeader( "Cache-Control", "no-store" );
response.setDateHeader("Expires", 0); %>

<html>
<head>
    <meta http-equiv="Context-Type" content="text/html; charset=ISO-8859-1">
    <s:head theme="twms"/>
    <u:stylePicker fileName="common.css"/>
    <u:stylePicker fileName="base.css"/>
     
 </head>
 <u:actionResults/>
 <u:stylePicker fileName="inboxLikeButton.css"/>
  <script type="text/javascript">  	  	
     
   </script>
   
<u:body smudgeAlert="false">
	 <s:form name="labelSearchForm" id="labelSearchForm" >
	 <s:hidden name="labelType"/>
	 <div class="policy_section_div">
	 <div  class="section_header">        
        	  			<s:text name="label.common.contractLabels"/>
       				</div>
	 	<table  width="100%" border="0" cellspacing="0" cellpadding="0" class="grid borderForTable" align="center">
	 	
      		 <tr class="row_head">
      		 	<th>
      		 		<s:text name="columnTitle.contract.contractCode"/>
      		 	</th>
      	    	<th>
      		 		<s:text name="columnTitle.contract.contractType"/>
      		 	</th>
      		 </tr>
      		 <s:iterator  value="contracts" status="itr" id="localesItr">
      		<tr>
				<td >
				<u:openTab decendentOf="%{getText('home_jsp.tabs.home')}" cssClass="claims_folder folder"
			         id="contractDetails" tagType="a"
			         tabLabel="%{getText('columnTitle.contract.contractCode')}"
			         url="contract_detail.action?id=%{id}"
					 catagory="contract">
		            <s:property value='code'/>
           		 </u:openTab>
				</td>
				<td class="label">
					<s:property value='type'/>
				</td>
	        </tr>
	        </s:iterator>
	      </table>
	      </div>
	  </s:form>
</u:body>      