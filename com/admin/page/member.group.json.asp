<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim MEM_LEVEL_LST_Table
   MEM_LEVEL_LST_Table = "MEM_LEVEL_LST"

   Dim MEM_LEVEL,ML_NAME,ML_USE_YN,ML_WDATE,ML_MDATE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   sEcho = Cint(Request("sEcho"))
   iDisplayStart = Cint(Request("iDisplayStart"))
   iDisplayLength = Cint(Request("iDisplayLength"))
   sSearch = Request("sSearch")
   iTotalRecords = 0 '전체레코드
   iTotalDisplayRecords = 0 '결과레코드

   WHERE = "MEM_LEVEL IS NOT NULL"

   SQL = "SELECT COUNT(*) FROM " & MEM_LEVEL_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   iTotalRecords = Rs(0)
   Rs.close

   If sSearch <> "" Then
      WHERE = WHERE & " AND ML_NAME LIKE '%" & sSearch & "%'"

      SQL = "SELECT COUNT(*) FROM " & MEM_LEVEL_LST_Table & " WHERE " & WHERE
      Set Rs = Conn.Execute(SQL, ,adCmdText)
      iTotalDisplayRecords = Rs(0)
      Rs.close
   Else
      iTotalDisplayRecords = iTotalRecords
   End If

   for k = 0 to 2
      if Request("bSortable_" & k) = "true" then
         order = order & Request("iSortCol_" & k) & " " & Request("sSortDir_" & k)
       end if
   next

   order = Replace(order,"0",", MEM_LEVEL")
   order = Replace(order,"1",", ML_NAME")
   order = Replace(order,"2",", ML_USE_YN")

   ORDER_BY = Right(order, Len(order)-1)

   If InStr(ORDER_BY,"MEM_LEVEL") = 0 Then ORDER_BY = ORDER_BY & ", MEM_LEVEL"

   S_ROWNUM = iDisplayStart + 1
   E_ROWNUM = iDisplayStart + iDisplayLength

   SQL = "SELECT * FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & MEM_LEVEL_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL)

   i= 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         MEM_LEVEL = Rs("MEM_LEVEL")
         ML_NAME = Rs("ML_NAME")
         ML_USE_YN = Rs("ML_USE_YN")

         If ML_USE_YN = "1" Then
            USE_YN = "<span class=\'label label-sm label-success\'>사용</span>"
         Else
            USE_YN = "<span class=\'label label-sm label-danger\'>미사용</span>"
         End If

         BTN_EDIT = "<button type=\""button\"" class=\""btn btn-primary btn-xs\"" onclick=\""level_edit('" & MEM_LEVEL & "');\"">EDIT</button>"

         listData = "['" & MEM_LEVEL & "','" & ML_NAME & "','" & USE_YN & "','BTN'],"
         listData = Replace(listData,"'",chr(34))

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
