<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   DTYPE = request("dtype")

   intThisYear = (Year(Now()))
   intThisMonth = int(Month(Now()))

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

   Dim MEM_LST_Table
   MEM_LST_Table = "MEM_LST"

   Dim L_CNT(31), M_CNT(31)

   If DTYPE = "Week" Then
      NOW_WEEKDAY = Weekday(now())

      THISWEEK1 = replace(FormatDateTime(DateAdd("d", - NOW_WEEKDAY + 1, now()),2),"-","") & "0000"
      THISWEEK2 = replace(FormatDateTime(DateAdd("d", - NOW_WEEKDAY + 7, now()),2),"-","") & "2359"

      S_CNT = Day(DateAdd("d", - NOW_WEEKDAY + 1, now()))
      E_CNT = Day(DateAdd("d", - NOW_WEEKDAY + 7, now()))

      S_KEY = "LV_DAY"
      S_TXT = "일"
      L_WHERE = "LV_WDATE >= '" & THISWEEK1 & "' AND LV_WDATE <= '" & THISWEEK2 & "'"

      M_KEY = "LEFT(MEM_WDATE,8)"
      M_WHERE = "MEM_WDATE >= '" & THISWEEK1 & "' AND MEM_WDATE <= '" & THISWEEK2 & "'"
   ElseIf DTYPE = "Month" Then
      V_DATE = Left(Replace(FormatDateTime(now(),2),"-",""),6)
      S_CNT = 1
      E_CNT = intLastDay
      S_KEY = "LV_DAY"
      S_TXT = "일"
      L_WHERE = "LV_WDATE LIKE '" & V_DATE & "%'"

      M_KEY = "LEFT(MEM_WDATE,8)"
      M_WHERE = "MEM_WDATE LIKE '" & V_DATE & "%'"
   Else
      V_DATE = Year(now())
      S_CNT = 1
      E_CNT = 12
      S_KEY = "LV_MONTH"
      S_TXT = "월"
      L_WHERE = "LV_WDATE LIKE '" & V_DATE & "%'"

      M_KEY = "LEFT(MEM_WDATE,6)"
      M_WHERE = "MEM_WDATE LIKE '" & V_DATE & "%'"
   End If

   SQL = "SELECT COUNT(*) AS L_CNT, " & S_KEY & " FROM " & LOG_VISIT_LST_Table _
       & " WHERE " & L_WHERE & " GROUP BY " & S_KEY & " ORDER BY " & S_KEY

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         i = Rs(S_KEY)

         L_CNT(i) = Rs("L_CNT")

         Rs.MoveNext
      Loop
   End If
   Rs.close

   SQL = "SELECT COUNT(*) AS M_CNT, " & M_KEY & " AS M_KEY FROM " & MEM_LST_Table _
       & " WHERE " & M_WHERE & " GROUP BY " & M_KEY & " ORDER BY " & M_KEY

   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         M_KEY = Rs("M_KEY")
         i = Cint(Right(M_KEY,2))

         M_CNT(i) = Rs("M_CNT")

         Rs.MoveNext
      Loop
   End If
   Rs.close

   If S_CNT < E_CNT Then
      For i = S_CNT to E_CNT
         L_DATE = Right("00" & i,2) & S_TXT

         If IsEmpty(L_CNT(i)) Then L_CNT(i) = 0
         If IsEmpty(M_CNT(i)) Then M_CNT(i) = 0

         If i > S_CNT Then
            labels = labels & ","
            visit = visit & ","
            mcnt = mcnt & ","
         End If

         labels = labels & """" & L_DATE & """"
         visit = visit & L_CNT(i)
         mcnt = mcnt & M_CNT(i)

         'If i > S_CNT Then L_DATA = L_DATA & "," & vbNewLine
         'L_DATA = L_DATA & "    {""lvdate"": """ & L_DATE & """, ""visit"": " & L_CNT(i) & ", ""mcnt"": " & M_CNT(i) & "}"
      Next
   Else
      For i = S_CNT to intLastDay
         L_DATE = Right("00" & i,2) & S_TXT

         If IsEmpty(L_CNT(i)) Then L_CNT(i) = 0
         If IsEmpty(M_CNT(i)) Then M_CNT(i) = 0

         If i > S_CNT Then
            labels = labels & ","
            visit = visit & ","
            mcnt = mcnt & ","
         End If

         labels = labels & """" & L_DATE & """"
         visit = visit & L_CNT(i)
         mcnt = mcnt & M_CNT(i)

         'If i > S_CNT Then L_DATA = L_DATA & "," & vbNewLine
         'L_DATA = L_DATA & "    {""lvdate"": """ & L_DATE & """, ""visit"": " & L_CNT(i) & ", ""mcnt"": " & M_CNT(i) & "}"
      Next

      For i = 1 to E_CNT
         L_DATE = Right("00" & i,2) & S_TXT

         If IsEmpty(L_CNT(i)) Then L_CNT(i) = 0
         If IsEmpty(M_CNT(i)) Then M_CNT(i) = 0

         If i > 1 Then
            labels = labels & ","
            visit = visit & ","
            mcnt = mcnt & ","
         End If

         labels = labels & """" & L_DATE & """"
         visit = visit & L_CNT(i)
         mcnt = mcnt & M_CNT(i)

         'L_DATA = L_DATA & "," & vbNewLine
         'L_DATA = L_DATA & "    {""lvdate"": """ & L_DATE & """, ""visit"": " & L_CNT(i) & ", ""mcnt"": " & M_CNT(i) & "}"
      Next
   End If
%>
<canvas id="canvas" height="300" width="700"></canvas>

<script type="text/javascript">
  var randomScalingFactor = function(){ return Math.round(Math.random()*100)};

  var barChartData = {
    labels : [<%=labels%>],
    datasets : [
      {
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,0.8)",
        highlightFill: "rgba(220,220,220,0.75)",
        highlightStroke: "rgba(220,220,220,1)",
        data : [<%=visit%>]
      },
      {
        fillColor : "rgba(151,187,205,0.5)",
        strokeColor : "rgba(151,187,205,0.8)",
        highlightFill : "rgba(151,187,205,0.75)",
        highlightStroke : "rgba(151,187,205,1)",
        data : [<%=mcnt%>]
      }
    ]
  }

  var ctx = document.getElementById("canvas").getContext("2d");
  window.myBar = new Chart(ctx).Bar(barChartData, {
    responsive : true
  });
</script>