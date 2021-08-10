<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/cms_function.inc" -->
<%
   Response.Expires = -1

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MSG,GO_PAGE

   PRO_METHOD = Trim(Request("method"))

   Dim CMS_LAYOUT_LST_Table
   CMS_LAYOUT_LST_Table = "CMS_LAYOUT_LST"

   Dim CL_CODE,CL_NAME,CL_WDATE,CL_MDATE,CL_STATE
   Dim ADM_SEQ

   CS_CODE = Trim(Request("cs_code"))
   CL_CODE = Trim(Request("cl_code"))
   CL_NAME = Replace(Trim(Request.Form("cl_name")),"'","''")
   CL_WDATE = NowDate
   CL_MDATE = NowDate
   CL_STATE = "00"
   ADM_SEQ = Trim(Request.Form("adm_seq"))

   Dim FileControl
   Set FileControl = Server.CreateObject("Server.FileControl")

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

   Set FileControl = Nothing

   Sub pro_register()
      SQL = "SELECT * FROM " & CMS_LAYOUT_LST_Table & " WHERE CS_CODE='" & CS_CODE & "' AND CL_CODE='" & CL_CODE & "' AND CL_STATE < '90'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Alert_Msg "사용중인 코드입니다.\n\n다른 코드를 사용해 주세요."
         response.end
      End If
      Rs.close

      CL_STATE = "00"

      SQL = "INSERT INTO " & CMS_LAYOUT_LST_Table _
          & " (CS_CODE,CL_CODE,CL_NAME,CL_WDATE,CL_MDATE,CL_STATE,ADM_SEQ)" _
          & " VALUES ('" _
          & CS_CODE & "','" _
          & CL_CODE & "',N'" _
          & CL_NAME & "','" _
          & CL_WDATE & "','" _
          & CL_MDATE & "','" _
          & CL_STATE & "'," _
          & ADM_SEQ & ")"

      Conn.Execute SQL, ,adCmdText

      Call file_save()
      Call layout_save(CS_CODE,CL_CODE,CL_NAME)

      MSG = "레이아웃 등록 되었습니다."

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
      SQL = "UPDATE " & CMS_LAYOUT_LST_Table & " SET " _
          & "CL_NAME=N'" & CL_NAME & "', " _
          & "CL_MDATE='" & CL_MDATE & "', " _
          & "ADM_SEQ=" & ADM_SEQ & " " _
          & "WHERE " _
          & "CS_CODE='" & CS_CODE & "' AND CL_CODE='" & CL_CODE & "'"

      Conn.Execute SQL, ,adCmdText

      Call file_save()
      Call layout_save(CS_CODE,CL_CODE,CL_NAME)

      MSG = "레이아웃을 수정하였습니다."

      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function parent_msg_reload(){" & vbNewLine
         .write "     alert('" & MSG & "');" & vbNewLine
         .write "     parent.layout_edit('" & CS_CODE & "','" & CL_CODE & "');" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:parent_msg_reload();'>" & vbNewLine
      End With
   End Sub

   Sub pro_delete()
      CL_STATE = "99"

      SQL = "UPDATE " & CMS_LAYOUT_LST_Table & " SET " _
          & "CL_MDATE='" & CL_MDATE & "', " _
          & "CL_STATE='" & CL_STATE & "' " _
          & "WHERE " _
          & "CS_CODE='" & CS_CODE & "' AND CL_CODE='" & CL_CODE & "'"

      Conn.Execute SQL, ,adCmdText

      MSG = "레이아웃을 삭제하였습니다."

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

   Sub file_save()
      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      skin_path = "/skin/" & CS_CODE
      skin_mappath = Server.MapPath(skin_path)

      layout_file = CL_CODE & ".temp"

      layout_file_path = skin_mappath & "/layout/" & layout_file
      back_file_path = skin_mappath & "/layout/" & Replace(layout_file,".temp",".bak")

      layout_content = Request.Form("layoutcont")

      '레이아웃 백업
      Result = FileControl.FileExists(layout_file_path)
      If Result Then FileControl.CopyFile layout_file_path, back_file_path

      '레이아웃 저장
      FileControl.CreateFile layout_file_path, "UTF-8", layout_content

      Set FileControl = Nothing
   End Sub
%>
