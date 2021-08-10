<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   CTYPE = request("ctype")
   DTYPE = request("dtype")
   CHARTDATE = request("chartdate")

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim LOG_VISIT_LST_Table
   LOG_VISIT_LST_Table = "LOG_VISIT_LST"

   If CTYPE = "Domain" Then
      V_TXT = "유입도메인"
   ElseIf CTYPE = "Query" Then
      V_TXT = "검색어"
   ElseIf CTYPE = "Os" Then
      V_TXT = "OS"
   Else
      V_TXT = "브라우져"
   End If

   If DTYPE = "Day" Then
      V_DATE = Replace(FormatDateTime(CHARTDATE,2),"-","")
   ElseIf DTYPE = "Month" Then
      V_DATE = Left(Replace(FormatDateTime(CHARTDATE,2),"-",""),6)
   Else
      V_DATE = Left(Replace(FormatDateTime(CHARTDATE,2),"-",""),4)
   End If

   S_KEY = "LV_" & LCase(CTYPE)

   SQL = "SELECT TOP 10 COUNT(*) AS L_CNT, " & S_KEY & " FROM " & LOG_VISIT_LST_Table _
       & " WHERE " & S_KEY & " <> '' AND LV_WDATE LIKE '" & V_DATE & "%' GROUP BY " & S_KEY & " ORDER BY L_CNT DESC"

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   S_COUNT = 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         S_COUNT = S_COUNT + Rs("L_CNT")
         Rs.MoveNext
      Loop
   End If
   Rs.close

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   With response
      .write "<div id='" & CTYPE & DTYPE & "Chart' class='chart no-padding'></div>" & vbNewLine

      .write "<div class='table-responsive'>" & vbNewLine
      .write "  <table class='table table-bordered font-xs'>" & vbNewLine
      .write "    <thead>" & vbNewLine
      .write "      <tr>" & vbNewLine
      .write "        <th width='10%'>번호</th>" & vbNewLine
      .write "        <th>" & V_TXT & "</th>" & vbNewLine
      .write "        <th width='15%'>접속수</th>" & vbNewLine
      .write "        <th width='15%'>비율</th>" & vbNewLine
      .write "      </tr>" & vbNewLine
      .write "    </thead>" & vbNewLine
      .write "    <tbody>" & vbNewLine

      i = 0
      If Rs.BOF = false AND Rs.EOF = false Then
         Do until Rs.EOF
            i = i + 1

            L_TXT = Rs(S_KEY)
            L_CNT = Rs("L_CNT")

            .write "      <tr>" & vbNewLine
            .write "        <td>" & i & "</td>" & vbNewLine
            .write "        <td>" & L_TXT & "</td>" & vbNewLine
            .write "        <td><font class='ver8' color='#EC4E00'>" & FormatNumber(L_CNT,0) & "</font></td>" & vbNewLine
            .write "        <td><font class='ver8' color='#6C6C6C'>" & Round(L_CNT/S_COUNT*100,2) & "%</font></td>" & vbNewLine
            .write "      </tr>" & vbNewLine

            If i > 1 Then L_DATA = L_DATA & "," & vbNewLine
            L_DATA = L_DATA & "    {""value"": " & Round(L_CNT/S_COUNT*100,2) & ", ""label"": """ & L_TXT & """}"

            Rs.MoveNext
         Loop
      Else
         .write "  <tr><td colspan='4' align='center'>분석데이터가 없습니다.</td></tr>" & vbNewLine
      End If
      Rs.close

      .write "    </tbody>" & vbNewLine
      .write "  </table>" & vbNewLine
      .write "</div>" & vbNewLine
   End With

%>

<script type="text/javascript">
  var day_data = [
<%=L_DATA%>
  ];

  Morris.Donut({
    element: '<%=CTYPE&DTYPE%>Chart',
    data: day_data,
    colors:["#23AE89","#2EC1CC","#FFB61C","#E94B3B"],
    formatter: function (x) { return x + "%"}
  });
</script>

