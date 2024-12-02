<%@ include file="/ui/system/taglibs.inc" %>
<%@ include file="/ui/system/beans.inc" %>
<%@ page import="com.webmethods.portal.service.meta2.type.IXType,
                 com.webmethods.portal.system.PortalSystem,
                 com.webmethods.portal.service.meta2.IMetaManager,
                 com.webmethods.portal.service.portlet.IPortletProvider,
                 com.webmethods.portal.service.portlet.impl.XTypeEditPropertyListFilter,
                 java.util.Iterator,
                 com.webmethods.portal.service.portlet.info.*,
                 com.webmethods.rtl.util.obj.IPropertyBag,
                 com.webmethods.portal.mech.storage.impl.ThingToPropertyBagAdapter"%>

<util:lookup scope="request" item="step" result="step" default="first" />
<util:lookup scope="request" item="property" result="sProp" default="" />

<util:lookup item="add" result="add" default="add" />
<util:lookup item="id" result="id" default="" />

<page:html title="Property Picker">

        <script type="text/javascript">
        function doLoad() {
            // register callback fns
            add = window.opener.<%=add%>;
        }
        registerEvent("load", doLoad);

        function doSubmit(elForm)
        {
            var sOption = getInputValue(elForm.propname);
            if ("<%=step %>" == "first") {
                if (elForm.propname) {
                    var sUrl =  g_sFullServletPath + "?layout=proppicker&hiddenRequest=true&id=<%=id %>&add=<%=add %>&step=second&property=" + sOption;
                    window.location.href = sUrl;
                    return false;
                 } else {
                    window.close();
                    return false;
                 }
            } else {

                if (sOption == "") {
                    alert("<util:message bundle="core" key="POP.013.0008" />");
                    return false;
                }
                var elPropValue = eval("elForm." + elForm.propname.value);
                var sPropValue = getInputValue(elPropValue, "none");
                if (sPropValue == "" || sPropValue == "none") {
                    alert("<util:message bundle="core" key="POP.013.0009" />");
                    elPropValue.focus();
                    return false;
                }
                sOption = sOption + "=" + sPropValue;

                add(sOption, sOption);
                window.close();
            }
        }

        function doCancel(elForm) {
            window.close();
        }

        </script>
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <form name="proppicker" onSubmit="doSubmit(this); return false;">
                <tr>
                    <td colspan="4" height="10" width="10"><ui:img width="10" height="10" border="0" alt="" src="dot.gif" /></td>
                </tr>
        </table>
        <% if (step.equals("first")) { %>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td height="20" width="10"><ui:img width="10" height="20" border="0" alt="" src="dot.gif" /></td>
                    <%  boolean bxTypeExists = false;
                        int xtypeID = Integer.parseInt (id);
                        IXType xTypeObj = ((IMetaManager)PortalSystem.getMetaProvider()).getDefaultContext().getXTypeService().getXType(xtypeID);
                        IPortletInfo info = ((IPortletProvider)PortalSystem.getPortletProvider()).getPortletInfo(xTypeObj.getThingID());
                        bxTypeExists = true;

                        //IPropertyBag props = new ThingToPropertyBagAdapter(currentNode);
                        IPortletPropertyListFilter filter = new XTypeEditPropertyListFilter(null, null, null, true);
                        boolean hasOneProperty = false;
                        Iterator it = info.getPropertyInfos (filter);
                        if (it.hasNext()) {
                    %>
                        <td nowrap="1"><util:message bundle="core" key="POP.013.0010" />&nbsp;</td>
                        <td width="100%">
                            <select name="propname" class="picker">
                                <% while (it.hasNext ()) {
										IPortletPropertyInfo prop = (IPortletPropertyInfo)it.next ();
										if(!prop.isHidden() && !(prop.getType() == IPortletPropertyInfo.PROPERTY_TYPE_SYSTEM)) {
                                %>
											<option value="<%=prop.getName()%>"><%=prop.getEditorTitle()%></option>
									 <% } %>
                                <% } %>
                            </select>
                        </td>
                    <% } else { %>
                        <td width="100%"><util:message bundle="core" key="POP.013.0011" /></td>
                    <% } %>
                    <td height="20" width="10"><ui:img width="10" height="20" border="0" alt="" src="dot.gif" /></td>
                </tr>
            </table>
        <% } else { %>
        <%--
        <%
            int xtypeID = Integer.parseInt (id);
            IXType xTypeObj = ((IMetaManager)PortalSystem.getMetaProvider()).getDefaultContext().getXTypeService().getXType(xtypeID);
        %>
            <portlet:info uri="<%=xTypeObj.getThingID().toString()%>" id="info" >
                <portlet:propertyGroups includeProps="<%=sProp%>" info="info" properties="info" >
                    <util:param name="property_line_form" value="properties" />
                    <util:param name="property_line_value" value="" />
                </portlet:propertyGroups>
            </portlet:info>
        --%>
            <%  boolean bxTypeExists = false;
                int xtypeID = Integer.parseInt (id);
                IXType xTypeObj = ((IMetaManager)PortalSystem.getMetaProvider()).getDefaultContext().getXTypeService().getXType(xtypeID);
                bxTypeExists = true;
            %>
                <input type="hidden" name="propname" value="<%=sProp%>" />

                <portlet:info uri="<%=xTypeObj.getThingID().toString()%>" id="info" >
                    <portlet:propertyLine name="<%=sProp%>" portletInfo="info" properties="info" >
                        <util:param name="property_line_form" value="proppicker" />
                        <util:param name="property_line_hasAccess">true</util:param>
                        <util:param name="property_line_value" value="" />
                    </portlet:propertyLine>
                </portlet:info>
        <% } %>
        <table width="100%" cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td>
                    <ui:propertySubmit>
                        <util:param name="property_submit"><% if (step.equals("first")) { %><util:message bundle="core" key="POP.013.0012" /><% } else { %><util:message bundle="core" key="POP.013.0013" /><% } %></util:param>
                        <util:param name="property_submit_popup" value="true" />
                    </ui:propertySubmit>
                </td>
            </tr>
        </form>
        </table>
</page:html>
