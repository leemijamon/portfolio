<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Response.Expires = -1

   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim CMS_PAGE_LST_Table
   CMS_PAGE_LST_Table = "CMS_PAGE_LST"

   Dim CP_CODE,CP_NUM,CP_NAME,CP_TITLE,CP_TITLE_ENG,CP_MEM_LEVEL,CP_SKIN,CP_PG_YN,CP_PG_ITEM,CP_PG_NAME
   Dim CP_PG_QUERY,CP_SSL_YN,CP_USE_YN,CP_TOP_ITEM,CP_SUBTOP_ITEM,CP_SIDE_ITEM,CP_SCROLL_ITEM,CP_BOTTOM_ITEM,CP_SORT,CP_WDATE
   Dim CP_MDATE,CP_STATE

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   CS_CODE = Request("cs_code")

   sEcho = Cint(Request("sEcho"))
   iDisplayStart = Cint(Request("iDisplayStart"))
   iDisplayLength = Cint(Request("iDisplayLength"))
   sSearch = Request("sSearch")
   iTotalRecords = 0 '전체레코드
   iTotalDisplayRecords = 0 '결과레코드

   WHERE = "CS_CODE='" & CS_CODE & "' AND CP_STATE < '90'"

   SQL = "SELECT COUNT(*) FROM " & CMS_PAGE_LST_Table & " WHERE " & WHERE
   Set Rs = Conn.Execute(SQL, ,adCmdText)
   iTotalRecords = Rs(0)
   Rs.close

   If sSearch <> "" Then
      WHERE = WHERE & " AND (CP_NAME LIKE '%" & sSearch & "%' OR CP_CODE LIKE '%" & sSearch & "%')"

      SQL = "SELECT COUNT(*) FROM " & CMS_PAGE_LST_Table & " WHERE " & WHERE
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

   order = Replace(order,"0",", CP_SORT")
   order = Replace(order,"1",", CP_NAME")
   order = Replace(order,"2",", CP_CODE")
   order = Replace(order,"3",", CP_CODE")
   order = Replace(order,"4",", CP_USE")

   ORDER_BY = Right(order, Len(order)-1)

   If InStr(ORDER_BY,"CP_SEQ") = 0 Then ORDER_BY = ORDER_BY & ", CP_SEQ"

   S_ROWNUM = iDisplayStart + 1
   E_ROWNUM = iDisplayStart + iDisplayLength

   SQL = "SELECT * FROM (" _
       & "SELECT *, ROW_NUMBER() OVER (ORDER BY " & ORDER_BY & ") AS ROW_NUM FROM " & CMS_PAGE_LST_Table & " WHERE " & WHERE _
       & ") T " _
       & "WHERE T.ROW_NUM BETWEEN " & S_ROWNUM & " AND " & E_ROWNUM & " " _
       & "ORDER BY T.ROW_NUM"

   Set Rs = Conn.Execute(SQL)

   i= 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         CP_SEQ = Rs("CP_SEQ")
         CP_CODE = Rs("CP_CODE")
         CP_NAME = Rs("CP_NAME")
         CP_NUM = Rs("CP_NUM")
         CP_PG_ITEM = Rs("CP_PG_ITEM")
         CP_PG_QUERY = Rs("CP_PG_QUERY")
         CP_USE_YN = Rs("CP_USE_YN")
         CP_SORT = Rs("CP_SORT")

         CP_LINK = "/" & CP_CODE
         If CP_PG_ITEM <> "" Or CP_PG_QUERY <> "" Then CP_LINK = CP_LINK & "?item=" & CP_PG_ITEM & "&" & CP_PG_QUERY

         If CP_USE_YN = "1" Then
            CP_USE = "<span class=\'label label-sm label-success\'>Yes</span>"
         Else
            CP_USE = "<span class=\'label label-sm label-danger\'>no</span>"
         End If

         'BTN = "<button type=\""button\"" class=\""btn btn-primary btn-xs hidden-sm hidden-xs\"" onclick=\""page_cont('html','" & CP_CODE & "');\"">HTML</button> "
         'BTN = "<button type=\""button\"" class=\""btn btn-primary btn-xs hidden-sm hidden-xs\"" onclick=\""page_cont('text','" & CP_CODE & "');\"">TEXT</button> "

         'BTN = BTN & "<a href=\""skin.asp?skin=" & CS_CODE & "&mode=content&url=" & Replace(CP_LINK,"&","|") & "\"" target=\""_blank\"" class=\""btn btn-primary btn-xs hidden-sm hidden-xs\"">Editor</a> "
			BTN = "<button type=\""button\"" class=\""btn btn-primary btn-xs hidden-sm hidden-xs\"" onclick=\""page_edit(" & CP_SEQ & ");\"">EDIT</button> "			
         'BTN = BTN & "<button type=\""button\"" class=\""btn btn-primary btn-xs hidden-sm hidden-xs\"" onclick=\""page_edit(" & CP_SEQ & ");\"">EDIT</button> "
         BTN = BTN & "<button type=\""button\"" class=\""btn btn-warning btn-xs hidden-sm hidden-xs\"" onclick=\""page_del(" & CP_SEQ & ");\"">DEL</button>"

         'BTN = BTN & "<button class=\""btn btn-xs btn-success hidden-md hidden-lg\"" onclick=\""page_cont('html','" & CP_CODE & "');\""><i class=\""fa fa-laptop\""></i></button> "
         BTN = BTN & "<button class=\""btn btn-xs btn-success hidden-md hidden-lg\"" onclick=\""page_cont('text','" & CP_CODE & "');\""><i class=\""fa fa-code\""></i></button> "
         BTN = BTN & "<button class=\""btn btn-xs btn-info hidden-md hidden-lg\"" onclick=\""page_edit(" & CP_SEQ & ");\""><i class=\""fa fa-edit\""></i></button> "
         BTN = BTN & "<button class=\""btn btn-xs btn-warning hidden-md hidden-lg\"" onclick=\""page_del(" & CP_SEQ & ");\""><i class=\""fa fa-trash-o\""></i></button>"

         listData = "['" & CP_SORT & "','" & CP_NAME & "','" & CP_CODE & "','{{link." & Replace(CP_CODE,"/",".") & "}}','" & CP_USE &  "','BTN'],"
         listData = Replace(listData,"'",chr(34))

         listData = Replace(listData,"BTN",BTN)
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