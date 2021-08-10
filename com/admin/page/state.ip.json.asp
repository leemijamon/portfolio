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

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

'page/state.ip.asp?iDisplayStart=0&iDisplayLength=20&sEcho=1

   sEcho = Cint(Request("sEcho"))
   iDisplayStart = Cint(Request("iDisplayStart"))
   iDisplayLength = Cint(Request("iDisplayLength"))
   sSearch = Replace(Trim(Request("sSearch")),"'","''")
   iTotalRecords = 0 '전체레코드
   iTotalDisplayRecords = 0 '결과레코드

   WHERE = "LV_SEQ IS NOT NULL"

   SQL = "SELECT COUNT(*) FROM " & LOG_VISIT_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   iTotalRecords = Rs(0)
   Rs.close

   If sSearch <> "" Then
      WHERE = WHERE & " AND (LV_IP LIKE '%" & sSearch & "%'"
      WHERE = WHERE & " OR LV_OS LIKE '%" & sSearch & "%'"
      WHERE = WHERE & " OR LV_BROWSER LIKE '%" & sSearch & "%'"
      WHERE = WHERE & " OR LV_DOMAIN LIKE '%" & sSearch & "%'"
      WHERE = WHERE & " OR LV_QUERY LIKE '%" & sSearch & "%')"

      SQL = "SELECT COUNT(*) FROM " & LOG_VISIT_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      iTotalDisplayRecords = Rs(0)
      Rs.close
   Else
      iTotalDisplayRecords = iTotalRecords
   End If

   for k=0 to 8
      if Request("bSortable_" & k) = "true" then
         order = order & Request("iSortCol_" & k) & " " & Request("sSortDir_" & k)
       end if
   next

   order = Replace(order,"0",", LV_SEQ")
   order = Replace(order,"1",", LV_IP")
   order = Replace(order,"2",", LV_COUNTRY_CODE")
   order = Replace(order,"3",", LV_PAGE_CNT")
   order = Replace(order,"4",", HISTORY_IP_CNT")
   order = Replace(order,"5",", LV_OS")
   order = Replace(order,"6",", LV_BROWSER")
   order = Replace(order,"8",", LV_DOMAIN")
   order = Replace(order,"9",", LV_QUERY")

   If order <> "" Then
      ORDER_BY = Right(order, Len(order)-1)
   Else
      ORDER_BY = "LV_SEQ"
   End If

   If InStr(ORDER_BY,"LV_SEQ") = 0 Then ORDER_BY = ORDER_BY & ", LV_SEQ"

   S_ROWNUM = iDisplayStart + 1
   E_ROWNUM = iDisplayStart + iDisplayLength

   MEM_SQL = "(SELECT TOP 1 MEM_NAME FROM MEM_LST WHERE MEM_LOG_IP=T.LV_IP AND MEM_STATE<'90' ORDER BY MEM_LOG_DATE DESC) AS MEM_NAME"
   HISTORY_SQL = "(SELECT COUNT(*) FROM LOG_VISIT_LST AS LL WHERE LL.LV_IP = T.LV_IP) AS HISTORY_IP_CNT"

   SQL = "SELECT *," & MEM_SQL & "," & HISTORY_SQL & " FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & LOG_VISIT_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL)

   i= 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         LV_SEQ = Rs("LV_SEQ")
         LV_YEAR = Rs("LV_YEAR")
         LV_MONTH = Rs("LV_MONTH")
         LV_DAY = Rs("LV_DAY")
         LV_HOUR = Rs("LV_HOUR")
         LV_WEEK = Rs("LV_WEEK")
         LV_IP = Rs("LV_IP")
         LV_BROWSER = Rs("LV_BROWSER")
         LV_OS = Rs("LV_OS")
         LV_DOMAIN = Rs("LV_DOMAIN")
         LV_URL = Rs("LV_URL")
         LV_QUERY = Rs("LV_QUERY")
         LV_COUNTRY_CODE = Rs("LV_COUNTRY_CODE")
         LV_COUNTRY_NAME = Rs("LV_COUNTRY_NAME")
         LV_PAGE_CNT = FormatNumber(Rs("LV_PAGE_CNT"),0)
         LV_WDATE = f_chang_time(Rs("LV_WDATE"))
         HISTORY_IP_CNT = Rs("HISTORY_IP_CNT")
         MEM_NAME = Rs("MEM_NAME")

         If IsNULL(LV_URL) OR trim(LV_URL) = "" Then
            LV_URL_LINK = ""
         Else
            LV_URL_LINK = "<a href=\'" & LV_URL & "\' target=\'_blank\'>" & LV_DOMAIN & "</a>"
         End If

         LV_PAGE_CNT = "<a onclick=\""page_log(" & LV_SEQ & ");\"">" & LV_PAGE_CNT & "</a>"
         HISTORY_IP_CNT = "<a onclick=\""ip_log('" & LV_IP & "');\"">" & HISTORY_IP_CNT & "</a>"

         LV_COUNTRY_NAME_TXT = LV_COUNTRY_NAME

         BTN_WHOIS = "<button type=\""button\"" class=\""btn btn-default btn-xs\"" onclick=\""whois('" & LV_IP & "');\"">whois</button> "
         BTN_DEL = "<button type=\""button\"" class=\""btn btn-warning btn-xs\"" onclick=\""log_del('" & LV_IP & "');\"">DEL</button>"

         listData = "['" & LV_WDATE & "','" & LV_IP & "','" & LV_COUNTRY_CODE & "','" & LV_PAGE_CNT & "','HISTORY_IP_CNT','" & LV_OS &  "','" & LV_BROWSER &  "','" & MEM_NAME &  "','" & LV_URL_LINK &  "','" & LV_QUERY &  "','BTN'],"
         listData = Replace(listData,"'",chr(34))

         listData = Replace(listData,"BTN",BTN_WHOIS & BTN_DEL)
         listData = Replace(listData,"HISTORY_IP_CNT",HISTORY_IP_CNT)

         aaData = aaData & listData

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