<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/page_function.inc" -->
<!-- #include virtual = "/exec/module/usercheck_non.inc" -->
<!-- #include virtual = "/skin/default/conf/menu_config.inc" -->
<%
   SelfUrl = Request.ServerVariables("URL")
   SelfQuery = Replace(Request.ServerVariables("QUERY_STRING"),"&","|")

   PreDate = Replace(FormatDateTime(DateAdd("d", -2, now()),2),"-","") & Replace(FormatDateTime(now(),4),":","")

   If request("date") <> "" Then
       choice_date = request("date")
       split_choice_date = split(choice_date,"-")
       YY = split_choice_date(0)
       MM = split_choice_date(1)
       DD = split_choice_date(2)
   Else
       YY = Year(date)
       MM = Month(date)
       DD = Day(Date)
       IF Len(MM) = 1 Then MM = "0" & MM
       IF Len(DD) = 1 Then DD = "0" & DD
       choice_date = YY & "-" & MM & "-" & DD
   End If

   intThisYear = int(YY)
   intThisMonth = int(MM)

   if intThisMonth=4 or intThisMonth=6 or intThisMonth=9 or intThisMonth=11 then  '월말 값 계산
       intLastDay=30
   elseif intThisMonth=2 and not (intThisYear mod 4) = 0 then
       intLastDay=28
   elseif intThisMonth=2 and (intThisYear mod 4) = 0 then
       if (intThisYear mod 100) = 0 then
           if (intThisYear mod 400) = 0 then
               intLastDay=29
           else
               intLastDay=28
           end if
       else
           intLastDay=29
       end if
   else
       intLastDay=31
   end if

   first_day = DateSerial(YY, MM, 1)
   first_day_count = Weekday(first_day)

   last_year = DateSerial(YY - 1, MM, DD)
   next_year = DateSerial(YY + 1, MM, DD)
   last_month = DateSerial(YY, MM - 1, DD)
   next_month = DateSerial(YY, MM + 1, DD)

   Date_Kor = FormatDateTime(choice_date, 1)

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim BOARD_CONFIG_LST_Table
   BOARD_CONFIG_LST_Table = "BOARD_CONFIG_LST"

   Dim BC_SEQ,BC_TYPE,BC_NAME,BC_READ_MT,BC_WRITE_MT,BC_MEM_SEQ

   Dim BOARD_LST_Table
   BOARD_LST_Table = "BOARD_LST"

   Dim B_SEQ,B_TITLE,B_SDATE,DAY_CONT(40)

   BC_SEQ = Trim(Request("bc_seq"))
   If IsNumeric(BC_SEQ) = false Then Response.End

   SQL = "SELECT * FROM " & BOARD_CONFIG_LST_Table & " WHERE BC_SEQ=" & BC_SEQ
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      BC_SEQ = Rs("BC_SEQ")
      BC_TYPE = Rs("BC_TYPE")
      BC_NAME = Rs("BC_NAME")
      BC_SKIN = RS("BC_SKIN")
      BC_READ_MT = Rs("BC_READ_MT")
      BC_WRITE_MT = Rs("BC_WRITE_MT")
      BC_MEM_SEQ = Rs("MEM_SEQ")
   End If
   Rs.close

   WRITE_BTN = "1"
   If BC_READ_MT <> "00" Then BC_READ_MT = "99"
   If BC_WRITE_MT <> "00" Then BC_WRITE_MT = "99"
   If BC_REPLY_MT <> "00" Then BC_REPLY_MT = "99"
   If BC_COMM_MT <> "00" Then BC_COMM_MT = "99"

   If BC_WRITE_MT = "00" AND MEM_LEVEL <> "00" AND Cstr(BC_MEM_SEQ) <> Cstr(MEM_SEQ) Then WRITE_BTN = "0"

   If IsNULL(BC_SKIN) OR BC_SKIN = "" Then BC_SKIN = "default"
   SKIN_PATH = "/skin/board/" & BC_SKIN

   If URL = "" OR InStr(URL,"/admin/") > 0 Then
      SelfUrl = Request.ServerVariables("URL")
      response.write "<link href='/skin/css/bootstrap.min.css' rel='stylesheet' type='text/css'>" & vbNewLine
   Else
      SelfUrl = "/" & URL
   End If

   response.write "<link href='" & SKIN_PATH & "/board.css' rel='stylesheet' type='text/css'>" & vbNewLine

   List_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','list','','','','');"

   '## 쓰기권한 체크
   If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cint(MEM_LEVEL) <= Cint(BC_WRITE_MT) Then
      Write_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','" & B_CATE & "','write','','','','');"
   Else
      If Cstr(MEM_LEVEL) = "99" Then
         Write_Script = "not_login('" & LINK_MEMBER_LOGIN & "','" & Rtn_Page & "');"
      Else
         Write_Script = "alert('글쓰기 권한이 없습니다.');"
      End If
   End If

   CUT_SQL = "CASE WHEN DATALENGTH(B_TITLE) > 17 THEN CONVERT(NVARCHAR(17), B_TITLE) + '..' ELSE B_TITLE END AS C_TITLE "

   SQL = "SELECT *," & CUT_SQL & " FROM " & BOARD_LST_Table _
       & " WHERE B_STATE < '90' AND BC_SEQ=" & BC_SEQ & " AND B_SDATE LIKE '" & YY & MM & "%'" _
       & " ORDER BY B_SDATE"

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         i = i + 1
         B_SEQ = Rs("B_SEQ")
         C_TITLE = Rs("C_TITLE")
         B_TITLE = Rs("B_TITLE")
         B_SDATE = Rs("B_SDATE")
         B_MEM_SEQ = Rs("MEM_SEQ")
         B_NOTICE = Rs("B_NOTICE")

         B_DAY = Int(Right(B_SDATE,2))

         If Cstr(BC_MEM_SEQ) = Cstr(MEM_SEQ) OR Cstr(B_MEM_SEQ) = Cstr(MEM_SEQ) OR InStr(BC_READ_MT, MEM_LEVEL) Then
            View_Script = "goBoard('" & SelfUrl & "','" & BC_SEQ & "','','view','" & page & "','" & B_SEQ & "','" & search_key & "','" & search_word & "');"
         Else
            If Login_check = "Y" Then
               View_Script = "alert('읽기 권한이 없습니다.');"
            Else
               View_Script = "not_login('" & LINK_MEM_LOGIN & "','" & Rtn_Page & "');"
            End If
         End If

         If InStr(URL,"/admin/") > 0 And B_NOTICE = "1" Then DAY_CONT(B_DAY) = DAY_CONT(B_DAY) & "(메인게시)"

         DAY_CONT(B_DAY) = DAY_CONT(B_DAY) & "<a href=""javascript:" & View_Script & """ title=""" & B_TITLE & """>" & C_TITLE & "</br>" &"</a>" & vbNewLine

         Rs.MoveNext
      Loop
   End If
   Rs.close

   Conn.Close
   Set Conn = nothing

   S_LINK = SelfUrl & "?pageid=" & PageID & "&pagenum=" & PageNum & "&bc_seq=" & BC_SEQ
	%>
	<div class="biz_biz1">
		<div class="container">
			<% If InStr(URL,"/admin/") = 0 Then %>
				<div class="sub-title">일정</div>
				<div class="sub-stitle">울산과학기술원의 일정을 알려드립니다.</div>
			<%End If%>
	<%
   With response
      .write "<table class='tbl_calendar'>" & vbNewLine
      .write "  <colgroup>" & vbNewLine
      .write "    <col width='14%' />" & vbNewLine
      .write "    <col width='14%' />" & vbNewLine
      .write "    <col width='14%' />" & vbNewLine
      .write "    <col width='14%' />" & vbNewLine
      .write "    <col width='14%' />" & vbNewLine
      .write "    <col width='14%' />" & vbNewLine
      .write "    <col width='14%' />" & vbNewLine
      .write "  </colgroup>" & vbNewLine
      .write "  <thead>" & vbNewLine
      .write "    <tr>" & vbNewLine
      .write "      <th colspan='7' class='first'>" & vbNewLine
      .write "        <a href=""javascript:move('" & last_month & "');"" class='prev'>이전</a>" & vbNewLine
      .write "        <strong>" & YY & "." & MM & "</strong>" & vbNewLine
      .write "        <a href=""javascript:move('" & next_month & "');"" class='next'>다음</a>" & vbNewLine
      .write "      </th>" & vbNewLine
      .write "    </tr>" & vbNewLine
      .write "    <tr>" & vbNewLine
      .write "      <th scope='col' class='first'>일</th>" & vbNewLine
      .write "      <th scope='col'>월</th>" & vbNewLine
      .write "      <th scope='col'>화</th>" & vbNewLine
      .write "      <th scope='col'>수</th>" & vbNewLine
      .write "      <th scope='col'>목</th>" & vbNewLine
      .write "      <th scope='col'>금</th>" & vbNewLine
      .write "      <th scope='col'>토</th>" & vbNewLine
      .write "    </tr>" & vbNewLine
      .write "  </thead>" & vbNewLine
      .write "  <tbody>" & vbNewLine
      .write "    <tr>" & vbNewLine

      For FC_blank = 1 to first_day_count - 1
         k = k + 1
         If k = 1 Then
            .write "      <td class='first'>&nbsp;</td>" & vbNewLine
         Else
            .write "      <td>&nbsp;</td>" & vbNewLine
         End If
      Next

      For FC_day = 1 to intLastDay
         k = k + 1
         If Len(FC_day) < 2 Then
            DD_Value = "0" & FC_day
         Else
            DD_Value = FC_day
         End If

         Week_Num = Weekday(DateSerial(YY, MM, FC_day))

         If Week_Num = 1 Then
            TD_CLASS = "first"
         ElseIf Week_Num = 7 then
            TD_CLASS = "last"
         Else
            TD_CLASS = ""
         End If

         'If DAY_CONT(FC_day) <> "" Then TD_CLASS = TD_CLASS & " bg"
            'Bg_Color = "#FFF8F8"


         .write "      <td class='" & TD_CLASS & "'>" & vbNewLine
         If TD_CLASS = "first" then
         .write "        <div class='daynum' style='color:red;'>" & FC_day & "</div>" & vbNewLine
         ElseIf TD_CLASS = "last" Then
         .write "        <div class='daynum' style='color:blue;'>" & FC_day & "</div>" & vbNewLine
         Else
         .write "        <div class='daynum'>" & FC_day & "</div>" & vbNewLine
         End if
         .write "        <div class='daycont'>" & DAY_CONT(FC_day) & "</div>" & vbNewLine
         .write "      </td>" & vbNewLine

         If FC_day <> intLastDay Then
           If (FC_day + first_day_count - 1) mod 7 = 0 Then
             .write "    </tr><tr>"
           End If
         End If
      Next

      td_count = 7 - (k mod 7)

      If td_count < 7 Then
        For FC_blank = 1 to td_count
          .write "      <td>&nbsp;</td>" & vbNewLine
        Next
      End If

      .write "    </tr>" & vbNewLine
      .write "  </tbody>" & vbNewLine
      .write "</table>" & vbNewLine
   End With
	%>
		</div>
	</div>
	<%
   With Response
		If InStr(URL,"/admin/") > 0 Then
			.write "<div class='tRight'>" & vbNewLine
			If WRITE_BTN <> "0" Then .write "  <button type='button' class='btn btn-primary' onclick=""javascript:" & Write_Script & """>글쓰기</button>" & vbNewLine
			.write "</div>" & vbNewLine
			.write "<br style='line-height:30px' />" & vbNewLine
		End If
   End With
%>
<script language="javascript">
<!--
  function move(date){
    document.location.href = "<%=SelfUrl%>?bc_seq=<%=bc_seq%>&method=<%=method%>&page=<%=page%>&date=" + date;
  }
-->
</script>