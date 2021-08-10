<%
   '파일존재 여부
   Function File_Exists(file)
      Dim fso
      Set fso = CreateObject("Scripting.FileSystemObject")
      If (fso.FileExists(file)) Then
         File_Exists = True
      Else
         File_Exists = false
      End If
   End Function

   '파일 수정 시간
   Function File_ModifyDate(file)
      Dim fso
      Set fso = CreateObject("Scripting.FileSystemObject")

      If fso.fileExists(file) then
         Set Out = fso.GetFile(file)
         File_ModifyDate = Out.DateLastModified
      End If
   End Function

   '파일 읽기
   Function Read_File(file)
      Dim fso
      Set fso = CreateObject("Scripting.FileSystemObject")

      If fso.fileExists(file) then
         Set Out = fso.OpenTextFile(file,1,FALSE,FALSE)
         If Out.AtEndOfStream = false Then
            Read_File = Out.ReadAll
         End If
         Out.Close
      End If
   End Function

   '파일 쓰기
   Sub Create_File(file,str_text)
      Dim fso
      Set fso = CreateObject("Scripting.FileSystemObject")
      Set Out = fso.CreateTextFile(file,TRUE,FALSE)
      Out.Write str_text
      Out.Close
   End Sub

   '파일삭제
   Sub Delete_File(file)
      Dim fso
      Set fso = CreateObject("Scripting.FileSystemObject")
      fso.DeleteFile(file)
   End Sub

   '파일 복사
   Sub Copy_File(old_file,new_file)
      Dim fso
      Set fso = CreateObject("Scripting.FileSystemObject")
      fso.CopyFile old_file, new_file
   End Sub

   '폴더존재 여부
   Function Folder_Exists(folder)
      Dim fso
      Set fso = CreateObject("Scripting.FileSystemObject")
      If (fso.FolderExists(folder)) Then
         Folder_Exists = True
      Else
         Folder_Exists = false
      End If
   End Function

   '폴더생성
   Sub Create_Folder(folder)
      Dim fso, f
      Set fso = CreateObject("Scripting.FileSystemObject")
      Set f = fso.CreateFolder(folder)
   End Sub

   '폴더삭제
   Sub Delete_Folder(folder)
      Dim fso
      Set fso = CreateObject("Scripting.FileSystemObject")
      fso.DeleteFolder(folder)
   End Sub

   '폴더삭제
   Sub Copy_Folder(old_folder,new_folder)
      Dim fso
      Set fso = CreateObject("Scripting.FileSystemObject")

      fso.CopyFolder old_folder, new_folder
   End Sub

   '플레쉬파일 변환
   Function f_object(html)
      S_Script = "<script>ObjectEmbed("""
      E_Script = """)</script>"

      Right_Html = html

      Do
         If InStr(Right_Html, "<object") > 0 AND InStr(Right_Html, "</object>") > 0 Then
            Cut_Html = Left(Right_Html, InStr(Right_Html, "<object") - 1)
            Right_Html = Right(Right_Html, Len(Right_Html) - Len(Cut_Html))

            Change_Html = Left(Right_Html, InStr(Right_Html, "</object>") + 9)
            Right_Html = Right(Right_Html, Len(Right_Html) - Len(Change_Html))

            Change_Html = Replace(Change_Html, """", "'")
            Change_Html = Replace(Change_Html, chr(13), "\" & chr(13))
            If Right(Change_Html, 2) = "\" & chr(13) Then Change_Html = Left(Change_Html, Len(Change_Html) - 2)
            Change_Html = S_Script & Change_Html & E_Script

            Left_Html = Left_Html & Cut_Html & Change_Html
         Else
            Exit Do
         End If
      Loop

      f_object = Left_Html & Right_Html
   End Function

   '//////////////////////////////////////////////////////////////////////////////////
   '// 파일관련
   '////////////////////////////////// ///////////////////////////////////////////////

   Function GetUniqueName(byRef strFileName, DirectoryPath)
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

      Dim saveName  : saveName = ImageSavePath & "\" & onlyName & ".jpg" '//& imgExt

      '// 이미지형식체크
      Dim ImageType : ImageType = 2
      Select Case imgExt
         Case "bmp", "wmf", "raw"  : ImageType = 1
         Case "gif"          : ImageType = 2
         Case "jpg"          : ImageType = 3
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
      Call ObjCxImage.Save(saveName, 3)                   '// 저장(종류에 관계없이 jpg 변환...파일명이같으면 덮어씌운다)

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
