<%-- note the form is started in wizard_header.inc  --%>

<%@ taglib uri="http://webmethods.com/portal/taglib/portlet" prefix="portlet" %>
<%@ taglib uri="http://webmethods.com/portal/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://webmethods.com/portal/taglib/util" prefix="util" %>

<ui:propertySubmit>
  <util:param name="property_submit_fn">onWizardFinish</util:param>
  <util:param name="property_submit_cancel_fn">onWizardCancel</util:param>
  <util:param name="property_submit_next_fn">onWizardNext</util:param>
  <util:param name="property_submit_prev_fn">onWizardPrev</util:param>
  <util:param name="property_submit"><util:if expr="<%=!portlet.hasFinish()%>"><util:then>none</util:then><util:else>  <%=portlet.getFinishCaption()%>  </util:else></util:if></util:param>
  <util:param name="property_submit_cancel"><util:if expr="<%=!portlet.hasCancel()%>"><util:then>none</util:then><util:else>  <%=portlet.getCancelCaption()%>  </util:else></util:if></util:param>
  <util:param name="property_submit_prev"><%=portlet.hasPrev()%></util:param>
  <util:param name="property_submit_next"><%=portlet.hasNext()%></util:param>
</ui:propertySubmit>
          
</portlet:controller>

