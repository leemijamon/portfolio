<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim BOARD_CONFIG_LST_Table
   BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

   Dim BC_SEQ,BC_TYPE,BC_NAME,BC_SKIN,BC_MEMO,BC_READ_MT,BC_WRITE_MT,BC_REPLY_MT,BC_COMM_MT,BC_CATE
   Dim BC_HEADER,BC_NOTICE,BC_SECRET,BC_COMMENT,BC_REPLY,BC_LIST,BC_LIST_CNT,BC_WDATE,BC_MDATE,BC_STATE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   sEcho = Cint(Request("sEcho"))
   iDisplayStart = Cint(Request("iDisplayStart"))
   iDisplayLength = Cint(Request("iDisplayLength"))
   sSearch = Request("sSearch")
   iTotalRecords = 0 '전체레코드
   iTotalDisplayRecords = 0 '결과레코드

   WHERE = "BC_STATE < '90'"

   SQL = "SELECT COUNT(*) FROM " & BOARD_CONFIG_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   iTotalRecords = Rs(0)
   Rs.close

   If sSearch <> "" Then
      WHERE = WHERE & " AND (BC_NAME LIKE '%" & sSearch & "%' OR BC_SKIN LIKE '%" & sSearch & "%')"

      SQL = "SELECT COUNT(*) FROM " & BOARD_CONFIG_LST_Table & " WHERE " & WHERE
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

   order = Replace(order,"0",", BC_SEQ")
   order = Replace(order,"1",", BC_TYPE")
   order = Replace(order,"2",", BC_NAME")
   order = Replace(order,"3",", BC_SKIN")
   order = Replace(order,"4",", BC_WDATE")

   ORDER_BY = Right(order, Len(order)-1)

   If InStr(ORDER_BY,"BC_SEQ") = 0 Then ORDER_BY = ORDER_BY & ", BC_SEQ"

   S_ROWNUM = iDisplayStart + 1
   E_ROWNUM = iDisplayStart + iDisplayLength

   SQL = "SELECT * FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & BOARD_CONFIG_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL)

   i= 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         BC_SEQ = Rs("BC_SEQ")
         BC_TYPE = Rs("BC_TYPE")
         BC_NAME = Rs("BC_NAME")
         BC_SKIN = Rs("BC_SKIN")
         BC_READ_MT = Rs("BC_READ_MT")
         BC_WRITE_MT = Rs("BC_WRITE_MT")
         BC_WDATE = f_chang_date(Rs("BC_WDATE"))

         BC_TYPE = f_arr_value(BC_TYPE_CD,BC_TYPE_NAME,BC_TYPE)

         BTN_VIEW = "<button type=\'button\' class=\'btn btn-primary btn-xs\' onclick=\""bc_view(" & BC_SEQ & ");\"">VIEW</button> "
         BTN_EDIT = "<button type=\'button\' class=\'btn btn-primary btn-xs\' onclick=\""bc_edit(" & BC_SEQ & ");\"">EDIT</button> "
         BTN_DEL = "<button type=\'button\' class=\'btn btn-warning btn-xs\' onclick=\""bc_del(" & BC_SEQ & ");\"">DEL</button>"

         aaData = aaData + "['" & BC_SEQ & "','" & BC_TYPE & "','" & BC_NAME & "','" & BC_SKIN &  "','" & BC_WDATE &  "','" & BTN_VIEW & BTN_EDIT & BTN_DEL & "'],"
         aaData = Replace(aaData,"'",chr(34))

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
