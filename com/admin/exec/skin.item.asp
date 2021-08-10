<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/cms_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MSG,GO_PAGE

   Dim CMS_ITEM_LST_Table
   CMS_ITEM_LST_Table = "CMS_ITEM_LST"

   Dim CS_CODE,CI_CODE,CI_TYPE,CI_NAME,CI_CONT,CI_WDATE,CI_MDATE,CI_STATE,ADM_SEQ

   PRO_METHOD = Trim(Request("method"))

   CS_CODE = Trim(Request("cs_code"))
   CI_CODE = Trim(Request("ci_code"))
   CI_TYPE = Trim(Request.Form("ci_type"))
   CI_NAME = Replace(Trim(Request.Form("ci_name")),"'","''")
   CI_CONT = Request.Form("ci_cont")
   CI_SKIN = Trim(Request.Form("ci_skin"))
   CI_WDATE = NowDate
   CI_MDATE = NowDate
   ADM_SEQ = Trim(Request.Form("adm_seq"))

   skin_path = "/skin/" & CS_CODE
   skin_mappath = Server.MapPath(skin_path)

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
      SQL = "SELECT * FROM " & CMS_ITEM_LST_Table & " WHERE CS_CODE='" & CS_CODE & "' AND CI_CODE='" & CI_CODE & "'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         If Rs("CI_STATE") < "90" Then
            Alert_Msg "사용중인 코드입니다.\n\n다른 코드를 사용해 주세요."
            response.end
         Else
            DBCK = "UPDATE"
         End If
      Else
         DBCK = "INSERT"
      End If
      Rs.close

      If CI_SKIN = "" AND CI_CONT <> "" Then pro_save
      If CI_SKIN <> "" Then pro_skinsave

      CI_STATE = "00"

      If DBCK = "INSERT" Then
         SQL = "INSERT INTO " & CMS_ITEM_LST_Table _
             & " (CS_CODE,CI_CODE,CI_TYPE,CI_NAME,CI_SKIN,CI_WDATE,CI_MDATE,CI_STATE,ADM_SEQ)" _
             & " VALUES (N'" _
             & CS_CODE & "',N'" _
             & CI_CODE & "',N'" _
             & CI_TYPE & "',N'" _
             & CI_NAME & "',N'" _
             & CI_SKIN & "','" _
             & CI_WDATE & "','" _
             & CI_MDATE & "','" _
             & CI_STATE & "'," _
             & ADM_SEQ & ")"
      Else
         SQL = "UPDATE " & CMS_ITEM_LST_Table & " SET " _
             & "CI_TYPE=N'" & CI_TYPE & "', " _
             & "CI_NAME=N'" & CI_NAME & "', " _
             & "CI_SKIN=N'" & CI_SKIN & "', " _
             & "CI_MDATE='" & CI_MDATE & "', " _
             & "CI_STATE='" & CI_STATE & "' " _
             & "WHERE " _
             & "CS_CODE='" & CS_CODE & "' AND CI_CODE='" & CI_CODE & "'"
      End If

      Conn.Execute SQL, ,adCmdText

      MSG = "아이템이 등록 되었습니다."

      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_href(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.goskin();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_href();'>" & vbNewLine
      End With
      'loadURL MSG, "skin/editor"
   End Sub

   Sub pro_modify()
      If CI_SKIN = "" AND CI_CONT <> "" Then pro_save
      If CI_SKIN <> "" Then pro_skinsave

      SQL = "UPDATE " & CMS_ITEM_LST_Table & " SET " _
          & "CI_TYPE=N'" & CI_TYPE & "', " _
          & "CI_NAME=N'" & CI_NAME & "', " _
          & "CI_SKIN=N'" & CI_SKIN & "', " _
          & "CI_MDATE='" & CI_MDATE & "' " _
          & "WHERE " _
          & "CS_CODE='" & CS_CODE & "' AND CI_CODE='" & CI_CODE & "'"

      Conn.Execute SQL, ,adCmdText

      MSG = "아이템을 수정하였습니다."

      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function parent_msg_reload(){" & vbNewLine
         .write "     alert('" & MSG & "');" & vbNewLine
         .write "     parent.item_edit('" & CS_CODE & "','" & CI_TYPE & "','" & CI_CODE & "');" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:parent_msg_reload();'>" & vbNewLine
      End With
   End Sub

   Sub pro_delete()
      CI_STATE = "99"

      SQL = "UPDATE " & CMS_ITEM_LST_Table & " SET " _
          & "CI_MDATE='" & CI_MDATE & "', " _
          & "CI_STATE='" & CI_STATE & "' " _
          & "WHERE " _
          & "CS_CODE='" & CS_CODE & "' AND CI_CODE='" & CI_CODE & "'"

      Conn.Execute SQL, ,adCmdText

      MSG = "아이템을 삭제하였습니다."

      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_href(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.goskin();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_href();'>" & vbNewLine
      End With
      'loadURL MSG, "skin/editor"
   End Sub

   Sub pro_save()
      temp_file_path = skin_mappath & "\items\" & CI_CODE & ".temp"
      back_file_path = skin_mappath & "\items\" & CI_CODE & ".bak"
      make_file_path = skin_mappath & "\items\" & CI_CODE & ".inc"

      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      '백업
      Result = FileControl.FileExists(temp_file_path)
      If Result Then FileControl.CopyFile temp_file_path, back_file_path

      item_html = CI_CONT

      '템프저장
      FileControl.CreateFile temp_file_path, "UTF-8", item_html

      item_html = CodeChange(CS_CODE,item_html)

      '실제파일저장
      FileControl.CreateFile make_file_path, "UTF-8", item_html

      If CI_CODE = "clause" OR CI_CODE = "privacy" Then
         '실제파일저장
         inc_start = "<" & chr(37) & "@ LANGUAGE=""VBSCRIPT"" CODEPAGE=65001 " & chr(37) & ">" & vbNewLine
         inc_start = inc_start & "<!-- #include virtual = ""/conf/site_config.inc"" -->" & vbNewLine
         make_file_path = skin_mappath & "\items\" & CI_CODE & ".asp"
         FileControl.CreateFile make_file_path, "UTF-8", inc_start & item_html
      End If

      Set FileControl = Nothing
   End Sub

   Sub pro_skinsave()
      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      If CI_SKIN = "userskin" Then
         '사용자스킨
         make_file_path = skin_mappath & "\items\" & CI_CODE & ".inc"
         defult_file_path = Server.MapPath("/execskin") & "\default\items\" & CI_CODE & ".inc"

         If FileControl.FileExists(make_file_path) = false Then
            If FileControl.FileExists(defult_file_path) Then
               FileControl.CopyFile defult_file_path, make_file_path
            Else
               FileControl.CreateFile make_file_path, "UTF-8", "<center>수정하세요.</center>"
            End If
         End If
      Else
         make_file_path = Server.MapPath("/execskin") & "\" & CI_SKIN & "\items\" & CI_CODE & ".inc"

         If FileControl.FileExists(make_file_path) = false Then
            FileControl.CreateFile make_file_path, "UTF-8", "<center>수정하세요.</center>"
         End If
      End If

      Set FileControl = Nothing
   End Sub
%>
