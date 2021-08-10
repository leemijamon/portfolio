<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   DTYPE = request("dtype")
   CTYPE = request("ctype")
   CHARTDATE = request("chartdate")

   intThisYear = (Year(CHARTDATE))
   intThisMonth = int(Month(CHARTDATE))

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

   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   Dim LOG_VISIT_LST_Table
   LOG_VISIT_LST_Table = "LOG_VISIT_LST"

   Dim L_CNT(31), P_CNT(31)

   If DTYPE = "Day" Then
      V_DATE = Replace(FormatDateTime(CHARTDATE,2),"-","")
      S_CNT = 0
      E_CNT = 23
      S_KEY = "LV_HOUR"
      S_TXT = "시"
   ElseIf DTYPE = "Month" Then
      V_DATE = Left(Replace(FormatDateTime(CHARTDATE,2),"-",""),6)
      S_CNT = 1
      E_CNT = intLastDay
      S_KEY = "LV_DAY"
      S_TXT = "일"
   Else
      V_DATE = Left(Replace(FormatDateTime(CHARTDATE,2),"-",""),4)
      S_CNT = 1
      E_CNT = 12
      S_KEY = "LV_MONTH"
      S_TXT = "월"
   End If

   SQL = "SELECT COUNT(*) AS L_CNT, SUM(LV_PAGE_CNT) AS P_CNT, " & S_KEY & " FROM " & LOG_VISIT_LST_Table _
       & " WHERE LV_WDATE LIKE '" & V_DATE & "%' GROUP BY " & S_KEY & " ORDER BY " & S_KEY

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         i = Rs(S_KEY)

         L_CNT(i) = Rs("L_CNT")
         P_CNT(i) = Rs("P_CNT")

         Rs.MoveNext
      Loop
   End If
   Rs.close

   For i = S_CNT to E_CNT
      L_DATE = Right("00" & i,2) & S_TXT

      If IsEmpty(L_CNT(i)) Then L_CNT(i) = 0
      If IsEmpty(P_CNT(i)) Then P_CNT(i) = 0

      If i > S_CNT Then L_DATA = L_DATA & "," & vbNewLine
      L_DATA = L_DATA & "    {""lvdate"": """ & L_DATE & """, ""visit"": " & L_CNT(i) & ", ""view"": " & P_CNT(i) & "}"
   Next
%>
<div id="<%=DTYPE & CTYPE%>Chart" class="chart no-padding"></div>
<script type="text/javascript">
  var day_data = [
<%=L_DATA%>
  ];

  Morris.<%=CTYPE%>({
    element: '<%=DTYPE & CTYPE%>Chart',
    data: day_data,
    xkey: 'lvdate',
    ykeys: ['visit','view'],
    labels: ['방문자','페이지뷰'],
<% If CTYPE = "Bar" Then %>
    barColors: ["#23AE89","#FFB61C","#2EC1CC"],
<% Else %>
    lineColors: ["#23AE89","#FFB61C","#2EC1CC"],
<% End If %>
    xLabelMargin: 10,
    parseTime: false,
    pointSize: 2,
    hideHover: true
  });
</script>