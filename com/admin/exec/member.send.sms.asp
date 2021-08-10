<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/send_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   S_FROM = Replace(Trim(Request.form("s_from")),"'","''")
   S_FROM = Replace(Replace(S_FROM, "-", ""), ".", "")
   S_CONT = Trim(Request.form("s_cont"))

   MEM_LEVEL = Trim(Request.form("mem_level"))
   WHERE = Trim(Request.Form("where"))

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_NAME,MEM_ID,MEM_HP

   If MEM_LEVEL = "99" Then
      MEM_NAME = "테스트"
      MEM_ID = "test"
      MEM_HP = Trim(Request.form("sms_test"))
      SEND_CONT = S_CONT

      SEND_CONT = Replace(SEND_CONT, "{{회원명}}", MEM_NAME)
      SEND_CONT = Replace(SEND_CONT, "{{아이디}}", MEM_ID)
      MEM_HP = Replace(Replace(MEM_HP, "-", ""), ".", "")

      If Left(MEM_HP, 2) = "01" Then Sms_Send SMS_ID,SMS_PWD,MEM_HP,S_FROM,SEND_CONT
   Else
      SQL = "SELECT MEM_NAME, MEM_ID, MEM_HP FROM " & MEM_LST_Table & " WHERE "

      If MEM_LEVEL <> "00" Then
         '회원그룹
         SQL = SQL & "MEM_HP <> '' AND MEM_HP IS NOT NULL AND MEM_SMS_YN='1' AND MEM_STATE < '90' AND MEM_LEVEL = '" & MEM_LEVEL & "'"
      Else
         If WHERE <> "" Then
            '검색회원
            SQL = SQL & WHERE
         Else
            '전체회원
            SQL = SQL & "MEM_HP <> '' AND MEM_HP IS NOT NULL AND MEM_SMS_YN='1' AND MEM_STATE < '90'"
         End If
      End If

      Dim Conn, Rs
      Set Conn = Server.CreateObject("ADODB.Connection")
      Conn.Open Application("connect")

      'SQL = "SELECT MEM_NAME, MEM_ID, MEM_HP FROM " & MEM_LST_Table & " WHERE MEM_HP <> '' AND MEM_HP IS NOT NULL AND MEM_SMS_YN='1' AND MEM_STATE < '90'"
      'If MEM_LEVEL <> "00" Then SQL = SQL & " AND MEM_LEVEL = '" & MEM_LEVEL & "'"

      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Do until Rs.EOF
            MEM_NAME = Rs("MEM_NAME")
            MEM_ID = Rs("MEM_ID")
            MEM_HP = Rs("MEM_HP")

            SEND_CONT = S_CONT

            SEND_CONT = Replace(SEND_CONT, "{{회원명}}", MEM_NAME)
            SEND_CONT = Replace(SEND_CONT, "{{아이디}}", MEM_ID)
            MEM_HP = Replace(Replace(MEM_HP, "-", ""), ".", "")

            If Left(MEM_HP, 2) = "01" Then Sms_Send SMS_ID,SMS_PWD,MEM_HP,S_FROM,SEND_CONT

            Rs.MoveNext
         Loop
      End If
      Rs.close

      Conn.Close
      Set Conn = nothing
   End If

   Page_Msg_ParentReload "SMS를 발송하였습니다."
   response.end
%>
