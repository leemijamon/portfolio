<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim POPUP_LST_Table
   POPUP_LST_Table = "POPUP_LST"

   Dim P_SEQ,P_TITLE,P_CONT,P_READCNT,P_DISP,P_TOP,P_LEFT,P_WHDTH,P_HEIGHT,P_SDATE
   Dim P_EDATE,P_WDATE,P_MDATE,P_STATE,ADM_SEQ

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   sEcho = Cint(Request("sEcho"))
   iDisplayStart = Cint(Request("iDisplayStart"))
   iDisplayLength = Cint(Request("iDisplayLength"))
   sSearch = Request("sSearch")
   iTotalRecords = 0 '전체레코드
   iTotalDisplayRecords = 0 '결과레코드

   WHERE = "P_STATE < '90'"

   SQL = "SELECT COUNT(*) FROM " & POPUP_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   iTotalRecords = Rs(0)
   Rs.close

   If sSearch <> "" Then
      WHERE = WHERE & " AND (P_TITLE LIKE '%" & sSearch & "%')"

      SQL = "SELECT COUNT(*) FROM " & POPUP_LST_Table & " WHERE " & WHERE
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

   order = Replace(order,"0",", P_SEQ")
   order = Replace(order,"3",", P_TITLE")
   order = Replace(order,"7",", P_WDATE")
   order = Replace(order,"8",", P_READCNT")

   ORDER_BY = Right(order, Len(order)-1)

   If InStr(ORDER_BY,"P_SEQ") = 0 Then ORDER_BY = ORDER_BY & ", P_SEQ"

   S_ROWNUM = iDisplayStart + 1
   E_ROWNUM = iDisplayStart + iDisplayLength

   SQL = "SELECT * FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & POPUP_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL)

   i= 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         P_SEQ = Rs("P_SEQ")
         P_TYPE = Rs("P_TYPE")
         P_TITLE = Replace(Rs("P_TITLE"),"""","\""")
         P_READCNT = Rs("P_READCNT")
         P_DISP = Rs("P_DISP")
         P_CENTER = Rs("P_CENTER")
         P_TOP = Rs("P_TOP")
         P_LEFT = Rs("P_LEFT")
         P_WHDTH = Rs("P_WHDTH")
         P_HEIGHT = Rs("P_HEIGHT")
         P_SDATE = f_chang_date(Rs("P_SDATE"))
         P_EDATE = f_chang_date(Rs("P_EDATE"))
         P_WDATE = f_chang_date(Rs("P_WDATE"))

         P_TYPE_TXT = f_arr_value(P_TYPE_CD, P_TYPE_NAME, Cstr(P_TYPE))

         If P_DISP = "1" Then
            P_DISP_TXT = "노출함"
         Else
            P_DISP_TXT = "노출안함"
         End If

         If P_CENTER = "1" Then
            P_POS = "CENTER"
         Else
            P_POS = P_TOP & ", " & P_LEFT
         End If

         BTN_VIEW = "<button type=\""button\"" class=\""btn btn-primary btn-xs\"" onclick=\""p_view(" & P_SEQ & "," & P_WHDTH & "," & P_HEIGHT & ");\"">VIEW</button> "
         BTN_EDIT = "<button type=\""button\"" class=\""btn btn-primary btn-xs\"" onclick=\""p_edit(" & P_SEQ & ");\"">EDIT</button> "
         BTN_DEL = "<button type=\""button\"" class=\""btn btn-warning btn-xs\"" onclick=\""p_del(" & P_SEQ & ");\"">DEL</button>"

         listData = "['" & P_SEQ & "','" & P_DISP_TXT & "','" & P_TYPE_TXT & "','" & P_TITLE &  "','" & P_POS &  "','" & P_WHDTH & " X " & P_HEIGHT &  "','" & P_SDATE & "~" & P_EDATE &  "','" & P_WDATE &  "','" & P_READCNT &  "','BTN'],"
         listData = Replace(listData,"'",chr(34))

         listData = Replace(listData,"BTN", BTN_VIEW & BTN_EDIT & BTN_DEL)

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
