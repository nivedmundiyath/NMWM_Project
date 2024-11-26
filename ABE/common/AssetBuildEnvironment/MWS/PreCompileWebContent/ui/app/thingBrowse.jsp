<%@ include file="/ui/system/taglibs.inc" %>
<%@ include file="/ui/system/beans.inc" %>

<page:html>
    <view:view id="thing" uri="current.resource">
    <%
    Object parentId = thing.getProperty("parentId");
    String parentUri = (parentId != null ? parentId.toString() : "");
    %>
        <view:view id="parent" uri="<%=parentUri%>">
        <table cellpadding="3" cellspacing="0" border="0" width="100%">
            <tr>
                <td class="portlet-section-body" width="45%" align="right"><%=parent.getURI()%></td>
                <td class="portlet-section-body" width="5%" align="center"><img src="<view:icon view="parent" />" width="16" height="16" border="0" align="absmiddle" /></td>
                <td class="portlet-section-body" width="50%">up to <ui:a href='<%=String.valueOf(parent.getURI()) + "?layout=thingBrowse"%>' css="portlet-section-body"><ui:encode type="html"><%=parent.getProperty("name")%></ui:encode></ui:a></td>
            </tr>
        </table>
        </view:view>
        <table cellpadding="3" cellspacing="0" border="0" width="100%">
            <tr>
                <td class="portlet-section-header" width="45%" align="right"><%=thing.getURI()%></td>
                <td class="portlet-section-header" width="5%" align="center"><img src="<view:icon view="thing" />" width="16" height="16" border="0" align="absmiddle" /></td>
                <td class="portlet-section-header" width="50%"><ui:encode type="html"><%=thing.getProperty("name")%></ui:encode></td>
            </tr>
        </table>
        <view:cookie id="cookie" uri="<%=thing.getURI().toString()%>" name="thingBrowse" pageSize="1000" sort="name">
        <view:list id="child" uri="current.resource" command="listChildren" params="includeItems=true&view=thingBrowse&depth=1&rights=1">
            <table cellpadding="3" cellspacing="0" border="0" width="100%">
                <tr>
                    <td class="portlet-section-body" width="45%" align="right"><%=child.getURI()%></td>
                    <td class="portlet-section-body" width="5%" align="center"><img src="<view:icon view="child" />" width="16" height="16" border="0" align="absmiddle" /></td>
                    <td class="portlet-section-body" width="50%"><ui:a href='<%=child.getURI() + "?layout=thingBrowse"%>' css="portlet-section-body"><ui:encode type="html"><%=child.getProperty("name")%></ui:encode></ui:a></td>
                </tr>
            </table>
        </view:list>
        </view:cookie>
    </view:view>
</page:html>
