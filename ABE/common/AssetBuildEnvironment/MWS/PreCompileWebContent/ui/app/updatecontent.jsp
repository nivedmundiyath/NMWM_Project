<%@ include file="/ui/system/taglibs.inc" %>
<%@ include file="/ui/system/beans.inc" %>

<%@ page import="com.webmethods.portal.resources.Ui" %>
<%@ page import="com.webmethods.portal.system.PortalSystem" %>

<view:view id="item" mechanicsId="mech" uri="current.resource" type="basic">
<jsp:setProperty name="authbean" property="*" />
<page:html title='<%=PortalSystem.localizeMessage(Ui.class, "POP.013.0019", null, false)%>'>
<script type="text/javascript">
function doSubmit(elForm) {
    if (elForm.fileInput.value == "") {
        alert("<util:message bundle="core" key="POP.013.0020" />");
        elForm.fileInput.focus();
        return false;
    }

    // save the file path
    elForm.originalFilePath.value = elForm.fileInput.value;
    elForm.returnUrl.value = "<jsp:getProperty name="presentationbean" property="contextPath" />/ui/app/close.html?returnUrl=<ui:encode type="js" expr='<%=request.getParameter("returnUrl")%>' />" ;

    return true;
}

function doCancel(elForm) {
    self.close();
}
</script>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <form name="publish1" method="post" onSubmit="return doSubmit(this);" enctype="multipart/form-data" action="<jsp:getProperty name="presentationbean" property="canonicalServletPath" /><%=item.getThingID().toString()%>">
        <input type="hidden" name="command" value="updateProperties" />
        <input type="hidden" name="axsrft" value="<%=com.webmethods.caf.faces.render.xsrf.AXSRFTVendingMachineFactory.getUnit().produceToken(request)%>" />
        <input type="hidden" name="returnUrl" value="" />
        <input type="hidden" name="originalFilePath" />
    <tr><td>
    <ui:propertyGroup title='<%=PortalSystem.localizeMessage(Ui.class, "POP.013.0019", null, false)%>'>
        <ui:propertyLine>
            <util:param name="property_line_title"><util:message bundle="core" key="POP.013.0021" /></util:param>
            <util:param name="property_line_type" value="custom" />
            <util:param name="property_line_value">
                <img src="<view:icon view="item" />" width="16" height="16" border="0" />&nbsp;<ui:encode type="html" expr='<%=mech.getFormattedProperty(item, "name", null)%>' />
            </util:param>
            <util:param name="property_line_style" value="medium" />
        </ui:propertyLine>
        <ui:propertyLine>
            <util:param name="property_line_title"><util:message bundle="core" key="POP.013.0022" /></util:param>
            <util:param name="property_line_value" value='<%=mech.getFormattedProperty(item, "lastModifiedDate", null)%>' />
            <util:param name="property_line_type" value="custom" />
            <util:param name="property_line_style" value="medium" />
        </ui:propertyLine>
        <ui:propertyLine>
            <util:param name="property_line_title"><util:message bundle="core" key="POP.013.0023" /></util:param>
            <util:param name="property_line_type" value="dynamic" />
            <util:param name="property_line_page" value="/ui/include/picker_file.jsp" />
            <util:param name="property_line_name" value="fileInput" />
            <util:param name="property_line_style" value="medium" />
            <util:param name="property_line_required" value="true" />
            <util:param name="property_line_form" value="updateContentForm"/>
        </ui:propertyLine>
        <% if (PortalSystem.getPortalSystem().acquireURI("folder.encodings") != null) { %>
           <ui:propertyLine>
             <util:param name="property_line_title"><util:message bundle="core" key="picker_encoding_type_custom_name_label" /></util:param>
             <util:param name="property_line_type" value="dynamic" />
             <util:param name="property_line_name" value="fileEncoding" />
             <util:param name="property_line_page" value="/ui/include/picker_encoding.jsp" />
             <util:param name="property_line_required" value="false" />
             <util:param name="property_line_style" value="medium" />
           </ui:propertyLine>
        <% } %>
    </ui:propertyGroup>
    <ui:propertySubmit>
        <util:param name="property_submit"><util:message bundle="core" key="POP.013.0024" /></util:param>
    </ui:propertySubmit>
    </td></tr>
      </form>
    </table>

</page:html>
</view:view>
