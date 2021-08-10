<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/skin/default/page/new_goto_page.inc" -->
<!-- #include virtual = "/skin/default/page/new_goto_page2.inc" -->

<!-- #include virtual = "/exec/module/dft_function.inc" -->
<%
   Session.CodePage = 65001
   Response.ChaRset = "utf-8"

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

	NowDate = Replace(FormatDateTime(now(),2),"-","")

	Dim BOARD_LST_TABLE
	BOARD_LST_TABLE = "BOARD_LST"

	BC_SEQ = request("bc_seq")
	CUT_SEQ = request("cut")

	If BC_SEQ = "" Then Response.end

	Dim page : page = request("page")
	if page = "" then page = 1
	page = int(page)

	Dim pageSize : pageSize = 4
	Dim recordCount, recentCount

	WHERE = "B_STATE < '90' AND BC_SEQ = '" & BC_SEQ & "'"

	If CUT_SEQ <> "" Then WHERE = WHERE & " AND B_SEQ <> '" & CUT_SEQ & "'" 
	'Response.write WHERE

	SQL = "SELECT COUNT(*) FROM " & BOARD_LST_TABLE & " WHERE " & WHERE
	Set Rs = Conn.Execute(SQL, ,adCmdText)
	recordCount = Rs(0)
	Rs.close

	Dim n_from,n_to,s_desc,s_asc,n_range,n_limit
	Dim pageCount : pageCount=int((recordCount-1)/pageSize)+1

	if page > pageCount then page = pageCount

	s_desc="desc"
	s_asc="asc"
	e_desc="desc"

	n_from = (page-1) * pageSize
	n_to = n_from + pageSize
	if n_to > recordCount then n_to = recordCount

	if page > int(pageCount/2)+1 then
		Dim t : t=n_to
		n_to=recordCount-n_from
		n_from=recordCount-t
		s_desc="asc"
		s_asc="desc"
		e_desc="desc"
	End if
	If page = 0 Then page = 1

	n_range = n_to
	n_limit = n_to-n_from

	s_select = "B_SEQ"

	ORDER_BY_B_DESC = "B_SEQ" & " " & s_desc
	ORDER_BY_B_ASC = "B_SEQ" & " " & s_asc
	ORDER_BY_E_DESC = "B_SEQ" & " " & e_desc

	SQL = "SELECT * FROM " & BOARD_LST_TABLE _
		 & " WHERE " & WHERE & " AND " & s_select & " IN " _
		 & " ( SELECT TOP " & n_limit & " " & s_select & " FROM " _
		 & "      ( SELECT TOP " & n_range & " " & s_select & s_sort & " FROM " & BOARD_LST_TABLE & " WHERE " & WHERE _
		 & "             ORDER BY " & ORDER_BY_B_DESC & " ) as a " _
		 & "        ORDER BY " & ORDER_BY_B_ASC & " ) " _
		 & "   ORDER BY " & ORDER_BY_E_DESC

	Set Rs = Conn.Execute(SQL, ,adCmdText)

	DisplayNum = recordCount - (Page-1) * pageSize

	Response.write "<div class='notice-list'>" & vbNewLine

	If Rs.BOF = false AND Rs.EOF = false Then
		Do until Rs.EOF
			B_SEQ = Rs("B_SEQ")
			B_TITLE = Rs("B_TITLE")
			B_WDATE = f_chang_date(Rs("B_WDATE"))
%>
			<div class="notice-item row mlmr3">
				<div class="notice-cell notice-list-title-cont col-xs-9 pad3">
					<div class="notice-list-title">
						<a class="modalTrigger" href="#" onclick="getView(<%=B_SEQ%>);return false;" data-toggle="modal" data-target="#noticeModal" title="<%=B_TITLE%>" class="notice-list-link"><%=B_TITLE%></a>
					</div>
				</div>
				<div class="notice-cell notice-list-date col-xs-3 pad3"><%=B_WDATE%></div>
			</div>
<%
			DisplayNum = DisplayNum - 1
			Rs.MoveNext
		Loop
	End If
%>
	</ul>

	<div class="page_wrap">
		<div class="page_nation"><% goto_directly page, pagecount, 10 %></div>
	</div>
<%
   Conn.Close
   Set Conn = Nothing
%>
<form name="result" method="get">
  <input type="hidden" name="cut" value="<%=CUT_SEQ%>">
  <input type="hidden" name="bc_seq" value="<%=BC_SEQ%>">
  <input type="hidden" name="page" value="<%=request("page")%>">
</form>