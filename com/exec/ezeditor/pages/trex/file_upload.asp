<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   Response.Expires = -10000
   Server.ScriptTimeOut = 7200

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Set theForm = Server.CreateObject("ABCUpload4.XForm")
   theForm.AbsolutePath = True '절대경로 사용가능
   theForm.Overwrite = True    '덮어쓰기 가능
   theForm.CodePage = 65001      '한글파일 가능하게

   sessionid = trim(theForm.item("sessionid"))
   uploadpath = trim(theForm.item("uploadpath"))

   Set theField = theForm("filedata")(1)

   If theField.FileExists Then
      DirectoryPath = server.mappath("/") & Replace(uploadpath,"/","\")
      strFileName = theField.SafeFileName
      MIMEtype = theField.MIMEtype

      strExt = LCase(Mid(strFileName, InstrRev(strFileName, ".")))
      If strExt = ".exe" OR strExt = ".jsp" OR strExt = ".asp" OR strExt = ".aspx" OR strExt = ".php" OR strExt = ".sdx" OR strExt = ".cer" OR strExt = ".js" OR strExt = ".htm" OR strExt = ".html" Then
         Response.end
      End If

      strFileWholePath = GetUniqueName(strFileName, DirectoryPath)
      theField.Save strFileWholePath

      Set fs = server.CreateObject("Scripting.FileSystemObject")
      strFileName = fs.GetFileName(strFileWholePath)

      response.write MIMEtype & "|" & strFileName
   End If

   'Session.CodePage = 949
   response.end

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