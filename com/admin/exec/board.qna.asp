<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/conf/send_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/send_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")
   SERVER_NAME = Request.ServerVariables("SERVER_NAME")

   Dim MSG,GO_PAGE
   Dim M_ITEM,M_TITLE,M_CONT

   PRO_METHOD = Trim(Request("method"))

   Dim QNA_LST_Table
   QNA_LST_Table = "QNA_LST"

   Dim Q_SEQ,Q_TYPE,Q_TITLE,Q_CONT,SO_SEQ,Q_ANSER,Q_ADATE,Q_RTN_MAIL,Q_RTN_SMS,Q_WDATE
   Dim Q_MDATE,MEM_SEQ,ADM_SEQ

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_NAME,MEM_ID,MEM_HP

   Q_SEQ = Trim(Request("q_seq"))
   Q_TYPE = Trim(Request.Form("q_type"))
   Q_RTN_MAIL = Trim(Request.Form("q_rtn_mail"))
   Q_RTN_SMS = Trim(Request.Form("q_rtn_sms"))
   Q_ADATE = NowDate
   Q_MDATE = NowDate
   MEM_SEQ = Trim(Request.Form("mem_seq"))
   ADM_SEQ = Trim(Request.Form("adm_seq"))

   RTNQUERY = Trim(Request.Form("rtnquery"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Select Case PRO_METHOD
      Case "register" : pro_register
      Case "modify" : pro_modify
      Case "delete" : pro_delete
   End Select

   Conn.Close
   Set Conn = nothing

   Sub pro_register()
      Q_TITLE = Trim(Request.Form("q_title"))
      Q_CONT = Trim(Request.Form("q_cont"))
      Q_ANSER = Trim(Request.form("content"))

      '#### 메일발송
      If Q_RTN_MAIL = "1" AND AM_QNA = "1" Then
         M_ITEM = "qna"
         M_TITLE = "{{회원명}}님 문의하신 사항을 이메일로 답변드립니다."

         Call MailRead()

         WHERE = "MEM_SEQ=" & MEM_SEQ

         SQL = "SELECT MEM_NAME,MEM_HP,MEM_EMAIL FROM " & MEM_LST_Table & " WHERE " & WHERE
         Set Rs = Conn.Execute(SQL, ,adCmdText)

         If Rs.BOF = false AND Rs.EOF = false Then
            MEM_NAME = Rs("MEM_NAME")
            MEM_HP = Rs("MEM_HP")
            MEM_EMAIL = Rs("MEM_EMAIL")
         End If
         Rs.close

         M_TITLE = Replace(M_TITLE, "{{회원명}}", MEM_NAME)

         M_CONT = Replace(M_CONT, "{{회원명}}", MEM_NAME)
         M_CONT = Replace(M_CONT, "{{문의제목}}", Q_TITLE)
         M_CONT = Replace(M_CONT, "{{문의내용}}", Q_CONT)
         M_CONT = Replace(M_CONT, "{{답변내용}}", Q_ANSER)

         mFrom = CS_NAME & "<" & CM_EMAIL & ">"
         mTo = MEM_NAME & "<" & MEM_EMAIL & ">"
         mSubject = M_TITLE
         mbody = M_CONT

         Call Send_Mail(mFrom,mTo,mSubject,mbody)
      End If

      '#### SMS발송
      If SMS_ID <> "" AND SMS_PWD <> "" AND Q_RTN_SMS = "1" Then
         If SEND_QUESTION_ANSWER = "1" Then
            SMS_QUESTION_ANSWER = Replace(SMS_QUESTION_ANSWER, "{사이트명}", CS_NAME)
            SMS_QUESTION_ANSWER = Replace(SMS_QUESTION_ANSWER, "{회원명}", MEM_NAME)

            rPhone = Replace(Replace(MEM_HP, "-", ""), ".", "")    '#### 수신자 번호 ####
            sPhone = Replace(Replace(SMS_SITE_TEL, "-", ""), ".", "")    '#### 발신자 번호 ####

            Call Sms_Send(SMS_ID,SMS_PWD,rPhone,sPhone,SMS_QUESTION_ANSWER)
         End If
      End If

      Q_TITLE = Replace(Trim(Request.Form("q_title")),"'","''")
      Q_ANSER = Replace(Trim(Request.form("content")),"'","''")

      SQL = "UPDATE " & QNA_LST_Table & " SET " _
          & "Q_TYPE=N'" & Q_TYPE & "', " _
          & "Q_RTN_MAIL='" & Q_RTN_MAIL & "', " _
          & "Q_RTN_SMS='" & Q_RTN_SMS & "', " _
          & "Q_TITLE=N'" & Q_TITLE & "', " _
          & "Q_ANSER=N'" & Q_ANSER & "', " _
          & "Q_ADATE='" & Q_ADATE & "', " _
          & "Q_MDATE='" & Q_MDATE & "' " _
          & "WHERE " _
          & "Q_SEQ=" & Q_SEQ

      Conn.Execute SQL, ,adCmdText

      Msg = "답변내용을 등록하였습니다.\n\n답변메일 및 문자를 발송하였습니다."
      AjaxURL Msg, "page/board.qna.asp"
   End Sub

   Sub pro_modify()
      Q_TITLE = Replace(Trim(Request.Form("q_title")),"'","''")
      Q_ANSER = Replace(Trim(Request.form("content")),"'","''")

      SQL = "UPDATE " & QNA_LST_Table & " SET " _
          & "Q_TYPE=N'" & Q_TYPE & "', " _
          & "Q_RTN_MAIL='" & Q_RTN_MAIL & "', " _
          & "Q_RTN_SMS='" & Q_RTN_SMS & "', " _
          & "Q_TITLE=N'" & Q_TITLE & "', " _
          & "Q_ANSER=N'" & Q_ANSER & "', " _
          & "Q_MDATE='" & Q_MDATE & "' " _
          & "WHERE " _
          & "Q_SEQ=" & Q_SEQ

      response.write SQL
      Conn.Execute SQL, ,adCmdText

      Msg = "답변내용을 수정하였습니다."
      AjaxURL Msg, "page/board.qna.asp?" & RTNQUERY
   End Sub

   Sub pro_delete()
      Q_STATE = "99"

      SQL = "UPDATE " & QNA_LST_Table & " SET " _
          & "Q_MDATE='" & Q_MDATE & "', " _
          & "Q_STATE='" & Q_STATE & "' " _
          & "WHERE " _
          & "Q_SEQ=" & Q_SEQ

      Conn.Execute SQL, ,adCmdText

      MSG = "제휴문의를 삭제하였습니다."
      AjaxURL Msg, "page/board.qna.asp"
   End Sub
%>
