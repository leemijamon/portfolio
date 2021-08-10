<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MEM_LEVEL_LST_Table
   MEM_LEVEL_LST_Table = "MEM_LEVEL_LST"

   Dim MEM_LEVEL,ML_NAME,ML_USE_YN,ML_WDATE,ML_MDATE

   ML_NAME = Replace(Trim(Request.form("ml_name")),"'","''")
   ML_USE_YN = Trim(Request.Form("ml_use_yn"))
   ML_MDATE = NowDate
   MEM_LEVEL = Trim(Request.Form("mem_level"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "UPDATE " & MEM_LEVEL_LST_Table & " SET " _
       & "ML_NAME=N'" & ML_NAME & "', " _
       & "ML_USE_YN='" & ML_USE_YN & "', " _
       & "ML_MDATE='" & ML_MDATE & "' " _
       & "WHERE " _
       & "MEM_LEVEL='" & MEM_LEVEL & "'"

   Conn.Execute SQL, ,adCmdText

   Conn.Close
   Set Conn = nothing

   '##코드 생성
   Server.Execute "/admin/exec/make.conf.asp"

   Page_Msg_Parent_ScriptReload "회원등급을 변경하였습니다."
   response.end
%>
