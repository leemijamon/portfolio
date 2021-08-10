<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim LOG_VISIT_LST_Table
   LOG_VISIT_LST_Table = "LOG_VISIT_LST"

   Dim LV_IP

   LV_IP = Trim(Request("lv_ip"))

   SQL = "DELETE FROM " & LOG_VISIT_LST_Table & " WHERE LV_IP='" & LV_IP & "'"

   Conn.Execute SQL, ,adCmdText

   Conn.Close
   Set Conn = nothing

   loadURL "로그 데이터를 삭제 하였습니다.", "state/ip"
   response.end
%>
