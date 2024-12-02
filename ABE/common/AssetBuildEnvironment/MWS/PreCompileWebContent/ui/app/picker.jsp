<%@ page import="com.webmethods.rtl.encode.HTMLEncoder"%>
<%@ include file="/ui/system/taglibs.inc" %>
<%@ include file="/ui/system/beans.inc" %>

<%--
  Add param 'multiple=true' if you want to allow multiple items to be selected (default).
  Add param 'type=folder' if you want to allow only folders to be selected;
  add param 'type=topic' if you want to allow only topics to be selected.
  Add param 'root=128546759654,folder.public' to specify the root(s).
  Add param 'selected=128546759668,folder.widgets' to specify the already selected item(s).
  Add param 'selectable=this.nRights == ACCESS_MODIFY && (this.sType == \\\"portlet\\\" || this.sType == \\\"xtype\\\")'
  to specify a js expression that validates whether or not an item can be selected.
  Add param 'unselectable=this.nRights == ACCESS_DELETE_REFERENCE'
  to specify a js expression that validates whether or not an item can be removed from the selected list.
  You must define the 'add(oThing)' (or optionally the remove()) and 'cancel()' fns for this window
  to handle add and cancel events.
--%>
<util:lookup item="multiple" result="multiple" default="false" />
<util:lookup item="type" result="type" default="" />
<util:lookup item="root" result="root" default="" />
<util:lookup item="selected" result="selected" default="" />
<util:lookup item="selectable" result="selectable" default="" />
<util:lookup item="unselectable" result="unselectable" default="" />
<util:lookup item="available" result="available" default="" />

<util:lookup item="add" result="add" default="" />
<util:lookup item="remove" result="remove" default="" />
<util:lookup item="cancel" result="cancel" default="" />

<jsp:include page="/ui/system/html_head.nbsp" flush="true" />

<script type="text/javascript">
/**
 * Setup callback fns.
 */
function doLoad() {
    if ("<ui:encode type='js' expr='<%=add%>' />" != "") {
        window.add = window.opener["<ui:encode type='js' expr='<%=add%>' />"];
    }
    
    if ("<ui:encode type='js' expr='<%=remove%>' />" != "") {
        window.remove = window.opener["<ui:encode type='js' expr='<%=remove%>' />"];
    }
    
    if ("<ui:encode type='js' expr='<%=cancel%>' />" != "") {
        window.cancel = window.opener["<ui:encode type='js' expr='<%=cancel%>' />"];
    }
}
doLoad();

/**
 * Closes window. If a not a multi-picker, adds selected child.
 */
function doSubmit(elForm) {
    var aNodes = g_oUP.selected();
    
    for (var i = 0; i < aNodes.length; i++) {
        // allow add to do some validation
        if (add(aNodes[i]) == false) {
            // ditch the nodes already added
            aNodes.slice(0, i-1);
            return false;
        }
    }
    
    // remove unselected
    if (window.remove != null) {
        aNodes = g_oUP.unselected();
        
        for (var i = 0; i < aNodes.length; i++) {
            if (remove(aNodes[i]) == false) {
                aNodes.slice(0, i-1);
                return false;
            }
        }
    }
    
    self.close();
    return false;
}

/**
 * Closes the picker without selecting anything.
 * Calls cancel function.
 */
function doCancel(elForm) {
    if (window.cancel != null) {
        cancel();
    }
    self.close();
}

Event.observe(window, "unload", function() { close(); });
</script>

<portlet:portlet uri="/portlet/wm_universalpicker" >
    <util:param name="multiple" value="<%=multiple%>" />
    <util:param name="type" value="<%=type%>" />
    <util:param name="root" value="<%=root%>" />
    <util:param name="selected" value="<%=selected%>" />
    <util:param name="selectable" value="<%=selectable%>" />
    <util:param name="unselectable" value="<%=unselectable%>" />
    <util:param name="available" value="<%=available%>" />
</portlet:portlet>

<div style="width:500px;">
<form name="dialog" onSubmit="return doSubmit(this);">
   <ui:propertySubmit style="widget">
     <util:param name="property_submit"><util:message bundle="core" key="POP.013.0007" /></util:param>
     <util:param name="property_submit_popup" value="true" />
   </ui:propertySubmit>
</form>
</div>

<jsp:include page="/ui/system/html_foot.nbsp" flush="true" />
