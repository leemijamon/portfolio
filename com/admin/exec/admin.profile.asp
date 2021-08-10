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

   Dim ADMIN_LST_Table
   ADMIN_LST_Table = "ADMIN_LST"

   Dim ADM_SEQ,ADM_TYPE,ADM_NAME,ADM_JUMIN,ADM_ID,ADM_PWD,ADM_HP,ADM_TEL,ADM_FAX,ADM_ZIPCODE
   Dim ADM_ADDR1,ADM_ADDR2,ADM_EMAIL,ADM_POST,ADM_ACCOUNT,ADM_WDATE,ADM_MDATE
   Dim ADM_STATE

   ADM_SEQ = Trim(Request("adm_seq"))
   ADM_ID = Trim(Request.Form("adm_id"))
   ADM_NAME = Replace(Trim(Request.form("adm_name")),"'","''")
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
   ADM_WDATE = NowDate
   ADM_MDATE = NowDate
   ADM_STATE = "00"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

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
       & "ADM_NAME=N'" & ADM_NAME & "', " _
       & "ADM_ID=N'" & ADM_ID & "', " _
       & "ADM_HP=N'" & ADM_HP & "', " _
       & "ADM_TEL=N'" & ADM_TEL & "', " _
       & "ADM_FAX=N'" & ADM_FAX & "', " _
       & "ADM_EMAIL=N'" & ADM_EMAIL & "', " _
       & "ADM_POST=N'" & ADM_POST & "', " & UPSQL _
       & "ADM_MDATE='" & ADM_MDATE & "' " _
       & "WHERE " _
       & "ADM_SEQ=" & ADM_SEQ

   Conn.Execute SQL, ,adCmdText

   Msg = "관리자정보를 수정하였습니다."

   Conn.Close
   Set Conn = nothing

   With response
      .write "<script language='javascript'>" & vbNewLine
      .write "<!--" & vbNewLine
      .write "  function msg_href(){" & vbNewLine
      .write "     alert('" & msg & "');" & vbNewLine
      .write "     parent.closeprofile();" & vbNewLine
      .write "  }" & vbNewLine
      .write "-->" & vbNewLine
      .write "</script>" & vbNewLine & vbNewLine

      .write "<body onload='javascript:msg_href();'>" & vbNewLine
   End With

   response.end

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
