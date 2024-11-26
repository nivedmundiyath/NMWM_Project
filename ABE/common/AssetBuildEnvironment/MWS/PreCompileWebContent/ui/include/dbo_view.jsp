<%@include file="/ui/system/taglibs.inc" %>
<%@include file="/ui/system/beans.inc" %>

<jsp:useBean id="xtypeBean" scope="request" class="com.webmethods.portal.service.meta2.thing.IThing" />

<% String uri = xtypeBean.getThingID().toString(); %>

<portlet:info id="info" uri="<%=uri%>" >
<table cellpadding="0" cellspacing="0" border="0" width="100%">
  <tr>
    <td>
        <view:view id="properties" uri="<%=uri%>">
            <portlet:propertyGroups properties="properties" info="info" excludeGroups="location,publish,instance,file" excludePropTypes="session,config,user" readonly="true" />
        </view:view>
   </td>
  </tr>
</table>
</portlet:info>
