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

   CSS_CODE = Trim(Request("css_code"))
   CS_CODE = Trim(Request("cs_code"))

   skin_path = "/skin/" & CS_CODE
   skin_mappath = Server.MapPath(skin_path)

   Select Case PRO_METHOD
      Case "register" : pro_register
      Case "modify" : pro_modify
      Case "delete" : pro_delete
   End Select

   Sub pro_register()
      Call pro_csssave()

      MSG = "CSS 파일이 등록 되었습니다."

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
      Call pro_csssave()

      MSG = "CSS 파일이 등록 되었습니다."

      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function parent_msg_reload(){" & vbNewLine
         .write "     alert('" & MSG & "');" & vbNewLine
         .write "     parent.css_edit('" & CS_CODE & "','" & CSS_CODE & "');" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:parent_msg_reload();'>" & vbNewLine
      End With
   End Sub

   Sub pro_delete()
      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      css_file = CSS_CODE & ".css"
      css_file_path = skin_mappath & "/css/" & css_file

      FileControl.DeleteFile(css_file_path)

      Set FileControl = Nothing

      MSG = "CSS 파일을 삭제 하였습니다."

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

   Sub pro_csssave()
      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      css_file = CSS_CODE & ".css"

      css_file_path = skin_mappath & "/css/" & css_file
      back_file_path = skin_mappath & "/css/" & Replace(css_file,".css",".temp")

      css_content = Request.Form("css_cont")

      'CSS 백업
      Result = FileControl.FileExists(css_file_path)
      If Result Then FileControl.CopyFile css_file_path, back_file_path

      'CSS 저장
      FileControl.CreateFile css_file_path, "UTF-8", css_content

      Set FileControl = Nothing
   End Sub
%>
