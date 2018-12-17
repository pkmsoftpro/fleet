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
<div dojoType="dijit.layout.ContentPane" id="reports"
        title="<s:text name="accordionLabel.manageUploadDownload"/>"
        iconClass="myclaims fleet-inv-icon" >
<div dojoType="dijit.layout.ContentPane" layoutAlign="client">
<authz:ifPermitted resource="uploadManagement">
    <ol>
        <!-- Manage Upload/Download Accordion -->
        <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
            id="admin_manage_uploads" tagType="li" cssClass="reports_folder folder"
            tabLabel="%{getText('title.manageUploadDownload.upload')}"
            url="../manageUploadDownload.action?context=UPLOAD" catagory="reports" helpCategory="Reports/Upload_Management.htm">
            <s:text name="accordionLabel.manageUploadDownload.upload" />
        </u:openTab>
    </ol>
</authz:ifPermitted>
</div>
</div>