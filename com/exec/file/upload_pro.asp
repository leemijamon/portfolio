<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1
   Server.ScriptTimeOut = 7200

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Set uploadform = Server.CreateObject("ABCUpload4.XForm")
   uploadform.AbsolutePath = True '절대경로 사용가능
   uploadform.Overwrite = True    '덮어쓰기 가능
   uploadform.CodePage = 65001      '한글파일 가능하게
   uploadform.MaxUploadSize = 1024000000

   f_num = uploadform("f_num")
   f_type = uploadform("f_type")
   f_path = uploadform("f_path")

   If f_type = "img" Then
      'uploadform.MaxUploadSize = 5120000
      uploadform.MaxUploadSize = 3999999
   Else
   '   uploadform.MaxUploadSize = 1024000000
   End If

   Set theField = uploadform("upfile")(1)

   filesize = theField.Length

   If theField.FileExists Then
      If int(theField.Length) > Int(uploadform.MaxUploadSize) Then
         If f_type = "img" Then
            Page_Msg_Back "4M 이상의 사이즈인 파일은 업로드하실 수 없습니다"
         Else
            Page_Msg_Back "10M 이상의 사이즈인 파일은 업로드하실 수 없습니다"
         End If
         Response.end
      End If

      mimetype = theField.MIMEtype
      strFileName = theField.SafeFileName

      strExt = LCase(Mid(strFileName, InstrRev(strFileName, ".")))

      If f_type = "img" Then
         If LCase(strExt) <> ".gif" AND LCase(strExt) <> ".jpg" AND LCase(strExt) <> ".jpeg" AND LCase(strExt) <> ".png" AND LCase(strExt) <> ".bmp" Then
            Page_Msg_Back "이미지만 업로드 할수 있습니다."
            Response.end
         End If
      Else
         If strExt = ".exe" OR strExt = ".jsp" OR strExt = ".asp" OR strExt = ".aspx" OR strExt = ".php" OR strExt = ".sdx" OR strExt = ".cer" OR strExt = ".js" OR strExt = ".htm" OR strExt = ".html" Then
            Page_Msg_Back "해당 파일은 업로드 할수 없습니다."
            Response.end
         End If
      End If

      DirectoryPath = server.mappath("/") & "\file\" & f_path
      FileLength = theField.Length
      MimeType = theField.MIMEtype

      ImageFormat = theField.ImageType
      ImageWidth = theField.ImageWidth
      ImageHeight = theField.ImageHeight

      strFileWholePath = GetUniqueName(strFileName, DirectoryPath)
      theField.Save strFileWholePath

      Set fs = server.CreateObject("Scripting.FileSystemObject")
      strFileName = fs.GetFileName(strFileWholePath)

      If f_type = "img" Then
         m_with = Cint(uploadform("m_with"))
         s_with = Cint(uploadform("s_with"))
         s_height = Cint(uploadform("s_height"))

         Set uploadform = Nothing

         f_spath = f_path
         If m_with > 0 AND (ImageWidth > m_with OR ImageHeight > 0) Then
            strFileName = getMakeThumbNail(strFileWholePath, DirectoryPath, strFileName, m_with, m_with, False)
         End If

         If s_with > 0 Then
            SaveDirectoryPath = Replace(DirectoryPath, "\file\" & f_path, "\file\" & f_path & "_thumbnail")
            strFileName = getMakeThumbNail(strFileWholePath, SaveDirectoryPath, strFileName, s_with, s_height, False)

            f_spath = f_path & "_thumbnail"
         End If

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

   '//////////////////////////////////////////////////////////////////////////////////
   '// 파일관련
   '////////////////////////////////// ///////////////////////////////////////////////

    Function GetUniqueName(byRef strFileName, DirectoryPath)
        strFileName = Replace(strFileName,"&","")

        Dim strName, strExt
        strName = Mid(strFileName, 1, InstrRev(strFileName, ".") - 1)
        strExt  = Mid(strFileName, InstrRev(strFileName, ".") + 1)

        Dim fso
        Set fso = Server.CreateObject("Scripting.FileSystemObject")

        Dim bExist : bExist = True
        '우선 같은이름의 파일이 존재한다고 가정
        Dim strFileWholePath : strFileWholePath = DirectoryPath & "\" & strName & "." & strExt
        '저장할 파일의 완전한 이름(완전한 물리적인 경로) 구성
        Dim countFileName : countFileName = 0
        '파일이 존재할 경우, 이름 뒤에 붙일 숫자를 세팅함.

        Do While bExist ' 우선 있다고 생각함.
            If (fso.FileExists(strFileWholePath)) Then ' 같은 이름의 파일이 있을 때
                countFileName = countFileName + 1 '파일명에 숫자를 붙인 새로운 파일 이름 생성
                strFileName = strName & "(" & countFileName & ")." & strExt
                strFileWholePath = DirectoryPath & "\" & strFileName
            Else
                bExist = False
            End If
        Loop
        GetUniqueName = strFileWholePath
    End Function

    Function getMakeThumbNail(ImageFullPath, ImageSavePath, imgName, ImageWidth, ImageHeight, bStretch)
      'On Error Resume Next
      '// 기본설정
      If IsNull(ImageFullPath) Or Trim(ImageFullPath) = "" Then Exit Function
      If IsNull(ImageWidth) Or Trim(ImageWidth) = "" Then   ImageWidth  = 100
      If IsNull(ImageHeight) Or Trim(ImageHeight) = "" Then ImageHeight = 100

      If ImageWidth <= 0 Then   ImageWidth  = 100
      If ImageHeight <= 0 Then  ImageHeight = 100

      Dim onlyName  : onlyName  = Left( imgName, InStrRev(imgName, ".") - 1 )       '// 순수파일명 추출
      Dim imgExt    : imgExt    = LCase( Mid(imgName, InStrRev(imgName, ".") + 1) )     '// 순수확장자 추출

      Dim saveName  : saveName = ImageSavePath & "\" & onlyName & "." & imgExt '//& imgExt

      '// 이미지형식체크
      Dim ImageType : ImageType = 2
      Select Case imgExt
         Case "bmp", "wmf", "raw"  : ImageType = 1
         Case "gif"          : ImageType = 2
         Case "jpg", "jpeg"  : ImageType = 3
         Case "png"          : ImageType = 4
         Case "ico"          : ImageType = 5
         Case "tif"          : ImageType = 6
         Case "tga"          : ImageType = 7
         Case "pcx"          : ImageType = 8
         Case "jp2"          : ImageType = 11
         Case "jpc"          : ImageType = 12
         Case "jpx"          : ImageType = 13
         Case "pnm"          : ImageType = 14
         Case "ras"          : ImageType = 15
         Case Else : Exit Function
      End Select

      '//★(시작)썸네일 생성 작업
      Dim objCxImage  : Set objCxImage = Server.CreateObject("CxImageATL.CxImage")  '// 개체생성

      Call objCxImage.Load(ImageFullPath, ImageType)  '// 원본 OPEN
      Call objCxImage.IncreaseBpp(24)         '//

      '// S: Stretch
      Dim ThumbWidth  : ThumbWidth  = ImageWidth  '// 원본사이즈와 무관하게 사용자 지정비율에 맞게 강제 조정
      Dim ThumbHeight : ThumbHeight = ImageHeight

      '// 원본사이즈에 따른 적절한 비율조정
      If bStretch = False Then
         Dim SourceWidth   : SourceWidth   = CDbl(objCxImage.GetWidth()) '// 원본 가로사이즈
         Dim SourceHeight  : SourceHeight  = CDbl(objCxImage.GetHeight())  '// 원본 세로사이즈

         ThumbWidth = SourceWidth
         ThumbHeight = SourceHeight

         ThumbMaxWidth  = ImageWidth '이미지 썸네일 기준 Width

         If SourceWidth > ThumbMaxWidth Then
            ThumbWidth = ThumbMaxWidth
            ThumbHeight = Cint(ThumbMaxWidth*(SourceHeight/SourceWidth))
         End If
      End If
      '// E: Stretch

      Call objCxImage.Resample(ThumbWidth, ThumbHeight, ImageType)      '// 이미지변형

      '// Save(saveFullPathName, ImageType)
      Call ObjCxImage.Save(saveName, ImageType)                   '// 저장(종류에 관계없이 jpg 변환...파일명이같으면 덮어씌운다)

      Set objCxImage = Nothing    '// 개체종료

      '// 리턴
      If Err.Number <> 0 Then
         getMakeThumbNail = ""
      Else
         getMakeThumbNail = Mid( saveName, InstrRev(saveName, "\") + 1 )   '// 썸네일 파일명 리턴
      End If
      'On Error GoTo 0
   End Function
%>

