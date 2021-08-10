<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/conf/send_config.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/send_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim CONSULT_LST_Table
   CONSULT_LST_Table = "CONSULT_LST"

   Dim C_TYPE,C_NAME,C_EMAIL,C_HP,C_TEL,C_TITLE,C_CONT,C_ANSER,C_ADATE,C_IP
   Dim C_WDATE,C_MDATE,C_STATE

   C_TYPE = Trim(Request.Form("c_type"))
   C_NAME = Replace(Trim(Request.Form("c_name")),"'","''")
   C_EMAIL = Replace(Trim(Request.form("c_email")),"'","''")
   C_HP = Replace(Trim(Request.form("c_hp")),"'","''")
   C_TEL = Replace(Trim(Request.form("c_tel")),"'","''")
   C_TITLE = Replace(Trim(Request.Form("c_title")),"'","''")
   C_CONT = Replace(Server.HTMLEncode(Trim(Request.form("c_cont"))),"'","''")
   C_IP = Request.ServerVariables("Remote_Addr")
   C_WDATE = NowDate
   C_MDATE = NowDate
   C_STATE = "00"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   SQL = "INSERT INTO " & CONSULT_LST_Table _
       & " (C_TYPE,C_NAME,C_EMAIL,C_HP,C_TEL,C_TITLE,C_CONT,C_IP,C_WDATE,C_MDATE,C_STATE)" _
       & " VALUES (N'" _
       & C_TYPE & "',N'" _
       & C_NAME & "',N'" _
       & C_EMAIL & "',N'" _
       & C_HP & "',N'" _
       & C_TEL & "',N'" _
       & C_TITLE & "','" _
       & C_CONT & "',N'" _
       & C_IP & "','" _
       & C_WDATE & "','" _
       & C_MDATE & "','" _
       & C_STATE & "')"

   Conn.Execute SQL, ,adCmdText

   Conn.Close
   Set Conn = nothing

   '#### SMS발송
   SMS_CONSULT_ADM = Replace(SMS_CONSULT_ADM, "{사이트명}", CS_NAME)
   SMS_CONSULT_ADM = Replace(SMS_CONSULT_ADM, "{신청자}", C_NAME)

   sPhone = Replace(Replace(SMS_SITE_TEL, "-", ""), ".", "")    '#### 발신자 번호 ####

   If SEND_CONSULT_ADM = "1" AND Left(SMS_ADMIN_HP, 2) = "01" Then
      rPhone = Replace(Replace(SMS_ADMIN_HP, "-", ""), ".", "")    '#### 수신자 번호 ####
      Call Sms_Send(SMS_ID,SMS_PWD,rPhone,sPhone,SMS_CONSULT_ADM)
   End If

   If SEND_CONSULT_MA = "1" AND Left(SMS_MA_HP, 2) = "01" Then
      rPhone = Replace(Replace(SMS_MA_HP, "-", ""), ".", "")    '#### 수신자 번호 ####
      Call Sms_Send(SMS_ID,SMS_PWD,rPhone,sPhone,SMS_CONSULT_ADM)
   End If

   Page_Msg_ParentReload "온라인 문의가 등록되었습니다.\n\n담당자 확인후 연락됩니다."
%>
