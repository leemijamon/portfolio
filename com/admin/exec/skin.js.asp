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

   JS_CODE = Trim(Request("js_code"))
   CS_CODE = Trim(Request("cs_code"))

   skin_path = "/skin/" & CS_CODE
   skin_mappath = Server.MapPath(skin_path)

   Select Case PRO_METHOD
      Case "register" : pro_register
      Case "modify" : pro_modify
      Case "delete" : pro_delete
   End Select

   Sub pro_register()
      Call pro_jssave()

      MSG = "Script 파일이 등록 되었습니다."

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
      Call pro_jssave()

      MSG = "Script 파일이 등록 되었습니다."

      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function parent_msg_reload(){" & vbNewLine
         .write "     alert('" & MSG & "');" & vbNewLine
         .write "     parent.js_edit('" & CS_CODE & "','" & JS_CODE & "');" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:parent_msg_reload();'>" & vbNewLine
      End With
   End Sub

   Sub pro_delete()
      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      js_file = JS_CODE & ".js"
      js_file_path = skin_mappath & "/js/" & js_file

      FileControl.DeleteFile(js_file_path)

      Set FileControl = Nothing

      MSG = "Script 파일을 삭제 하였습니다."

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

   Sub pro_jssave()
      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      js_file = JS_CODE & ".js"

      js_file_path = skin_mappath & "/js/" & js_file
      back_file_path = skin_mappath & "/js/" & Replace(js_file,".js",".temp")

      js_content = Request.Form("js_cont")

      'js 백업
      Result = FileControl.FileExists(js_file_path)
      If Result Then FileControl.CopyFile js_file_path, back_file_path

      'js 저장
      FileControl.CreateFile js_file_path, "UTF-8", js_content

      Set FileControl = Nothing
   End Sub
%>
