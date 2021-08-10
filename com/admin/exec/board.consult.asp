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

   Dim CONSULT_LST_Table
   CONSULT_LST_Table = "CONSULT_LST"

   Dim C_TYPE,C_NAME,C_EMAIL,C_HP,C_TEL,C_TITLE,C_CONT,C_ANSER,C_ADATE,C_IP
   Dim C_WDATE,C_MDATE
   Dim C_SEQ

   C_SEQ = Trim(Request("c_seq"))
   C_TYPE = Trim(Request.Form("c_type"))
   C_NAME = Replace(Trim(Request.Form("c_name")),"'","''")
   C_EMAIL = Replace(Trim(Request.form("c_email")),"'","''")
   C_HP = Trim(Request.Form("c_hp"))
   C_TEL = Trim(Request.Form("c_tel"))
   C_ADATE = NowDate
   C_MDATE = NowDate
   ADM_SEQ = Trim(Request.Form("adm_seq"))

   RTNQUERY = Trim(Request.Form("rtnquery"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Select Case PRO_METHOD
      Case "registerall" : pro_register
      Case "registermall" : pro_register
      Case "registersms" : pro_register
      Case "modify" : pro_modify
      Case "delete" : pro_delete
   End Select

   Conn.Close
   Set Conn = nothing

   Sub pro_register()
      C_TITLE = Trim(Request.Form("c_title"))
      C_CONT = Trim(Request.Form("c_cont"))
      C_ANSER = Trim(Request.form("content"))

      '#### 메일발송
      If AM_QNA = "1" AND (PRO_METHOD="registerall" OR PRO_METHOD="registermall") Then
         M_ITEM = "consult"
         M_TITLE = "{{회원명}}님 문의하신 사항을 이메일로 답변드립니다."

         Call MailRead()

         M_TITLE = Replace(M_TITLE, "{{회원명}}", C_NAME)

         M_CONT = Replace(M_CONT, "{{회원명}}", C_NAME)
         M_CONT = Replace(M_CONT, "{{문의제목}}", C_TITLE)
         M_CONT = Replace(M_CONT, "{{문의내용}}", C_CONT)
         M_CONT = Replace(M_CONT, "{{답변내용}}", C_ANSER)

         mFrom = CS_NAME & "<" & CM_EMAIL & ">"
         mTo = C_NAME & "<" & C_EMAIL & ">"
         mSubject = M_TITLE
         mbody = M_CONT

         Call Send_Mail(mFrom,mTo,mSubject,mbody)
      End If

      '#### SMS발송
      If SMS_ID <> "" AND SMS_PWD <> "" AND (PRO_METHOD="registerall" OR PRO_METHOD="registersms") Then
         If SEND_CONSULT_ANSWER = "1" Then
            SMS_CONSULT_ANSWER = Replace(SMS_CONSULT_ANSWER, "{사이트명}", CS_NAME)
            SMS_CONSULT_ANSWER = Replace(SMS_CONSULT_ANSWER, "{신청자}", C_NAME)

            rPhone = Replace(Replace(C_HP, "-", ""), ".", "")    '#### 수신자 번호 ####
            sPhone = Replace(Replace(SMS_SITE_TEL, "-", ""), ".", "")    '#### 발신자 번호 ####

            Call Sms_Send(SMS_ID,SMS_PWD,rPhone,sPhone,SMS_CONSULT_ANSWER)
         End If
      End If

      C_TITLE = Replace(Trim(Request.Form("c_title")),"'","''")
      C_ANSER = Replace(Trim(Request.form("content")),"'","''")

      SQL = "UPDATE " & CONSULT_LST_Table & " SET " _
          & "C_TYPE=N'" & C_TYPE & "', " _
          & "C_NAME=N'" & C_NAME & "', " _
          & "C_EMAIL=N'" & C_EMAIL & "', " _
          & "C_HP=N'" & C_HP & "', " _
          & "C_TEL=N'" & C_TEL & "', " _
          & "C_TITLE=N'" & C_TITLE & "', " _
          & "C_ANSER=N'" & C_ANSER & "', " _
          & "C_ADATE='" & C_ADATE & "', " _
          & "C_MDATE='" & C_MDATE & "' " _
          & "WHERE " _
          & "C_SEQ=" & C_SEQ

      Conn.Execute SQL, ,adCmdText

      Msg = "답변내용을 등록하였습니다.\n\n답변메일 및 문자를 발송하였습니다."
      AjaxURL Msg, "page/board.consult.asp"
   End Sub

   Sub pro_modify()
      C_TITLE = Replace(Trim(Request.Form("c_title")),"'","''")
      C_ANSER = Replace(Trim(Request.form("content")),"'","''")

      SQL = "UPDATE " & CONSULT_LST_Table & " SET " _
          & "C_TYPE=N'" & C_TYPE & "', " _
          & "C_NAME=N'" & C_NAME & "', " _
          & "C_EMAIL=N'" & C_EMAIL & "', " _
          & "C_HP=N'" & C_HP & "', " _
          & "C_TEL=N'" & C_TEL & "', " _
          & "C_TITLE=N'" & C_TITLE & "', " _
          & "C_ANSER=N'" & C_ANSER & "', " _
          & "C_MDATE='" & C_MDATE & "' " _
          & "WHERE " _
          & "C_SEQ=" & C_SEQ

      Conn.Execute SQL, ,adCmdText

      Msg = "답변내용을 수정하였습니다."
      AjaxURL Msg, "page/board.consult.asp?" & RTNQUERY
   End Sub

   Sub pro_delete()
      C_STATE = "99"

      SQL = "UPDATE " & CONSULT_LST_Table & " SET " _
          & "C_MDATE='" & C_MDATE & "', " _
          & "C_STATE='" & C_STATE & "' " _
          & "WHERE " _
          & "C_SEQ=" & C_SEQ

      Conn.Execute SQL, ,adCmdText

      MSG = "온라인문의를 삭제하였습니다."
      AjaxURL Msg, "page/board.consult.asp"
   End Sub
%>
