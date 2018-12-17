<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sd" uri="/struts-dojo-tags"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%>
<%@taglib prefix="u" uri="/ui-ext"%>

<u:stylePicker fileName="base.css" />
<u:stylePicker fileName="actionResult.css"/>
<style type="text/css">
	.labelFooter {
		margin:0;
	    border-top:1px solid #EFEBF7;
        padding: 4px;
    }

    .labelEditSection {
        padding: 5px;
    }

    td.label {
        padding-left:2px;
        font-weight: bold;
	}

	td.data {
        padding:0;
	}
	
	td.heading {
        font-size:10pt;
        color: #636363;
        font-weight: bold;
        font-style:  normal;
    }

    #labelsDialog {
        width: 50%;
    }
	
.dijitComboBoxMenuPopup{z-index:1200!important}

/*custom*/
.buttonGeneric{padding:1px 6px!important}
</style>

<div style="display:none;">
<div dojoType="twms.widget.Dialog" title='<s:text name="label.common.addRemoveLabel"/>' id="labelsDialog"
     bgColor="white" bgOpacity="0.5" toggle="fade" toggleDuration="250" style="z-index:1000;">
   		<div dojoType="dijit.layout.ContentPane" layoutAlign="client" id="labels_div" class="labelEditSection">
   		<div id="noSearchParamsErrorSection" class="twmsActionResults" style="display:none">
   		 <link href="../css/theme/official/ui-ext/actionResult/actionResult.css" type="text/css" rel="stylesheet"/>
            <div class="twmsActionResultsSectionWrapper twmsActionResultsErrors">
				<h4 class="twmsActionResultActionHead"><s:text name="label.common.errors"/></h4>
					<ol>
						<li><s:text name="error.Labels.create" /></li>
					</ol>
				<hr/>
			</div>
		</div>
     		<div id="forErrors"></div>
     			<table class="form" cellpadding="0" cellspacing="0" id="labelsTable"  style="border-collapse: separate;border-spacing:4px;margin-top: 10px;">
     			<tr >
     				<td><span><input type="radio" checked="checked" id="forAutoComplete" name="level"/><s:text name="label.common.searchLabel"/></span></td><td>
     				<input type="radio" id="fortextField" name="level" /><s:text name="button.common.create" /></td>
     			</tr>
				<tr>
			        <td width="30%" class="labelStyle"  style="text-indent:17px"><s:text name="label.common.searchALabel"/>:</td>
			        <td id="tagLevel">		     
			        <script type="text/javascript">
               					 dojo.addOnLoad(function() {
               						if(window.location.href.indexOf('/fleet') >= 0)
               						 var url= "../list_labels.action";  
               						else
                       			 	 var url= "list_labels.action";                       			 	
                       				 dojo.publish("listLabels", [{
                           						 url: url,
                           						 params: {
                       								labelType: document.getElementById("labelType").value
                            					}
                        					}]);
               								 });
                    </script>
					<sd:autocompleter id='labelAutoComplete' showDownArrow='false' listenTopics='listLabels' />
				    <s:textfield name="label" id="textfieldForLabel"/>
					</td>
				  	<td>
                          <button class="buttonGeneric" style="margin-left:5px!important" onclick="addLabel()">
                            <s:text name="button.common.addLabel"/>
                          </button>
				  	</td>
				</tr>
						<tr>
							<td valign="top" class="labelStyle" style="text-indent:8px"> <span style="margin-top:3px;display:inline-block"><s:text name="label.common.selectedLabels"/>: </span></td>
							<td valign="top" class="data"><div id="listOfLabels" style="margin-top:3px"></div></td>
							<td valign="top">
                                <button class="buttonGeneric" style="margin-top:3px;margin-left:5px!important" onclick="clearList()">
                                    <s:text name="button.common.clearList"/>
                                </button>
						</tr>
					</table>
			</div>
			<div dojoType="dijit.layout.ContentPane" layoutAlign="bottom" class="labelFooter">
				<div align="center" id="submitButtonsDiv">
				  <table width="50%" class="buttonWrapperPrimary">
                    <tr>                    
                        <td>
							<button class="buttonGeneric" id="applyLabel" onclick="applyLabel()">
		                        <s:text name="button.common.applyLabel"/>
		                    </button>
		                </td>
	                    <td>
							<button class="buttonGeneric" id="removeLabel" onclick="removeLabel()">
		                        <s:text name="button.common.removeLabel"/>
		                    </button>
	                    </td>
                    	</tr>
                  </table>
			   </div>
			</div>
</div>
</div>
