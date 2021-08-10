<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<%
   ON Error Resume next

   'If Request.ServerVariables("Remote_Addr") = "61.40.205.154" Then
   '   response.write f_Query(Request.ServerVariables("HTTP_REFERER"))
   'End If

   Session("check") = "IsCookie" '세션변수에 아무값이나 넣어주고

   If IsEmpty(Session("check")) = false AND IsNull(Session("check")) = false AND Session("check") <> "" Then
      LOG_USERAGENT = Request.ServerVariables("HTTP_USER_AGENT")
      LOG_IP = Request.ServerVariables("Remote_Addr")
      LOG_REFERER = Request.ServerVariables("HTTP_REFERER")

      If Request.ServerVariables("HTTP_X_ORIGINAL_URL") <> "" Then
         LOG_URL = Request.ServerVariables("HTTP_X_ORIGINAL_URL")
      Else
         LOG_URL = Request.ServerVariables("URL")
      End If
      LOG_QUERY = Request.ServerVariables("QUERY_STRING")

      LOG_DATE = Replace(FormatDateTime(now(),2),"-","") & Replace(FormatDateTime(now(),4),":","")

      'If LOG_IP = "124.53.226.24" Then LOG_CHECK = "N"
      If InStr(LOG_USERAGENT, "Bot/") > 0 Then LOG_CHECK = "N"
      If InStr(LOG_USERAGENT, "bots/") > 0 Then LOG_CHECK = "N"
      If InStr(LOG_USERAGENT, "bot/") > 0 Then LOG_CHECK = "N"
      If InStr(LOG_USERAGENT, "Slurp/") > 0 Then LOG_CHECK = "N"
      If InStr(LOG_USERAGENT, "+http") > 0 Then LOG_CHECK = "N"
      'If InStr(LOG_IP, "65.55.") > 0 Then LOG_CHECK = "N"
      'If InStr(LOG_IP, "121.156.") > 0 Then LOG_CHECK = "N"

      If LOG_CHECK <> "N" Then
         Dim LOG_VISIT_LST_Table
         LOG_VISIT_LST_Table = "LOG_VISIT_LST"

         Dim LV_SEQ,LV_IP,LV_BROWSER,LV_OS,LV_DOMAIN,LV_URL,LV_QUERY,LV_PAGE_CNT,LV_COUNTRY_CODE,LV_COUNTRY_NAME
         Dim LV_WDATE,LV_MDATE,LV_YEAR,LV_MONTH,LV_DAY,LV_HOUR,LV_WEEK

         Dim LOG_PAGE_LST_Table
         LOG_PAGE_LST_Table = "LOG_PAGE_LST"

         Dim LP_URL,LP_QUERY,LP_WDATE,LP_YEAR,LP_MONTH,LP_DAY,LP_HOUR,LP_WEEK

         Dim Conn, Rs
         Set Conn = Server.CreateObject("ADODB.Connection")
         Conn.Open Application("connect")

         If IsEmpty(Session("LV_SEQ")) Or IsNull(Session("LV_SEQ")) Or Session("LV_SEQ") = "" Then
            Call LOG_VISIT()
         End If

         If LOG_URL <> "/index.asp" Then
            Call LOG_PAGE()
         End If

         Call LOG_PAGE_DEL()

         Conn.Close
         Set Conn = nothing
      End If
   End If

   Sub LOG_VISIT()
      LV_YEAR = Year(Now)
      LV_MONTH = Month(Now)
      LV_DAY = Day(Now)
      LV_HOUR = Hour(Now)
      LV_WEEK = Weekday(Now)

      LV_IP = LOG_IP
      LV_URL = LOG_REFERER

      If InStr(LV_URL, "http://") > 0 Then
         temp_point = InStr(8,LV_URL,"/")
         LV_DOMAIN = Left(LV_URL,temp_point-1)
         LV_DOMAIN = Replace(LV_DOMAIN,"http://","")
      End If

      If InStr(LV_URL, "https://") > 0 Then
         temp_point = InStr(9,LV_URL,"/")
         LV_DOMAIN = Left(LV_URL,temp_point-1)
         LV_DOMAIN = Replace(LV_DOMAIN,"https://","")
      End If

      If trim(LV_URL) <> "" Then
         LV_QUERY = f_Query(LV_URL)
      End If

      LV_BROWSER = f_Browser(LOG_USERAGENT)
      LV_OS = f_Os(LOG_USERAGENT)

      LV_USERAGENT = LOG_USERAGENT

      LV_WDATE = LOG_DATE
      LV_MDATE = LOG_DATE
      LV_PAGE_CNT = 0

      SQL = "SELECT ip.dbo.FUNC_IPCountry('" & LV_IP & "') AS COUNTRY_CODE"
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      LV_COUNTRY_CODE = Rs("COUNTRY_CODE")
      Rs.close

      SQL = "SELECT C_NAME FROM ip.dbo.COUNTRY_LST WHERE C_CODE = '" & LV_COUNTRY_CODE & "'"
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      LV_COUNTRY_NAME = Rs("C_NAME")
      Rs.close

      SQL = "INSERT INTO " & LOG_VISIT_LST_Table _
          & " (LV_IP,LV_BROWSER,LV_OS,LV_USERAGENT,LV_DOMAIN,LV_URL,LV_QUERY,LV_PAGE_CNT,LV_COUNTRY_CODE,LV_COUNTRY_NAME,LV_WDATE,LV_MDATE,LV_YEAR,LV_MONTH,LV_DAY,LV_HOUR,LV_WEEK)" _
          & " VALUES (N'" _
          & LV_IP & "',N'" _
          & LV_BROWSER & "',N'" _
          & LV_OS & "',N'" _
          & LV_USERAGENT & "',N'" _
          & LV_DOMAIN & "',N'" _
          & LV_URL & "',N'" _
          & LV_QUERY & "'," _
          & LV_PAGE_CNT & ",'" _
          & LV_COUNTRY_CODE & "','" _
          & LV_COUNTRY_NAME & "','" _
          & LV_WDATE & "','" _
          & LV_MDATE & "'," _
          & LV_YEAR & "," _
          & LV_MONTH & "," _
          & LV_DAY & "," _
          & LV_HOUR & "," _
          & LV_WEEK & ")"

      Conn.Execute SQL, ,adCmdText

      SQL = "SELECT @@IDENTITY FROM " & LOG_VISIT_LST_Table
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      LV_SEQ = Rs(0)
      Rs.close

      Session("LV_SEQ") = LV_SEQ

      'SQL = "SP_LOG_COUNTRY_INSERT '" & LV_IP & "', " & LV_SEQ
      'Conn.Execute SQL, ,adCmdText
   End Sub

   Sub LOG_PAGE()
      LP_YEAR = Year(Now)
      LP_MONTH = Month(Now)
      LP_DAY = Day(Now)
      LP_HOUR = Hour(Now)
      LP_WEEK = Weekday(Now)
      LP_WDATE = LOG_DATE
      LP_MDATE = LOG_DATE
      LP_CNT = 1

      LV_SEQ = Session("LV_SEQ")

      If Request.ServerVariables("HTTP_X_ORIGINAL_URL") <> "" Then
         LP_URL = Request.ServerVariables("HTTP_X_ORIGINAL_URL")

         If InStr(LP_URL,"?") > 0 Then
            SP_URL = Split(LP_URL,"?")
            LP_URL = SP_URL(0)
            LP_QUERY = SP_URL(1)
         End If
      Else
         LP_URL = Request.ServerVariables("URL")
         LP_QUERY = Request.ServerVariables("QUERY_STRING")
      End If

      If Session("LP_URL") <> LP_URL OR Session("LP_QUERY") <> LP_QUERY Then
         SQL = "INSERT INTO " & LOG_PAGE_LST_Table _
             & " (LP_URL,LP_QUERY,LP_CNT,LP_WDATE,LP_MDATE,LP_YEAR,LP_MONTH,LP_DAY,LP_HOUR,LP_WEEK,LV_SEQ)" _
             & " VALUES (N'" _
             & LP_URL & "',N'" _
             & LP_QUERY & "'," _
             & LP_CNT & ",'" _
             & LP_WDATE & "','" _
             & LP_MDATE & "'," _
             & LP_YEAR & "," _
             & LP_MONTH & "," _
             & LP_DAY & "," _
             & LP_HOUR & "," _
             & LP_WEEK & "," _
             & LV_SEQ & ")"

         Conn.Execute SQL, ,adCmdText

         SQL = "SELECT @@IDENTITY FROM " & LOG_PAGE_LST_Table
         Set Rs = Conn.Execute(SQL, ,adCmdText)
         LP_SEQ = Rs(0)
         Rs.close

         Session("LP_SEQ") = LP_SEQ
         Session("LP_URL") = LP_URL
         Session("LP_QUERY") = LP_QUERY
      Else
         SQL = "UPDATE " & LOG_PAGE_LST_Table & " SET " _
             & "LP_CNT=LP_CNT + 1 " _
             & "WHERE " _
             & "LP_SEQ=" & Session("LP_SEQ")

         Conn.Execute SQL, ,adCmdText
      End If

      LV_MDATE = LOG_DATE

      SQL = "UPDATE " & LOG_VISIT_LST_Table & " SET " _
          & "LV_PAGE_CNT=LV_PAGE_CNT + 1, " _
          & "LV_MDATE='" & LV_MDATE & "' " _
          & "WHERE " _
          & "LV_SEQ=" & LV_SEQ

      Conn.Execute SQL, ,adCmdText
   End Sub

   Sub LOG_PAGE_DEL()
      LP_WDATE = Replace(FormatDateTime(DateAdd("m", -1, now()),2),"-","") & Replace(FormatDateTime(now(),4),":","")

      SQL = "DELETE FROM " & LOG_PAGE_LST_Table & " WHERE LP_WDATE < '" & LP_WDATE & "'"
      Conn.Execute SQL, ,adCmdText
   End Sub

   Function f_Query(strUrl)
      UrlQuery = ""
      If InStr(strUrl,"?q=") > 0 OR InStr(strUrl,"&q=") > 0 Then UrlQuery = "q="
      If InStr(strUrl,"?query=") > 0 OR InStr(strUrl,"&query=") > 0 Then UrlQuery = "query="
      If UrlQuery = "" Then
         f_Query = ""
         Exit Function
      End If

      SpUrl = Split(strUrl,"&")

      If IsArray(SpUrl) Then
         For i = 0 to UBound(SpUrl)
            If Left(SpUrl(i),Len(UrlQuery)) = UrlQuery Then
               SP_QUERY = SpUrl(i)
               Exit For
            End If
         Next
      End If

      SP_QUERY = REPLACE(SP_QUERY, UrlQuery, "")
      SP_QUERY = REPLACE(SP_QUERY, "%20", "+")

      Set UrlTool = Server.CreateObject("EzWebUtil.UrlTool")
      f_Query = UrlTool.UrlDecode(SP_QUERY)
      Set UrlTool = Nothing
   End Function

   Function f_Browser(str_useragent)
      If InStr(str_useragent,"Trident/7.0") > 0 Then f_Browser = "IE11" : Exit Function
      If InStr(str_useragent,"Trident/6.0") > 0 OR InStr(str_useragent,"MSIE 10.0") > 0 Then f_Browser = "IE10" : Exit Function
      If InStr(str_useragent,"Trident/5.0") > 0 OR InStr(str_useragent,"MSIE 9.0") > 0 Then f_Browser = "IE9" : Exit Function
      If InStr(str_useragent,"Trident/4.0") > 0 OR InStr(str_useragent,"MSIE 8.0") > 0 Then f_Browser = "IE8" : Exit Function
      If InStr(str_useragent,"MSIE 7.0") > 0 Then f_Browser = "IE7" : Exit Function
      If InStr(str_useragent,"MSIE 6.0") > 0 Then f_Browser = "IE6" : Exit Function

      If InStr(LCase(str_useragent),"chrome") > 0 Then f_Browser = "Chrome" : Exit Function
      If InStr(LCase(str_useragent),"firefox") > 0 Then f_Browser = "Firefox" : Exit Function
      If InStr(LCase(str_useragent),"safari") > 0 Then f_Browser = "Safari" : Exit Function
      If InStr(LCase(str_useragent),"opera") > 0 Then f_Browser = "Opera" : Exit Function

      f_Browser = "Etc"
   End Function

   Function f_Os(str_useragent)
      If InStr(str_useragent,"Windows NT 10.0") > 0 Then f_Os = "Windows 10" : Exit Function
      If InStr(str_useragent,"Windows NT 6.4") > 0 Then f_Os = "Windows 10" : Exit Function
      If InStr(str_useragent,"Windows NT 6.3") > 0 Then f_Os = "Windows 8.1" : Exit Function
      If InStr(str_useragent,"Windows NT 6.2") > 0 Then f_Os = "Windows 8" : Exit Function
      If InStr(str_useragent,"Windows NT 6.1") > 0 Then f_Os = "Windows 7" : Exit Function
      If InStr(str_useragent,"Windows NT 6.0") > 0 Then f_Os = "Windows Vista" : Exit Function
      If InStr(str_useragent,"Windows NT 5.2") > 0 Then f_Os = "Windows XP" : Exit Function
      If InStr(str_useragent,"Windows NT 5.1") > 0 Then f_Os = "Windows XP" : Exit Function
      If InStr(str_useragent,"Windows NT 5.0") > 0 Then f_Os = "Windows 2000" : Exit Function
      If InStr(str_useragent,"Windows NT 4.0") > 0 Then f_Os = "Windows NT 4.0" : Exit Function
      If InStr(str_useragent,"Windows") > 0 Then f_Os = "Windows" : Exit Function

      If InStr(LCase(str_useragent),"android") > 0 Then f_Os = "Android" : Exit Function
      If InStr(LCase(str_useragent),"linux") > 0 Then f_Os = "Linux" : Exit Function

      If InStr(LCase(str_useragent),"iphone") > 0 Then f_Os = "iPhone" : Exit Function
      If InStr(LCase(str_useragent),"ipod touch") > 0 Then f_Os = "iPod touch" : Exit Function
      If InStr(LCase(str_useragent),"iphone") > 0 Then f_Os = "iPhone" : Exit Function

      f_Os  = "Etc"
   End Function
%>