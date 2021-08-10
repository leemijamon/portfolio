<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/aspJSON1.17.asp" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MSG,GO_PAGE

   PRO_METHOD = Trim(Request("method"))

   Dim CMS_CODE_LST_Table
   CMS_CODE_LST_Table = "CMS_CODE_LST"

   Dim CC_TYPE,CC_CODE,CC_NAME,CC_DISP,CC_SORT,CC_WDATE,CC_MDATE,CC_STATE,ADM_SEQ

   CC_SEQ = Trim(Request("cc_seq"))
   CC_TYPE = Trim(Request("cc_type"))
   CC_CODE = Replace(Trim(Request.Form("cc_code")),"'","''")
   CC_NAME = Replace(Trim(Request.Form("cc_name")),"'","''")
   CC_DISP = Trim(Request.Form("cc_disp"))
   CC_SORT = 0
   CC_WDATE = NowDate
   CC_MDATE = NowDate
   CC_STATE = Trim(Request.Form("cc_state"))
   ADM_SEQ = Trim(Request.Form("adm_seq"))

   CC_CODE = Replace(CC_CODE,",","")
   CC_NAME = Replace(CC_NAME,",","")

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Select Case PRO_METHOD
      Case "register" : pro_register
      Case "modify" : pro_modify
      Case "delete" : pro_delete
      Case "sort" : pro_sort
   End Select

   Conn.Close
   Set Conn = nothing

   '##코드 생성
   Server.Execute "/admin/exec/make.conf.asp"
   response.end

   Sub pro_register()
      WHERE = "CC_TYPE='" & CC_TYPE & "' AND CC_CODE='" & CC_CODE & "' AND CC_STATE < '90'"
      SQL = "SELECT * FROM " & CMS_CODE_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Alert_Msg "사용중인 코드입니다.\n\n다른 코드를 입력후 중복확인해 주세요."
         response.end
      End If
      Rs.close

      CC_STATE = "00"

      SQL = "INSERT INTO " & CMS_CODE_LST_Table _
          & " (CC_TYPE,CC_CODE,CC_NAME,CC_DISP,CC_SORT,CC_WDATE,CC_MDATE,CC_STATE,ADM_SEQ)" _
          & " VALUES ('" _
          & CC_TYPE & "','" _
          & CC_CODE & "',N'" _
          & CC_NAME & "','" _
          & CC_DISP & "'," _
          & CC_SORT & ",'" _
          & CC_WDATE & "','" _
          & CC_MDATE & "','" _
          & CC_STATE & "'," _
          & ADM_SEQ & ")"

      Conn.Execute SQL, ,adCmdText

      MSG = "코드가 등록 되었습니다."
      Page_Msg_Parent_ScriptReload MSG
   End Sub

   Sub pro_modify()
      WHERE = "CC_SEQ<>" & CC_SEQ & " AND CC_TYPE='" & CC_TYPE & "' AND CC_CODE='" & CC_CODE & "' AND CC_STATE < '90'"
      SQL = "SELECT * FROM " & CMS_CODE_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Alert_Msg "사용중인 코드입니다.\n\n다른 코드를 입력후 중복확인해 주세요."
         response.end
      End If
      Rs.close

      SQL = "UPDATE " & CMS_CODE_LST_Table & " SET " _
          & "CC_CODE='" & CC_CODE & "', " _
          & "CC_NAME=N'" & CC_NAME & "', " _
          & "CC_DISP='" & CC_DISP & "', " _
          & "CC_MDATE='" & CC_MDATE & "', " _
          & "ADM_SEQ=" & ADM_SEQ & " " _
          & "WHERE " _
          & "CC_SEQ=" & CC_SEQ

      Conn.Execute SQL, ,adCmdText

      MSG = "코드를 수정하였습니다."
      Page_Msg_Parent_ScriptReload MSG
   End Sub

   Sub pro_delete()
      CC_STATE = "99"

      SQL = "UPDATE " & CMS_CODE_LST_Table & " SET " _
          & "CC_MDATE='" & CC_MDATE & "', " _
          & "CC_STATE='" & CC_STATE & "' " _
          & "WHERE " _
          & "CC_SEQ=" & CC_SEQ
          response.write SQL

      Conn.Execute SQL, ,adCmdText

      MSG = "코드를 삭제하였습니다."
      Page_Msg_Parent_ScriptReload MSG
   End Sub

   Sub pro_sort()
      CODELIST = Trim(Request.Form("codelist-output"))
      If CODELIST <> "" Then
         jsonstring = "{""codelist"":" & CODELIST & "}"

         Set oJSON = New aspJSON
         oJSON.loadJSON(jsonstring)

         CC_SORT = 0
         For Each lists In oJSON.data("codelist")
            Set this = oJSON.data("codelist").item(lists)
            CC_SEQ = Replace(this.item("id"),"c","")

            CC_SORT = CC_SORT + 1

            SQL = "UPDATE " & CMS_CODE_LST_Table & " SET " _
                & "CC_SORT=" & CC_SORT & " " _
                & "WHERE CC_SEQ=" & CC_SEQ

            Conn.Execute SQL, ,adCmdText
         Next
      End If
   End Sub
%>
