<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim CONSULT_LST_Table
   CONSULT_LST_Table = "CONSULT_LST"

   Dim C_SEQ,C_AREA,C_TYPE,C_NAME,C_ZIPCODE,C_ADDR1,C_ADDR2,C_MA_NAME,C_MA_HP,C_HOMEPAGE
   Dim C_BLOG,C_CONT,C_ANSER,C_ADATE,C_IP,C_WDATE,C_MDATE,C_STATE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   sEcho = Cint(Request("sEcho"))
   iDisplayStart = Cint(Request("iDisplayStart"))
   iDisplayLength = Cint(Request("iDisplayLength"))
   sSearch = Request("sSearch")
   iTotalRecords = 0 '전체레코드
   iTotalDisplayRecords = 0 '결과레코드

   WHERE = "C_STATE < '90'"

   SQL = "SELECT COUNT(*) FROM " & CONSULT_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   iTotalRecords = Rs(0)
   Rs.close

   If sSearch <> "" Then
      WHERE = WHERE & " AND (C_NAME LIKE '%" & sSearch & "%' OR C_TITLE LIKE '%" & sSearch & "%')"

      SQL = "SELECT COUNT(*) FROM " & CONSULT_LST_Table & " WHERE " & WHERE
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

   order = Replace(order,"0",", C_SEQ")
   order = Replace(order,"1",", C_TYPE")
   order = Replace(order,"2",", C_TITLE")
   order = Replace(order,"3",", C_NAME")
   order = Replace(order,"4",", C_WDATE")
   order = Replace(order,"5",", C_ADATE")

   ORDER_BY = Right(order, Len(order)-1)

   If InStr(ORDER_BY,"C_SEQ") = 0 Then ORDER_BY = ORDER_BY & ", C_SEQ"

   S_ROWNUM = iDisplayStart + 1
   E_ROWNUM = iDisplayStart + iDisplayLength

   SQL = "SELECT * FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & CONSULT_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL)

   i= 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         C_SEQ = Rs("C_SEQ")
         C_TYPE = Rs("C_TYPE")
         C_NAME = Rs("C_NAME")
         C_EMAIL = Rs("C_EMAIL")
         C_HP = Rs("C_HP")
         C_TEL = Rs("C_TEL")
         C_TITLE = Rs("C_TITLE")
         C_CONT = Rs("C_CONT")
         C_ANSER = Rs("C_ANSER")
         C_ADATE = Rs("C_ADATE")
         C_IP = Rs("C_IP")
         C_WDATE = f_chang_time(Rs("C_WDATE"))

         C_TYPE = f_arr_value(C_TYPE_CD,C_TYPE_NAME,C_TYPE)

         If IsNULL(C_ADATE) OR C_ADATE = "" Then
            C_ADATE = "미답변"
         Else
            C_ADATE = f_chang_time(C_ADATE)
         End If

         BTN_EDIT = "<button type=\'button\' class=\'btn btn-primary btn-xs\' onclick=\""c_edit(" & C_SEQ & ");\"">EDIT</button> "
         BTN_DEL = "<button type=\'button\' class=\'btn btn-warning btn-xs\' onclick=\""c_del(" & C_SEQ & ");\"">DEL</button>"

         aaData = aaData + "['" & C_SEQ & "','" & C_TYPE & "','" & C_TITLE & "','" & C_NAME &  "','" & C_WDATE &  "','" & C_ADATE &  "','" & BTN_EDIT & BTN_DEL & "'],"
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
