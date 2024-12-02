<%@include file="/ui/system/taglibs.inc" %>
<%@include file="/ui/system/beans.inc" %>
<%@page import="com.webmethods.portal.service.portlet.info.*,
                com.webmethods.rtl.util.WildcardMatcher,
                com.webmethods.portal.service.portlet.IPortletConstants" %>

<jsp:useBean id="portlet" scope="request" class="com.webmethods.portal.framework.portlet.beans.BasicPortletBean" />

<util:lookup scope="request" item="tabs_start" result="start" default="0" />
<util:lookup scope="request" item="tabs_count" result="count" default="-1" />
<util:lookup scope="request" item="tabs_include_filters" result="includes" default="*" />
<util:lookup scope="request" item="tabs_exclude_filters" result="excludes" default="" />

<% WildcardMatcher matcher = new WildcardMatcher(includes, excludes);  %>
<ui:tabsList>
    <util:iterate container="<%=java.util.Arrays.asList(portlet.getControllerInfo().getLayouts())%>" indexVar="layoutInfo" className="IPortletLayoutInfo" start="<%=Integer.parseInt(start)%>" limit="<%=Integer.parseInt(count)%>" >
        <util:if expr="<%=matcher.checkForMatch(layoutInfo.getName() )%>">
            <util:then>
                <ui:tab>
                    <util:param name="tab_name"><%=layoutInfo.getCaption()%></util:param>
                    <util:param name="tab_state"><%=(portlet.getLayout().equals(layoutInfo.getName())) ? "active" : "inactive"%></util:param>
                    <util:param name="tab_href"><portlet:controller layout="<%=layoutInfo.getName()%>" context="href"/></util:param>
                </ui:tab>
            </util:then>
        </util:if>
    </util:iterate>
</ui:tabsList>
