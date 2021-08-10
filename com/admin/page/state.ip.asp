<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->

<link href="css/jquery.dataTables.css" rel="stylesheet">
<link href="css/dataTables.bootstrap.css" rel="stylesheet">

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">통계</a>
    </li>
    <li class="active">로그분석(상세)</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">로그분석(상세)</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">

      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 로그분석(상세)</div>
        <div class="panel-body no-padding">

          <table id="datatable_col_reorder" class="display dataTable DTTT_selectable">
            <thead>
              <tr>
                <th>기록시간</th>
                <th>접속IP</th>
                <th>접속국가</th>
                <th>페이지뷰</th>
                <th>IP접속수</th>
                <th>운영체제</th>
                <th>브라우져</th>
                <th>회원명</th>
                <th>접속도메인</th>
                <th>검색어</th>
                <th>관리</th>
              </tr>
            </thead>
          </table>

        </div>
      </div>
    </div>
  </div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title" id="modal-title">로그</h4>
      </div>
      <div class="modal-body no-padding" id="modal-body" style="padding:1px;">

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-sm" data-dismiss="modal">Close</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
  loadDataTableScripts();
  function loadDataTableScripts() {
    loadScript("js/jquery.dataTables.min.js", dt_2);

    function dt_2() {
      loadScript("js/dataTables.bootstrap.js", dt_3);
    }

    function dt_3() {
      loadScript("js/dataTables.tableTools.min.js", runDataTables);
    }
  }

  function runDataTables(){
    $('#datatable_col_reorder').dataTable({
      "bProcessing": true,
      "bServerSide": true,
      "sAjaxSource": "page/state.ip.json.asp",
      "iDisplayLength": 25,
      "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs no-right-padding'l>r>t<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
      "aaSorting" : [[0, 'desc']],
      "aoColumns": [
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true },
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": false, "bSortable": false, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": false, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": true, "bSortable": true, "bVisible": true, "sClass": "hidden-xs" },
        { "bSearchable": true, "bSortable": true, "bVisible": true, "sClass": "hidden-xs" },
        { "bSearchable": false, "bSortable": false, "bVisible": true, "sClass": "hidden-sm hidden-xs" }
        ]
    });
  }

  function page_log(lv_seq){
    AjaxloadURL('page/state.ip.page.asp?lv_seq=' + lv_seq, $('#modal-body'));
    $('#modal-title').html("로그분석(페이지)");
    $('#myModal').modal('show');
  }

  function ip_log(lv_ip){
    AjaxloadURL('page/state.ip.history.asp?lv_ip=' + lv_ip, $('#modal-body'));
    $('#modal-title').html("로그분석(IP)");
    $('#myModal').modal('show');
  }

  function whois(ip){
    window.open('http://whoisdomain.kr/whois/pop_whois.php?from=left&type=nameserver&domain=' + ip,'whois','width=620,height=620,resizable=no,scrollbars=yes,status=no,toolbar=no');
  }

  function log_del(lv_ip){
    var msg = "삭제하시겠습니까?"
    if(confirm(msg)){
      document.sframe.location.href = "?action=state.ip&method=delete&lv_ip=" + lv_ip;
    }else{
      return;
    }
  }

</script>
