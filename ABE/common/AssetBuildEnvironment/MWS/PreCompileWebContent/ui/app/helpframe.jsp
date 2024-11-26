<%@ page import="com.webmethods.portal.framework.portlet.beans.BasicPortletBean,
                 com.webmethods.portal.framework.portlet.beans.PortletControllerHelper,
                 com.webmethods.portal.service.portlet.impl.BasePortletBean,
                 com.webmethods.portal.system.IConstants,
                 com.webmethods.portal.system.cluster.IClusterProvider,
                 com.webmethods.portal.system.PortalSystem,
                 com.webmethods.portal.system.cluster.ISegment,
                 com.webmethods.portal.service.portlet.IPortletProvider,
                 com.webmethods.portal.service.meta2.thing.IThingID,
                 com.webmethods.portal.resources.Ui"%>
<%@ include file="/ui/system/taglibs.inc" %>
<%@ include file="/ui/system/beans.inc" %>

<%
    boolean bFullPage = true;
    String portletUri = null;
%>

<util:lookup item="layout" result="layout" default="" />
<%
    // if the layout is specified, we're full page, otherwise it's assumed
    // that we're rendered in a page.  When full page, we're
    // responsible for drawing the shell
    if( layout == null || layout.length() <= 0 )
    {
        // we're rendedered in place, use a null URI for the portet:bean so
        // that the current portlet is used
        bFullPage = false;
    }
    else
    {
        // we're not in-place, use the current resource as our portlet
        portletUri = "current.resource";
    }
%>

<%-- get a reference to the portlet bean --%>
<portlet:bean uri="<%=portletUri%>"id="portlet" className="com.webmethods.portal.service.portlet.impl.BasePortletBean">


<%
    String uniqueId = portlet.getId();
    IThingID thingId = portlet.getPortletThingID();

    String helpPage = portlet.getPropertyAsString("helpPage");
    if( helpPage != null && helpPage.length() > 0 )
    {
        // external url
        if (helpPage.startsWith("http")) {
            // do nothing, assume it's valid
        } else if (helpPage.startsWith(IConstants.FORWARD_SLASH)) {
            // relative to web root, account for a clustered environment
            StringBuffer link = new StringBuffer(0x100);
            IClusterProvider cp = (IClusterProvider) PortalSystem.getClusterProvider();
            ISegment segment = cp.getSegment();
            link.append(segment.getWebServerUrlPath());
            link.append(helpPage);
            helpPage = link.toString();
        } else {
            // relative to portlet, fixup the page URL
            IPortletProvider pp = (IPortletProvider) PortalSystem.getPortletProvider();
            helpPage = pp.getResourceLocation(thingId, helpPage, true);
        }

        /*
        // add a "return to previous layout" button
        String returnClick =PortletControllerHelper.getControllerUrl(thingId, "return", null, "", false, true, false);
        if (portlet instanceof BasicPortletBean)
        {
            BasicPortletBean basicPortlet = (BasicPortletBean)portlet;
            if ( basicPortlet.usePortletController() )
            {
                // we have a PCA portlet, the return click will return to the previous layout
                // String prevLayout = basicPortlet.getControllerBean().getPrevLayout();
                returnClick = PortletControllerHelper.getControllerUrl(portlet.getPortletThingID(), "void", "default", "", false, true, false);
            }
        }
        */
        %>
        <iframe id="helpframe<%=uniqueId%>" name="helpFrame" frameborder="0" src="<%=helpPage%>" width="100%" height="100%"></iframe>

        <script>
            function helpframe<%=uniqueId%>_load() {
                // when the frame is resized, attempt to expand the frame around the content
                var iframe = window.document.getElementById("helpframe<%=uniqueId%>");
                if (iframe != null) {
                    var coords = getElementOffset(iframe);
                    var bodyHeight = (window.document.body.scrollHeight < window.document.body.offsetHeight ? window.document.body.scrollHeight : window.document.body.offsetHeight);
                    var remainingHeight = window.document.body.clientHeight - bodyHeight + iframe.offsetHeight - 10;
                    if (remainingHeight > 0) {
                        iframe.height = remainingHeight;
                    }
                }
            }
            registerEvent("load", helpframe<%=uniqueId%>_load);
            registerEvent("resize", helpframe<%=uniqueId%>_load);
        </script>
        <%
    }
    else {
      %>
        <h3>
          <%=PortalSystem.localizeMessage(Ui.class, "help.not.available", null, false)%>
        </h3>
      <%
    }
%>


</portlet:bean>
