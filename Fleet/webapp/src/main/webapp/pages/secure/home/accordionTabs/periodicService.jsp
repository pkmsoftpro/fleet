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

<div dojoType="dijit.layout.ContentPane" id="periodicServices"
	 iconClass="myclaims serv-req-icon" title="<s:text name="accordion_jsp.accordionPane.periodicServices" />" >
	<div dojoType="dijit.layout.ContentPane">
	<authz:ifPermitted resource="serviceSchedules">
		<ol>
		    <u:fold label="%{getText('accordionLabel.periodicServices.serviceSchedules')}"
                id="service_Schedules" tagType="li" cssClass="uFoldStyle folder"
                foldableClass="foldableServiceSchedules"/>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="listDueServices" tagType="li"
                cssClass="periodicServices_folder folder foldableServiceSchedules sublist"
                tabLabel="%{getText('label.periodicService.dueServices')}"
                url="getScheduleServices.action?folderName=Due Services"
                catagory="pmSchedule" helpCategory="periodicServices/dueServices.htm">
                <s:text name="label.periodicService.dueServices" />(<span class="count"></span>)
                 <script type="text/javascript" language="javascript">
                        dojo.addOnLoad(function() {
                              dojo.connect(dojo.byId("service_Schedules"), "onmousedown", function(event) {
                              event.folderName = "DUE SERVICES COUNT";
                              autoRefreshFolderCount(event);
                              refreshManager.register("listDueServices", "DUE SERVICES COUNT", "serviceSchedulesCount.action");
                            });
                        });
                    </script>         
            </u:openTab>
            <u:openTab decendentOf="%{getText('home_jsp.tabs.home')}"
                id="listOverDueServices" tagType="li"
                cssClass="periodicServices_folder folder foldableServiceSchedules sublist"
                tabLabel="%{getText('label.periodicService.overDueServices')}"
                url="getScheduleServices?folderName=Over Due Services"
                catagory="pmSchedule" helpCategory="periodicServices/overDueServices.htm">
               <s:text name="label.periodicService.overDueServices" />(<span class="count"></span>)
                    <script type="text/javascript" language="javascript">
                        dojo.addOnLoad(function() {
                            /* dojo.connect(dojo.byId("listDueServices"), "onmousedown", function(event) {
                              event.folderName = "OVER DUE SERVICES COUNT";
                              autoRefreshFolderCount(event);   */
                              refreshManager.register("listOverDueServices", "OVER DUE SERVICES COUNT", "serviceSchedulesCount.action");
                            /* }); */  
                        });
                    </script>
            </u:openTab>
		</ol>
	</authz:ifPermitted>
	<authz:ifPermitted resource="searchPeriodicServices">
        <t:daSection id="periodicServiceSearchFolders" fetchFrom="../periodicServiceSearchFolders" fetchOn="/accordion/refreshperiodicservicesearchfolders"
            title="%{getText('accordionLabel.viewCustomer.searchFolders')}" appendMode="false" cssClass="searchFolders" />
     </authz:ifPermitted>
      </div>
</div>
