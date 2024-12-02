<%@ taglib uri="http://webmethods.com/portal/taglib/portlet" prefix="portlet" %>
<%@ taglib uri="http://webmethods.com/portal/taglib/ui" prefix="ui" %>
<%@ taglib uri="http://webmethods.com/portal/taglib/util" prefix="util" %>

<% String scriptID = portlet.getId(); %>

<portlet:controller name='<%="wizardForm" + scriptID %>' context="form" method="finish" >
<%-- note the form is continued onto wizard_footer.  --%>
