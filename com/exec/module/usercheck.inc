<%
   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   PATH_INFO = Request.ServerVariables("PATH_INFO")
   REMOTE_ADDR = Request.ServerVariables("REMOTE_ADDR")

   HTTP_URL = Request.ServerVariables("URL")
   R_QueryString = Request.ServerVariables("QUERY_STRING")

   SERVER_NAME = Request.ServerVariables("SERVER_NAME")
   HTTPS_STATE = Request.ServerVariables("HTTPS")

   URL = Trim(Request("url"))
   If URL = "" OR URL = "/index.asp" Then URL = "index"
   If Right(URL,1) = "/" Then URL = Left(URL,Len(URL)-1)

   PG_SEQ = f_arr_value(PAGE_URL, PAGE_SEQ, URL)

   If Left(URL,1) = "/" Then
      HTTP_URL = URL
   Else
      HTTP_URL = "/" & URL
   End If

   If R_QueryString <> "" Then
      R_QueryString = Replace(R_QueryString,"url=" & URL & "&","")
      R_QueryString = Replace(R_QueryString,"url=" & URL,"")
      R_QueryString = Replace(R_QueryString,"&","|")
   End If

   If R_QueryString <> "" Then HTTP_URL =  HTTP_URL & "?" & R_QueryString

   Rtn_Page = HTTP_URL
   'Rtn_Page = Request.ServerVariables("HTTP_X_ORIGINAL_URL")

   PG_LEVEL = PAGE_MEM_LEVEL(PG_SEQ)
   PG_NUM = PAGE_NUM(PG_SEQ)
   PG_TITLE = PAGE_TITLE(PG_SEQ)
   PG_SSL_YN = PAGE_SSL_YN(PG_SEQ)

   If InStr(Rtn_Page,"member/login") <> 0 Then Rtn_Page = ""

   '####SSL 적용
   If HTTPS_STATE = "on" Then
      HTTP_PROTOCOL = "https:"
   Else
      HTTP_PROTOCOL = "http:"
   End If

   If SSL_USE = "2" Then
      If SERVER_NAME <> SSL_DOMAIN Then Response.Redirect "http://" & SSL_DOMAIN & Replace(HTTP_URL,"|","&")

      If HTTPS_STATE = "off" Then
         If SSL_PORT <> "" AND SSL_PORT <> "443" Then SSL_DOMAIN = SSL_DOMAIN & ":" & SSL_PORT
         Response.Redirect "https://" & SSL_DOMAIN & Replace(HTTP_URL,"|","&")
      End If
   End If

   If SSL_USE = "1" Then
      If SERVER_NAME <> SSL_DOMAIN Then Response.Redirect "http://" & SSL_DOMAIN & Replace(HTTP_URL,"|","&")

      If PG_SSL_YN = "1" AND HTTPS_STATE = "off" Then
         If SSL_PORT <> "" AND SSL_PORT <> "443" Then SSL_DOMAIN = SSL_DOMAIN & ":" & SSL_PORT
         Response.Redirect "https://" & SSL_DOMAIN & Replace(HTTP_URL,"|","&")
      End If
      If PG_SSL_YN <> "1" AND HTTPS_STATE = "on" Then
         Response.Redirect "http://" & SSL_DOMAIN & Replace(HTTP_URL,"|","&")
      End If
   End If

   If IsEmpty(Session("MEM_SEQ")) Or IsNull(Session("MEM_SEQ")) Or Session("MEM_SEQ") = "" Or Session("MEM_IP") <> REMOTE_ADDR Then
      Login_check = "N"
      MEM_SEQ = ""
      MEM_LEVEL = "99"

      If PG_LEVEL <> "99" Then
         Response.Redirect LINK_MEMBER_LOGIN & "?rtn_page=" & server.URLEncode(Rtn_Page)
         Response.End
      End If
   Else
      Login_check = "Y"

      MEM_SEQ = Session("MEM_SEQ")
      MEM_LEVEL = Session("MEM_LEVEL")
      MEM_NAME = Session("MEM_NAME")
      MEM_ID = Session("MEM_ID")
      MEM_HP = Session("MEM_HP")
      MEM_EMAIL = Session("MEM_EMAIL")
      MEM_AREA = Session("MEM_AREA")

      If MEM_LEVEL > PG_LEVEL Then
         with response
            .write "<script language='javascript'>" & vbNewLine
            .write "  alert('회원님은 접근권한이 없습니다.');" & vbNewLine
            .write "  history.back();" & vbNewLine
            .write "</script>" & vbNewLine
         End with
         Response.End
      End If
   End If

   PageNum = request("pagenum")
   If PageNum = "" Then
      If PG_NUM <> "" Then PageNum = PG_NUM
      If PageNum = "" Then PageNum = "000000"
   End If

   If PG_NUM <> "" Then
      For i = 1 to UBound(MENU_CODE)
         If MENU_DEPTH(i) = 0 AND Left(MENU_CODE(i),2) = Left(PG_NUM,2) Then PG_POSITION1 = "<li><a href=""" & MENU_LINK(i) & """>" & MENU_NAME(i) & "</a></li>" & vbNewLine
         If MENU_DEPTH(i) = 1 AND Right(PG_NUM,4) <> "0000" AND Left(MENU_CODE(i),4) = Left(PG_NUM,4) Then PG_POSITION2 = "<li><a href=""" & MENU_LINK(i) & """>" & MENU_NAME(i) & "</a></li>" & vbNewLine
         If MENU_DEPTH(i) = 2 AND Right(PG_NUM,2) <> "00" AND MENU_CODE(i) = PG_NUM Then PG_POSITION3 = "<li><a href=""" & MENU_LINK(i) & """>" & MENU_NAME(i) & "</a></li>" & vbNewLine
      Next

      PG_POSITION = PG_POSITION1
      If PG_POSITION3 <> "" Then
         PG_POSITION3 = Replace(PG_POSITION3, "<li>", "<li class='active'>")
      Else
         PG_POSITION2 = Replace(PG_POSITION2, "<li>", "<li class='active'>")
      End If
      If PG_POSITION2 <> "" Then PG_POSITION = PG_POSITION & PG_POSITION2
      If PG_POSITION3 <> "" Then PG_POSITION = PG_POSITION & PG_POSITION3
   End If

   '#### 타이틀적용
   If PAGE_TITLE(PG_SEQ) <> "" AND URL <> "index" Then
      If SITE_TITLE = "" Then
         SITE_TITLE = PAGE_TITLE(PG_SEQ)
      Else
         SITE_TITLE = SITE_TITLE & " - " & PAGE_TITLE(PG_SEQ)
      End if
   End if
   If PAGE_KEYWORDS(PG_SEQ) <> "" Then SITE_KEYWORDS = PAGE_KEYWORDS(PG_SEQ)
   If PAGE_DESCRIPTION(PG_SEQ) <> "" Then SITE_DESCRIPTION = PAGE_DESCRIPTION(PG_SEQ)
%>