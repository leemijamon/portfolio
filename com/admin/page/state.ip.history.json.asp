<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim LOG_VISIT_LST_Table
   LOG_VISIT_LST_Table = "LOG_VISIT_LST"

   Dim LV_SEQ,LV_IP,LV_BROWSER,LV_OS,LV_DOMAIN,LV_URL,LV_QUERY,LV_PAGE_CNT,LV_COUNTRY_CODE,LV_COUNTRY_NAME
   Dim LV_WDATE,LV_MDATE,LV_YEAR,LV_MONTH,LV_DAY,LV_HOUR,LV_WEEK

   LV_IP = Trim(Request("lv_ip"))

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   sEcho = Cint(Request("sEcho"))
   iDisplayStart = Cint(Request("iDisplayStart"))
   iDisplayLength = Cint(Request("iDisplayLength"))
   sSearch = Replace(Trim(Request("sSearch")),"'","''")
   iTotalRecords = 0 '전체레코드
   iTotalDisplayRecords = 0 '결과레코드

   WHERE = "LV_SEQ IS NOT NULL AND LV_IP = '" & LV_IP & "'"

   SQL = "SELECT COUNT(*) FROM " & LOG_VISIT_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   iTotalRecords = Rs(0)
   Rs.close

   If sSearch <> "" Then
      WHERE = WHERE & " AND (LV_URL LIKE '%" & sSearch & "%' OR LV_QUERY LIKE '%" & sSearch & "%')"

      SQL = "SELECT COUNT(*) FROM " & LOG_VISIT_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      iTotalDisplayRecords = Rs(0)
      Rs.close
   Else
      iTotalDisplayRecords = iTotalRecords
   End If

   for k=0 to 4
      if Request("bSortable_" & k) = "true" then
         order = order & Request("iSortCol_" & k) & " " & Request("sSortDir_" & k)
       end if
   next

   order = Replace(order,"0",", LV_SEQ")
   order = Replace(order,"1",", LV_PAGE_CNT")
   order = Replace(order,"2",", LV_URL")
   order = Replace(order,"3",", LV_QUERY")

   If order <> "" Then
      ORDER_BY = Right(order, Len(order)-1)
   Else
      ORDER_BY = "LV_SEQ"
   End If

   If InStr(ORDER_BY,"LV_SEQ") = 0 Then ORDER_BY = ORDER_BY & ", LV_SEQ"

   S_ROWNUM = iDisplayStart + 1
   E_ROWNUM = iDisplayStart + iDisplayLength

   SQL = "SELECT * FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & LOG_VISIT_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL)

   i= 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         LV_SEQ = Rs("LV_SEQ")
         LV_IP = Rs("LV_IP")
         LV_DOMAIN = Rs("LV_DOMAIN")
         LV_URL = Rs("LV_URL")
         LV_QUERY = Rs("LV_QUERY")
         LV_PAGE_CNT = FormatNumber(Rs("LV_PAGE_CNT"),0)
         LV_WDATE = f_chang_time(Rs("LV_WDATE"))

         If IsNULL(LV_URL) OR trim(LV_URL) = "" Then
            LV_URL_LINK = ""
         Else
            LV_URL_LINK = "<a href=\'" & LV_URL & "\' target=\'_blank\'>" & LV_DOMAIN & "</a>"
         End If

         listData = "['" & LV_WDATE & "','" & LV_PAGE_CNT & "','" & LV_URL_LINK & "','" & LV_QUERY & "'],"
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