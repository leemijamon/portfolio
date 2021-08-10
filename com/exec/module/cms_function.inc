<%
   Sub outline_save()
      Dim CMS_LAYOUT_LST_Table
      CMS_LAYOUT_LST_Table = "CMS_LAYOUT_LST"

      Dim CS_CODE,CL_CODE,CL_NAME,CL_TOP_ITEM,CL_SIDE_ITEM,CL_BODY_ITEM,CL_SCROLL_ITEM,CL_BOTTOM_ITEM

      SQL = "SELECT * FROM " & CMS_LAYOUT_LST_Table & " WHERE CL_STATE < '90'"
      Set RsLayout = Conn.Execute(SQL, ,adCmdText)

      If RsLayout.BOF = false AND RsLayout.EOF = false Then
         Do until RsLayout.EOF
            i = i + 1
            CS_CODE = RsLayout("CS_CODE")
            CL_CODE = RsLayout("CL_CODE")
            CL_NAME = RsLayout("CL_NAME")

            Call layout_save(CS_CODE,CL_CODE,CL_NAME)

            RsLayout.MoveNext
         Loop
      End If
      RsLayout.close
   End Sub

   Sub layout_save(CS_CODE,CL_CODE,CL_NAME)
      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      skin_path = "/skin/" & CS_CODE
      skin_mappath = Server.MapPath(skin_path)

      layout_file = CL_CODE & ".temp"

      layout_file_path = skin_mappath & "/layout/" & layout_file
      make_file_path = skin_mappath & "/layout/" & CL_CODE & ".asp"

      Result = FileControl.FileExists(layout_file_path)
      If Result Then layout_html = FileControl.ReadFile(layout_file_path, "UTF-8")

      layout_html = Replace(layout_html,"{{content}}", "<!-- #include virtual = """ & skin_path & "/execpage/content.asp"" -->")

      '코드변환
      layout_html = CodeChange(CS_CODE,layout_html)

      inc_start = "<" & chr(37) & "@ LANGUAGE=""VBSCRIPT"" CODEPAGE=65001 " & chr(37) & ">" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = ""/exec/conf/code.inc"" -->" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = ""/conf/site_config.inc"" -->" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = """ & skin_path & "/conf/menu_config.inc"" -->" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = ""/exec/module/dft_function.inc"" -->" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = ""/exec/module/page_function.inc"" -->" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = ""/exec/module/usercheck.inc"" -->" & vbNewLine

      layout_html = inc_start & layout_html

      '레이아웃파일생성
      FileControl.CreateFile make_file_path, "UTF-8", layout_html

      Set FileControl = Nothing
   End Sub

   Function layoutExecCodeChange(CS_CODE,code_html)
      skin_path = "/skin/" & CS_CODE

      code_html = Replace(code_html, "<!-- #include virtual = """ & skin_path & "/execpage/content.asp"" -->", "{{content}}")

      inc_start = "<" & chr(37) & "@ LANGUAGE=""VBSCRIPT"" CODEPAGE=65001 " & chr(37) & ">" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = ""/exec/conf/code.inc"" -->" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = ""/conf/site_config.inc"" -->" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = """ & skin_path & "/conf/menu_config.inc"" -->" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = ""/exec/module/dft_function.inc"" -->" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = ""/exec/module/page_function.inc"" -->" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = ""/exec/module/usercheck.inc"" -->" & vbNewLine

      code_html = Replace(code_html, inc_start, "")

      '코드변환
      code_html = ExecCodeChange(CS_CODE,code_html)

      layoutExecCodeChange = code_html
   End Function

   Function CodeChange(CS_CODE,code_html)
      skin_path = "/skin/" & CS_CODE

      '코드변환
      Dim CmsControl
      Set CmsControl = Server.CreateObject("Server.CmsBuilder3")

      CodeChange = CmsControl.CmsCodeChange(Application("connect"), skin_path, code_html)

      Set CmsControl = Nothing
   End Function

   Function ExecCodeChange(CS_CODE,code_html)
      skin_path = "/skin/" & CS_CODE

      '코드변환
      Dim CmsControl
      Set CmsControl = Server.CreateObject("Server.CmsBuilder3")

      ExecCodeChange = CmsControl.CmsExecCodeChange(Application("connect"), skin_path, code_html)

      Set CmsControl = Nothing
   End Function
%>
