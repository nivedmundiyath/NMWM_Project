<%@ include file="/ui/system/taglibs.inc" %>
<%@ include file="/ui/system/beans.inc" %>

<%@ page import="com.webmethods.portal.framework.IWebApplication" %>
<%@ page import="com.webmethods.portal.framework.propertyeditor.IPropertyEditor" %>
<%@ page import="com.webmethods.portal.service.portlet.IPortletProvider" %>
<%@ page import="com.webmethods.portal.system.IComponent" %>
<%@ page import="com.webmethods.portal.system.IURI" %>
<%@ page import="com.webmethods.portal.system.PortalSystem" %>
<%@ page import="java.util.*" %>

<%!
public static class EditorComparator implements Comparator {
    
    public int compare(Object o1, Object o2) {
        IComponent e1 = (IComponent) o1;
        IComponent e2 = (IComponent) o2;
        
        return e1.getComponentName().compareTo(e2.getComponentName());
    }
    
    public boolean equals(Object o) {
        return (o instanceof Comparator);
    }
}
%>

<page:html title="Property Editor Tests">

<h2>Property Editor Tests</h2>

<ui:list>
<%
IPortletProvider widgieChrist = (IPortletProvider) PortalSystem.getPortletProvider();
IWebApplication webApp = (IWebApplication) PortalSystem.getWebAppProvider();
List editors = new ArrayList(webApp.getPropertyEditorManager().getComponents().values());
Collections.sort(editors, new EditorComparator());

for (int i = 0; i < editors.size(); i++) {
    Object o = editors.get(i);
    
    if (o instanceof IPropertyEditor) {
        IPropertyEditor editor = (IPropertyEditor) o;
        String test = (String) editor.getComponentData().getProperties().get("test");
        
        if (test != null) {
            if (test.endsWith(".jsp")) {
                test = test.substring(0, test.length() - ".jsp".length());
            }
            
            String portlet = (String) editor.getComponentData().getProperties().get("portlet");
            IURI portletUri = (portlet != null ? PortalSystem.getPortalSystem().acquireURI(portlet) : null);
            
            if (portletUri != null) {
                String layout = widgieChrist.getResourceLocation(portletUri, test, false);
                %>
                <ui:listRow>
                  <ui:listCell width="100%"><a href="<%=presentationbean.getCanonicalServletPath()%>?layout=<%=layout%>"><%=editor.getComponentName()%></a></ui:listCell>
                </ui:listRow>
                <%
            } else {
                %>
                <ui:listRow>
                  <ui:listCell width="100%"><a href="<%=presentationbean.getCanonicalServletPath()%>?layout=<%=test%>"><%=editor.getComponentName()%></a></ui:listCell>
                </ui:listRow>
                <%
            }
        }
    }
}
%>
</ui:list>
</page:html>
