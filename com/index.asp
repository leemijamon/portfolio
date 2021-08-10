<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   If Request("action") <> "" Then
      EXEC_FILE = "/exec/action/" & Request("action") & ".asp"
      Server.Execute(EXEC_FILE)
   Else
      If request("skin") <> "" Then Session("SKIN") = request("skin")
      If Session("SKIN") <> "" Then SKIN = Session("SKIN")

      EXEC_FILE = "/skin/" & SKIN & "/index.asp"
      Server.Execute(EXEC_FILE)

      Server.Execute("/exec/log/check.asp")
'      Server.Execute("/main.asp")
   End If
%>
