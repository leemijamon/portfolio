<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->
<%
   NowDate = FormatDateTime(now(),2)

   If request("chartdate") <> "" Then
      CHARTDATE = request("chartdate")
   Else
      CHARTDATE = NowDate
   End If
%>

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li class="active">접속통계</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">접속통계</h2>
    </div>
  </div>

  <form id="dateform" method="get" class="form">
  <div class="row">
    <section class="col col-sm-4 col-md-2">
      <strong><label for="skin">기준일자 선택</label></strong>
      <label class="input"> <i class="icon-append fa fa-calendar"></i>
        <input type="text" id="chartdate" name="chartdate" class="form-control" value="<%=CHARTDATE%>">
      </label>
    </section>
  </div>
  </form>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">

      <div class="panel panel-pink">
        <div class="panel-heading">
          <i class="fa fa-bar-chart-o"></i> 일별 방문자/페이지뷰 분석
          <div class="btn-group pull-right">
            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-chevron-down"></i>
            </button>
            <ul class="dropdown-menu slidedown">
              <li>
                <a href="javascript:ChangeVisitChart('Day','Bar');">Bar Chart</a>
              </li>
              <li>
                <a href="javascript:ChangeVisitChart('Day','Line');">Line Chart</a>
              </li>
              <li>
                <a href="javascript:ChangeVisitChart('Day','Area');">Area Chart</a>
              </li>
            </ul>
          </div>
        </div>
        <div class="panel-body" id="VisitChartDay">

        </div>
      </div>

      <div class="panel panel-greenLight">
        <div class="panel-heading"><i class="fa fa-bar-chart-o"></i> 월별 방문자/페이지뷰 분석
          <div class="btn-group pull-right">
            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-chevron-down"></i>
            </button>
            <ul class="dropdown-menu slidedown">
              <li>
                <a href="javascript:ChangeVisitChart('Month','Bar');">Bar Chart</a>
              </li>
              <li>
                <a href="javascript:ChangeVisitChart('Month','Line');">Line Chart</a>
              </li>
              <li>
                <a href="javascript:ChangeVisitChart('Month','Area');">Area Chart</a>
              </li>
            </ul>
          </div>
        </div>
        <div class="panel-body" id="VisitChartMonth">

        </div>
      </div>

      <div class="panel panel-blue">
        <div class="panel-heading"><i class="fa fa-bar-chart-o"></i> 년별 방문자/페이지뷰 분석
          <div class="btn-group pull-right">
            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-chevron-down"></i>
            </button>
            <ul class="dropdown-menu slidedown">
              <li>
                <a href="javascript:ChangeVisitChart('Year','Bar');">Bar Chart</a>
              </li>
              <li>
                <a href="javascript:ChangeVisitChart('Year','Line');">Line Chart</a>
              </li>
              <li>
                <a href="javascript:ChangeVisitChart('Year','Area');">Area Chart</a>
              </li>
            </ul>
          </div>
        </div>
        <div class="panel-body" id="VisitChartYear">

        </div>
      </div>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-6">

      <div class="panel panel-pink">
        <div class="panel-heading"><i class="fa fa-bar-chart-o"></i> 유입도메인 분석
          <div class="btn-group pull-right">
            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-chevron-down"></i>
            </button>
            <ul class="dropdown-menu slidedown">
              <li>
                <a href="javascript:ChangeChart('Domain','Day');">일별</a>
              </li>
              <li>
                <a href="javascript:ChangeChart('Domain','Month');">월별</a>
              </li>
              <li>
                <a href="javascript:ChangeChart('Domain','Year');">년별</a>
              </li>
            </ul>
          </div>
        </div>
        <div class="panel-body" id="DomainChart">
        </div>
      </div>

      <div class="panel panel-greenLight">
        <div class="panel-heading"><i class="fa fa-bar-chart-o"></i> 검색어 분석
          <div class="btn-group pull-right">
            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-chevron-down"></i>
            </button>
            <ul class="dropdown-menu slidedown">
              <li>
                <a href="javascript:ChangeChart('Query','Day');">일별</a>
              </li>
              <li>
                <a href="javascript:ChangeChart('Query','Month');">월별</a>
              </li>
              <li>
                <a href="javascript:ChangeChart('Query','Year');">년별</a>
              </li>
            </ul>
          </div>
        </div>
        <div class="panel-body" id="QueryChart">
        </div>
      </div>

    </div>
    <div class="col-sm-12 col-md-12 col-lg-6">

      <div class="panel panel-magenta">
        <div class="panel-heading"><i class="fa fa-bar-chart-o"></i> 브라우져 분석
          <div class="btn-group pull-right">
            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-chevron-down"></i>
            </button>
            <ul class="dropdown-menu slidedown">
              <li>
                <a href="javascript:ChangeChart('Browser','Day');">일별</a>
              </li>
              <li>
                <a href="javascript:ChangeChart('Browser','Month');">월별</a>
              </li>
              <li>
                <a href="javascript:ChangeChart('Browser','Year');">년별</a>
              </li>
            </ul>
          </div>
        </div>
        <div class="panel-body" id="BrowserChart">
        </div>
      </div>

      <div class="panel panel-blue">
        <div class="panel-heading"><i class="fa fa-bar-chart-o"></i> OS 분석
          <div class="btn-group pull-right">
            <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-chevron-down"></i>
            </button>
            <ul class="dropdown-menu slidedown">
              <li>
                <a href="javascript:ChangeChart('Os','Day');">일별</a>
              </li>
              <li>
                <a href="javascript:ChangeChart('Os','Month');">월별</a>
              </li>
              <li>
                <a href="javascript:ChangeChart('Os','Year');">년별</a>
              </li>
            </ul>
          </div>
        </div>
        <div class="panel-body" id="OsChart">
        </div>
      </div>

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
        AjaxloadURL('page/state.chart.asp?chartdate=' + $('#chartdate').val(), $('#main-content'));
      }
    });

    ChangeVisitChart('Day','Bar');
    ChangeVisitChart('Month','Bar');
    ChangeVisitChart('Year','Bar');

    ChangeChart('Domain','Day');
    ChangeChart('Query','Day')
    ChangeChart('Browser','Day');
    ChangeChart('Os','Day');
  }

  function ChangeVisitChart(dtype,ctype){
    AjaxloadURL('page/state.chart.visit.asp?chartdate=' + $('#chartdate').val() + '&dtype=' + dtype + '&ctype=' + ctype, $('#VisitChart' + dtype));
  }

  function ChangeChart(ctype,dtype){
    AjaxloadURL('page/state.chart.donut.asp?chartdate=' + $('#chartdate').val() + '&dtype=' + dtype + '&ctype=' + ctype, $('#' + ctype + 'Chart'));
  }
</script>
