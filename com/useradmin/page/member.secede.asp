<%@ LANGUAGE="VBSCRIPT" CODEPAGE=65001 %>
<!-- #include virtual = "/exec/conf/code.inc" -->
<!-- #include virtual = "/exec/module/dft_function.inc" -->
<!-- #include virtual = "/exec/module/admincheck.inc" -->

<link href="css/jquery.dataTables.css" rel="stylesheet">
<link href="css/dataTables.bootstrap.css" rel="stylesheet">
<link href="css/dataTables.tableTools.css" rel="stylesheet">

<div class="breadcrumbs" id="breadcrumbs">
  <ul class="breadcrumb">
    <li>
      <i class="fa fa-home"></i>
      <a href="#">Home</a>
    </li>
    <li>
      <a href="#">회원관리</a>
    </li>
    <li class="active">회원탈퇴내역</li>
  </ul>
</div>

<div class="page-content">
  <div class="row">
    <div class="col-sm-12 col-md-12">
      <h2 class="page-header">회원탈퇴내역</h2>
    </div>
  </div>

  <div class="row">
    <div class="col-sm-12 col-md-12 col-lg-12">
      <div class="panel panel-default">
        <div class="panel-heading"><i class="fa fa-table"></i> 회원탈퇴내역</div>
        <div class="panel-body no-padding">

          <table id="datatable_col_reorder" class="display dataTable">
            <thead>
              <tr>
                <th>번호</th>
                <th>이름</th>
                <th>아이디</th>
                <th>처리형태</th>
                <th>IP</th>
                <th>가입일</th>
                <th>탈퇴/삭제일</th>
                <th>탈퇴사유</th>
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
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h4 class="modal-title">회원탈퇴 사유</h4>
      </div>
      <div class="modal-body" id="modal-body" style="padding:1px;">

      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
  loadDataTableScripts();
  function loadDataTableScripts() {
    loadScript("js/jquery.dataTables.js", dt_2);

    function dt_2() {
      loadScript("js/dataTables.bootstrap.js", dt_3);
    }

    function dt_3() {
      loadScript("js/dataTables.tableTools.min.js", runDataTables);
    }
  }

  function runDataTables(){
    var table = $('#datatable_col_reorder').dataTable({
      "bProcessing": true,
      "bServerSide": true,
      "sAjaxSource": "page/member.secede.json.asp",
      "sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs no-right-padding'l>r>t<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
      "aaSorting" : [[0, 'desc']],
      "aoColumns": [
        { "bSearchable": false, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true },
        { "bSearchable": true, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": true, "bVisible": true, "sClass": "hidden-sm hidden-xs" },
        { "bSearchable": false, "bSortable": false, "bVisible": true },
        { "bSearchable": false, "bSortable": false, "bVisible": true }
      ]
    });
  }

  function mem_detail(mem_seq){
    AjaxloadURL('page/member.secede.detail.asp?mem_seq=' + mem_seq, $('#modal-body'));
    $('#myModal').modal({show:true});
  }

  function mem_del(mem_seq){
    var msg = "회원정보를 삭제하시겠습니까?"
    if(confirm(msg)){
      document.sframe.location.href = "?action=member.edit&method=delete&mem_seq=" + mem_seq;
    }else{
      return;
    }
  }

  function page_reload(){
    document.location.reload();
  }
</script>
