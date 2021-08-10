<%@ LANGUAGE="VBSCRIPT" CODEPAGE="949" %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/file_function.inc"-->
<%
   Response.Expires = -1
   Server.ScriptTimeOut = 7200

   DefaultPath = server.mappath("/") & "\file"

   Set uploadform = Server.CreateObject("DEXT.FileUpload")
   uploadform.DefaultPath = DefaultPath

   f_num = uploadform("f_num")
   f_type = uploadform("f_type")
   f_path = uploadform("f_path")

   If f_type = "img" Then
      uploadform.MaxFileLen = 4096000
   Else
      uploadform.MaxFileLen = 10240000
   End If

   If uploadform("upfile").FileLen > uploadform.MaxFileLen Then
      If f_type = "img" Then
         Page_Msg_Back "4M 이상의 사이즈인 파일은 업로드하실 수 없습니다"
      Else
         Page_Msg_Back "10M 이상의 사이즈인 파일은 업로드하실 수 없습니다"
      End If
      Response.end
   End If

   mimetype = uploadform("upfile").MimeType
   If f_type = "img" Then
      If mimetype <> "image/gif" AND mimetype <> "image/pjpeg" Then
         Page_Msg_Back "이미지만 업로드 할수 있습니다."
         Response.end
      End If
   End If

   DirectoryPath = server.mappath("/") & "\file\" & f_path
   strFileName = uploadform("upfile").FileName

   FullPath = uploadform("upfile").FilePath
   FileLength = uploadform("upfile").FileLen
   MimeType = uploadform("upfile").MimeType

   ImageFormat = uploadform("upfile").ImageFormat
   ImageWidth = uploadform("upfile").ImageWidth
   ImageHeight = uploadform("upfile").ImageHeight

   strFileWholePath = GetUniqueName(strFileName, DirectoryPath)

   If f_type = "img" Then
      m_with = Cint(uploadform("m_with"))
      s_with = Cint(uploadform("s_with"))
      s_height = Cint(uploadform("s_height"))

      SaveFileName = strFileWholePath
      If m_with = 0 OR m_with > ImageWidth OR m_with > ImageHeight Then
         thumbImageMake uploadform("upfile").TempFilePath, SaveFileName, ImageWidth, ImageHeight, true

         f_spath = f_path
      Else
         thumbImageMake uploadform("upfile").TempFilePath, SaveFileName, m_with, m_with, true
      End If

      If s_with > 0 Then
         SaveFileName = Replace(strFileWholePath, "\file\" & f_path, "\file\" & f_path & "_thumbnail")
         thumbImageMake uploadform("upfile").TempFilePath, SaveFileName, s_with, s_height, false

         f_spath = f_path & "_thumbnail"
      End If

      Set fs = server.CreateObject("Scripting.FileSystemObject")
      strFileName = fs.GetFileName(strFileWholePath)

      Set uploadform = Nothing

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
      uploadform("upfile").SaveAs strFileWholePath

      Set fs = server.CreateObject("Scripting.FileSystemObject")
      strFileName = fs.GetFileName(strFileWholePath)

      Set uploadform = Nothing

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

   Sub thumbImageMake(OriFilePath, SaveFileName, MaxWidth, MaxHeight, AutoSize)
      Dim objImage, OriFileWidth, OriFileHeight, ThumbMaxWidth, ThumbMaxHeight, ThumbWidth, ThumbHeight, ThumbFileName, ThumbPath, OriThumbPath, Filesize

      Set objImage = server.CreateObject("DEXT.ImageProc")

      If objImage.SetSourceFile(OriFilePath) then
         OriFileWidth = objImage.ImageWidth
         OriFileHeight = objImage.ImageHeight

         ThumbWidth = OriFileWidth
         ThumbHeight = OriFileHeight

         ThumbMaxWidth  = MaxWidth '이미지 썸네일 기준 Width
         ThumbMaxHeight = MaxHeight '이미지 썸네일 기준 Height

         if AutoSize AND (OriFileWidth > ThumbMaxWidth Or OriFileHeight > ThumbMaxHeight) Then
            if OriFileWidth >= OriFileHeight Then
               ThumbHeight = Cint(ThumbMaxWidth*(OriFileHeight/OriFileWidth))
               ThumbWidth = ThumbMaxWidth
            Elseif OriFileWidth < OriFileHeight Then
               ThumbWidth = Cint(ThumbMaxHeight*(OriFileWidth/OriFileHeight))
               ThumbHeight = ThumbMaxHeight
            End If
         Else
            ThumbWidth = MaxWidth
            ThumbHeight = MaxHeight
         End If
      End If

      objImage.Quality = 90

      objImage.SaveAsThumbnail SaveFileName, ThumbWidth, ThumbHeight, true, AutoSize
      Set objImage = nothing
   End Sub
%>
