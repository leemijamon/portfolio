<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/cms_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim MSG,PRO_METHOD

   PRO_METHOD = Trim(Request("method"))

   MAIL_CODE = Trim(Request("mail_code"))
   CS_CODE = Trim(Request("cs_code"))

   skin_path = "/skin/" & CS_CODE
   skin_mappath = Server.MapPath(skin_path)

   Select Case PRO_METHOD
      Case "register" : pro_register
      Case "modify" : pro_modify
      Case "delete" : pro_delete
   End Select

   Sub pro_register()
      Call pro_mailsave()

      MSG = "MAIL 파일이 등록 되었습니다."

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
      response.end
   End Sub

   Sub pro_modify()
      Call pro_mailsave()

      MSG = "MAIL 파일이 등록 되었습니다."

      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function parent_msg_reload(){" & vbNewLine
         .write "     alert('" & MSG & "');" & vbNewLine
         .write "     parent.mail_edit('" & CS_CODE & "','" & MAIL_CODE & "');" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:parent_msg_reload();'>" & vbNewLine
      End With
   End Sub

   Sub pro_delete()
      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      mail_file = MAIL_CODE & ".html"
      mail_file_path = skin_mappath & "/mail/" & mail_file

      FileControl.DeleteFile(mail_file_path)

      Set FileControl = Nothing

      MSG = "mail 파일을 삭제 하였습니다."

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
      response.end
   End Sub

   Sub pro_mailsave()
      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      mail_file = MAIL_CODE & ".html"

      mail_file_path = skin_mappath & "/mail/" & mail_file
      back_file_path = skin_mappath & "/mail/" & Replace(mail_file,".mail",".temp")

      mail_content = Request.Form("mail_cont")

      'mail 백업
      Result = FileControl.FileExists(mail_file_path)
      If Result Then FileControl.CopyFile mail_file_path, back_file_path

      'mail 저장
      FileControl.CreateFile mail_file_path, "UTF-8", mail_content

      Set FileControl = Nothing
   End Sub
%>
