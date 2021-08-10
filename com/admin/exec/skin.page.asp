<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/cms_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   Dim MSG,GO_PAGE

   Dim CMS_PAGE_LST_Table
   CMS_PAGE_LST_Table = "CMS_PAGE_LST"

   Dim CP_SEQ,CP_TYPE,CP_CODE,CP_NUM,CP_NAME,CP_TITLE,CP_TITLE_ENG,CP_MEM_LEVEL,CP_PG_YN,CP_PG_ITEM,CP_PG_NAME
   Dim CP_PG_QUERY,CP_SSL_YN,CP_USE_YN,CP_TOP_ITEM,CP_SUBTOP_ITEM,CP_SIDE_ITEM,CP_SCROLL_ITEM,CP_BOTTOM_ITEM,CP_SORT,CP_WDATE
   Dim CP_MDATE,CP_STATE,ADM_SEQ,CP_CONT

   PRO_METHOD = Trim(Request("method"))

   CS_CODE = Trim(Request("cs_code"))
   CP_SEQ = Trim(Request("cp_seq"))
   CP_TYPE = Replace(Trim(Request.Form("cp_type")),"'","")
   CP_CODE = Replace(Trim(Request.Form("cp_code")),"'","")
   CP_NUM = Replace(Trim(Request.Form("cp_num")),"'","")
   CP_TYPE = Trim(Request.Form("cp_type"))
   CP_NAME = Replace(Trim(Request.Form("cp_name")),"'","''")
   CP_TITLE = Replace(Trim(Request.Form("cp_title")),"'","''")
   CP_TITLE_ENG = Replace(Trim(Request.Form("cp_title_eng")),"'","''")
   CP_KEYWORDS = Replace(Trim(Request.Form("cp_keywords")),"'","''")
   CP_DESCRIPTION = Replace(Trim(Request.Form("cp_description")),"'","''")
   CP_MEM_LEVEL = Trim(Request.Form("cp_mem_level"))
   CP_SKIN = Trim(Request.Form("cp_skin"))

   CP_PG = Replace(Trim(Request.Form("cp_pg")),"'","''")
   SP_PG = Split(CP_PG,"|")

   If UBound(SP_PG) = 2 Then
      CP_PG_YN = "1"
      CP_PG_ITEM = SP_PG(0)
      CP_PG_QUERY = SP_PG(1)
      CP_PG_NAME = SP_PG(2)
   Else
      CP_PG_YN = "0"
   End If

   CP_SSL_YN = Trim(Request.Form("cp_ssl_yn"))
   CP_USE_YN = Trim(Request.Form("cp_use_yn"))
   CP_WDATE = NowDate
   CP_MDATE = NowDate
   CP_STATE = "00"
   CL_CODE = Trim(Request.Form("cl_code"))
   ADM_SEQ = Trim(Request.Form("adm_seq"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Select Case PRO_METHOD
      Case "register" : pro_register
      Case "modify" : pro_modify
      Case "delete" : pro_delete
      Case "cont" : pro_cont
      Case "sort" : pro_sort
   End Select

   Conn.Close
   Set Conn = nothing

   If PRO_METHOD <> "sort" AND PRO_METHOD <> "cont" Then
      '##코드 생성
      Server.Execute "/admin/exec/make.menu.asp"
   End If

   If PRO_METHOD = "cont" OR PRO_METHOD = "delete" Then
      '##네이버
      Server.Execute "/admin/exec/skin.page.syndiping.asp"
   End If

   Sub pro_register()
      SQL = "SELECT * FROM " & CMS_PAGE_LST_Table & " WHERE CS_CODE='" & CS_CODE & "' AND CP_CODE='" & CP_CODE & "' AND CP_STATE < '90'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Alert_Msg "사용중인 코드입니다.\n\n다른 코드를 사용해 주세요."
         response.end
      End If
      Rs.close

      CP_STATE = "00"

      SQL = "SELECT MAX(CP_SEQ) AS MAX_SEQ FROM " & CMS_PAGE_LST_Table& " WHERE CS_CODE='" & CS_CODE & "'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      CP_SEQ = Rs("MAX_SEQ")
      If IsNULL(CP_SEQ) Then CP_SEQ = 0
      CP_SEQ = CP_SEQ + 1
      Rs.close

      SQL = "SELECT MAX(CP_SORT) AS MAX_SORT FROM " & CMS_PAGE_LST_Table& " WHERE CS_CODE='" & CS_CODE & "'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      CP_SORT = Rs("MAX_SORT")
      If IsNULL(CP_SORT) Then CP_SORT = 0
      CP_SORT = CP_SORT + 1
      Rs.close

      SQL = "INSERT INTO " & CMS_PAGE_LST_Table _
          & " (CS_CODE,CP_SEQ,CP_TYPE,CP_CODE,CP_NUM,CP_NAME,CP_TITLE,CP_TITLE_ENG,CP_KEYWORDS,CP_DESCRIPTION,CP_MEM_LEVEL,CP_SKIN,CP_PG_YN,CP_PG_ITEM,CP_PG_NAME,CP_PG_QUERY,CP_SSL_YN,CP_USE_YN,CP_SORT,CP_WDATE,CP_MDATE,CP_STATE,CL_CODE,ADM_SEQ)" _
          & " VALUES (N'" _
          & CS_CODE & "'," _
          & CP_SEQ & ",N'" _
          & CP_TYPE & "',N'" _
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
          & ADM_SEQ & ")"

      Conn.Execute SQL, ,adCmdText

      MSG = "페이지가 등록 되었습니다."

      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_href(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.reloadskin();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_href();'>" & vbNewLine
      End With
   End Sub

   Sub pro_modify()
      SQL = "SELECT * FROM " & CMS_PAGE_LST_Table & " WHERE CP_SEQ <> " & CP_SEQ & " AND CS_CODE='" & CS_CODE & "' AND CP_CODE='" & CP_CODE & "' AND CP_STATE<'90'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         Alert_Msg "사용중인 코드입니다.\n\n다른 코드를 사용해 주세요."
         response.end
      End If
      Rs.close

      SQL = "UPDATE " & CMS_PAGE_LST_Table & " SET " _
          & "CP_TYPE=N'" & CP_TYPE & "', " _
          & "CP_CODE=N'" & CP_CODE & "', " _
          & "CP_NUM=N'" & CP_NUM & "', " _
          & "CP_NAME=N'" & CP_NAME & "', " _
          & "CP_TITLE=N'" & CP_TITLE & "', " _
          & "CP_TITLE_ENG=N'" & CP_TITLE_ENG & "', " _
          & "CP_KEYWORDS=N'" & CP_KEYWORDS & "', " _
          & "CP_DESCRIPTION=N'" & CP_DESCRIPTION & "', " _
          & "CP_MEM_LEVEL='" & CP_MEM_LEVEL & "', " _
          & "CP_SKIN=N'" & CP_SKIN & "', " _
          & "CP_PG_YN='" & CP_PG_YN & "', " _
          & "CP_PG_ITEM=N'" & CP_PG_ITEM & "', " _
          & "CP_PG_NAME=N'" & CP_PG_NAME & "', " _
          & "CP_PG_QUERY=N'" & CP_PG_QUERY & "', " _
          & "CP_SSL_YN='" & CP_SSL_YN & "', " _
          & "CP_USE_YN='" & CP_USE_YN & "', " _
          & "CP_MDATE='" & CP_MDATE & "', " _
          & "CL_CODE=N'" & CL_CODE & "', " _
          & "ADM_SEQ=" & ADM_SEQ & " " _
          & "WHERE " _
          & "CS_CODE='" & CS_CODE & "' AND CP_SEQ=" & CP_SEQ

      Conn.Execute SQL, ,adCmdText

      MSG = "페이지를 수정하였습니다."

      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_href(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.reloadskin();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_href();'>" & vbNewLine
      End With
   End Sub

   Sub pro_delete()
      CP_STATE = "99"

      SQL = "UPDATE " & CMS_PAGE_LST_Table & " SET " _
          & "CP_MDATE='" & CP_MDATE & "', " _
          & "CP_STATE='" & CP_STATE & "' " _
          & "WHERE " _
          & "CS_CODE='" & CS_CODE & "' AND CP_SEQ=" & CP_SEQ

      Conn.Execute SQL, ,adCmdText

      MSG = "페이지를 삭제하였습니다."

      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_href(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.reloadskin();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_href();'>" & vbNewLine
      End With
   End Sub

   Sub pro_sort()
      CP_SEQ = Replace(CP_SEQ, "sortable[]=","")
      CP_SEQ = Replace(CP_SEQ,"&",",")

      If InStr(CP_SEQ,",") > 0 Then
         SP_SEQ = Split(CP_SEQ,",")

         For fn = 0 to UBound(SP_SEQ)
            CP_SORT = fn + 1
            SQL = "UPDATE " & CMS_PAGE_LST_Table & " SET " _
                & "CP_SORT=" & CP_SORT & " " _
                & "WHERE CS_CODE='" & CS_CODE & "' AND CP_SEQ=" & trim(SP_SEQ(fn))

            Conn.Execute SQL, ,adCmdText
         Next
      End If
   End Sub

   Sub pro_cont()
      CP_CONT = Trim(Request.Form("content"))

      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      skin_path = "/skin/" & CS_CODE
      skin_mappath = Server.MapPath(skin_path)

      temp_file_path = skin_mappath & "\page\" & Replace(CP_CODE,"/",".") & ".temp"
      back_file_path = skin_mappath & "\page\" & Replace(CP_CODE,"/",".") & ".bak"
      make_file_path = skin_mappath & "\page\" & Replace(CP_CODE,"/",".") & ".asp"

      '페이지 백업
      Result = FileControl.FileExists(temp_file_path)
      If Result Then FileControl.CopyFile temp_file_path, back_file_path

      page_html = CP_CONT

      '템프저장
      FileControl.CreateFile temp_file_path, "UTF-8", page_html

      '코드변환
      page_html = CodeChange(CS_CODE,page_html)

      inc_start = "<" & chr(37) & "@ LANGUAGE=""VBSCRIPT"" CODEPAGE=65001 " & chr(37) & ">" & vbNewLine
      inc_start = inc_start & "<!-- #include virtual = ""/conf/site_config.inc"" -->" & vbNewLine

      '실제파일저장
      FileControl.CreateFile make_file_path, "UTF-8", inc_start & page_html

      Set FileControl = Nothing

      MSG = "페이지를 수정하였습니다."

      With response
         .write "<script language='javascript'>" & vbNewLine
         .write "<!--" & vbNewLine
         .write "  function msg_href(){" & vbNewLine
         .write "     alert('" & msg & "');" & vbNewLine
         .write "     parent.parent.goskin();" & vbNewLine
         .write "  }" & vbNewLine
         .write "-->" & vbNewLine
         .write "</script>" & vbNewLine & vbNewLine

         .write "<body onload='javascript:msg_href();'>" & vbNewLine
      End With
   End Sub
%>
