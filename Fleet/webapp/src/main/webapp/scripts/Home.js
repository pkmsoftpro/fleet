/*
var djConfig = {isDebug: true,
                debugAtAllCosts: true};
*/

dojo.require("dijit.layout.LayoutContainer");
dojo.require("dijit.layout.ContentPane");
dojo.require("dijit.layout.SplitContainer");
dojo.require("dijit.layout.TabContainer");
dojo.require("dijit.layout.AccordionContainer");
dojo.require("dijit.Menu");
dojo.require("dijit.form.Button");
dojo.require("dijit.Dialog");

// TWMS Help related constants.
var HELP_WINDOW_OPTIONS = 'directories=no,copyhistory=no,location=yes,' +
        'resizable=yes,scrollbars=yes,toolbar=yes,status=yes,menubar=yes,fullscreen=yes';
var DEALER_HELP_URL = "pages/secure/help/Dealer Files/Dealer_Guide.htm";
var PROCESSOR_HELP_URL = "pages/secure/help/Processor Files/Processor_Guide.htm";


var HELP_FILE_PARENT_DIRECTORY_PATH = 'pages/secure/help/';
var INDEX_FILE_FOR_MODULE = "Index.htm";
var indexFile = '';
var INDEX_FILE_LOCATION = "/!SSL!/WebHelp/"

function hideCompletedRow(tabId, keyValue, folderName) {
    publishEvent("/refresh/folderCount", [{folderName: folderName}]);
    var tab = tabManager.getTabHavingLabel(folderName);
    if(tab != null) {
        var iframeName = tab.id + "_iframe";
        window.frames[iframeName].hideCompletedRow(tabId, keyValue);
    }
}

function getFileOnRole(userRole) {
	if(userRole == 'Supplier Recovery Processor') {
		for(i=0;i<userRole.length-1;i++) {
			if(i.indexOf(" ") != -1) {
				userRole = userRole.replace(" ","_");
			}
		}
	}
	INDEX_FILE_FOR_MODULE = userRole + '.htm';
	return INDEX_FILE_FOR_MODULE;
}

/**
 Opens context help for loggedin user. 
 Context is decided on basis of the loggedIn user's role and 'helpCategory'
 property of focused tab.
 If help category could not be retrieved or not present then a default help Index file
 is opened 
*/
function openHelp(userRole){

	var helpFileUrl = HELP_FILE_PARENT_DIRECTORY_PATH + userRole;	
	//INDEX_FILE_FOR_MODULE = userRole + '.htm';

	// Gets reference to active/focused tab		
	var currentTab = getFocusedTab();		
	
	// If no current tab found open help Index page
	if(currentTab)
	{
		helpFileUrl = helpFileUrl + getHelpFileUrlForCurrentTab(currentTab,userRole);
	}
	else
	{	
		helpFileUrl = helpFileUrl + INDEX_FILE_LOCATION + getFileOnRole(userRole);
	}
	
	// console.debug('helpFileUrl ' + helpFileUrl);		

	var helpWindow = openAndFocusHelpWindow(helpFileUrl);			
}

/**
* This functions gets catagory and helpCategory from the given tab 
* and returns help file url depending upon the availability of 
* property 'catagory' and 'helpCategory' in the tab. 
* Here for a loggedin user
* 'helpCategory': used to find out the sub-module for which help is required to be shown
* 'catagory'	: is fetched only if 'helpCategory' is not found
				  used to find out the module for which help is required to be shown
Returns:
URL for help file to open				  
**/
function getHelpFileUrlForCurrentTab(currentTab, userRole)
{	
	var helpFileUrl = '';
	if(currentTab && currentTab._helpCategory)
	{
		//If helpCategory found then open the 
		// help file for corresponding module for logged in user
		//console.debug('HELP Catagory: ' + currentTab._helpCategory);			
		helpFileUrl = helpFileUrl + INDEX_FILE_LOCATION + currentTab._helpCategory;			
	}
	else
	{
		// If category is found and helpCategory is not 
		// is not found then open index file for the module for the logged in user		
		if(currentTab && currentTab._catagory && currentTab._catagory != '')
		{
			var category = getFormatedCategory(currentTab._catagory);
			
			// console.debug('Catagory ' + category);				
			helpFileUrl = helpFileUrl + INDEX_FILE_LOCATION + category + '/'+ getFileOnRole(userRole);
		}
		else
		{
			// If no category is found then open
			// Index begin file for a user
			//console.debug('No Catagory no HELP'); 
			helpFileUrl = helpFileUrl + INDEX_FILE_LOCATION + getFileOnRole(userRole);		
		}			
	}
	return helpFileUrl;
}
/**
Converts the first letter of given string to upper case 
and returns the thus formated string
Also validates the catagory attribute
*/
function getFormatedCategory(category){
	if(category == 'myClaims'){
		category = 'Claims';
		return category;
	}
	
	if(category == 'admin'){
		category = 'Warranty_Admin';
		return category;
	}
	
	var firstChar = category.substr(0,1);
	firstChar = firstChar.toUpperCase();			
	category = category.substr(1,category.length-1);
	category = firstChar.concat(category);	
	
	return category;
}
    
function openHelpForDealer() {
	var dealerHelpWindow =
            openAndFocusHelpWindow(DEALER_HELP_URL);
}

function openHelpForProcessor() {
	var processorHelpWindow =
            openAndFocusHelpWindow(PROCESSOR_HELP_URL);
}

function openAndFocusHelpWindow(url) {
    // Title (second argument) is not required since it will be overridden
    // by the page loaded from the url.
    var helpWindow = window.open(url, "", HELP_WINDOW_OPTIONS);
	helpWindow.focus();
    
    return helpWindow;
}

function logout() {
    publishEvent("/refresh/stopAutoRefresh");
    location.href= "j_acegi_logout";
}

function getAlertMessage() {
    var val= dojo.byId("islocationChanged").value;
    if(val!="true"){
	twms.ajax.fireHtmlRequest("userTimezone", "", function(data) {
	 
		if (data == "true") {
		   
			dijit.byId("businessHourMessage").show();
		}
	}, function(error) {
	}, true);
    }
}

var mm = 'JANUARY, FEBRUARY, MARCH, APRIL, MAY, JUNE, JULY, AUGUST, SEPTEMBER, OCTOBER, NOVEMBER, DECEMBER';
mm = mm.split(', ');
var t = new Date();
var year = t.getYear();
if (year < 1900) {
    year += 1900;
}
dateStr = mm[t.getMonth()] + ' ' + t.getDate() + ', ' + year;

dojo.addOnLoad(function() {
	if (dijit.byId("businessHourMessage")) {
		getAlertMessage();
	}
	if (dojo.byId("actualLoggedInUser")) {
		getActualLoggedInUser();
	}
});

function getActualLoggedInUser() {
	var login= dojo.byId("actualLoggedInUser").value;
	twms.ajax.fireHtmlRequest("fetchActualLoggedInUser", {
		userId : login
    }, function(data) {
			dojo.byId("actualLogin").innerHTML = data;
	});
}

dojo.addOnLoad(function() {
    /*   HACK : This function here ensures that the last accordion pane's body doesn't cut through the bottom pane of the page in FF */
    if (dojo.isFF) {
        var footer = dijit.byId("footer");
        dijit.byId("accordion").onSlideEnd = function() {
            footer.hide();
            setTimeout(function() {
                footer.show();
            }, 0);
        };
    }
});
