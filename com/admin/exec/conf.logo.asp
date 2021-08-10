<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Server.ScriptTimeOut = 7200

   Set uploadform = Server.CreateObject("ABCUpload4.XForm")
   uploadform.AbsolutePath = True '절대경로 사용가능
   uploadform.Overwrite = True    '덮어쓰기 가능
   uploadform.CodePage = 65001      '한글파일 가능하게
   uploadform.MaxUploadSize = 4096000

   Set theField = uploadform("file1")(1)

   If theField.FileExists Then
      If theField.Length > uploadform.MaxUploadSize Then
         Page_Msg_Back "4M 이상의 사이즈인 파일은 업로드하실 수 없습니다"
         Response.end
      End If

      MimeType = theField.MIMEtype
      If MimeType <> "image/gif" AND MimeType <> "image/pjpeg" AND MimeType <> "image/png" Then
         Page_Msg_Back "이미지만 업로드 할수 있습니다."
         Response.end
      End If

      DirectoryPath = server.mappath("/file") & "\logo\"
      strFileName = theField.SafeFileName
      theField.Save DirectoryPath & strFileName
      LOGO1_FILE = strFileName
   End If

   Set theField = uploadform("file2")(1)

   If theField.FileExists Then
      If theField.Length > uploadform.MaxUploadSize Then
         Page_Msg_Back "4M 이상의 사이즈인 파일은 업로드하실 수 없습니다"
         Response.end
      End If

      MimeType = theField.MIMEtype
      If MimeType <> "image/gif" AND MimeType <> "image/pjpeg" AND MimeType <> "image/png" Then
         Page_Msg_Back "이미지만 업로드 할수 있습니다."
         Response.end
      End If

      DirectoryPath = server.mappath("/file") & "\logo\"
      strFileName = theField.SafeFileName
      theField.Save DirectoryPath & strFileName
      LOGO2_FILE = strFileName
   End If

   Set uploadform = Nothing

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim CMS_CONFIG_LST_Table
   CMS_CONFIG_LST_Table = "CMS_CONFIG_LST"

   Dim CC_TYPE,CC_KEY,CC_VALUE,CC_WDATE,CC_MDATE,ADM_SEQ

   CC_TYPE = "logo"
   CC_WDATE = NowDate
   CC_MDATE = NowDate
   ADM_SEQ = Session("ADM_SEQ")
   If ADM_SEQ = "" Then ADM_SEQ = "NULL"

   If LOGO1_FILE = "" Then LOGO1_FILE = "top_logo.gif"
   If LOGO2_FILE = "" Then LOGO2_FILE = "bottom_logo.gif"

   TOPLOGO = "<img src='/file/logo/" & LOGO1_FILE & "'>"
   BOTTOMLOGO = "<img src='/file/logo/" & LOGO2_FILE & "'>"

   CC_KEY = "TOPLOGO,BOTTOMLOGO,LOGO1_FILE,LOGO2_FILE"
   CC_VALUE = TOPLOGO & "," & BOTTOMLOGO & "," & LOGO1_FILE & "," & LOGO2_FILE
   CC_VALUE = Replace(CC_VALUE,"'","''")

   WHERE = "CC_TYPE='" & CC_TYPE & "'"
   SQL = "SELECT * FROM " & CMS_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      '수정
      SQL = "UPDATE " & CMS_CONFIG_LST_Table & " SET " _
          & "CC_KEY='" & CC_KEY & "', " _
          & "CC_VALUE='" & CC_VALUE & "', " _
          & "CC_MDATE='" & CC_MDATE & "', " _
          & "ADM_SEQ=" & ADM_SEQ & " " _
          & "WHERE " _
          & "CC_TYPE='" & CC_TYPE & "'"

      Conn.Execute SQL, ,adCmdText
   Else
      '등록
      SQL = "INSERT INTO " & CMS_CONFIG_LST_Table _
          & " (CC_TYPE,CC_KEY,CC_VALUE,CC_WDATE,CC_MDATE,ADM_SEQ)" _
          & " VALUES ('" _
          & CC_TYPE & "','" _
          & CC_KEY & "','" _
          & CC_VALUE & "','" _
          & CC_WDATE & "','" _
          & CC_MDATE & "'," _
          & ADM_SEQ & ")"

      Conn.Execute SQL, ,adCmdText
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing

   '##코드 생성
   Server.Execute "/admin/exec/make.conf.asp"

   rtnurl = "conf/site"
   rtnmsg = "사이트정보를 등록하였습니다."

   loadURL rtnmsg, rtnurl
   response.end
%>
