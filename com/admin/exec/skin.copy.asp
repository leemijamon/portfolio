<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   OLD_CODE = Trim(Request.Form("old_code"))
   NEW_CODE = Trim(Request.Form("new_code"))
   ADM_SEQ = Trim(Request.Form("adm_seq"))

   Dim FileControl
   Set FileControl = Server.CreateObject("Server.FileControl") '컴포넌트 Object 선언

   Dim Result

   old_path = Server.MapPath("/skin") & "/" & OLD_CODE
   new_path = Server.MapPath("/skin") & "/" & NEW_CODE

   'new 폴더존재여부
   Result = FileControl.FolderExists(new_path) '메소드(함수) 호출

   If Result Then
      Alert_Msg "사용중인 스킨입니다."
      Response.End
   End If

   '폴더copy
   Result = FileControl.CopyFolder(old_path, new_path) '메소드(함수) 호출

   If Result = False Then
      Alert_Msg "스킨 복사 실패."
      Response.End
   End If

   '파일변환
   Dim oFSO
   Set oFSO = CreateObject("Scripting.FileSystemObject")

   Dim oFolder, oSubFolder
   Set oFolder = oFSO.GetFolder(new_path)

   For Each oSubFolder In oFolder.SubFolders
      For Each oFile In oSubFolder.Files
         oFileName = oFile.Name

         If Right(oFileName,4) = ".asp" OR Right(oFileName,4) = ".inc" OR Right(oFileName,4) = ".css" OR Right(oFileName,5) = ".temp" OR Right(oFileName,5) = ".html" Then
            'Response.write oFile.Path & vbNewLine

            oFilePath = oFile.Path

            CP_CONT = FileControl.ReadFile(oFilePath, "UTF-8")
            CP_CONT = Replace(CP_CONT, "/skin/" & OLD_CODE & "/", "/skin/" & NEW_CODE & "/")

            FileControl.CreateFile oFilePath, "UTF-8", CP_CONT
         End If
      Next
   Next

   oFilePath = new_path & "/index.asp"

   CP_CONT = FileControl.ReadFile(oFilePath, "UTF-8")
   CP_CONT = Replace(CP_CONT, "/skin/" & OLD_CODE & "/", "/skin/" & NEW_CODE & "/")

   FileControl.CreateFile oFilePath, "UTF-8", CP_CONT

   Set FileControl = Nothing

   'DB copy
   Dim CMS_ITEM_LST_Table
   CMS_ITEM_LST_Table = "CMS_ITEM_LST"

   Dim CS_CODE,CI_CODE,CI_TYPE,CI_NAME,CI_CONT,CI_SKIN,CI_SORT,CI_WDATE,CI_MDATE,CI_STATE

   Dim CMS_LAYOUT_LST_Table
   CMS_LAYOUT_LST_Table = "CMS_LAYOUT_LST"

   Dim CL_CODE,CL_NAME,CL_SORT,CL_WDATE,CL_MDATE,CL_STATE

   Dim CMS_PAGE_LST_Table
   CMS_PAGE_LST_Table = "CMS_PAGE_LST"

   Dim CP_SEQ,CP_CODE,CP_TYPE,CP_NUM,CP_NAME,CP_TITLE,CP_TITLE_ENG,CP_KEYWORDS,CP_DESCRIPTION
   Dim CP_MEM_LEVEL,CP_SKIN,CP_PG_YN,CP_PG_ITEM,CP_PG_NAME,CP_PG_QUERY,CP_SSL_YN,CP_USE_YN,CP_SORT,CP_WDATE
   Dim CP_MDATE,CP_STATE

   Dim CMS_MENU_LST_Table
   CMS_MENU_LST_Table = "CMS_MENU_LST"

   Dim CM_SEQ,CM_NAME,CM_ENG_NAME,CM_ID,CM_DEPTH,CM_CODE,CM_SORT,CM_WDATE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   WHERE = "CS_CODE='" & OLD_CODE & "' AND CI_STATE < '90'"
   ORDER_BY = "CI_CODE"
   SQL = "SELECT * FROM " & CMS_ITEM_LST_Table & " WHERE " & WHERE & " ORDER BY " & ORDER_BY
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      MAKE_SQL = MAKE_SQL & vbNewLine & "--CMS_ITEM_LST" & vbNewLine

      Do until Rs.EOF
         i = i + 1
         CS_CODE = NEW_CODE
         CI_CODE = Rs("CI_CODE")
         CI_TYPE = Rs("CI_TYPE")
         CI_NAME = Rs("CI_NAME")
         CI_CONT = Rs("CI_CONT")
         CI_SKIN = Rs("CI_SKIN")
         CI_SORT = Rs("CI_SORT")
         CI_WDATE = NowDate
         CI_MDATE = NowDate
         CI_STATE = Rs("CI_STATE")

         SQL = "INSERT INTO " & CMS_ITEM_LST_Table _
             & " (CS_CODE,CI_CODE,CI_TYPE,CI_NAME,CI_CONT,CI_SKIN,CI_SORT,CI_WDATE,CI_MDATE,CI_STATE,ADM_SEQ)" _
             & " VALUES (N'" _
             & CS_CODE & "',N'" _
             & CI_CODE & "',N'" _
             & CI_TYPE & "',N'" _
             & CI_NAME & "','" _
             & CI_CONT & "',N'" _
             & CI_SKIN & "'," _
             & CI_SORT & ",'" _
             & CI_WDATE & "','" _
             & CI_MDATE & "','" _
             & CI_STATE & "'," _
             & ADM_SEQ & ");"

         MAKE_SQL = MAKE_SQL & SQL & vbNewLine

         Rs.MoveNext
      Loop
   End If
   Rs.close

   WHERE = "CS_CODE='" & OLD_CODE & "' AND CL_STATE < '90'"
   ORDER_BY = "CL_CODE"
   SQL = "SELECT * FROM " & CMS_LAYOUT_LST_Table & " WHERE " & WHERE & " ORDER BY " & ORDER_BY
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      MAKE_SQL = MAKE_SQL & vbNewLine & "--CMS_LAYOUT_LST" & vbNewLine

      Do until Rs.EOF
         i = i + 1
         CS_CODE = NEW_CODE
         CL_CODE = Rs("CL_CODE")
         CL_NAME = Rs("CL_NAME")
         CL_SORT = Rs("CL_SORT")
         CL_WDATE = NowDate
         CL_MDATE = NowDate
         CL_STATE = Rs("CL_STATE")

         SQL = "INSERT INTO " & CMS_LAYOUT_LST_Table _
             & " (CS_CODE,CL_CODE,CL_NAME,CL_WDATE,CL_MDATE,CL_STATE,ADM_SEQ)" _
             & " VALUES ('" _
             & CS_CODE & "','" _
             & CL_CODE & "',N'" _
             & CL_NAME & "','" _
             & CL_WDATE & "','" _
             & CL_MDATE & "','" _
             & CL_STATE & "'," _
             & ADM_SEQ & ");"

         MAKE_SQL = MAKE_SQL & SQL & vbNewLine

         Rs.MoveNext
      Loop
   End If
   Rs.close

   WHERE = "CS_CODE='" & OLD_CODE & "' AND CP_STATE<'90'"
   ORDER_BY = "CP_SEQ"
   SQL = "SELECT * FROM " & CMS_PAGE_LST_Table & " WHERE " & WHERE & " ORDER BY " & ORDER_BY
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      MAKE_SQL = MAKE_SQL & vbNewLine & "--CMS_PAGE_LST" & vbNewLine

      Do until Rs.EOF
         i = i + 1
         CS_CODE = NEW_CODE
         CP_SEQ = Rs("CP_SEQ")
         CP_CODE = Rs("CP_CODE")
         'CP_TYPE = Rs("CP_TYPE")
         CP_NUM = Rs("CP_NUM")
         CP_NAME = Rs("CP_NAME")
         CP_TITLE = Rs("CP_TITLE")
         CP_TITLE_ENG = Rs("CP_TITLE_ENG")
         CP_KEYWORDS = Rs("CP_KEYWORDS")
         CP_DESCRIPTION = Rs("CP_DESCRIPTION")
         CP_MEM_LEVEL = Rs("CP_MEM_LEVEL")
         CP_SKIN = Rs("CP_SKIN")
         CP_PG_YN = Rs("CP_PG_YN")
         CP_PG_ITEM = Rs("CP_PG_ITEM")
         CP_PG_NAME = Rs("CP_PG_NAME")
         CP_PG_QUERY = Rs("CP_PG_QUERY")
         CP_SSL_YN = Rs("CP_SSL_YN")
         CP_USE_YN = Rs("CP_USE_YN")
         CP_SORT = Rs("CP_SORT")
         CP_WDATE = NowDate
         CP_MDATE = NowDate
         CP_STATE = Rs("CP_STATE")
         CL_CODE = Rs("CL_CODE")

         SQL = "INSERT INTO " & CMS_PAGE_LST_Table _
             & " (CS_CODE,CP_SEQ,CP_CODE,CP_NUM,CP_NAME,CP_TITLE,CP_TITLE_ENG,CP_KEYWORDS,CP_DESCRIPTION,CP_MEM_LEVEL,CP_SKIN,CP_PG_YN,CP_PG_ITEM,CP_PG_NAME,CP_PG_QUERY,CP_SSL_YN,CP_USE_YN,CP_SORT,CP_WDATE,CP_MDATE,CP_STATE,CL_CODE,ADM_SEQ)" _
             & " VALUES (N'" _
             & CS_CODE & "'," _
             & CP_SEQ & ",N'" _
             & CP_CODE & "',N'" _
             & CP_NUM & "',N'" _
             & CP_NAME & "',N'" _
             & CP_TITLE & "',N'" _
             & CP_TITLE_ENG & "',N'" _
             & CP_KEYWORDS & "',N'" _
             & CP_DESCRIPTION & "','" _
             & CP_MEM_LEVEL & "',N'" _
             & CP_SKIN & "','" _
             & CP_PG_YN & "',N'" _
             & CP_PG_ITEM & "',N'" _
             & CP_PG_NAME & "',N'" _
             & CP_PG_QUERY & "','" _
             & CP_SSL_YN & "','" _
             & CP_USE_YN & "'," _
             & CP_SORT & ",'" _
             & CP_WDATE & "','" _
             & CP_MDATE & "','" _
             & CP_STATE & "',N'" _
             & CL_CODE & "'," _
             & ADM_SEQ & ");"

         MAKE_SQL = MAKE_SQL & SQL & vbNewLine

         Rs.MoveNext
      Loop
   End If
   Rs.close

   WHERE = "CS_CODE='" & OLD_CODE & "'"
   ORDER_BY = "CM_SORT"
   SQL = "SELECT * FROM " & CMS_MENU_LST_Table & " WHERE " & WHERE & " ORDER BY " & ORDER_BY
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      MAKE_SQL = MAKE_SQL & vbNewLine & "--CMS_MENU_LST" & vbNewLine

      Do until Rs.EOF
         i = i + 1
         CS_CODE = NEW_CODE
         CM_SEQ = Rs("CM_SORT")
         CM_NAME = Rs("CM_NAME")
         CM_ENG_NAME = Rs("CM_ENG_NAME")
         'CM_ID = Rs("CM_ID")
         CM_DEPTH = Rs("CM_DEPTH")
         CM_CODE = Rs("CM_CODE")
         CM_SORT = Rs("CM_SORT")
         CM_WDATE = NowDate
         CP_SEQ = Rs("CP_SEQ")

         SQL = "INSERT INTO " & CMS_MENU_LST_Table _
             & " (CS_CODE,CM_SEQ,CM_NAME,CM_CODE,CM_DEPTH,CM_SORT,CM_WDATE,CP_SEQ)" _
             & " VALUES (N'" _
             & CS_CODE & "'," _
             & CM_SEQ & ",N'" _
             & CM_NAME & "','" _
             & CM_CODE & "'," _
             & CM_DEPTH & "," _
             & CM_SORT & ",'" _
             & CM_WDATE & "'," _
             & CP_SEQ & ");"

         MAKE_SQL = MAKE_SQL & SQL & vbNewLine

         Rs.MoveNext
      Loop
   End If
   Rs.close

   Conn.Execute MAKE_SQL, ,adCmdText

   Conn.Close
   Set Conn = nothing

   Msg = "\'" & NEW_CODE & "\' 스킨을 생성 하였습니다."
   Page_Msg_Parent_ScriptReload MSG
   response.end
%>
