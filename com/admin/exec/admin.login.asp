<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Server.ScriptTimeout = 60
   'Session.Timeout = 60

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   WEB_INDEX = Request.ServerVariables("INSTANCE_ID")

   Dim Conn
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim ADMIN_LST_Table
   ADMIN_LST_Table = "ADMIN_LST"

   Dim ADM_SEQ,ADM_NAME,ADM_ID,ADM_PWD,ADM_LEVEL,ADM_JUMIN,ADM_SEX,ADM_HP,ADM_TEL,ADM_EMAIL
   Dim ADM_URL,ARA_CODE

   ADM_ID = Replace(Trim(Request.form("adm_id")),"'","''")
   ADM_PWD = Replace(Trim(Request.form("adm_pwd")),"'","''")

   ADM_LOG_IP = Request.ServerVariables("Remote_Addr")
   ADM_LOG_DATE = NowDate

   SQL = "SELECT * FROM " & ADMIN_LST_Table & " WHERE ADM_ID='" & ADM_ID & "' AND ADM_STATE < '90'"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      ADM_SEQ = Rs("ADM_SEQ")
      ADM_TYPE = Rs("ADM_TYPE")
      ADM_NAME = Rs("ADM_NAME")
      ADM_ID = Rs("ADM_ID")
      ADM_HASH = Rs("ADM_HASH")
      ADM_HASH_PWD = Rs("ADM_PWD")
      ADM_TEL = Rs("ADM_TEL")
      ADM_HP = Rs("ADM_HP")
      ADM_EMAIL = Rs("ADM_EMAIL")
      ADM_PERMIT = Rs("ADM_PERMIT")
   Else
      Alert_Msg "관리자 아이디/비밀번호가 일치하지 않습니다.\n\n다시 로그인하여주십시오."
      Response.End
   End If
   Rs.close

   ADM_GET_PWD = GetHash(ADM_HASH,ADM_PWD)

   If ADM_GET_PWD = ADM_HASH_PWD Then
      Session("ADM_SEQ") = ADM_SEQ
      Session("ADM_TYPE") = ADM_TYPE
      Session("ADM_NAME") = ADM_NAME
      Session("ADM_ID") = ADM_ID
      Session("ADM_TEL") = ADM_TEL
      Session("ADM_HP") = ADM_HP
      Session("ADM_EMAIL") = ADM_EMAIL
      Session("ADM_PERMIT") = ADM_PERMIT
      Session("ADM_IP") = Request.ServerVariables("Remote_Addr")

      SQL = "UPDATE " & ADMIN_LST_Table & " SET " _
          & "ADM_LOG_IP='" & ADM_LOG_IP & "', " _
          & "ADM_LOG_DATE='" & ADM_LOG_DATE & "', " _
          & "ADM_LOG_CNT=ADM_LOG_CNT+1 " _
          & "WHERE " _
          & "ADM_SEQ=" & Session("ADM_SEQ")

      Conn.Execute SQL, ,adCmdText

      NewDate = DateSerial(year(now), month(now)+1, day(now))
      Response.Cookies("AdminInfo").expires = NewDate

      If Trim(Request.form("idsave")) = "1" Then
         Response.Cookies("AdminInfo")("adm_id") = ADM_ID
         Response.Cookies("AdminInfo")("idsave") = "1"
      Else
         Response.Cookies("AdminInfo")("adm_id") = ""
         Response.Cookies("AdminInfo")("idsave") = "0"
      End If

      Response.Cookies("AdminInfo").Domain = Request.ServerVariables("SERVER_NAME")

      Call Page_ParentReload()
      'Response.Redirect "/admin/index.asp"
      response.end
   Else
      Alert_Msg "관리자 아이디/비밀번호가 일치하지 않습니다.\n\n다시 로그인하여주십시오."
      Response.End
   End If

   Conn.Close
   Set Conn = nothing

   Function GetHash(HashType,HashValue)
      If IsNULL(HashType) OR HashType = "" Then
         GetHash = HashValue
      ElseIf HashType = "MySQL4" OR HashType = "MySQL5" Then
         Set Hash = Server.CreateObject("EzWebUtil.Hash")
         GetHash = Hash.GetHash(HashValue,HashType)
         Set Hash = Nothing
      Else
         If HashType = "SHA256" Then HashType = "SHA2_256"
         If HashType = "SHA512" Then HashType = "SHA2_512"

         SQL = "SELECT SubString(master.dbo.fn_varbintohexstr(HashBytes('" & HashType & "', CONVERT(nvarchar(4000),'" & HashValue & "'))), 3, 150) AS HashValue"
         Set Rs = Conn.Execute(SQL, ,adCmdText)
         GetHash = Rs("HashValue")
         Rs.close
      End If
   End Function
%>