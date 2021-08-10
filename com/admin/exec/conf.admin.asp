<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MSG,GO_PAGE

   PRO_METHOD = Trim(Request("method"))

   Dim ADMIN_LST_Table
   ADMIN_LST_Table = "ADMIN_LST"

   Dim ADM_SEQ,ADM_TYPE,ADM_NAME,ADM_JUMIN,ADM_ID,ADM_PWD,ADM_HP,ADM_TEL,ADM_FAX,ADM_ZIPCODE
   Dim ADM_ADDR1,ADM_ADDR2,ADM_EMAIL,ADM_POST,ADM_ACCOUNT,ADM_WDATE,ADM_MDATE
   Dim ADM_STATE

   ADM_SEQ = Trim(Request("adm_seq"))
   ADM_ID = Trim(Request.Form("adm_id"))
   ADM_TYPE = Trim(Request.Form("adm_type"))
   ADM_NAME = Replace(Trim(Request.form("adm_name")),"'","''")
   ADM_JUMIN = Trim(Request.Form("adm_jumin1")) & Trim(Request.Form("adm_jumin2"))
   ADM_HASH = HASH_TYPE
   MOD_PWD = Trim(Request.Form("mod_pwd"))
   ADM_PWD = Replace(Trim(Request.form("adm_pwd")),"'","''")
   ADM_HP = Replace(Trim(Request.form("adm_hp")),"'","''")
   ADM_TEL = Replace(Trim(Request.form("adm_tel")),"'","''")
   ADM_FAX = Replace(Trim(Request.form("adm_fax")),"'","''")
   ADM_ZIPCODE = Trim(Request.Form("adm_zipcode1")) & Trim(Request.Form("adm_zipcode2"))
   ADM_ADDR1 = Replace(Trim(Request.form("adm_addr1")),"'","''")
   ADM_ADDR2 = Replace(Trim(Request.form("adm_addr2")),"'","''")
   ADM_EMAIL = Replace(Trim(Request.form("adm_email")),"'","''")
   ADM_POST = Trim(Request.Form("adm_post"))
   ADM_ACCOUNT = Replace(Trim(Request.form("adm_account")),"'","''")
   ADM_PERMIT = Trim(Request.Form("adm_permit"))
   ADM_WDATE = NowDate
   ADM_MDATE = NowDate
   ADM_STATE = "00"

   ADM_PERMIT = ADM_PERMIT & ","
   ADM_PERMIT = Replace(ADM_PERMIT," ","")

   If ADM_TYPE = "00" Then
      If InStr(ADM_PERMIT,"service") > 0 Then
         ADM_PERMIT = "config,design,service,member,board,state"
      Else
         ADM_PERMIT = "config,design,member,board,state"
      End If
   Else
      If InStr(ADM_PERMIT,"config") > 0 Then
         ADM_PERMIT = Replace(ADM_PERMIT,"config,","")
         ADM_PERMIT = Replace(ADM_PERMIT,"config","")
      End If
   End If

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

   Page_Msg_Parent_ScriptReload MSG
   response.end

   Sub pro_register()
      SQL = "SELECT ADM_SEQ,ADM_ID FROM " & ADMIN_LST_Table & " WHERE ADM_ID='" & ADM_ID & "' AND ADM_STATE < '90'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Alert_Msg "사용중인 아이디입니다.\n\n다른 아이디를 입력후 중복확인해 주세요."
         response.end
      End If
      Rs.close

      ADM_STATE = "00"

      ADM_PWD = GetHash(ADM_HASH,ADM_PWD)

      SQL = "INSERT INTO " & ADMIN_LST_Table _
          & " (ADM_TYPE,ADM_NAME,ADM_ID,ADM_HASH,ADM_PWD,ADM_HP,ADM_TEL,ADM_FAX,ADM_EMAIL,ADM_POST,ADM_PERMIT,ADM_WDATE,ADM_MDATE,ADM_STATE)" _
          & " VALUES ('" _
          & ADM_TYPE & "',N'" _
          & ADM_NAME & "',N'" _
          & ADM_ID & "',N'" _
          & ADM_HASH & "',N'" _
          & ADM_PWD & "',N'" _
          & ADM_HP & "',N'" _
          & ADM_TEL & "',N'" _
          & ADM_FAX & "',N'" _
          & ADM_EMAIL & "',N'" _
          & ADM_POST & "',N'" _
          & ADM_PERMIT & "','" _
          & ADM_WDATE & "','" _
          & ADM_MDATE & "','" _
          & ADM_STATE & "')"

      Conn.Execute SQL, ,adCmdText

      Msg = "관리자정보를 등록하였습니다."
   End Sub

   Sub pro_modify()
      SQL = "SELECT ADM_SEQ,ADM_ID FROM " & ADMIN_LST_Table & " WHERE ADM_ID='" & ADM_ID & "' AND ADM_SEQ <> " & ADM_SEQ & " AND ADM_STATE < '90'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Alert_Msg "사용중인 아이디입니다.\n\n다른 아이디를 입력후 중복확인해 주세요."
         response.end
      End If
      Rs.close

      If ADM_PWD <> "" Then
         ADM_PWD = GetHash(ADM_HASH,ADM_PWD)
         UPSQL = UPSQL & "ADM_HASH=N'" & ADM_HASH & "', "
         UPSQL = UPSQL & "ADM_PWD=N'" & ADM_PWD & "', "
      End If

      SQL = "UPDATE " & ADMIN_LST_Table & " SET " _
          & "ADM_TYPE='" & ADM_TYPE & "', " _
          & "ADM_NAME=N'" & ADM_NAME & "', " _
          & "ADM_ID=N'" & ADM_ID & "', " _
          & "ADM_HP=N'" & ADM_HP & "', " _
          & "ADM_TEL=N'" & ADM_TEL & "', " _
          & "ADM_FAX=N'" & ADM_FAX & "', " _
          & "ADM_EMAIL=N'" & ADM_EMAIL & "', " _
          & "ADM_POST=N'" & ADM_POST & "', " _
          & "ADM_ACCOUNT=N'" & ADM_ACCOUNT & "', " _
          & "ADM_PERMIT=N'" & ADM_PERMIT & "', " & UPSQL _
          & "ADM_MDATE='" & ADM_MDATE & "' " _
          & "WHERE " _
          & "ADM_SEQ=" & ADM_SEQ

      Conn.Execute SQL, ,adCmdText

      Msg = "관리자정보를 수정하였습니다."
   End Sub

   Sub pro_delete()
      ADM_STATE = "99"

      SQL = "UPDATE " & ADMIN_LST_Table & " SET " _
          & "ADM_MDATE='" & ADM_MDATE & "', " _
          & "ADM_STATE='" & ADM_STATE & "' " _
          & "WHERE " _
          & "ADM_SEQ=" & ADM_SEQ

      Conn.Execute SQL, ,adCmdText

      MSG = "관리자정보를 삭제하였습니다."
   End Sub

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
