<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim MEM_SEQ,MEM_NAME,MEM_ID,MEM_LEVEL,MEM_SEX,MEM_HP,MEM_EMAIL,MEM_SMS_YN,MEM_EMAIL_YN,MEM_LOG_DATE
   Dim MEM_LOG_CNT,MEM_SALE_PRICE,MEM_MONEY,MEM_STATE,ARA_CODE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   sEcho = Cint(Request("sEcho"))
   iDisplayLength = Cint(Request("iDisplayLength"))
   iDisplayStart = Cint(Request("iDisplayStart"))
   sSearch = Request("sSearch")
   iTotalRecords = 0 '전체레코드
   iTotalDisplayRecords = 0 '결과레코드

   WHERE = "MEM_STATE > '90' AND MEM_STATE < '99'"

   SQL = "SELECT COUNT(*) FROM " & MEM_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   iTotalRecords = Rs(0)
   Rs.close

   If sSearch <> "" Then
      WHERE = WHERE & " AND (MEM_NAME LIKE '%" & sSearch & "%' OR MEM_ID LIKE '%" & sSearch & "%' OR MEM_ID LIKE '%" & sSearch & "%' OR MEM_HP LIKE '%" & sSearch & "%')"

      SQL = "SELECT COUNT(*) FROM " & MEM_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      iTotalDisplayRecords = Rs(0)
      Rs.close
   Else
      iTotalDisplayRecords = iTotalRecords
   End If

   for k = 0 to 6
      if k = 0 OR Request("bSortable_" & k) = "true" then
         order = order & Request("iSortCol_" & k) & " " & Request("sSortDir_" & k)
       end if
   next

   order = Replace(order,"0","MEM_SEQ")
   order = Replace(order,"1","MEM_NAME")
   order = Replace(order,"2","MEM_ID")
   order = Replace(order,"3","MEM_STATE")
   order = Replace(order,"4","MEM_LOG_IP")
   order = Replace(order,"5","MEM_WDATE")
   order = Replace(order,"6","MEM_MDATE")

   ORDER_BY = order
   'ORDER_BY = "MEM_SEQ"

   If InStr(ORDER_BY,"MEM_SEQ") = 0 Then ORDER_BY = ORDER_BY & ", MEM_SEQ"

   S_ROWNUM = iDisplayStart + 1
   E_ROWNUM = iDisplayStart + iDisplayLength

   SQL = "SELECT * FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & MEM_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL)

   i= 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         MEM_SEQ = Rs("MEM_SEQ")
         MEM_NAME = Rs("MEM_NAME")
         MEM_ID = Rs("MEM_ID")
         MEM_HP = Rs("MEM_HP")
         MEM_EMAIL = Rs("MEM_EMAIL")
         MEM_LOG_IP = Rs("MEM_LOG_IP")
         MEM_WDATE = f_chang_date(Rs("MEM_WDATE"))
         MEM_MDATE = f_chang_date(Rs("MEM_MDATE"))
         MEM_STATE = Rs("MEM_STATE")
         MEM_SECEDE = Rs("MEM_SECEDE")
         MEM_SECEDE_DETAIL = Rs("MEM_SECEDE_DETAIL")

         If MEM_STATE < "90" Then MEM_STATE_TXT = "정상회원"
         If MEM_STATE = "91" Then MEM_STATE_TXT = "본인탈퇴"
         If MEM_STATE = "92" Then MEM_STATE_TXT = "강제탈퇴"

         MEM_SECEDE_TXT = f_arr_value(MEM_SECEDE_CD, MEM_SECEDE_NAME, MEM_SECEDE)

         BTN_DETAIL = "<button type=\'button\' class=\'btn btn-primary btn-xs\' onclick=\""mem_detail(" & MEM_SEQ & ");\"">DETAIL</button> "
         BTN_DEL = "<button type=\'button\' class=\'btn btn-warning btn-xs\' onclick=\""mem_del(" & MEM_SEQ & ");\"">DEL</button>"

         aaData = aaData + "['" & MEM_SEQ & "','" & MEM_NAME & "','" & MEM_ID & "','" & MEM_STATE_TXT & "','" & MEM_LOG_IP &  "','" & MEM_WDATE &  "','" & MEM_MDATE &  "','" & MEM_SECEDE_TXT &  "','" & BTN_DETAIL & BTN_DEL & "'],"
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
