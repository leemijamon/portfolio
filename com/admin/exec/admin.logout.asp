<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Session("ADM_SEQ") = ""
   Session("ADM_TYPE") = ""
   Session("ADM_NAME") = ""
   Session("ADM_ID") = ""
   Session("ADM_TEL") = ""
   Session("ADM_HP") = ""
   Session("ADM_EMAIL") = ""
   Session("ADM_PERMIT") = ""
   Session("ADM_IP") = ""

   Call Page_ParentReload()
   response.end
%>
