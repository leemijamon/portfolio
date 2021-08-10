<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim ADMIN_LST_Table
   ADMIN_LST_Table = "ADMIN_LST"

   Dim ADM_SEQ,ADM_TYPE,ADM_NAME,ADM_ID,ADM_PWD,ADM_HP,ADM_TEL,ADM_FAX,ADM_ZIPCODE
   Dim ADM_ADDR1,ADM_ADDR2,ADM_EMAIL,ADM_POST,ADM_ACCOUNT,ADM_PERMIT,ADM_LOG_IP,ADM_LOG_DATE,ADM_WDATE,ADM_MDATE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   sEcho = Cint(Request("sEcho"))
   iDisplayStart = Cint(Request("iDisplayStart"))
   iDisplayLength = Cint(Request("iDisplayLength"))
   sSearch = Request("sSearch")
   iTotalRecords = 0 '전체레코드
   iTotalDisplayRecords = 0 '결과레코드

   WHERE = "ADM_STATE < '90'"

   SQL = "SELECT COUNT(*) FROM " & ADMIN_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   iTotalRecords = Rs(0)
   Rs.close

   If sSearch <> "" Then
      WHERE = WHERE & " AND (ADM_ID LIKE '%" & sSearch & "%' OR ADM_NAME LIKE '%" & sSearch & "%')"

      SQL = "SELECT COUNT(*) FROM " & ADMIN_LST_Table & " WHERE " & WHERE
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

   order = Replace(order,"0",", ADM_ID")
   order = Replace(order,"1",", ADM_TYPE")
   order = Replace(order,"2",", ADM_NAME")
   order = Replace(order,"3",", ADM_HP")
   order = Replace(order,"4",", ADM_LOG_DATE")
   order = Replace(order,"5",", ADM_WDATE")

   ORDER_BY = Right(order, Len(order)-1)

   If InStr(ORDER_BY,"ADM_SEQ") = 0 Then ORDER_BY = ORDER_BY & ", ADM_SEQ"

   S_ROWNUM = iDisplayStart + 1
   E_ROWNUM = iDisplayStart + iDisplayLength

   SQL = "SELECT * FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & ADMIN_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL)

   i= 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         ADM_SEQ = Rs("ADM_SEQ")
         ADM_TYPE = Rs("ADM_TYPE")
         ADM_NAME = Rs("ADM_NAME")
         ADM_ID = Rs("ADM_ID")
         ADM_HP = Rs("ADM_HP")
         ADM_LOG_DATE = Rs("ADM_LOG_DATE")
         ADM_WDATE = Rs("ADM_WDATE")

         If Session("ADM_TYPE") = "00" Then
            BTN_EDIT = "<button type=\'button\' class=\'btn btn-primary btn-xs\' onclick=\""adm_edit(" & ADM_SEQ & ");\"">EDIT</button> "
            If ADM_TYPE = "00" Then
               BTN_DEL = "<button type=\'button\' class=\'btn btn-warning btn-xs\' onclick=\""adm_del(0);\"">DEL</button>"
            Else
               BTN_DEL = "<button type=\'button\' class=\'btn btn-warning btn-xs\' onclick=\""adm_del(" & ADM_SEQ & ");\"">DEL</button>"
            End If
         Else
            BTN_EDIT = ""
            BTN_DEL = ""
         End If

         aaData = aaData + "['" & ADM_ID & "','" & f_arr_value(ADM_TYPE_CD,ADM_TYPE_NAME,ADM_TYPE) & "','" & ADM_NAME & "','" & ADM_HP &  "','" & f_chang_date(ADM_LOG_DATE) &  "','" & f_chang_date(ADM_WDATE) &  "','" & BTN_EDIT & BTN_DEL & "'],"
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
