/*

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

 */
/**
 * @author: janmejay.singh
 * @author: vikas.sasidharan
 */
/**
 * This file holds javascript functions that are more of a common utility, rather than being tightly
 * associated with anything.
 * The functions here may be used in multiple places in different contexts.
 */
/**
 * This variable is for checking from any page or free marker template, if
 * util.js is included.
 */
var TWMS_UTILITY_JS = true;

function isIgnorableKeyStroke(keyCode, ignoreBackspaceAndDelete) {
    // ignore keys:
    // F1 - F12 i.e. 112 - 123
    // PageUp - Delete i.e. 33 - 46
    // Delete i.e. 46 is NOT ignored \
    // SpaceBar i.e. 32 is NOT ignored - unless ignoreBackspaceAndDelete is
    // true;
    // Backspace i.e. 8 is NOT ignored /
    // everything else below 32 is ignored
    if (keyCode == null) {
        return true;
    }
    if (ignoreBackspaceAndDelete && (keyCode == 8 || keyCode == 46)) {
        return true;
    }
    return (keyCode != 8 && keyCode < 32) || (keyCode >= 33 && keyCode < 46) || (keyCode >= 112 && keyCode <= 123);
}

function getTabHavingId(/* String */id) {
    return top.tabManager.getTabHavingId(id);
}

function getMyTab() {
    return getTabHavingId(getTabDetailsForIframe().tabId);
}

function getMyTabLabel() {
    return getMyTab().title;
}

function closeTab(/* tab reference */tab) {
    top.publishEvent("/tab/close", {
        tab : tab
    });
}

function closeMyTab() {
    closeTab(parent.getTabHavingLabel(getMyTabLabel()));
}

function getDetailsOfTab(/* tab reference */tab) {
    var iframe = getIFrameForTab(tab);
    return parseIframeDetails(iframe.name);
}

function getTabDetailsForIframe() {
    return parseIframeDetails(window.name);
}

function parseIframeDetails(/* String */name) {
    var suffix = "_iframe";
    var folderName = null, tabId = null;
    var indexOfHash = name.indexOf("#");
    if (indexOfHash == -1) {
        tabId = name.substring(0, name.length - suffix.length);
    } else {
        folderName = name.substring(indexOfHash + 1, name.length - suffix.length).replace(/_/g, " ");
        tabId = name.substring(0, indexOfHash);
    }
    return {
        tabId : tabId,
        folderName : folderName
    };// FIXME: this was named as folderName by
    // mistake.. but now its too difficult to
    // fix.
}

function getTabHavingLabel(label) {
    return top.tabManager.getTabHavingLabel(label);
}

function refreshSummaryTableInTabHavinglabel(tabLabel) {
    var tab = getTabHavingLabel(tabLabel);
    if (tab != null) {
        var tabId = tab.id;
        var iframeName = tabId + "_iframe";
        window.frames[iframeName].summaryTable.refreshTable();
        delete tabId, iframeName;
    }
    delete tab;
}

function setTooltip(/* DomNode */domNode, /* String */title) {
    domNode.title = title;
}

function removeTooltip(/* DomNode */domNode) {
    domNode.removeAttribute("title");
}

function isRightClickEvent(event) {
    return event.button == 2;
}

function __substituteIndex(template, key, val) {
    return template.replace(new RegExp("#" + key, "g"), val);
}

function requestDeletion(/* TR */ofRow, /* Ognl collection name */fromCollection) {
    var col = fromCollection.replace(/\./g, "\\.");
    col = col.replace(/\[/g, "\\[");
    col = col.replace(/\]/g, "\\]");
    var reg = new RegExp("^" + col + "\\[.*\\]$");
    var inputs = ofRow.getElementsByTagName("input");
    for ( var i = 0; i < inputs.length; i++) {
        var input = inputs[i];
        if ((input.type == "hidden") && (reg.test(input.name))) {
            var tbody = ofRow.parentNode;
            __appendDeleterFormElem(fromCollection, input.name, tbody);
            delete tbody;
        }
        delete input;
    }
    delete reg, inputs;
}

function __appendDeleterFormElem(fromCollection, withId, toTbody) {
    var deleter = document.createElement("input");
    deleter.type = "hidden";
    deleter.name = "__remove." + fromCollection;
    deleter.value = withId;
    toTbody.appendChild(deleter);
    delete deleter;
}

function unescapeThisHtml(/* String */str) {
    return (new String(str)).replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">");
}

function publishOnParentTab(/* String */topic, /* assoc array(event message) */message) {
    var parentWindow = _getParentIFrame();
    if (!parentWindow.publishEvent)
        throw new Error("'publishEvent' method not found in the parent. Please include utility.js in the parent page.");
    parentWindow.publishEvent(topic, message);
}
/**
 * The function invocation string is something like ... "myFunction(parentVar1,
 * \"and something\", parentVar2)"
 */
function invokeInParentTab(/* String (function invocation string) */func) {
    var parentWindow = _getParentIFrame();
    try {
        return parentWindow.eval(func);
    } catch (ex) {
        throw new Error("invokeInParentTab : the function invocation string raised an exception... "
                + "please check the variable/function names and make sure they exist in the tab.", ex);
    }
}

function manageRowHide(/* String (summaryTableId) */summaryTableId,/*
 * String
 * (dataId)
 */dataId) {
    if (getFrameAttribute("TST_IS_PREVIEW")) {// this means we are in preview
        parent.publishEvent(parent.SUMMARY_TABLE_UTIL.getHideCompletedRowTopic(summaryTableId), {
            dataId : dataId
        });
    } else {// this means we are in detail page. So, we can use decendentOf.
        publishOnParentTab(invokeInParentTab("SUMMARY_TABLE_UTIL.getHideCompletedRowTopic(\"" + summaryTableId + "\")"), {
            dataId : dataId
        });
    }
}

function manageMultipleRowHide(/* String (summaryTableId) */summaryTableId,/*
 * Array
 * (of
 * dataIds)
 */dataIds) {
    if (getFrameAttribute("TST_IS_PREVIEW")) {// this means we are in preview
        // view
        parent.publishEvent(parent.SUMMARY_TABLE_UTIL.getHideCompletedRowsTopic(summaryTableId), {
            dataIds : dataIds
        });

    } else {// this means we are in detail page. So, we can use decendentOf.
        publishOnParentTab(invokeInParentTab("SUMMARY_TABLE_UTIL.getHideCompletedRowsTopic(\"" + summaryTableId + "\")"), {
            dataIds : dataIds
        });
    }
}

function manageTableRefresh(/* String (summaryTableId) */summaryTableId, /* boolean */forceFullRefresh) {
    if (getFrameAttribute("TST_IS_PREVIEW")) {// this means we are in preview
        // view
        parent.publishEvent(parent.SUMMARY_TABLE_UTIL.getRefreshListingTopic(summaryTableId));
    } else {// this means we are in detail page. So, we can use decendentOf.
        var parentTabLabel = getTabDetailsForIframe().folderName;
        top.tabManager.markDirty(parentTabLabel, forceFullRefresh);
    }
}

function manageTableMinimize(/* String (summaryTableId) */summaryTableId) {
    if (getFrameAttribute("TST_IS_PREVIEW")) {// this means we are in preview
        // view
        var topic = parent.SUMMARY_TABLE_UTIL.getMinimizeTopic(summaryTableId);
        parent.publishEvent(topic);
    } else {// this means we are in detail page. So, we can use decendentOf.
        publishOnParentTab(invokeInParentTab("SUMMARY_TABLE_UTIL.getMinimizeTopic(\"" + summaryTableId + "\")"));
    }
}

function manageTableRestore(/* String (summaryTableId) */summaryTableId) {
    if (getFrameAttribute("TST_IS_PREVIEW")) {// this means we are in preview
        // view
        parent.publishEvent(parent.SUMMARY_TABLE_UTIL.getRestoreTopic(summaryTableId));
    } else {// this means we are in detail page. So, we can use decendentOf.
        publishOnParentTab(invokeInParentTab("SUMMARY_TABLE_UTIL.getRestoreTopic(\"" + summaryTableId + "\")"));
    }
}

function getFrameAttribute(/* String (name of attribute) */attribute) {
    return window.frameElement ? window.frameElement[attribute] : null;
}

var VALIDATOR_MODE = {
    EXPRESSION : "EXP",
    FUNCTION : "FN"
};

/**
 * This is the class that does the validation logic... It can be instantiated in
 * following two ways... new twms.utility.Validator(VALIDATOR_MODE.EXPRESSION,
 * "left hand side value", "operator for ex. === ", "right hand side"); or new
 * twms.utility.Validator(VALIDATOR_MODE.FUNCTION, "functionName", "argument1",
 * "argument2"...); and then calling validate(targetObject).. tires to validate
 * and returns null or validationMessage... depending on weather the validation
 * was successful or not....
 */

var __fileDownloader = null;
/**
 * FileDownloader is an expensive resource... please make sure there is only one
 * instance of this in a page. don't instantiate the class yourself... use the
 * getFileDownloader method below.
 */

function getFileDownloader(/* boolean */lazyInitialization) {
    if (__fileDownloader == null) {
        __fileDownloader = new twms.utility._FileDownloader(lazyInitialization);
    }
    return __fileDownloader;
}

function getMapLength(/* javascript map */map) {
    var i = 0;
    for ( var j in map)
        i++;
    return i;
}

/**
 * Returns reference to focused tab
 */
function getFocusedTab() {
    return top.tabManager.tabPane.selectedChildWidget;
}