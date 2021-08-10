<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim LOG_PAGE_LST_Table
   LOG_PAGE_LST_Table = "LOG_PAGE_LST"

   Dim LP_SEQ,LP_URL,LP_QUERY,LP_WDATE
   Dim LV_SEQ

   LV_SEQ = Trim(Request("lv_seq"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   sEcho = Cint(Request("sEcho"))
   iDisplayStart = Cint(Request("iDisplayStart"))
   iDisplayLength = Cint(Request("iDisplayLength"))
   sSearch = Replace(Trim(Request("sSearch")),"'","''")
   iTotalRecords = 0 '전체레코드
   iTotalDisplayRecords = 0 '결과레코드

   WHERE = "LV_SEQ=" & LV_SEQ

   SQL = "SELECT COUNT(*) FROM " & LOG_PAGE_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   iTotalRecords = Rs(0)
   Rs.close

   If sSearch <> "" Then
      WHERE = WHERE & " AND LP_URL LIKE '%" & sSearch & "%'"

      SQL = "SELECT COUNT(*) FROM " & LOG_PAGE_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      iTotalDisplayRecords = Rs(0)
      Rs.close
   Else
      iTotalDisplayRecords = iTotalRecords
   End If

   for k=0 to 2
      if Request("bSortable_" & k) = "true" then
         order = order & Request("iSortCol_" & k) & " " & Request("sSortDir_" & k)
       end if
   next

   order = Replace(order,"0",", LP_SEQ")
   order = Replace(order,"1",", LP_URL")
   order = Replace(order,"2",", LP_CNT")

   If order <> "" Then
      ORDER_BY = Right(order, Len(order)-1)
   Else
      ORDER_BY = "LP_SEQ"
   End If

   If InStr(ORDER_BY,"LP_SEQ") = 0 Then ORDER_BY = ORDER_BY & ", LP_SEQ"

   S_ROWNUM = iDisplayStart + 1
   E_ROWNUM = iDisplayStart + iDisplayLength

   SQL = "SELECT * FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & LOG_PAGE_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL)

   i= 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         LP_SEQ = Rs("LP_SEQ")
         LP_URL = Rs("LP_URL")
         LP_QUERY = Rs("LP_QUERY")
         LP_WDATE = f_chang_time(Rs("LP_WDATE"))
         LP_CNT = FormatNumber(Rs("LP_CNT"),0)

         If IsNULL(LP_QUERY) OR LP_QUERY = "" Then
            LP_QUERY = ""
            L_URL = LP_URL
         Else
            L_URL = LP_URL & "?" & LP_QUERY
         End If

         L_URL = "<a href=\'" & L_URL & "\' target=\'_blank\'>" & L_URL & "</a>"

         listData = "['" & LP_WDATE & "','" & L_URL & "','" & LP_CNT & "'],"
         listData = Replace(listData,"'",chr(34))

         aaData = aaData + listData

         i = i + 1

         Rs.MoveNext
      Loop
      aaData = Left(aaData,Len(aaData)-1)
   Else
      aaData = ""
   End If
   Rs.close

   response.write "{""sEcho"": " & sEcho & ", ""iTotalRecords"": " & iTotalRecords & ", ""iTotalDisplayRecords"": " & iTotalDisplayRecords & ", ""aaData"": [" & aaData & "]}"
%>