<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim CMS_SKIN_LST_Table
   CMS_SKIN_LST_Table = "CMS_SKIN_LST"

   Dim CS_CODE,CS_STATE

   CS_CODE = Trim(Request.Form("cs_code"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "UPDATE " & CMS_SKIN_LST_Table & " SET " _
       & "CS_STATE='00' " _
       & "WHERE CS_STATE='01'"

   Conn.Execute SQL, ,adCmdText

   SQL = "UPDATE " & CMS_SKIN_LST_Table & " SET " _
       & "CS_STATE='01' " _
       & "WHERE CS_CODE='" & CS_CODE & "'"

   Conn.Execute SQL, ,adCmdText

   Conn.Close
   Set Conn = nothing

   loadURL "스킨을 \'" & CS_CODE & "\'으로 활성화 하였습니다.", "skin.active"
   response.end
%>
