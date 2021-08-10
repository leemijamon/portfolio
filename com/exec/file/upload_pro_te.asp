<%@ LANGUAGE="VBSCRIPT" CODEPAGE="949" %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/file_function.inc"-->
<%
   Response.Expires = -1
   Server.ScriptTimeOut = 7200

   Set uploadform = Server.CreateObject("ABCUpload4.XForm")
   uploadform.AbsolutePath = True '절대경로 사용가능
   uploadform.Overwrite = True    '덮어쓰기 가능
   'uploadform.CodePage = 65001      '한글파일 가능하게

   If f_type = "img" Then
      uploadform.MaxUploadSize = 4096000
   Else
      uploadform.MaxUploadSize = 10240000
   End If

   f_num = uploadform("f_num")
   f_type = uploadform("f_type")
   f_path = uploadform("f_path")

   Set theField = uploadform("upfile")(1)

   If theField.FileExists Then
      If theField.Length > uploadform.MaxUploadSize Then
         If f_type = "img" Then
            Page_Msg_Back "4M 이상의 사이즈인 파일은 업로드하실 수 없습니다"
         Else
            Page_Msg_Back "10M 이상의 사이즈인 파일은 업로드하실 수 없습니다"
         End If
         Response.end
      End If

      MimeType = theField.MIMEtype
      If f_type = "img" Then
         If MimeType <> "image/gif" AND MimeType <> "image/pjpeg" Then
            Page_Msg_Back "이미지만 업로드 할수 있습니다."
            Response.end
         End If
      End If

      DirectoryPath = server.mappath("/") & "\file\" & f_path
      strFileName = theField.SafeFileName
      FileLength = theField.Length

      ImageFormat = theField.ImageType
      ImageWidth = theField.ImageWidth
      ImageHeight = theField.ImageHeight

      strFileWholePath = GetUniqueName(strFileName, DirectoryPath)
      theField.Save strFileWholePath

      If f_type = "img" Then
         m_with = Cint(uploadform("m_with"))
         s_with = Cint(uploadform("s_with"))
         s_height = Cint(uploadform("s_height"))

         Set uploadform = Nothing

         Set Thumbnail = server.createobject("EzWebUtil.Thumbnail")

         f_spath = f_path

         If m_with > 0 AND (ImageWidth > m_with OR ImageHeight > 0) Then
            trnmsg = Thumbnail.ResizeImage(strFileWholePath, strFileWholePath, m_with, m_with, true)
            'Alert_Msg trnmsg
         End If

         If s_with > 0 Then
            SaveFileName = Replace(strFileWholePath, "\file\" & f_path, "\file\" & f_path & "_thumbnail")
            trnmsg = Thumbnail.ResizeImage(strFileWholePath, SaveFileName, s_with, s_height, false)
            'Alert_Msg trnmsg

            f_spath = f_path & "_thumbnail"
         End If

         Set fs = server.CreateObject("Scripting.FileSystemObject")
         strFileName = fs.GetFileName(strFileWholePath)

         Set Thumbnail = Nothing

         With response
            .write "<script language=javascript>" & vbNewLine
            .write "  if(window.opener && !window.opener.closed){" & vbNewLine
            .write "    opener.insert_img(" & f_num & ",'" & f_type & "','" & f_path & "','" & f_spath & "','" & strFileName & "'," & FileLength & "," & m_with & "," & s_with & "," & s_height & ");" & vbNewLine
            .write "  }" & vbNewLine
            .write "  window.close();" & vbNewLine
            .write "</script>" & vbNewLine
         End With
         Response.end
      Else
         Set uploadform = Nothing

         Set fs = server.CreateObject("Scripting.FileSystemObject")
         strFileName = fs.GetFileName(strFileWholePath)

         With response
            .write "<script language=javascript>" & vbNewLine
            .write "  if(window.opener && !window.opener.closed){" & vbNewLine
            .write "    opener.insert_file(" & f_num & ",'" & f_type & "','" & f_path & "','" & f_path & "','" & strFileName & "'," & FileLength & ");" & vbNewLine
            .write "  }" & vbNewLine
            .write "  window.close();" & vbNewLine
            .write "</script>" & vbNewLine
         End With
         Response.end
      End If
   End If
%>
