<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   '설정파일변경
   Dim CmsControl
   Set CmsControl = Server.CreateObject("Server.CmsBuilder3")

   Dim Result, SavePath, CharSet

   SavePath = Server.MapPath("/conf")
   CharSet = "UTF-8" 'UTF-8

   Result = CmsControl.CmsConfig(Application("connect"), SavePath, CharSet)
   'response.write Result

   Set CmsControl = Nothing
%>