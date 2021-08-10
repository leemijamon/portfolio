<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/conf/site_config.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   Dim Conn, Rs
   Set Conn = Server.CreateObject("ADODB.Connection")
   Conn.Open Application("connect")

   NOW_DATE = Replace(FormatDateTime(now(),2),"-","")

   NOW_WEEKDAY = Weekday(now())

   '### 종합현황
   TODAY = NOW_DATE
   THISWEEK1 = replace(FormatDateTime(DateAdd("d", - NOW_WEEKDAY + 1, now()),2),"-","") & "0000"
   THISWEEK2 = replace(FormatDateTime(now(),2),"-","") & "2359"
   LASTWEEK1 = replace(FormatDateTime(DateAdd("d", - NOW_WEEKDAY - 6, now()),2),"-","") & "0000"
   LASTWEEK2 = replace(FormatDateTime(DateAdd("d", - NOW_WEEKDAY, now()),2),"-","") & "2359"

   THISMONTH = Left(NOW_DATE,6)
   LASTMONTH = Left(Replace(FormatDateTime(DateAdd("m", -1, now()),2),"-",""),6)
   THISYEAR = Year(now())
   LASTYEAR = Year(FormatDateTime(DateAdd("yyyy", -1, now()),2))

   Dim STODAY(2), STHISWEEK(2), SLASTWEEK(2), STHISMONTH(2), SLASTMONTH(2), STHISYEAR(2), SLASTYEAR(2), STOTAL(2)

   SQL = "SP_ADM_REPORT '" & TODAY & "', '" & THISWEEK1 & "','" & THISWEEK2 & "','" & LASTWEEK1 & "','" & LASTWEEK2 & "','" & THISMONTH & "','" & LASTMONTH & "','" & THISYEAR & "','" & LASTYEAR & "'"
   Set Rs = Conn.Execute(SQL, ,adCmdText)

   If Rs.BOF = false AND Rs.EOF = false Then
      Do until Rs.EOF
         NUM = Rs("LTYPE")

         STODAY(NUM) = FormatNumber(Rs("STODAY"),0)
         STHISWEEK(NUM) = FormatNumber(Rs("STHISWEEK"),0)
         SLASTWEEK(NUM) = FormatNumber(Rs("SLASTWEEK"),0)
         STHISMONTH(NUM) = FormatNumber(Rs("STHISMONTH"),0)
         SLASTMONTH(NUM) = FormatNumber(Rs("SLASTMONTH"),0)
         STHISYEAR(NUM) = FormatNumber(Rs("STHISYEAR"),0)
         SLASTYEAR(NUM) = FormatNumber(Rs("SLASTYEAR"),0)
         STOTAL(NUM) = FormatNumber(Rs("STOTAL"),0)

         Rs.MoveNext
      Loop
   End If
   Rs.close

   PreDate = Replace(FormatDateTime(DateAdd("d", -2, now()),2),"-","") & Replace(FormatDateTime(now(),4),":","")
   NowDate = Replace(FormatDateTime(now(),2),"-","")

   If IsEmpty(MAINBOARD1) Then MAINBOARD1 = "board/1"
   If IsEmpty(MAINBOARD2) Then MAINBOARD2 = "qna"
   If IsEmpty(MAINBOARD3) Then MAINBOARD3 = "consult"

   If MAINBOARD1 <> "" Then MAINBOARD1_HTML = BoardCont(MAINBOARD1)
   If MAINBOARD2 <> "" Then MAINBOARD2_HTML = BoardCont(MAINBOARD2)
   If MAINBOARD3 <> "" Then MAINBOARD3_HTML = BoardCont(MAINBOARD3)

   Conn.Close
   Set Conn = nothing
%>
<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li class="active">메인페이지</li>
  </ul>
</div>

<!-- #include virtual = "/admin/page/index.function.asp" -->

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">메인페이지</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-md-8">
      <div class="panel panel-pink">
        <div class="panel-heading">
          <i class="fa fa-bar-chart-o fa-fw"></i>가입자/방문자현황
          <div class="pull-right">
            <div class="btn-group">
              <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                <i class="fa fa-chevron-down"></i>
              </button>
              <ul class="dropdown-menu pull-right" role="menu">
                <li>
                <a href="javascript:ChangeVisitChart('Week');">주간동계</a>
                </li>
                <li>
                <a href="javascript:ChangeVisitChart('Month');">월간통계</a>
                </li>
                <li>
                <a href="javascript:ChangeVisitChart('Year');">년간통계</a>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <div class="panel-body">
          <div class="row">
            <div class="col-lg-4">
              <div class="table-responsive">
                <table class="table table-bordered table-hover table-striped font-sm">
                <thead>
                <tr>
                  <th>구분</th>
                  <th>방문자</th>
                  <th>가입자</th>
                </tr>
                </thead>
                <tbody>
                <tr class="active">
                  <td>오늘</td>
                  <td><%=STODAY(1)%></td>
                  <td><%=STODAY(0)%></td>
                </tr>
                <tr>
                  <td>이번주</td>
                  <td><%=STHISWEEK(1)%></td>
                  <td><%=STHISWEEK(0)%></td>
                </tr>
                <tr class="active">
                  <td>지난주</td>
                  <td><%=SLASTWEEK(1)%></td>
                  <td><%=SLASTWEEK(0)%></td>
                </tr>
                <tr>
                  <td>이번달</td>
                  <td><%=STHISMONTH(1)%></td>
                  <td><%=STHISMONTH(0)%></td>
                </tr>
                <tr class="active">
                  <td>지난달</td>
                  <td><%=SLASTMONTH(1)%></td>
                  <td><%=SLASTMONTH(0)%></td>
                </tr>
                <tr>
                  <td>이번년도</td>
                  <td><%=STHISYEAR(1)%></td>
                  <td><%=STHISYEAR(0)%></td>
                </tr>
                <tr class="active">
                  <td>전년도</td>
                  <td><%=SLASTYEAR(1)%></td>
                  <td><%=SLASTYEAR(0)%></td>
                </tr>
                <tr>
                  <td>전체</td>
                  <td><%=STOTAL(1)%></td>
                  <td><%=STOTAL(0)%></td>
                </tr>
                </tbody>
                </table>
              </div>
            </div>
            <div class="col-lg-8">
              <div id="BarChart">

              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="panel panel-magenta">
        <div class="panel-heading">
          <i class="fa fa-bar-chart-o fa-fw"></i> 검색어
          <div class="pull-right">
            <div class="btn-group">
              <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                <i class="fa fa-chevron-down"></i>
              </button>
              <ul class="dropdown-menu pull-right" role="menu">
                <li>
                <a href="javascript:ChangeChart('Week');">주간동계</a>
                </li>
                <li>
                <a href="javascript:ChangeChart('Month');">월간통계</a>
                </li>
                <li>
                <a href="javascript:ChangeChart('Year');">년간통계</a>
                </li>
              </ul>
            </div>
          </div>
        </div>
        <div class="panel-body">
          <div id="DonutChart"></div>
        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-md-4">
<%=MAINBOARD1_HTML%>
    </div>
    <div class="col-md-4">
<%=MAINBOARD2_HTML%>
    </div>
    <div class="col-md-4">
<%=MAINBOARD3_HTML%>
    </div>
  </div>
</div>

<script type="text/javascript">
  loadScript("js/raphael-min.js", loadMorrisEngine);

  function loadMorrisEngine() {
    loadScript("js/morris.min.js", runMorrisCharts);
  }

  function runMorrisCharts(){
    $('#chartdate').datepicker({
      dateFormat : 'yy-mm-dd',
      onSelect : function(selectedDate) {
        AjaxloadURL('page/state.asp?chartdate=' + $('#chartdate').val(), $('#main-content'));
      }
    });

    ChangeVisitChart('Week');

    ChangeChart('Week')
  }

  function ChangeVisitChart(dtype){
    AjaxloadURL('page/index.chart.visit.asp?dtype=' + dtype, $('#BarChart'));
  }

  function ChangeChart(dtype){
    AjaxloadURL('page/index.chart.donut.asp?dtype=' + dtype, $('#DonutChart'));
  }
</script>
