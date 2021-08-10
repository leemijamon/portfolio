<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim QNA_VIEW_Table
   QNA_VIEW_Table = "QNA_VIEW"

   Dim Q_SEQ,Q_TYPE,Q_TITLE,Q_CONT,Q_ANSER,Q_ADATE,Q_RTN_MAIL,Q_RTN_SMS,Q_READCNT,Q_IP
   Dim Q_WDATE,Q_MDATE,Q_STATE,MEM_SEQ,ADM_SEQ,Q_NAME

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   sEcho = Cint(Request("sEcho"))
   iDisplayStart = Cint(Request("iDisplayStart"))
   iDisplayLength = Cint(Request("iDisplayLength"))
   sSearch = Request("sSearch")
   iTotalRecords = 0 '전체레코드
   iTotalDisplayRecords = 0 '결과레코드

   WHERE = "Q_STATE < '90'"

   SQL = "SELECT COUNT(*) FROM " & QNA_VIEW_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   iTotalRecords = Rs(0)
   Rs.close

   If sSearch <> "" Then
      WHERE = WHERE & " AND (Q_NAME LIKE '%" & sSearch & "%' OR Q_TITLE LIKE '%" & sSearch & "%')"

      SQL = "SELECT COUNT(*) FROM " & QNA_VIEW_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      iTotalDisplayRecords = Rs(0)
      Rs.close
   Else
      iTotalDisplayRecords = iTotalRecords
   End If

   for k=0 to 5
      if Request("bSortable_" & k) = "true" then
         order = order & Request("iSortCol_" & k) & " " & Request("sSortDir_" & k)
       end if
   next

   order = Replace(order,"0",", Q_SEQ")
   order = Replace(order,"1",", Q_TYPE")
   order = Replace(order,"2",", Q_TITLE")
   order = Replace(order,"3",", Q_NAME")
   order = Replace(order,"4",", Q_WDATE")
   order = Replace(order,"5",", Q_ADATE")

   ORDER_BY = Right(order, Len(order)-1)

   If InStr(ORDER_BY,"Q_SEQ") = 0 Then ORDER_BY = ORDER_BY & ", Q_SEQ"

   S_ROWNUM = iDisplayStart + 1
   E_ROWNUM = iDisplayStart + iDisplayLength

   SQL = "SELECT * FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & QNA_VIEW_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL)

   i= 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         Q_SEQ = Rs("Q_SEQ")
         Q_TYPE = Rs("Q_TYPE")
         Q_NAME = Rs("Q_NAME")
         Q_TITLE = Replace(Rs("Q_TITLE"),"""","\""")
         Q_ADATE = Rs("Q_ADATE")
         Q_IP = Rs("Q_IP")
         Q_WDATE = f_chang_time(Rs("Q_WDATE"))

         Q_TYPE = f_arr_value(Q_TYPE_CD,Q_TYPE_NAME,Q_TYPE)

         If IsNULL(Q_ADATE) OR Q_ADATE = "" Then
            Q_ADATE = "미답변"
         Else
            Q_ADATE = f_chang_time(Q_ADATE)
         End If

         BTN_EDIT = "<button type=\'button\' class=\'btn btn-primary btn-xs\' onclick=\""q_edit(" & Q_SEQ & ");\"">EDIT</button> "
         BTN_DEL = "<button type=\'button\' class=\'btn btn-warning btn-xs\' onclick=\""q_del(" & Q_SEQ & ");\"">DEL</button>"

         aaData = aaData + "['" & Q_SEQ & "','" & Q_TYPE & "','" & Q_TITLE & "','" & Q_NAME &  "','" & Q_WDATE &  "','" & Q_ADATE &  "','" & BTN_EDIT & BTN_DEL & "'],"
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
