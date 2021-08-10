<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/conf/code.inc" -->
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

   WHERE = "MEM_STATE < '90'"

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

   for k = 0 to 9
      if k = 0 OR Request("bSortable_" & k) = "true" then
         order = order & Request("iSortCol_" & k) & " " & Request("sSortDir_" & k)
       end if
   next

   order = Replace(order,"1","MEM_SEQ")
   order = Replace(order,"2","MEM_NAME")
   order = Replace(order,"3","MEM_ID")
   order = Replace(order,"4","MEM_HP")
   order = Replace(order,"5","MEM_LEVEL")
   order = Replace(order,"6","MEM_WDATE")
   order = Replace(order,"7","MEM_LOG_DATE")
   order = Replace(order,"8","MEM_EMAIL_YN")
   order = Replace(order,"9","MEM_STATE")

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
         MEM_LEVEL = Rs("MEM_LEVEL")
         MEM_HP = Rs("MEM_HP")
         MEM_EMAIL = Rs("MEM_EMAIL")
         MEM_SMS_YN = Rs("MEM_SMS_YN")
         MEM_EMAIL_YN = Rs("MEM_EMAIL_YN")
         MEM_LOG_DATE = f_chang_date(Rs("MEM_LOG_DATE"))
         MEM_LOG_CNT = FormatNumber(Rs("MEM_LOG_CNT"),0)
         MEM_WDATE = f_chang_date(Rs("MEM_WDATE"))
         MEM_STATE = Rs("MEM_STATE")
         ARA_CODE = Rs("ARA_CODE")

         MEM_LEVEL = f_arr_value(MEM_LEVEL_CD, MEM_LEVEL_NAME, Rs("MEM_LEVEL"))
         MEM_SEX = f_arr_value(MEM_SEX_CD, MEM_SEX_NAME, CStr(MEM_SEX))

         If MEM_STATE > "90" Then MEM_NAME = "탈퇴회원"

         If Left(MEM_HP,2) = "01" Then
            MEM_HP = "<font color=\""#3366CC\"" style=\""cursor:hand;\"" onclick=\""opensms('" & MEM_HP & "');\"">" & MEM_HP & "</font>"
         End If

         If MEM_EMAIL_YN = "1" Then
            EMAIL_YN = "<span class=\'label label-sm label-success\'>수신</span>"
         Else
            EMAIL_YN = "<span class=\'label label-sm label-danger\'>미수신</span>"
         End If

         If MEM_STATE = "01" Then
            STATE_TXT = "<span class=\'label label-sm label-success\'>승인</span>"
         Else
            STATE_TXT = "<span class=\'label label-sm label-danger\'>미승인</span>"
         End If

         BTN_EDIT = "<button type=\""button\"" class=\""btn btn-primary btn-xs\"" onclick=\""mem_edit(" & MEM_SEQ & ");\"">EDIT</button> "

         listData = "['','" & MEM_SEQ & "','" & MEM_NAME & "','" & MEM_ID & "','MEM_HP','" & MEM_LEVEL &  "','" & MEM_WDATE &  "','" & MEM_LOG_DATE &  "','" & EMAIL_YN &  "','" & STATE_TXT &  "','BTN'],"
         listData = Replace(listData,"'",chr(34))
         listData = Replace(listData,"MEM_HP",MEM_HP)
         listData = Replace(listData,"BTN",BTN_EDIT)

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
