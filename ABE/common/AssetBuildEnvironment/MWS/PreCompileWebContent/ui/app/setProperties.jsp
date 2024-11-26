<%@ include file="/ui/system/taglibs.inc" %>
<%@ include file="/ui/system/beans.inc" %>

<util:lookup item="property" result="propertyName" default="" />

<meta:thing id="view" mechanicsId="mech" uri="current.resource" type="basic">

<page:html>

<%
boolean canModify = mech.canUpdateProperties(view.getThingID(), authbean.getUserID()); 
if (!canModify) {
%>	
<div class="portlet-msg-error"><h3>You don't have rights to modify the properties of this item.</h3></div>
<%	
} else { 
%>
<%
if (propertyName.length() > 0) {
%>
<script type="text/javascript">
function doSubmit(elForm) {
    // set name
    elForm.propertyvalue.name = trimString(elForm.propertyname.value);
    return true;
}

function doCancel(elForm) {
    window.history.back();
}
</script>
<table cellpadding="0" cellspacing="0" border="0" width="100%">
<form name="properties" method="post" onSubmit="return doSubmit(this)" action="<jsp:getProperty name="presentationbean" property="canonicalServletPath" /><%=view.getURI()%>">
 <input type="hidden" name="command" value="updateProperties" />
 <input type="hidden" name="axsrft" value="<%=com.webmethods.caf.faces.render.xsrf.AXSRFTVendingMachineFactory.getUnit().produceToken(request)%>" />
 <input type="hidden" name="returnUrl" value="<jsp:getProperty name="presentationbean" property="previousRequestURL" />" />
 <tr>
   <td>
     <ui:titlebar>
       <util:param name="title_bar_prefix">Set Properties</util:param>
     </ui:titlebar>
     
    <ui:propertyGroup title="Property">
        <ui:propertyLine>
          <util:param name="property_line_title">Name</util:param>
          <util:param name="property_line_name" value="propertyname" />
          <util:param name="property_line_value" value="<%=propertyName%>" />
          <util:param name="property_line_type" value="text" />
          <util:param name="property_line_style" value="medium" />
          <util:param name="property_line_required" value="true" />
        </ui:propertyLine>
        <ui:propertyLine>
          <util:param name="property_line_title">Value</util:param>
          <util:param name="property_line_name" value="propertyvalue" />
          <util:param name="property_line_value" value="<%=view.getProperty(propertyName)%>" />
          <util:param name="property_line_type" value="textarea" />
          <util:param name="property_line_cols" value="80" />
          <util:param name="property_line_rows" value="10" />
        </ui:propertyLine>
    </ui:propertyGroup>
     
     <ui:propertySubmit>
       <util:param name="property_submit">  Apply  </util:param>
     </ui:propertySubmit>
   </td>
 </tr>
</form>
</table>
<%
} else {
%>

<ui:titlebar>
 <util:param name="title_bar_prefix">Properties of </util:param>
</ui:titlebar>
<ui:list>
<%
    Object[] properties = view.getPropertyNames().toArray();
    java.util.Arrays.sort(properties);
    
    for (int i = 0; i < properties.length; i++) {
        String property = String.valueOf(properties[i]);
%>
<ui:listRow>
<ui:listCell width="30%"><ui:a href='<%=view.getURI() + "?layout=setProperties&property=" + property%>'><%=property%></ui:a></ui:listCell>
<ui:listCell width="60%">
<%
try {
    %><ui:encode type='html' expr='<%=mech.getListProperty(view, property)%>' /><%
} catch (Exception e) {
    out.print(e.getMessage());
}
%>
</ui:listCell>
</ui:listRow>
<%
    }
%>
</ui:list>
<%
}
%>
<%	
} /*endif (canModify) */
%>
</page:html>
</meta:thing>
