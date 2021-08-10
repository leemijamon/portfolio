<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   NowDate = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")
   SERVER_NAME = Request.Servervariables("SERVER_NAME")

   Dim CMS_SKIN_LST_Table
   CMS_SKIN_LST_Table = "CMS_SKIN_LST"

   Dim CS_CODE,CS_STATE

   '링크로드
   Dim CMS_PAGE_LST_Table
   CMS_PAGE_LST_Table = "CMS_PAGE_LST"

   Dim CP_CODE,CP_PG_QUERY

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   WHERE = "CS_STATE < '90'"
   ORDER_BY = "CS_CODE"
   SQL = "SELECT * FROM " & CMS_SKIN_LST_Table & " WHERE " & WHERE & " ORDER BY " & ORDER_BY
   Set RsSkin = Conn.Execute(SQL, ,adCmdText)

   If RsSkin.BOF = false AND RsSkin.EOF = false Then
      Do until RsSkin.EOF
         CS_CODE = RsSkin("CS_CODE")
         CS_STATE = RsSkin("CS_STATE")

         Call MENU_MAKE(CS_CODE,CS_STATE)

         RsSkin.MoveNext
      Loop
   End If
   RsSkin.close

   Conn.Close
   Set Conn = nothing

   Sub MENU_MAKE(CS_CODE,CS_STATE)
      SQL = "SELECT * FROM " & CMS_PAGE_LST_Table & " WHERE CS_CODE='" & CS_CODE & "' AND CP_USE_YN='1' AND CP_STATE < '90' ORDER BY CP_SEQ"
      Set Rs = Conn.Execute(SQL, ,adCmdText)

      If Rs.BOF = false AND Rs.EOF = false Then
         i = 0
         Do until Rs.EOF
            CP_SEQ = Rs("CP_SEQ")
            CP_CODE = Rs("CP_CODE")
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
            CP_USE_YN = Rs("CP_USE_YN")
            CP_SSL_YN = Rs("CP_SSL_YN")
            CP_MDATE = Rs("CP_MDATE")
            CL_CODE = Rs("CL_CODE")

            CP_LINK = "/" & CP_CODE
            If CP_PG_QUERY <> "" Then CP_LINK = CP_LINK & "?" & CP_PG_QUERY

            SITE_LINK = SITE_LINK & "   Dim LINK_" & UCase(Replace(CP_CODE,"/","_")) & " : LINK_" & UCase(Replace(CP_CODE,"/","_")) & " = """ & CP_LINK & """" & vbNewLine

            If CS_STATE = "01" AND CP_USE_YN = "1" AND InStr(CP_LINK,"/member/") = 0 Then
               CP_SITEMAP = CP_SITEMAP & "  <url>" & vbNewLine
               CP_SITEMAP = CP_SITEMAP & "    <loc>http://" & SERVER_NAME & CP_LINK & "</loc>" & vbNewLine
               CP_SITEMAP = CP_SITEMAP & "    <lastmod>" & f_date(CP_MDATE,"-") & "</lastmod>" & vbNewLine
               CP_SITEMAP = CP_SITEMAP & "  </url>" & vbNewLine
            End If

            If i > 0 Then
               PAGE_SEQ = PAGE_SEQ & ","
               PAGE_URL = PAGE_URL & ","
            End If

            PAGE_SEQ = PAGE_SEQ & CP_SEQ
            PAGE_URL = PAGE_URL & CP_CODE

            PAGE_LAYOUT = PAGE_LAYOUT & "   PAGE_LAYOUT(" & CP_SEQ & ") = """ & CL_CODE & """" & vbNewLine
            PAGE_NUM = PAGE_NUM & "   PAGE_NUM(" & CP_SEQ & ") = """ & CP_NUM & """" & vbNewLine
            PAGE_NAME = PAGE_NAME & "   PAGE_NAME(" & CP_SEQ & ") = """ & Replace(CP_NAME,"""","") & """" & vbNewLine
            PAGE_TITLE = PAGE_TITLE & "   PAGE_TITLE(" & CP_SEQ & ") = """ & Replace(CP_TITLE,"""","") & """" & vbNewLine
            PAGE_TITLE_ENG = PAGE_TITLE_ENG & "   PAGE_TITLE_ENG(" & CP_SEQ & ") = """ & Replace(CP_TITLE_ENG,"""","") & """" & vbNewLine
            PAGE_KEYWORDS = PAGE_KEYWORDS & "   PAGE_KEYWORDS(" & CP_SEQ & ") = """ & Replace(CP_KEYWORDS,"""","") & """" & vbNewLine
            PAGE_DESCRIPTION = PAGE_DESCRIPTION & "   PAGE_DESCRIPTION(" & CP_SEQ & ") = """ & Replace(CP_DESCRIPTION,"""","") & """" & vbNewLine
            PAGE_MEM_LEVEL = PAGE_MEM_LEVEL & "   PAGE_MEM_LEVEL(" & CP_SEQ & ") = """ & trim(CP_MEM_LEVEL) & """" & vbNewLine
            PAGE_SKIN = PAGE_SKIN & "   PAGE_SKIN(" & CP_SEQ & ") = """ & trim(CP_SKIN) & """" & vbNewLine
            PAGE_PG_YN = PAGE_PG_YN & "   PAGE_PG_YN(" & CP_SEQ & ") = """ & trim(CP_PG_YN) & """" & vbNewLine
            PAGE_PG_ITEM = PAGE_PG_ITEM & "   PAGE_PG_ITEM(" & CP_SEQ & ") = """ & trim(CP_PG_ITEM) & """" & vbNewLine
            PAGE_SSL_YN = PAGE_SSL_YN & "   PAGE_SSL_YN(" & CP_SEQ & ") = """ & trim(CP_SSL_YN) & """" & vbNewLine

            i = i + 1
            Rs.MoveNext
         Loop

         PAGE_DIM = "   Dim PAGE_LAYOUT(" & CP_SEQ & "),PAGE_NUM(" & CP_SEQ & "),PAGE_NAME(" & CP_SEQ & "),PAGE_TITLE(" & CP_SEQ & "),PAGE_TITLE_ENG(" & CP_SEQ & "),PAGE_MEM_LEVEL(" & CP_SEQ & ")"
         PAGE_DIM = PAGE_DIM & ",PAGE_SKIN(" & CP_SEQ & "),PAGE_PG_YN(" & CP_SEQ & "),PAGE_PG_ITEM(" & CP_SEQ & "),PAGE_USE_YN(" & CP_SEQ & "),PAGE_SSL_YN(" & CP_SEQ & ")"
         PAGE_DIM = PAGE_DIM & ",PAGE_KEYWORDS(" & CP_SEQ & "),PAGE_DESCRIPTION(" & CP_SEQ & ")" & vbNewLine

         PAGE_VAL = PAGE_LAYOUT & vbNewLine & PAGE_NUM & vbNewLine &  PAGE_NAME & vbNewLine & PAGE_TITLE & vbNewLine & PAGE_TITLE_ENG & vbNewLine & PAGE_KEYWORDS & vbNewLine & PAGE_DESCRIPTION & vbNewLine & PAGE_MEM_LEVEL & vbNewLine & PAGE_SKIN & vbNewLine & PAGE_PG_YN & vbNewLine & PAGE_PG_ITEM & vbNewLine & PAGE_SSL_YN
      End If
      Rs.close

      Dim CM_SEQ,CM_NAME,CM_DEPTH,CM_SORT
      Dim CM_CNT(100)

      '홈페이지메뉴
      SQL = "SELECT M.*, P.CP_CODE, P.CP_NUM, P.CP_NAME, P.CP_TITLE, P.CP_TITLE_ENG, P.CP_PG_ITEM, P.CP_PG_QUERY, P.CL_CODE " _
          & "FROM CMS_MENU_LST AS M INNER JOIN CMS_PAGE_LST AS P ON M.CS_CODE = '" & CS_CODE & "' AND P.CS_CODE = '" & CS_CODE & "' AND M.CP_SEQ = P.CP_SEQ " _
          & "WHERE M.CM_DEPTH < 3 ORDER BY M.CM_SORT"

      Set Rs = Conn.Execute(SQL, ,adCmdText)

      i = 0
      If Rs.BOF = false AND Rs.EOF = false Then
         Do until Rs.EOF
            CM_SEQ = Rs("CM_SEQ")
            CM_NAME = Rs("CM_NAME")
            CM_ENG_NAME = Rs("CM_ENG_NAME")
            CM_DEPTH = Rs("CM_DEPTH")
            CM_CODE = Rs("CM_CODE")
            CM_SORT = Rs("CM_SORT")

            CP_CODE = Rs("CP_CODE")
            CP_NUM = Rs("CP_NUM")
            CP_TITLE = Rs("CP_TITLE")
            CP_TITLE_ENG = Rs("CP_TITLE_ENG")
            CP_PG_ITEM = Rs("CP_PG_ITEM")
            CP_PG_QUERY = Rs("CP_PG_QUERY")
            CL_CODE = Rs("CL_CODE")

            If IsNULL(CM_ENG_NAME) Then CM_ENG_NAME = ""

            CP_LINK = "/" & CP_CODE
            If CP_PG_QUERY <> "" Then CP_LINK = CP_LINK & "?" & CP_PG_QUERY
            'If CP_NUM <> "" Or CP_PG_ITEM <> "" Or CP_PG_QUERY <> "" Then CP_LINK = CP_LINK & "?pagenum=" & CP_NUM & "&item=" & CP_PG_ITEM & "&" & CP_PG_QUERY

            CM_MNUM = CInt(Left(CM_CODE,2))
            If CM_DEPTH = 1 Then CM_CNT(CM_MNUM) = CM_CNT(CM_MNUM) + 1

            MENU_NAME = MENU_NAME & "   MENU_NAME(" & CM_SORT & ") = """ & Replace(CM_NAME,"""","") & """" & vbNewLine
            MENU_ENG_NAME = MENU_ENG_NAME & "   MENU_ENG_NAME(" & CM_SORT & ") = """ & Replace(CM_ENG_NAME,"""","") & """" & vbNewLine
            MENU_DEPTH = MENU_DEPTH & "   MENU_DEPTH(" & CM_SORT & ") = " & CM_DEPTH & vbNewLine
            MENU_CODE = MENU_CODE & "   MENU_CODE(" & CM_SORT & ") = """ & CM_CODE & """" & vbNewLine
            MENU_LINK = MENU_LINK & "   MENU_LINK(" & CM_SORT & ") = """ & CP_LINK & """" & vbNewLine

            i = i + 1
            Rs.MoveNext
         Loop

         MENU_DIM = "   Dim MENU_NAME(" & CM_SORT & "),MENU_ENG_NAME(" & CM_SORT & "),MENU_DEPTH(" & CM_SORT & "),MENU_CODE(" & CM_SORT & "),MENU_LINK(" & CM_SORT & ")" & vbNewLine
         MENU_VAL = MENU_NAME & vbNewLine & MENU_ENG_NAME & vbNewLine & MENU_DEPTH & vbNewLine & MENU_CODE & vbNewLine & MENU_LINK

         MENU_DIM = MENU_DIM & "   Dim MENU_SCNT(" & CM_MNUM & ")" & vbNewLine

         For i = 1 to CM_MNUM
            If CM_CNT(i) = "" Then CM_CNT(i) = 0
            MENU_SCNT = MENU_SCNT & "   MENU_SCNT(" & i & ") = " & CM_CNT(i) & vbNewLine
         Next

         MENU_VAL = MENU_VAL & vbNewLine & MENU_SCNT
      End If
      Rs.close

      sc_cont = sc_cont & Chr(60) & Chr(37) & vbNewLine

      sc_cont = sc_cont & "   Dim PAGE_SEQ : PAGE_SEQ = """ & PAGE_SEQ & """" & vbNewLine
      sc_cont = sc_cont & "   Dim PAGE_URL : PAGE_URL = """ & PAGE_URL & """" & vbNewLine

      sc_cont = sc_cont & PAGE_DIM & vbNewLine
      sc_cont = sc_cont & PAGE_VAL & vbNewLine

      sc_cont = sc_cont & MENU_DIM & vbNewLine
      sc_cont = sc_cont & MENU_VAL & vbNewLine

      If MOBILE_DIM <> "" Then
         sc_cont = sc_cont & MOBILE_DIM & vbNewLine
         sc_cont = sc_cont & MOBILE_VAL & vbNewLine
      End If

      sc_cont = sc_cont & SITE_LINK & vbNewLine
      sc_cont = sc_cont & Chr(37) & Chr(62)

      sc_index = "<" & chr(37) & "@ LANGUAGE=""VBSCRIPT"" CODEPAGE=65001 " & chr(37) & ">" & vbNewLine
      sc_index = sc_index & "<!-- #include virtual = ""/exec/conf/code.inc"" -->" & vbNewLine
      sc_index = sc_index & "<!-- #include virtual = ""/conf/site_config.inc"" -->" & vbNewLine
      sc_index = sc_index & "<!-- #include virtual = ""/skin/" & CS_CODE & "/conf/menu_config.inc"" -->" & vbNewLine
      sc_index = sc_index & "<!-- #include virtual = ""/exec/module/dft_function.inc"" -->" & vbNewLine

      'sc_index = sc_index & "<!-- #include virtual = ""/exec/module/page_function.inc"" -->" & vbNewLine
      'sc_index = sc_index & "<!-- #include virtual = ""/exec/module/usercheck.inc"" -->" & vbNewLine

      sc_index = sc_index & Chr(60) & Chr(37) & vbNewLine

      sc_index = sc_index & "   Session.CodePage = 65001" & vbNewLine
      sc_index = sc_index & "   Response.ChaRset = ""utf-8""" & vbNewLine & vbNewLine

      sc_index = sc_index & "   URL = Trim(Request(""url""))" & vbNewLine
      sc_index = sc_index & "   If URL = """" OR URL = ""/index.asp"" Then URL = ""index""" & vbNewLine
      sc_index = sc_index & "   If Right(URL,1) = ""/"" Then URL = Left(URL,Len(URL)-1)" & vbNewLine & vbNewLine

      sc_index = sc_index & "   PAGE_SEQ = f_arr_value(PAGE_URL, PAGE_SEQ, URL)" & vbNewLine & vbNewLine

      sc_index = sc_index & "   If PAGE_SEQ = """" Then" & vbNewLine
      sc_index = sc_index & "      EXEC_FILE = ""/skin/" & CS_CODE & "/execpage/notpage.asp""" & vbNewLine
      sc_index = sc_index & "   Else" & vbNewLine
      sc_index = sc_index & "      LAYOUT = PAGE_LAYOUT(PAGE_SEQ)" & vbNewLine
      sc_index = sc_index & "      EXEC_FILE = ""/skin/" & CS_CODE & "/layout/"" & LAYOUT & "".asp""" & vbNewLine & vbNewLine
      sc_index = sc_index & "   End If" & vbNewLine

      sc_index = sc_index & "   Server.Execute(EXEC_FILE)" & vbNewLine

      sc_index = sc_index & Chr(37) & Chr(62)

      If CS_STATE = "01" Then
         sc_sitemap = sc_sitemap & "<?xml version=""1.0"" encoding=""UTF-8""?>" & vbNewLine
         sc_sitemap = sc_sitemap & "<urlset xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"" xmlns:mobile=""http://www.google.com/schemas/sitemap-mobile/1.0"">" & vbNewLine
         sc_sitemap = sc_sitemap & CP_SITEMAP
         sc_sitemap = sc_sitemap & "</urlset>" & vbNewLine

         sc_robots = sc_robots & "User-agent: *" & vbNewLine
         sc_robots = sc_robots & "Disallow: /admin/" & vbNewLine
         sc_robots = sc_robots & "Disallow: /useradmin/" & vbNewLine
         sc_robots = sc_robots & "Sitemap: http://" & SERVER_NAME & "/sitemap.xml" & vbNewLine
      End If

      '설정파일변경
      Dim FileControl
      Set FileControl = Server.CreateObject("Server.FileControl")

      Dim Result, FilePath, CharSet
      CharSet = "UTF-8" 'UTF-8

      FilePath = Server.MapPath("/skin") & "\" & CS_CODE & "\conf\menu_config.inc"
      FileControl.CreateFile FilePath, CharSet, sc_cont

      FilePath = Server.MapPath("/skin") & "\" & CS_CODE & "\index.asp"
      FileControl.CreateFile FilePath, CharSet, sc_index

      If CS_STATE = "01" Then
         FilePath = Server.MapPath("/") & "\robots_.txt"
         FileControl.CreateFile FilePath, CharSet, sc_robots

         FilePath = Server.MapPath("/") & "\sitemap_.xml"
         FileControl.CreateFile FilePath, CharSet, sc_sitemap
      End If

      Set FileControl = Nothing
   End Sub
%>