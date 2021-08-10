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
   uploadform.MaxUploadSize = 4096000

   f_path = "img"

   Set theField = uploadform("file")(1)

   filesize = theField.Length

   If theField.FileExists Then
      If int(theField.Length) > Int(uploadform.MaxUploadSize) Then
         Page_Msg_Back "4M 이상의 사이즈인 파일은 업로드하실 수 없습니다"
         Response.end
      End If

      mimetype = theField.MIMEtype
      strFileName = theField.SafeFileName

      strExt = LCase(Mid(strFileName, InstrRev(strFileName, ".")))

      If LCase(strExt) <> ".gif" AND LCase(strExt) <> ".jpg" AND LCase(strExt) <> ".jpeg" AND LCase(strExt) <> ".png" AND LCase(strExt) <> ".bmp" Then
         Page_Msg_Back "이미지만 업로드 할수 있습니다."
         Response.end
      End If

      DirectoryPath = server.mappath("/file") & "\" & f_path
      FileLength = theField.Length
      MimeType = theField.MIMEtype

      ImageFormat = theField.ImageType
      ImageWidth = theField.ImageWidth
      ImageHeight = theField.ImageHeight

      strFileWholePath = GetUniqueName(strFileName, DirectoryPath)
      theField.Save strFileWholePath

      Set fs = server.CreateObject("Scripting.FileSystemObject")
      strFileName = fs.GetFileName(strFileWholePath)

      Set uploadform = Nothing

      Call INSERT_DB()

      response.write "{""name"": " & strFileName & ", ""size"": " & FileLength & "}"
      Response.end
   End If

   Sub INSERT_DB()
      NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

      Dim CMS_IMAGE_LST_Table
      CMS_IMAGE_LST_Table = "CMS_IMAGE_LST"

      Dim CI_CODE,CI_NAME,CI_FILE,CI_WIDTH,CI_HEIGHT,CI_WDATE,CI_MDATE,CI_STATE

      CI_CODE = strFileName
      CI_NAME = strFileName
      CI_FILE = strFileName
      CI_DESCRIPTION = strFileName
      CI_WIDTH = ImageWidth
      CI_HEIGHT = ImageHeight
      CI_WDATE = NowDate
      CI_MDATE = NowDate
      CI_STATE = "00"

      Dim Conn, Rs
      Set Conn = Server.CreateObject("ADODB.Connection")
      Conn.Open Application("connect")

      SQL = "SELECT MAX(CI_SEQ) AS MAX_SEQ FROM " & CMS_IMAGE_LST_Table
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      CI_SEQ = Rs("MAX_SEQ")
      Rs.close

      If IsNULL(CI_SEQ) Then CI_SEQ = 0
      CI_SEQ = CI_SEQ + 1

      SQL = "INSERT INTO " & CMS_IMAGE_LST_Table _
          & " (CI_SEQ,CI_DESCRIPTION,CI_CODE,CI_NAME,CI_FILE,CI_WIDTH,CI_HEIGHT,CI_WDATE,CI_MDATE,CI_STATE)" _
          & " VALUES (" _
          & CI_SEQ & ",N'" _
          & CI_DESCRIPTION & "',N'" _
          & CI_CODE & "',N'" _
          & CI_NAME & "',N'" _
          & CI_FILE & "'," _
          & CI_WIDTH & "," _
          & CI_HEIGHT & ",'" _
          & CI_WDATE & "','" _
          & CI_MDATE & "','" _
          & CI_STATE & "')"

      Conn.Execute SQL, ,adCmdText

      Conn.Close
      Set Conn = nothing
   End Sub


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
%>
