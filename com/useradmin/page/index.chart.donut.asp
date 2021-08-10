<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   DTYPE = request("dtype")

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")


   Dim LOG_VISIT_LST_Table
   LOG_VISIT_LST_Table = "LOG_VISIT_LST"

   If DTYPE = "Week" Then
      NOW_WEEKDAY = Weekday(now())

      THISWEEK1 = replace(FormatDateTime(DateAdd("d", - NOW_WEEKDAY + 1, now()),2),"-","") & "0000"
      THISWEEK2 = replace(FormatDateTime(DateAdd("d", - NOW_WEEKDAY + 7, now()),2),"-","") & "2359"

      WHERE = "LV_WDATE >= '" & THISWEEK1 & "' AND LV_WDATE <= '" & THISWEEK2 & "'"
   ElseIf DTYPE = "Month" Then
      V_DATE = Left(Replace(FormatDateTime(now(),2),"-",""),6)
      WHERE = "LV_WDATE LIKE '" & V_DATE & "%'"
   Else
      V_DATE = Year(now())
      WHERE = "LV_WDATE LIKE '" & V_DATE & "%'"
   End If

   V_TXT = "검색어"
   S_KEY = "LV_QUERY"

   SQL = "SELECT TOP 10 COUNT(*) AS L_CNT, " & S_KEY & " FROM " & LOG_VISIT_LST_Table _
       & " WHERE " & S_KEY & " <> '' AND " & WHERE & " GROUP BY " & S_KEY & " ORDER BY L_CNT DESC"

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

   i = 0
   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         i = i + 1

         L_TXT = Rs("LV_QUERY")
         L_CNT = Rs("L_CNT")

         If i > 1 Then L_DATA = L_DATA & "," & vbNewLine
         L_DATA = L_DATA & "    {""value"": " & Round(L_CNT/S_COUNT*100,2) & ", ""label"": """ & L_TXT & """}"

         Rs.MoveNext
      Loop
   Else
      L_DATA = L_DATA & "    {""value"": 100, ""label"": ""자료없음""}"
   End If
   Rs.close
%>
<script type="text/javascript">
  var day_data = [
<%=L_DATA%>
  ];

  Morris.Donut({
    element: 'DonutChart',
    data: day_data,
    colors:["#23AE89","#2EC1CC","#FFB61C","#E94B3B"],
    formatter: function (x) { return x + "%"}
  });
</script>
