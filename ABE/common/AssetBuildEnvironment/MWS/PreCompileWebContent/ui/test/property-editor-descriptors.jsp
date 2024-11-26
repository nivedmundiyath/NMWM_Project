<%@ include file="/ui/system/taglibs.inc" %>
<%@ include file="/ui/system/beans.inc" %>

<%@ page import="com.webmethods.portal.framework.IWebApplication" %>
<%@ page import="com.webmethods.portal.framework.propertyeditor.*" %>
<%@ page import="com.webmethods.portal.system.PortalSystem" %>

<page:html title="Property Editor Tests">

<h2>Property Editor Descriptors</h2>

<%
IWebApplication webApp = (IWebApplication) PortalSystem.getWebAppProvider();
IPropertyEditorManager manager = (IPropertyEditorManager) webApp.getPropertyEditorManager();

IPropertyEditorCategoryDescriptor[] categories = manager.getDescriptors(contextbean);
for (int i = 0; i < categories.length; i++) {
    IPropertyEditorCategoryDescriptor category = categories[i];
    %>
    <h3><%=category.getTitle()%> (<code><%=category.getName()%></code>)</h3>
    <%
    
    IPropertyEditorDescriptor[] editors = category.getPropertyEditors();
    if (editors != null) {
    for (int j = 0; j < editors.length; j++) {
        IPropertyEditorDescriptor editor = editors[j];
        %>
        <h4><%=editor.getTitle()%> (<code><%=editor.getName()%></code>)</h4>
        
        <pre>
        description: <%=editor.getDescription()%>
        icon: <img src="<%=editor.getIcon()%>" width="32" height="32" border="0" />
        preview: <img src="<%=editor.getPreview()%>" border="0" />
        </pre>
        
        <%
        IPropertyEditorParameterDescriptor[] parameters = editor.getParameters();
        if (parameters != null) {
        for (int k = 0; k < parameters.length; k++) {
            IPropertyEditorParameterDescriptor parameter = parameters[k];
            %>
            <h5><%=parameter.getTitle()%> (<code><%=parameter.getName()%></code>)</h5>
            
            <pre>
            description: <%=parameter.getDescription()%>
            type: <%=parameter.getType()%>
            required: <%=parameter.isRequired()%>
            default: <%=parameter.getDefault()%>
            </pre>
            <%
            
            IPropertyEditorParameterChoiceDescriptor[] choices = parameter.getChoices();
            if (choices != null) {
            for (int m = 0; m < choices.length; m++) {
                IPropertyEditorParameterChoiceDescriptor choice = choices[m];
                %>
                <h6><%=choice.getTitle()%> (<code><%=choice.getValue()%></code>)</h6>
                
                <pre>
                description: <%=choice.getDescription()%>
                </pre>
                <%
            }
            }
        }
        }
    }
    }
}
%>
</page:html>
