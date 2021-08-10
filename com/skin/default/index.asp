<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<%
If Request.ServerVariables("Remote_Addr") <> "211.108.168.96" Then 
	If Datediff( "s", Now(), "2020-03-27 AM 04:00:00") <= 0 And Datediff( "s", Now(), "2020-03-27 AM 06:00:00") >= 0 Then 
		Response.Redirect "/zunder_construction.asp"
	End If 
End If 
%>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/skin/default/conf/menu_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   URL = Trim(Request("url"))
   If URL = "" OR URL = "/index.asp" Then URL = "index"
   If Right(URL,1) = "/" Then URL = Left(URL,Len(URL)-1)

   PAGE_SEQ = f_arr_value(PAGE_URL, PAGE_SEQ, URL)

   If PAGE_SEQ = "" Then
      EXEC_FILE = "/skin/default/execpage/notpage.asp"
   Else
      LAYOUT = PAGE_LAYOUT(PAGE_SEQ)
      EXEC_FILE = "/skin/default/layout/" & LAYOUT & ".asp"

   End If
   Server.Execute(EXEC_FILE)
%>
