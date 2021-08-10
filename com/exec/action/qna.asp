<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/conf/send_config.inc" -->
<!-- #include virtual = "/exec/module/send_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim QNA_LST_Table
   QNA_LST_Table = "QNA_LST"

   Dim Q_SEQ,Q_TYPE,Q_TITLE,Q_CONT,Q_CS_DISP,SO_SEQ,SG_SEQ,Q_ANSER,Q_ADATE,Q_RTN_MAIL
   Dim Q_RTN_SMS,Q_READCNT,Q_IP,Q_WDATE,Q_MDATE,Q_STATE,MEM_SEQ,ADM_SEQ

   PRO_METHOD = Trim(Request("method"))

   Dim MSG,GO_PAGE

   Q_SEQ = Trim(Request("q_seq"))
   Q_TYPE = Trim(Request.Form("q_type"))
   Q_TITLE = Replace(Server.HTMLEncode(Trim(Request.form("q_title"))),"'","''")
   Q_CONT = Replace(Server.HTMLEncode(Trim(Request.form("q_cont"))),"'","''")
   Q_RTN_MAIL = Trim(Request.Form("q_rtn_mail"))
   Q_RTN_SMS = Trim(Request.Form("q_rtn_sms"))
   Q_READCNT = 0
   Q_IP = Request.ServerVariables("Remote_Addr")
   Q_WDATE = NowDate
   Q_MDATE = NowDate

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Select Case PRO_METHOD
      Case "write" : pro_write
      Case "delete" : pro_delete
   End Select

   Conn.Close
   Set Conn = nothing

   Sub pro_write()
      If Session("MEM_SEQ") = "" Then
         Page_Msg_Href "회원정보를 찾을 수 없습니다.", "?method=list"
         Response.End
      End If

      MEM_SEQ = Session("MEM_SEQ")
      MEM_NAME = Session("MEM_NAME")

      Q_STATE = "00"

      SQL = "INSERT INTO " & QNA_LST_Table _
          & " (Q_TYPE,Q_TITLE,Q_CONT,Q_RTN_MAIL,Q_RTN_SMS,Q_READCNT,Q_IP,Q_WDATE,Q_MDATE,Q_STATE,MEM_SEQ)" _
          & " VALUES (N'" _
          & Q_TYPE & "',N'" _
          & Q_TITLE & "','" _
          & Q_CONT & "','" _
          & Q_RTN_MAIL & "','" _
          & Q_RTN_SMS & "'," _
          & Q_READCNT & ",N'" _
          & Q_IP & "','" _
          & Q_WDATE & "','" _
          & Q_MDATE & "','" _
          & Q_STATE & "'," _
          & MEM_SEQ & ")"

      Conn.Execute SQL, ,adCmdText

      '#### SMS발송
      SMS_QUESTION_ADM = Replace(SMS_QUESTION_ADM, "{사이트명}", CS_NAME)
      SMS_QUESTION_ADM = Replace(SMS_QUESTION_ADM, "{회원명}", MEM_NAME)

      sPhone = Replace(Replace(SMS_SITE_TEL, "-", ""), ".", "")    '#### 발신자 번호 ####

      If SEND_QUESTION_ADM = "1" AND Left(SMS_ADMIN_HP, 2) = "01" Then
         rPhone = Replace(Replace(SMS_ADMIN_HP, "-", ""), ".", "")    '#### 수신자 번호 ####
         Call Sms_Send(SMS_ID,SMS_PWD,rPhone,sPhone,SMS_QUESTION_ADM)
      End If

      If SEND_QUESTION_MA = "1" AND Left(SMS_MA_HP, 2) = "01" Then
         rPhone = Replace(Replace(SMS_MA_HP, "-", ""), ".", "")    '#### 수신자 번호 ####
         Call Sms_Send(SMS_ID,SMS_PWD,rPhone,sPhone,SMS_QUESTION_ADM)
      End If

      Page_Msg_Href "입력하신 내용을 상담신청 하였습니다.", "?method=list"
   End Sub

   Sub pro_delete()
      If Session("MEM_SEQ") = "" Then
         Page_Msg_Href "회원정보를 찾을 수 없습니다.", "?method=list"
         Response.End
      End If

      MEM_SEQ = Session("MEM_SEQ")

      Q_STATE = "99"

      SQL = "UPDATE " & QNA_LST_Table & " SET " _
          & "Q_MDATE='" & Q_MDATE & "', " _
          & "Q_STATE='" & Q_STATE & "' " _
          & "WHERE " _
          & "Q_SEQ=" & Q_SEQ

      Conn.Execute SQL, ,adCmdText

      Page_Msg_Href "상담내역을 삭제하였습니다.", "?method=list"
   End Sub
%>
