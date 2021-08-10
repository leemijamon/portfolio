<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_SEQ,MEM_SECEDE,MEM_SECEDE_DETAIL,MEM_MDATE,MEM_STATE

   MEM_SEQ = Trim(Request.Form("mem_seq"))
   MEM_SECEDE = Trim(Request.Form("mem_secede"))
   MEM_SECEDE_DETAIL = Replace(Trim(Request.Form("mem_secede_detail")),"'","''")
   MEM_MDATE = NowDate
   MEM_STATE = "92" '관리자탈퇴

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "SELECT * FROM " & MEM_LST_Table & " WHERE MEM_SEQ=" & MEM_SEQ & " AND MEM_STATE < '90'"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF OR Rs.EOF Then
      Alert_Msg "회원정보를 찾을수 없습니다."
      response.end
   End If
   Rs.close

   SQL = "UPDATE " & MEM_LST_Table & " SET " _
       & "MEM_SECEDE='" & MEM_SECEDE & "', " _
       & "MEM_SECEDE_DETAIL='" & MEM_SECEDE_DETAIL & "', " _
       & "MEM_MDATE='" & MEM_MDATE & "', " _
       & "MEM_STATE='" & MEM_STATE & "' " _
       & "WHERE " _
       & "MEM_SEQ=" & MEM_SEQ

   Conn.Execute SQL, ,adCmdText

   Conn.Close
   Set Conn = nothing

   Msg = "정상적으로 탈퇴처리 되었습니다."
   loadURL Msg, "member/list"
%>