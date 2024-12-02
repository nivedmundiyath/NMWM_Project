<%@ include file="/ui/system/taglibs.inc" %>
<%@ include file="/ui/system/beans.inc" %>

<%@ page import="com.webmethods.portal.resources.Ui" %>
<%@ page import="com.webmethods.portal.system.PortalSystem" %>

<util:lookup item="name" result="name" default="" />
<util:lookup item="setName" result="setName" default="setName" />

<page:html title='<%=PortalSystem.localizeMessage(Ui.class, "POP.013.0014", null, false)%>'>

<script type="text/javascript">
/**
 * Called onLoad.
 */
function doLoad() {
    document.dialog.name.focus();
    
    // setup callback fns
    setName = window.opener.<%=setName%>
}
registerEvent("load", doLoad);

/**
 * Calls the setName() callback.
 * The opener window should set this windows setName() fn.
 */
function doSubmit(elForm) {
    setName(document.dialog.name.value);
    
    self.close();
    return false;
}
</script>
<table cellpadding="3" cellspacing="0" border="0" width="100%" height="100%" class="darkbg">
<form name="dialog" onSubmit="return doSubmit(this)">
    <tr>
      <td width="10" nowrap="1">&nbsp;</td>
      <td width="50%" class="formtitle"><util:message bundle="core" key="POP.013.0015" /></td>
      <td width="10" nowrap="1">&nbsp;</td>
      <td><input type="text" name="name" size="18" value="<%=name%>" /></td>
      <td width="100%">&nbsp;</td>
    </tr>
    <tr>
      <td width="10" nowrap="1">&nbsp;</td>
      <td colspan="3" align="right"><input type="submit" value="<util:message bundle="core" key="POP.013.0016" />" /></td>
      <td width="100%">&nbsp;</td>
    </tr>
  </form>
</table>
</page:html>
