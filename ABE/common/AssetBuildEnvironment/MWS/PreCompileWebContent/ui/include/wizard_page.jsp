<%@ taglib uri="http://webmethods.com/portal/taglib/portlet" prefix="portlet" %>

<portlet:bean id="portlet" className="com.webmethods.portal.framework.portlet.beans.JspWizardPortletBean" >

<%@include file="/ui/include/wizard_header.inc" %>
<portlet:propertyGroup name="<%=portlet.getLayout()%>" />
<%@include file="/ui/include/wizard_footer.inc" %>

</portlet:bean>