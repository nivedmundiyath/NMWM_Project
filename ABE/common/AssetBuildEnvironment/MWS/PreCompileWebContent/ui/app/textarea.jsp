<%@ include file="/ui/system/taglibs.inc" %>
<%@ include file="/ui/system/beans.inc" %>

<util:lookup item="add" result="add" default="add" />
<util:lookup item="cancel" result="cancel" default="cancel" />
<util:lookup item="default" result="defaultValue" default="" />
<util:lookup item="content" result="content" default="" />
<util:lookup item="columns" result="columns" default="90" />
<util:lookup item="rows" result="rows" default="20" />
<util:lookup item="wrap" result="wrap" default="soft" />

<%
int nsColumns = 2 * Integer.parseInt(columns) / 3;
%>

<page:html popups="false">

<script type="text/javascript">
function doLoad() {
    var elForm = document.dialog;
    var sDefault = "<ui:encode type="js" expr="<%=defaultValue%>" />";
    
    if (sDefault.length < 1 && "<%=content%>".length > 0) {
        sDefault = window.opener.<%=content%>();
    }
    
    elForm.textarea.value = sDefault;
    elForm.textarea.focus();
    //elForm.textarea.select();
}
registerEvent("load", doLoad);

function doSubmit(elForm) {
    var sValue = trimString(elForm.textarea.value);
    
    if (window.opener.<%=add%>(sValue) != false) {
        window.close();
    }
    
    return false;
}

function doCancel(elForm) {
    if (window.opener.<%=cancel%>() != false) {
        window.close();
    }
}
</script>

<table cellpadding="0" cellspacing="0" border="0" width="100%" height="100%" class="lightbg">
<tr><td align="center" valign="middle">
  <table cellpadding="3" cellspacing="0" border="0" align="center" valign="middle">
    <form name="dialog">
      <tr>
        <td width="10" nowrap="1">&nbsp;</td>
        <td valign="top"><textarea wrap="<%=wrap%>" cols="<ui:browser is="ns4"><%=nsColumns%></ui:browser><ui:browser isNot="ns4"><%=columns%></ui:browser>" rows="<%=rows%>" name="textarea"></textarea></td>
        <td width="10">&nbsp;</td>
      </tr>
      <tr>
        <td width="10" nowrap="1">&nbsp;</td>
        <td align="right"><input class="portlet-form-button" type="button" value="<util:message bundle="core" key="POP.013.0017" />" onclick="doSubmit(this.form)" />&nbsp;&nbsp;<input class="portlet-form-button" type="button" value="<util:message bundle="core" key="POP.013.0018" />" onclick="doCancel(this.form);"/></td>
        <td width="10">&nbsp;</td>
      </tr>
    </form>
  </table>
</td></tr>
</table>
</page:html>
