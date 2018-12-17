<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="t" uri="twms"%><%@taglib prefix="u" uri="/ui-ext"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="authz" uri="authz"%>
<%
    response.setHeader("Pragma", "no-cache");
    response.addHeader("Cache-Control", "must-revalidate");
    response.addHeader("Cache-Control", "no-cache");
    response.addHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
%>

<div dojoType="dijit.layout.ContentPane" id="messagesAndBulletins"
	 iconClass="myclaims serv-req-icon" title="<s:text name="accordion_jsp.accordionPane.messagesAndBulletins" />" >
	<div dojoType="dijit.layout.ContentPane">
		<ol>
	         <authz:ifPermitted resource="createMessage">
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="createMessageBulletins" tagType="li"
                cssClass="messagesBulletin_folder folder foldableMessagesBulletin sublist"
                 tabLabel="label.messagesAndBulletins.createNewMessage"
                url="createMessagesBulletins.action?folderName=Create Messages Bulletins"
                catagory="messagesBulletins" helpCategory="messagesBulletins/createMessagesAndBulletins.htm">
                <s:text name="label.messagesAndBulletins.createNewMessage" />
            </u:openTab>           
            </authz:ifPermitted>
          
		</ol>     
      </div>
</div>
