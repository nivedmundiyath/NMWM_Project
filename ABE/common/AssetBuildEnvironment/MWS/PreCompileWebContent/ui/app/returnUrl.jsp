<%@ taglib uri="http://webmethods.com/portal/taglib/ui" prefix="ui" %>
<jsp:useBean id="presentationbean" class="com.webmethods.portal.framework.presentation.PresentationData" scope="request" />

<html>
<head>
<%
//first try the request attribute
String returnUrl = null;
Object attr = request.getAttribute("returnUrl");
if (attr instanceof String) {
	returnUrl = (String)request.getAttribute("returnUrl");
}
if (returnUrl == null || returnUrl.length() == 0) {
    //no request attriute, so try the request parameter
    returnUrl = request.getParameter("returnUrl");   
}

if (returnUrl != null && returnUrl.length() > 0) {
    //Check for "protocol relative" URL/URI which is an absolute URL whose scheme is inherited
    // from the scheme of the current page.
    if (returnUrl.startsWith("//")) { //$NON-NLS-1$
        //add the expected scheme to the front so it can be parsed by the URL class
        returnUrl = String.format("%s:%s", request.getScheme(), returnUrl); //$NON-NLS-1$
    }

    //all relative urls are assumed to be ok.
    if (!returnUrl.startsWith("/")) {        
        // check the the URL is valid or the server is in the redirection whitelist
        if( !com.webmethods.portal.service.whitelist.ServerWhiteListProvider.validateURL(returnUrl, request) ) {
        	com.webmethods.rtl.util.Debug.warn("Attempted to redirect to external URL not in the redirection whitelist.  If this is a valid redirect, please add it to the whitelist via the Redirection Whitelist Administration porlet.  URL=" + returnUrl );
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
    var returnUrl = "<ui:encode type="js" expr='<%=returnUrl%>' />";
    if (returnUrl != "") {
        var servletPath = "<jsp:getProperty name="presentationbean" property="canonicalServletPath" />";
        if (returnUrl.indexOf("http") != 0 && returnUrl.indexOf(servletPath) != 0) {
            returnUrl = servletPath + returnUrl;
        }
        
        window.location.href = returnUrl;

    } else {
        window.history.back();
    }
}
reroute();
</script>
</head>
<body>
</body>
</html>