<%@ include file="/ui/system/taglibs.inc" %>
<%@ include file="/ui/system/beans.inc" %>

<%@ page import="com.webmethods.portal.service.whitelist.ServerWhiteListProvider" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<%@ page import="org.slf4j.Logger" %>

<html>
<head>
    <title><util:message bundle="core" key="POP.013.0001" /></title>

<%
	String returnUrl = request.getParameter("url");
	if (returnUrl != null && !returnUrl.isEmpty()) {
		// Check for "protocol relative" URL/URI which is an absolute URL whose scheme
		// is inherited from the scheme of the current page.
		if (returnUrl.startsWith("//")) { //$NON-NLS-1$
			// add the expected scheme to the front so it can be parsed by the URL
			// class
			returnUrl = String.format("%s:%s", request.getScheme(), returnUrl); //$NON-NLS-1$
		}
	
		// all relative urls are assumed to be ok.
		if (!returnUrl.startsWith("/")) {
			// check the the URL is valid or the server is in the redirection
			// whitelist
			if (!ServerWhiteListProvider.validateURL(returnUrl, request)) {
				LoggerFactory.getLogger(getClass()).warn(
						"Attempted to redirect to external URL not in the redirection whitelist. If this is a valid redirect, please add it to the whitelist via the Redirection Whitelist Administration porlet. URL="
								+ returnUrl);
				returnUrl = "/page.error.redirect";
			}
		}
	}
%>

<script type="text/javascript">
/**
 * Redirects to the returnUrl specified on the query string
 */
function reroute() {
	let returnUrl = "<ui:encode type="js" expr='<%=returnUrl%>' />";
	let servletPath = "<jsp:getProperty name="presentationbean" property="canonicalServletPath" />";
	if (returnUrl.indexOf("http") != 0 && returnUrl.indexOf(servletPath) != 0) {
	    returnUrl = servletPath + returnUrl;
	}
	if (returnUrl.indexOf("page.error.redirect") == -1) {
		returnUrl = returnUrl + "&action=true";
	}
	document.location.href = returnUrl;
}
reroute();
</script>
</head>
<body bgcolor="#ffffff" marginwidth="0" marginheight="0" oncontextmenu="return false;">
<table width="100%" border="0">
    <tr>
	    <td><h4 family="arial" size="2"><util:message bundle="core" key="POP.013.0002" /><P><util:message bundle="core" key="POP.013.0003" /></h4></td>
    </tr>
</table>
</body>
</html>
